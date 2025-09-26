using System;
using System.Text;
using System.Xml;
using System.Text.RegularExpressions;

namespace XsltExtensions
{
	public class CiFormatHelper
	{
		static readonly char[] SentenceDelimiter = new char[] { '－', '，', '。', '？', '！' };
		static readonly Regex ParaRegex = new Regex ("\r\n", RegexOptions.CultureInvariant | RegexOptions.Compiled);
		static readonly RegexReplace NormalizeNewLine = new RegexReplace("，\r\n", "，");
		static readonly RegexReplace LeadingCharacter = new RegexReplace("[！～]", m => m.Value[0] == '！' ? @"<span class=""lingge"">│</span>" : @"<span class=""lingge"">－</span>");
		static readonly RegexReplace Tone = new RegexReplace("[│－＋ˇ]", m => {
			switch (m.Value[0]) {
				case '│': return "仄";
				case '－': return "平";
				case '＋': return @"<span class=""zhong"">中</span>";
				case 'ˇ': return "<sup>ˇ</sup>";
				default: return null;
			}
		});
		static readonly RegexReplace Note = new RegexReplace("（(.+?)）|｛(.+?)｝|［(.+?)］", m => {
			switch (m.Value[0]) {
				case '（': return $@"<span class=""note"">{m.Groups[1].Value}</span>";
				case '｛': return $@"<span class=""duiou""><sup>『</sup>{m.Groups[2].Value}<sub>』</sub></span>";
				case '［': return $@"<span class=""note"">〖</span>{m.Groups[3].Value}<span class=""note"">〗</span>";
				default: return null;
			}
		});
		static readonly RegexReplace Rhythm = new RegexReplace("(.)[＊☆★％＆＃]", m => {
			switch (m.Value[m.Value.Length - 1]) {
				case '＊': return $@"<span class=""ze"">{m.Groups[1].Value}</span><span class=""yun0"">（韵）</span>";
				case '☆': return $@"<span class=""ze2"">{m.Groups[1].Value}</span><span class=""yun0"">（韵）</span>";
				case '★': return $@"<span class=""ze3"">{m.Groups[1].Value}</span><span class=""yun0"">（韵）</span>";
				case '％': return $@"<span class=""ping"">{m.Groups[1].Value}</span><span class=""yun0"">（韵）</span>";
				case '＆': return $@"<span class=""ping2"">{m.Groups[1].Value}</span><span class=""yun0"">（韵）</span>";
				case '＃': return $@"<span class=""zeng"">{m.Groups[1].Value}</span><span class=""yun0"">（增韵）</span>";
				default: return null;
			}
		});

		public XmlDocument formatCiPai (string strCi) {
			XmlDocument doc = new XmlDocument ();
			string[] paras = ParaRegex.Split (strCi.Replace(NormalizeNewLine).Replace(LeadingCharacter).Replace(Tone).Replace(Note).Replace(Rhythm));
			for (int i = 0; i < paras.Length; i++) {
				ref var p = ref paras[i];
				p = p.Length > 0 ? $"<div>{p}</div>" : "<br class=\"empty\"/>";
			}
			doc.AppendChild (doc.CreateElement ("blockquote")).CreateNavigator ().AppendChild (String.Concat (paras));
			return doc;
		}

		public XmlDocument formatCi (string strCi) {
			XmlDocument doc = new XmlDocument ();
			doc.AppendChild (doc.CreateElement ("div")).CreateNavigator ().AppendChild (formatCiString(strCi));
			return doc;
		}

