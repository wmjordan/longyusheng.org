/*
* positionBy 1.0.7 (2008-01-29)
*
* Copyright (c) 2006,2007 Jonathan Sharp (http://jdsharp.us)
* Dual licensed under the MIT (MIT-LICENSE.txt)
* and GPL (GPL-LICENSE.txt) licenses.
*
* http://jdsharp.us/
*
* Built upon jQuery 1.2.2 (http://jquery.com)
* This also requires the jQuery dimensions plugin
*/
(function($){
var Range = function(x1, y1, x2, y2) {
this.x1 = x1; this.x2 = x2;
this.y1 = y1; this.y2 = y2;
};
Range.prototype.contains = function(range) {
return (this.x1 <= range.x1 && range.x2 <= this.x2) 
&& 
(this.y1 <= range.y1 && range.y2 <= this.y2);
};
Range.prototype.transform = function(x, y) {
return new Range(this.x1 + x, this.y1 + y, this.x2 + x, this.y2 + y);
};
$.fn.positionBy = function(args) {
var date1 = new Date();
if ( this.length == 0 ) {
return this;
}
var args = $.extend({ 
target: null,
targetPos: null,
elementPos: null,
x: null,
y: null,
positions: null,
addClass: false,
force: false,
container: window,
hideAfterPosition: false
}, args);
if ( args.x != null ) {
var tLeft = args.x;
var tTop = args.y;
var tWidth = 0;
var tHeight = 0;
} else {
var $target = $( $( args.target )[0] );
var tWidth = $target.outerWidth();
var tHeight = $target.outerHeight();
var tOffset = $target.offset();
var tLeft = tOffset.left;
var tTop = tOffset.top;
}
var tRight = tLeft + tWidth;
var tBottom = tTop + tHeight;
return this.each(function() {
var $element = $( this );
if ( !$element.is(':visible') ) {
$element.css({ left: -3000, 
top: -3000
})
.show();
}
var eWidth = $element.outerWidth();
var eHeight = $element.outerHeight();
var position = [];
var next = [];
position[0] = new Range(tRight, tTop, tRight + eWidth, tTop + eHeight);
next[0] = [1,7,4];
position[1] = new Range(tRight, tBottom - eHeight, tRight + eWidth, tBottom);
next[1] = [0,6,4];
position[2] = new Range(tRight, tBottom, tRight + eWidth, tBottom + eHeight);
next[2] = [1,3,10];
position[3] = new Range(tRight - eWidth, tBottom, tRight, tBottom + eHeight);
next[3] = [1,6,10];
position[4] = new Range(tLeft, tBottom, tLeft + eWidth, tBottom + eHeight);
next[4] = [1,6,9];
position[5] = new Range(tLeft - eWidth, tBottom, tLeft, tBottom + eHeight);
next[5] = [6,4,9];
position[6] = new Range(tLeft - eWidth, tBottom - eHeight, tLeft, tBottom);
next[6] = [7,1,4];
position[7] = new Range(tLeft - eWidth, tTop, tLeft, tTop + eHeight);
next[7] = [6,0,4];
position[8] = new Range(tLeft - eWidth, tTop - eHeight, tLeft, tTop);
next[8] = [7,9,4];
position[9] = new Range(tLeft, tTop - eHeight, tLeft + eWidth, tTop);
next[9] = [0,7,4];
position[10]= new Range(tRight - eWidth, tTop - eHeight, tRight, tTop);
next[10] = [0,7,3];
position[11]= new Range(tRight, tTop - eHeight, tRight + eWidth, tTop);
next[11] = [0,10,3];
position[12]= new Range(tRight - eWidth, tTop, tRight, tTop + eHeight);
next[12] = [13,7,10];
position[13]= new Range(tRight - eWidth, tBottom - eHeight, tRight, tBottom);
next[13] = [12,6,3];
position[14]= new Range(tLeft, tBottom - eHeight, tLeft + eWidth, tBottom);
next[14] = [15,1,4];
position[15]= new Range(tLeft, tTop, tLeft + eWidth, tTop + eHeight);
next[15] = [14,0,9];
if ( args.positions !== null ) {
var pos = args.positions[0];
} else if ( args.targetPos != null && args.elementPos != null ) {
var pos = [];
pos[0] = [];
pos[0][0] = 15;
pos[0][1] = 7;
pos[0][2] = 8;
pos[0][3] = 9;
pos[1] = [];
pos[1][0] = 0;
pos[1][1] = 12;
pos[1][2] = 10;
pos[1][3] = 11;
pos[2] = [];
pos[2][0] = 2;
pos[2][1] = 3;
pos[2][2] = 13;
pos[2][3] = 1;
pos[3] = [];
pos[3][0] = 4;
pos[3][1] = 5;
pos[3][2] = 6;
pos[3][3] = 14;
var pos = pos[args.targetPos][args.elementPos];
}
var ePos = position[pos];
var fPos = pos;
if ( !args.force ) {
$window = $( window );
var sx = $window.scrollLeft();
var sy = $window.scrollTop();
var container = new Range( sx, sy, sx + $window.width(), sy + $window.height() );
var stack;
if ( args.positions ) {
stack = args.positions;
} else {
stack = [pos];
}
var test = []; 
while ( stack.length > 0 ) {
var p = stack.shift();
if ( test[p] ) {
continue;
}
test[p] = true;
if ( !container.contains(position[p]) ) {
if ( args.positions === null ) {
stack = jQuery.merge( stack, next[p] );
}
} else {
ePos = position[p];
break;
}
}
}
$element.parents().each(function() {
var $this = $(this);
if ( $this.css('position') != 'static' ) {
var abs = $this.offset();
ePos = ePos.transform( -abs.left, -abs.top );
return false;
}
});
var css = { left: ePos.x1, top: ePos.y1 };
if ( args.hideAfterPosition ) {
css['display'] = 'none';
}
$element.css( css );
if ( args.addClass ) {
$element.removeClass( 'positionBy0 positionBy1 positionBy2 positionBy3 positionBy4 positionBy5 positionBy6 positionBy7 positionBy8 positionBy9 positionBy10 positionBy11 positionBy12 positionBy13 positionBy14 positionBy15')
.addClass('positionBy' + p);
}
});
};
})(jQuery);
