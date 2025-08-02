# 本脚本可用于统计词牌的字数、分阕、押韵

import xml.etree.ElementTree as ET
import re

def clean_notation(text):
    """清理格律符号：移除不占字位的符号并保留有效字符"""
    # 定义不占字位的符号（豆号、对偶标记、叠韵标记、衬字、括号、句读）
    non_char_symbols = ['、', '｛', '｝', '［', '］', 'ˇ', '（', '）', '，', '。']
    # 移除不占字位的符号
    for symbol in non_char_symbols:
        text = text.replace(symbol, '')

    return text

def process_stanza(stanza_text):
    """处理单个阕（stanza），返回统计信息"""
    cleaned = clean_notation(stanza_text)

    # 统计平韵（％）和仄韵（＊）
    ping_rhymes = cleaned.count('％')
    ze_rhymes = cleaned.count('＊')
    optional_rhymes = cleaned.count('＃')  # 可选增韵

    # 计算字数（剔除押韵标记）
    char_count = len(re.sub(r'\s', '', cleaned)) - (ping_rhymes + ze_rhymes + optional_rhymes)

    return {
        'chars': char_count,
        'ping_rhymes': ping_rhymes,
        'ze_rhymes': ze_rhymes,
        'optional_rhymes': optional_rhymes,
        'total_rhymes': ping_rhymes + ze_rhymes # 增韵不计入总押韵数
    }

def process_gelv(notation):
    """处理格律文本，返回各阕统计和总体统计"""
    # 按连续两个换行符分隔各阕
    stanzas = re.split(r'\n\s*\n', notation)

    stanza_stats = []
    total_chars = 0
    total_rhymes = 0

    for stanza in stanzas:
        if stanza.strip():  # 忽略空阕
            stats = process_stanza(stanza)
            stanza_stats.append(stats)
            total_chars += stats['chars']
            total_rhymes += stats['total_rhymes']

    return {
        'stanzas': stanza_stats,
        'total_chars': total_chars,
        'total_rhymes': total_rhymes
    }

def process_ci_pai(ci_pai):
    """处理单个词牌，返回包含格律统计的列表"""
    results = []
    names = [name.text for name in ci_pai.findall('名称')]
    ci_pai_name = names[0] if names else "无名词牌"

    # 处理所有格律变体
    for gelv in ci_pai.findall('.//格律'):
        variant = gelv.get('说明', '默认')
        notation = gelv.text.strip() if gelv.text else ""

        # 处理格律并获取统计信息
        stats = process_gelv(notation)

        results.append({
            'name': ci_pai_name,
            'variant': variant,
            'total_chars': stats['total_chars'],
            'total_rhymes': stats['total_rhymes'],
            'stanzas': stats['stanzas']
        })
    return results

def format_stanza_stats(stanza):
    """格式化单个阕的统计信息，忽略0值的韵类"""
    parts = [f"{stanza['chars']}字"]
    if stanza['ping_rhymes'] > 0:
        parts.append(f"{stanza['ping_rhymes']}平韵")
    if stanza['ze_rhymes'] > 0:
        parts.append(f"{stanza['ze_rhymes']}仄韵")
    if stanza['optional_rhymes'] > 0:
        parts.append(f"{stanza['optional_rhymes']}增韵")
    return ", ".join(parts)

def main(xml_file):
    try:
        # 尝试用UTF-16编码打开文件
        tree = ET.parse(xml_file, parser=ET.XMLParser(encoding='utf-16'))
    except Exception as e:
        print(f"使用UTF-16编码打开文件失败: {e}")
        try:
            # 尝试用UTF-8编码打开文件
            tree = ET.parse(xml_file)
            print("使用UTF-8编码成功打开文件")
        except Exception as e2:
            print(f"打开文件失败: {e2}")
            return

    root = tree.getroot()

    # 遍历所有类别
    for category in root.findall('类别'):
        category_name = category.find('名称').text

        # 统计当前类别下的词牌数量（不重复统计）
        ci_pai_list = []
        for ci_pai in category.findall('词牌'):
            names = [name.text for name in ci_pai.findall('名称')]
            ci_pai_name = names[0] if names else "无名词牌"
            if ci_pai_name not in ci_pai_list:
                ci_pai_list.append(ci_pai_name)

        # 输出类别信息，包含词牌数量
        print(f"\n类别: {category_name}（{len(ci_pai_list)}个词牌）")
        all_results = []
        # 处理类别下的所有词牌
        for ci_pai in category.findall('词牌'):
            all_results.extend(process_ci_pai(ci_pai))

        # 输出统计结果
        for res in all_results:
            print(f"\n词牌: {res['name']} ({res['variant']})")
            print(f"  {res['total_chars']}字, {res['total_rhymes']}韵")

            for i, stanza in enumerate(res['stanzas'], 1):
                print(f"  阕{i}: {format_stanza_stats(stanza)}")

if __name__ == "__main__":
    main('..\唐宋词格律.xml')