		static readonly RegexReplace EmptyLine = new RegexReplace("^\r\n", String.Empty);
		static readonly RegexReplace RemoveNewLine1 = new RegexReplace("([，；：])\r\n", m => m.Groups[1].Value);
		static readonly RegexReplace RemoveNewLine2 = new RegexReplace("([^＾－￥])([？！])\r\n", m => m.Groups[1].Value + m.Groups[2].Value);
		static readonly RegexReplace SwapRhythmMarker = new RegexReplace("】([＾－￥])", m => m.Groups[1].Value + "】");
		static readonly RegexReplace CiRhythm = new RegexReplace("(.)[＾－￥＃＠]", m => {
			switch (m.Value[m.Value.Length-1]) {
				case '＾': return $"<span class=\"ze\">{m.Groups[1].Value}</span>";
				case '－': return $"<span class=\"ping\">{m.Groups[1].Value}</span>";
				case '￥': return $"<span class=\"yun\">{m.Groups[1].Value}</span>";
				case '＃': return $"<span class=\"zeng\">{m.Groups[1].Value}</span>";// 增韵
				case '＠': return $"<span class=\"shiyun\">{m.Groups[1].Value}</span>";// 失韵
				default: return null;
			}
		});
		static readonly RegexReplace CiLeading = new RegexReplace("↑(.)", m => $"<span class=\"lingge\">{m.Groups[1].Value}</span>");
		static readonly RegexReplace StripRhythm = new RegexReplace("[＾－￥＃＠]", String.Empty);
		static readonly RegexReplace StripMarkup = new RegexReplace("<.+?>", String.Empty);
		static readonly RegexReplace CiNote = new RegexReplace(@"「(.+?)」|【(.+?)】|〖(.+?)〗|（(.+?)）|\{(.*?):(\d+)\}|＝(.+?)＝", m => {
			switch (m.Value[0]) {
				// 对偶
				case '「': return $"<span class=\"duiou\">{m.Groups[1].Value}</span>";
				// 专名
				case '【': return $"<u>{m.Groups[2].Value.Replace(CiNote)}</u>";
				// 版本差异标识
				case '〖': return $"<i>{m.Groups[3].Value.Replace(CiNote)}</i>";
				// 注释
				case '（': return $"<span class=\"note\">{m.Groups[4].Value.Replace(CiNote)}</span>";
				// 引用附注
				case '{':
					var id = m.Groups[6].Value;
					var title = m.Groups[5].Value;
					return $"{title}<sup><a href=\"#fn{id}\" name=\"qfn{id}\" class=\"Ref\" title=\"查看“{title.Replace(StripRhythm).Replace(StripMarkup)}”的附注（本页）\">[{id}]</a></sup>";
				// 圈点标识
				case '＝': return $"<span class=\"mark\">{m.Groups[7].Value.Replace(CiNote)}</span>";
				default: return null;
			}
		});

		public string formatCiString (string strCi) {
			var hasCjkExt = hasCjkExtText(strCi);
			strCi = strCi.Replace(EmptyLine).Replace(RemoveNewLine1).Replace(RemoveNewLine2).Replace(SwapRhythmMarker).Replace(CiNote).Replace(CiRhythm).Replace(CiLeading);
			if (hasCjkExt) {
				strCi = encodeCjkExtText (strCi);
			}
			string[] paras = ParaRegex.Split (strCi);
			for (int i = 0; i < paras.Length; i++) {
				ref var p = ref paras[i];
				p = p.Length > 0 ? $"<div>{p}</div>" : "<br class=\"empty\"/>";
			}
			return String.Concat (paras);
		}

		public string firstLine (string strPara) {
			int n = strPara.IndexOfAny (SentenceDelimiter);
			strPara = strPara.Substring (0, n);
			strPara = Regex.Replace (strPara, "\r\n", "");
			strPara = Regex.Replace (strPara, "[【】＾－￥＠＃↑]", "");
			return strPara;
		}

		public bool hasCjkExtText (string source) {
			foreach (char c in source) {
				if (c > 0x33FF && c < 0x4DC0) {
					// CJK Ext-A
					return true;
				}
				if (Char.IsHighSurrogate (c) || Char.IsLowSurrogate (c)) {
					// Surrogate char (Ext-B, Ext-C)
					return true;
				}
			}
			return false;
		}

		public static string encodeCjkExtText (string source) {
			int p = 0;
			string ent;
			StringBuilder sb = new StringBuilder (source.Length + 120);
			for (int i = 0; i < source.Length; i++) {
				char c = source[i];
				if (c > 0x33FF && c < 0x4DC0) {
					ent = ((int)c).ToString ("X4");
					sb.Append (source, p, i - p);
					sb.Append (@"<span class=""extA"" title=""Unicode: ENTITY"">&#xENTITY;</span>".Replace ("ENTITY", ent));
					p = i + 1;
				}
				else if (Char.IsHighSurrogate (c)) {
					ent = ((c - 0xD800) * 0x400 + (source[i + 1] - 0xDC00) + 0x10000).ToString ("X6");
					sb.Append (source, p, i - p);
					sb.Append (@"<span class=""extB"" title=""Unicode: ENTITY"">&#xENTITY;</span>".Replace ("ENTITY", ent));
					i++;
					p = i + 1;
				}
			}
			if (p < source.Length - 1) {
				sb.Append (source, p, source.Length - p);
			}
			return sb.ToString ();
		}
	}

	sealed class RegexReplace
	{
		const RegexOptions Options = RegexOptions.Compiled | RegexOptions.CultureInvariant;
		readonly Regex _Regex;
		readonly string _Replacement;
		readonly MatchEvaluator _MatchEvaluator;

		public RegexReplace(string pattern, string replacement) {
			_Regex = new Regex(pattern, Options);
			_Replacement = replacement;
		}
		public RegexReplace(string pattern, MatchEvaluator matchEvaluator) {
			_Regex = new Regex(pattern, Options);
			_MatchEvaluator = matchEvaluator;
		}

		public string Replace(string source) {
			if (_Replacement != null) {
				return _Regex.Replace(source, _Replacement);
			}
			return _Regex.Replace(source, _MatchEvaluator);
		}
	}

	static class RegexExtensions
	{
		public static string Replace(this string source, RegexReplace replacement) {
			return replacement.Replace(source);
		}
	}
}
