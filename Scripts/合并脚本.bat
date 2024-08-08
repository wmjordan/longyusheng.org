cscript convertMenuItem.js
jsmin < jquery.pack.js > ..\html\site.js
copy /Y jquery.dimensions.js + jquery.positionBy.js + jquery.jdMenu.js + jquery.hotkeys.js + X.menuitem.js X.script.js
jsmin < X.script.js >> ..\html\site.js
jsmin < cipai.js > ..\html\cipai.js
