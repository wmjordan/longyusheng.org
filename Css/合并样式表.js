var fs, a;
fs = new ActiveXObject("Scripting.FileSystemObject");
a = fs.OpenTextFile("jquery.jdMenu.css", 1, false);
var s = a.ReadAll();
a = fs.OpenTextFile("style.css", 1, false);
s = a.ReadAll().replace(/@import "jquery\.jdMenu\.css";/g, s);
a.Close();
a = fs.OpenTextFile("X.style.css", 2, true);
a.Write (s);
a.Close ();

var exe = (new ActiveXObject("WScript.Shell")).Exec ("csstidy.exe X.style.css --silent=true ..\\html\\style.css");
WScript.Sleep (2000);
