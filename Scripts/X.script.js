/* Copyright (c) 2007 Paul Bakaus (paul.bakaus@googlemail.com) and Brandon Aaron (brandon.aaron@gmail.com || http://brandonaaron.net)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * $LastChangedDate$
 * $Rev$
 *
 * Version: @VERSION
 *
 * Requires: jQuery 1.2+
 */

(function($){
	
$.dimensions = {
	version: '@VERSION'
};

// Create innerHeight, innerWidth, outerHeight and outerWidth methods
$.each( [ 'Height', 'Width' ], function(i, name){
	
	// innerHeight and innerWidth
	$.fn[ 'inner' + name ] = function() {
		if (!this[0]) return;
		
		var torl = name == 'Height' ? 'Top'    : 'Left',  // top or left
		    borr = name == 'Height' ? 'Bottom' : 'Right'; // bottom or right
		
		return this.is(':visible') ? this[0]['client' + name] : num( this, name.toLowerCase() ) + num(this, 'padding' + torl) + num(this, 'padding' + borr);
	};
	
	// outerHeight and outerWidth
	$.fn[ 'outer' + name ] = function(options) {
		if (!this[0]) return;
		
		var torl = name == 'Height' ? 'Top'    : 'Left',  // top or left
		    borr = name == 'Height' ? 'Bottom' : 'Right'; // bottom or right
		
		options = $.extend({ margin: false }, options || {});
		
		var val = this.is(':visible') ? 
				this[0]['offset' + name] : 
				num( this, name.toLowerCase() )
					+ num(this, 'border' + torl + 'Width') + num(this, 'border' + borr + 'Width')
					+ num(this, 'padding' + torl) + num(this, 'padding' + borr);
		
		return val + (options.margin ? (num(this, 'margin' + torl) + num(this, 'margin' + borr)) : 0);
	};
});

// Create scrollLeft and scrollTop methods
$.each( ['Left', 'Top'], function(i, name) {
	$.fn[ 'scroll' + name ] = function(val) {
		if (!this[0]) return;
		
		return val != undefined ?
		
			// Set the scroll offset
			this.each(function() {
				this == window || this == document ?
					window.scrollTo( 
						name == 'Left' ? val : $(window)[ 'scrollLeft' ](),
						name == 'Top'  ? val : $(window)[ 'scrollTop'  ]()
					) :
					this[ 'scroll' + name ] = val;
			}) :
			
			// Return the scroll offset
			this[0] == window || this[0] == document ?
				self[ (name == 'Left' ? 'pageXOffset' : 'pageYOffset') ] ||
					$.boxModel && document.documentElement[ 'scroll' + name ] ||
					document.body[ 'scroll' + name ] :
				this[0][ 'scroll' + name ];
	};
});

$.fn.extend({
	position: function() {
		var left = 0, top = 0, elem = this[0], offset, parentOffset, offsetParent, results;
		
		if (elem) {
			// Get *real* offsetParent
			offsetParent = this.offsetParent();
			
			// Get correct offsets
			offset       = this.offset();
			parentOffset = offsetParent.offset();
			
			// Subtract element margins
			offset.top  -= num(elem, 'marginTop');
			offset.left -= num(elem, 'marginLeft');
			
			// Add offsetParent borders
			parentOffset.top  += num(offsetParent, 'borderTopWidth');
			parentOffset.left += num(offsetParent, 'borderLeftWidth');
			
			// Subtract the two offsets
			results = {
				top:  offset.top  - parentOffset.top,
				left: offset.left - parentOffset.left
			};
		}
		
		return results;
	},
	
	offsetParent: function() {
		var offsetParent = this[0].offsetParent;
		while ( offsetParent && (!/^body|html$/i.test(offsetParent.tagName) && $.css(offsetParent, 'position') == 'static') )
			offsetParent = offsetParent.offsetParent;
		return $(offsetParent);
	}
});

function num(el, prop) {
	return parseInt($.curCSS(el.jquery?el[0]:el,prop,true))||0;
};

})(jQuery);/*
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
/*
 * jdMenu 1.4.1 (2008-03-31)
 *
 * Copyright (c) 2006,2007 Jonathan Sharp (http://jdsharp.us)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * http://jdsharp.us/
 *
 * Built upon jQuery 1.2.1 (http://jquery.com)
 * This also requires the jQuery dimensions >= 1.2 plugin
 */

(function($){
	function addEvents(ul) {
		var settings = $.data( $(ul).parents().andSelf().filter('ul.jd_menu')[0], 'jdMenuSettings' );
		$('> li', ul)
			.bind('mouseenter.jdmenu mouseleave.jdmenu', function(evt) {

// ignore menu item separator
				var hr = $('> hr', this);
				if (hr.length > 0) {
					return ;
				}
// end

				$(this).toggleClass('jdm_hover');
				var ul = $('> ul', this);
				if ( ul.length == 1 ) {
					clearTimeout( this.$jdTimer );
					var enter = ( evt.type == 'mouseenter' );
					var fn = ( enter ? showMenu : hideMenu );
					this.$jdTimer = setTimeout(function() {
						fn( ul[0], settings.onAnimate, settings.isVertical );
					}, enter ? settings.showDelay : settings.hideDelay );
				}
			})
			.bind('click.jdmenu', function(evt) {

// ignore menu item separator
				var hr = $('> hr', this);
				if (hr.length > 0) {
					return ;
				}
// end
				var ul = $('> ul', this);
				if ( ul.length == 1 && 
					( settings.disableLinks == true || $(this).hasClass('accessible') ) ) {
					showMenu( ul, settings.onAnimate, settings.isVertical );
					return false;
				}
				
				// The user clicked the li and we need to trigger a click for the a
				if ( evt.target == this ) {
					var link = $('> a', evt.target).not('.accessible');
					if ( link.length > 0 ) {
						var a = link[0];
						if ( !a.onclick ) {
							window.open( a.href, a.target || '_self' );
						} else {
							$(a).trigger('click');
						}
					}
				}
				if ( settings.disableLinks || 
					( !settings.disableLinks && !$(this).parent().hasClass('jd_menu') ) ) {
					$(this).parent().jdMenuHide();
					evt.stopPropagation();
				}
			})
			.find('> a')
				.bind('focus.jdmenu blur.jdmenu', function(evt) {
					var p = $(this).parents('li:eq(0)');
					if ( evt.type == 'focus' ) {
						p.addClass('jdm_hover');
					} else { 
						p.removeClass('jdm_hover');
					}
				})
				.filter('.accessible')
					.bind('click.jdmenu', function(evt) {
						evt.preventDefault();
					});
	}

	function showMenu(ul, animate, vertical) {
		var ul = $(ul);
		if ( ul.is(':visible') ) {
			return;
		}
		// optional bgiframe plugin
		if (ul.bgiframe) ul.bgiframe ();
		var li = ul.parent();
		ul	.trigger('jdMenuShow')
			.positionBy({ 	target: 	li[0], 
							targetPos: 	( vertical === true || !li.parent().hasClass('jd_menu') ? 1 : 3 ), 
							elementPos: 0,
							hideAfterPosition: true
							});
		if ( !ul.hasClass('jdm_events') ) {
			ul.addClass('jdm_events');
			addEvents(ul);
		}
		li	.addClass('jdm_active')
			// Hide any adjacent menus
			.siblings('li').find('> ul:eq(0):visible')
				.each(function(){
					hideMenu( this ); 
				});
		if ( animate === undefined ) {
			ul.show();
		} else {
			animate.apply( ul[0], [true] );
		}
	}
	
	function hideMenu(ul, animate) {
		var ul = $(ul);
		$('.bgiframe', ul).remove();
		ul	.filter(':not(.jd_menu)')
			.find('> li > ul:eq(0):visible')
				.each(function() {
					hideMenu( this );
				})
			.end();
		if ( animate === undefined ) {
			ul.hide()
		} else {
			animate.apply( ul[0], [false] );
		}

		ul	.trigger('jdMenuHide')
			.parents('li:eq(0)')
				.removeClass('jdm_active jdm_hover')
			.end()
				.find('> li')
				.removeClass('jdm_active jdm_hover');
	}
	
	// Public methods
	$.fn.jdMenu = function(settings) {
		// Future settings: activateDelay
		var settings = $.extend({	// Time in ms before menu shows
									showDelay: 		200,
									// Time in ms before menu hides
									hideDelay: 		500,
									// Should items that contain submenus not 
									// respond to clicks
									disableLinks:	true
									// This callback allows for you to animate menus
									//onAnimate:	null
									}, settings);
		if ( !$.isFunction( settings.onAnimate ) ) {
			settings.onAnimate = undefined;
		}
		return this.filter('ul.jd_menu').each(function() {
			$.data(	this, 
					'jdMenuSettings', 
					$.extend({ isVertical: $(this).hasClass('jd_menu_vertical') }, settings) 
					);
			addEvents(this);
		});
	};
	
	$.fn.jdMenuUnbind = function() {
		$('ul.jdm_events', this)
			.unbind('.jdmenu')
			.find('> a').unbind('.jdmenu');
	};
	$.fn.jdMenuHide = function() {
		return this.filter('ul').each(function(){ 
			hideMenu( this );
		});
	};

	// Private methods and logic
	$(window)
		// Bind a click event to hide all visible menus when the document is clicked
		.bind('click.jdmenu', function(){
			$('ul.jd_menu ul:visible').jdMenuHide();
		});
})(jQuery);

// This initializes the menu
$(function() {
	$('ul.jd_menu').jdMenu();
});
/*
(c) Copyrights 2007 - 2008

Original idea by by Binny V A, http://www.openjs.com/scripts/events/keyboard_shortcuts/
 
jQuery Plugin by Tzury Bar Yochay 
tzury.by@gmail.com
http://evalinux.wordpress.com
http://facebook.com/profile.php?id=513676303

Project's sites: 
http://code.google.com/p/js-hotkeys/
http://github.com/tzuryby/hotkeys/tree/master

License: same as jQuery license. 

USAGE:
    // simple usage
    $(document).bind('keydown', 'Ctrl+c', function(){ alert('copy anyone?');});
    
    // special options such as disableInIput
    $(document).bind('keydown', {combi:'Ctrl+x', disableInInput: true} , function() {});
    
Note:
    This plugin wraps the following jQuery methods: $.fn.find, $.fn.bind and $.fn.unbind
*/

(function (jQuery){
    // keep reference to the original $.fn.bind, $.fn.unbind and $.fn.find
    jQuery.fn.__bind__ = jQuery.fn.bind;
    jQuery.fn.__unbind__ = jQuery.fn.unbind;
    jQuery.fn.__find__ = jQuery.fn.find;
    
    var hotkeys = {
        version: '0.7.9',
        override: /keypress|keydown|keyup/g,
        triggersMap: {},
        
        specialKeys: { 27: 'esc', 9: 'tab', 32:'space', 13: 'return', 8:'backspace', 145: 'scroll', 
            20: 'capslock', 144: 'numlock', 19:'pause', 45:'insert', 36:'home', 46:'del',
            35:'end', 33: 'pageup', 34:'pagedown', 37:'left', 38:'up', 39:'right',40:'down', 
            109: '-', 
            112:'f1',113:'f2', 114:'f3', 115:'f4', 116:'f5', 117:'f6', 118:'f7', 119:'f8', 
            120:'f9', 121:'f10', 122:'f11', 123:'f12', 191: '/'},
        
        shiftNums: { "`":"~", "1":"!", "2":"@", "3":"#", "4":"$", "5":"%", "6":"^", "7":"&", 
            "8":"*", "9":"(", "0":")", "-":"_", "=":"+", ";":":", "'":"\"", ",":"<", 
            ".":">",  "/":"?",  "\\":"|" },
        
        newTrigger: function (type, combi, callback) { 
            // i.e. {'keyup': {'ctrl': {cb: callback, disableInInput: false}}}
            var result = {};
            result[type] = {};
            result[type][combi] = {cb: callback, disableInInput: false};
            return result;
        }
    };
    // add firefox num pad char codes
    //if (jQuery.browser.mozilla){
    // add num pad char codes
    hotkeys.specialKeys = jQuery.extend(hotkeys.specialKeys, { 96: '0', 97:'1', 98: '2', 99: 
        '3', 100: '4', 101: '5', 102: '6', 103: '7', 104: '8', 105: '9', 106: '*', 
        107: '+', 109: '-', 110: '.', 111 : '/',
			189:'minus', 187:'equal'
        });
    //}
    
    // a wrapper around of $.fn.find 
    // see more at: http://groups.google.com/group/jquery-en/browse_thread/thread/18f9825e8d22f18d
    jQuery.fn.find = function( selector ) {
        this.query = selector;
        return jQuery.fn.__find__.apply(this, arguments);
	};
    
    jQuery.fn.unbind = function (type, combi, fn){
        if (jQuery.isFunction(combi)){
            fn = combi;
            combi = null;
        }
        if (combi && typeof combi === 'string'){
            var selectorId = ((this.prevObject && this.prevObject.query) || (this[0].id && this[0].id) || this[0]).toString();
            var hkTypes = type.split(' ');
            for (var x=0; x<hkTypes.length; x++){
                delete hotkeys.triggersMap[selectorId][hkTypes[x]][combi];
            }
        }
        // call jQuery original unbind
        return  this.__unbind__(type, fn);
    };
    
    jQuery.fn.bind = function(type, data, fn){
        // grab keyup,keydown,keypress
        var handle = type.match(hotkeys.override);
        
        if (jQuery.isFunction(data) || !handle){
            // call jQuery.bind only
            return this.__bind__(type, data, fn);
        }
        else{
            // split the job
            var result = null,            
            // pass the rest to the original $.fn.bind
            pass2jq = jQuery.trim(type.replace(hotkeys.override, ''));
            
            // see if there are other types, pass them to the original $.fn.bind
            if (pass2jq){
                result = this.__bind__(pass2jq, data, fn);
            }            
            
            if (typeof data === "string"){
                data = {'combi': data};
            }
            if(data.combi){
                for (var x=0; x < handle.length; x++){
                    var eventType = handle[x];
                    var combi = data.combi.toLowerCase(),
                        trigger = hotkeys.newTrigger(eventType, combi, fn),
                        selectorId = ((this.prevObject && this.prevObject.query) || (this[0].id && this[0].id) || this[0]).toString();
                        
                    //trigger[eventType][combi].propagate = data.propagate;
                    trigger[eventType][combi].disableInInput = data.disableInInput;
                    
                    // first time selector is bounded
                    if (!hotkeys.triggersMap[selectorId]) {
                        hotkeys.triggersMap[selectorId] = trigger;
                    }
                    // first time selector is bounded with this type
                    else if (!hotkeys.triggersMap[selectorId][eventType]) {
                        hotkeys.triggersMap[selectorId][eventType] = trigger[eventType];
                    }
                    // make trigger point as array so more than one handler can be bound
                    var mapPoint = hotkeys.triggersMap[selectorId][eventType][combi];
                    if (!mapPoint){
                        hotkeys.triggersMap[selectorId][eventType][combi] = [trigger[eventType][combi]];
                    }
                    else if (mapPoint.constructor !== Array){
                        hotkeys.triggersMap[selectorId][eventType][combi] = [mapPoint];
                    }
                    else {
                        hotkeys.triggersMap[selectorId][eventType][combi][mapPoint.length] = trigger[eventType][combi];
                    }
                    
                    // add attribute and call $.event.add per matched element
                    this.each(function(){
                        // jQuery wrapper for the current element
                        var jqElem = jQuery(this);
                        
                        // element already associated with another collection
                        if (jqElem.attr('hkId') && jqElem.attr('hkId') !== selectorId){
                            selectorId = jqElem.attr('hkId') + ";" + selectorId;
                        }
                        jqElem.attr('hkId', selectorId);
                    });
                    result = this.__bind__(handle.join(' '), data, hotkeys.handler)
                }
            }
            return result;
        }
    };
    // work-around for opera and safari where (sometimes) the target is the element which was last 
    // clicked with the mouse and not the document event it would make sense to get the document
    hotkeys.findElement = function (elem){
        if (!jQuery(elem).attr('hkId')){
            if (jQuery.browser.opera || jQuery.browser.safari){
                while (!jQuery(elem).attr('hkId') && elem.parentNode){
                    elem = elem.parentNode;
                }
            }
        }
        return elem;
    };
    // the event handler
    hotkeys.handler = function(event) {
        var target = hotkeys.findElement(event.currentTarget), 
            jTarget = jQuery(target),
            ids = jTarget.attr('hkId');
        
        if(ids){
            ids = ids.split(';');
            var code = event.which,
                type = event.type,
                special = hotkeys.specialKeys[code],
                // prevent f5 overlapping with 't' (or f4 with 's', etc.)
                character = !special && String.fromCharCode(code).toLowerCase(),
                shift = event.shiftKey,
                ctrl = event.ctrlKey,            
                // patch for jquery 1.2.5 && 1.2.6 see more at:  
                // http://groups.google.com/group/jquery-en/browse_thread/thread/83e10b3bb1f1c32b
                alt = event.altKey || event.originalEvent.altKey,
                mapPoint = null;

            for (var x=0; x < ids.length; x++){
                if (hotkeys.triggersMap[ids[x]][type]){
                    mapPoint = hotkeys.triggersMap[ids[x]][type];
                    break;
                }
            }
            
            //find by: id.type.combi.options            
            if (mapPoint){ 
                var trigger;
                // event type is associated with the hkId
                if(!shift && !ctrl && !alt) { // No Modifiers
                    trigger = mapPoint[special] ||  (character && mapPoint[character]);
                }
                else{
                    // check combinations (alt|ctrl|shift+anything)
                    var modif = '';
                    if(alt) modif +='alt+';
                    if(ctrl) modif+= 'ctrl+';
                    if(shift) modif += 'shift+';
                    // modifiers + special keys or modifiers + character or modifiers + shift character or just shift character
                    trigger = mapPoint[modif+special];
                    if (!trigger){
                        if (character){
                            trigger = mapPoint[modif+character] 
                                || mapPoint[modif+hotkeys.shiftNums[character]]
                                // '$' can be triggered as 'Shift+4' or 'Shift+$' or just '$'
                                || (modif === 'shift+' && mapPoint[hotkeys.shiftNums[character]]);
                        }
                    }
                }
                if (trigger){
                    var result = false;
                    for (var x=0; x < trigger.length; x++){
                        if(trigger[x].disableInInput){
                            // double check event.currentTarget and event.target
                            var elem = jQuery(event.target);
                            if (jTarget.is("input") || jTarget.is("textarea") || jTarget.is("select") 
                                || elem.is("input") || elem.is("textarea") || elem.is("select")) {
                                return true;
                            }
                        }                       
                        // call the registered callback function
                        result = result || trigger[x].cb.apply(this, [event]);
                    }
                    return result;
                }
            }
        }
    };
    // place it under window so it can be extended and overridden by others
    window.hotkeys = hotkeys;
    return jQuery;
})(jQuery);
jQuery.myPage = {
	/*float*/ zoom: 1,
	zoomIn : function  () {
		$.myPage.zoom += 0.1;
		document.body.style.zoom = $.myPage.zoom;
	},
	zoomOut : function () {
		if ($.myPage.zoom > 0.5) {
			$.myPage.zoom -= 0.1;
			document.body.style.zoom = $.myPage.zoom;
		}
	},
	nextPage: function () {
		if ($("#anc_next").get(0)) {
			window.location.href = $("#anc_next").get(0).href;
		}
	},
	prevPage: function () {
		if ($("#anc_prev").get(0)) {
			window.location.href = $("#anc_prev").get(0).href;
		}
	}
};

$(function () {
	if (window.location.href.indexOf ("cover.html") == -1) {
		$("#PageInnerFrame").prepend('<div class="jd_bar" id="MainMenu"><ul class="jd_menu"><li><span>导览目录</span><ul><li><a href="~/index.html">首页</a></li><li><a href="~/jinian/index.html">纪念专辑</a></li><li>唐宋名家词选　　　→<ul><li><b><a href="~/tangsongci/index.html">唐宋名家词选</a></b></li><li><hr></li><li><a href="~/tangsongci/mulu.html">原书目录</a></li><li><a href="~/tangsongci/pinyin.html">词人姓氏读音排序目录</a></li><li><a href="~/tangsongci/tongji.html">词作数目排序目录</a></li><li><hr></li><li><a href="~/tangsongci/ciren.html">词人传记与集评</a></li></ul></li><li>近三百年名家词选　→<ul><li><b><a href="~/jindaici/index.html">近三百年名家词选</a></b></li><li><hr></li><li><a href="~/jindaici/mulu.html">原书目录</a></li><li><a href="~/jindaici/pinyin.html">词人姓氏读音排序目录</a></li><li><a href="~/jindaici/tongji.html">词作数目排序目录</a></li><li><hr></li><li><a href="~/jindaici/ciren.html">词人传记与集评</a></li></ul></li><li><a href="~/cixueshijiang/index.html">词学十讲</a></li><li><a href="~/zhongguoyunwenshi/index.html">中国韵文史</a></li><li>唐宋词格律　　　　→<ul><li><b><a href="~/cipai/index.html">唐宋词格律</a></b></li><li><hr></li><li><a href="~/cipai/mulu.html">韵脚分类目录</a></li><li><a href="~/cipai/pinyin.html">词牌名称排序目录</a></li><li><a href="~/cipai/zishu.html">词牌字数排序目录</a></li></ul></li><li><hr></li><li><a href="~/about/gy-xiazai.html">下载电子书</a></li></ul></li><li><span>使用说明</span><ul><li><a href="~/about/gy-shiyongshuoming.html">使用说明</a></li><li><a href="~/about/shuoming-tili.html">电子版体例说明</a></li><li><a href="~/about/shuoming-biaozhi.html">格律标识说明</a></li><li><a href="~/about/shuoming-dianzishu.html">电子书使用方法</a></li><li><a href="~/about/shuoming-ziti.html">汉字字体</a></li><li><a href="~/about/shuoming-jianpan.html" title="使用键盘阅读电子书的方法">键盘导航快捷键</a></li></ul></li><li><span>辅助功能</span><ul style="width: 200px"><li><a href="javascript:window.print();">打印本页 (Ctrl+P)</a></li><li><a href="javascript:$.myPage.zoomIn();">放大页面字体 (键盘+)</a></li><li><a href="javascript:$.myPage.zoomOut();">缩小页面字体 (键盘-)</a></li><li id="rel"><a href="javascript:$.myPage.nextPage();">下一篇 (键盘右箭头→)</a></li><li id="rev"><a href="javascript:$.myPage.prevPage();">上一篇 (键盘左箭头←)</a></li><li id="ftSearchLink"><a href="~/help/search.html">全文检索</a></li></ul></li><li><span>网上内容</span><ul style="width: 200px"><li><div><img src="~/images/qrcode.png" alt="公众号二维码"/></div><div>龙榆生词学公众号</div></li><li><a href="https://gitee.com/wmjordan/longyusheng" target="_blank">网站开放源代码项目</a></li></ul></li></ul></div>'.replace (/~\//g, depth));
		if (window.location.href.indexOf ("://longyusheng.org/") == -1) {
			$("#ftSearchLink").remove();
		}
        if (!$.support.boxModel) {
            $("#MainMenu").css("position", "absolute");
        }
		if ($("#anc_next").get(0)) {
			$("#rel").get(0).title = "转到 " + $("#anc_next").text();
		}
		else {
			$("#rel").remove();
		}
		if ($("#anc_prev").get(0)) {
			$("#rev").get(0).title = "转到 " + $("#anc_prev").text();
		}
		else {
			$("#rev").remove();
		}
		//$("#fbLink").get(0).href += "?from=" + window.location.href.replace (/http:\/\/longyusheng\.org\//gi, '');
		$('ul.jd_menu').jdMenu();
	}
	$(document).bind('keydown', {combi:'+',disableInInput:true}, $.myPage.zoomIn);
	$(document).bind('keydown', {combi:'-',disableInInput:true}, $.myPage.zoomOut);
	$(document).bind('keydown', {combi:'equal',disableInInput:true}, $.myPage.zoomIn);
	$(document).bind('keydown', {combi:'minus',disableInInput:true}, $.myPage.zoomOut);
	$(document).bind('keydown', {combi:'right',disableInInput:true}, $.myPage.nextPage);
	$(document).bind('keydown', {combi:'2',disableInInput:true}, $.myPage.nextPage);
	$(document).bind('keydown', {combi:'left',disableInInput:true}, $.myPage.prevPage);
	$(document).bind('keydown', {combi:'1',disableInInput:true}, $.myPage.prevPage);
	$(".cr:first").prepend($('<div><img src="~/images/qrcode-2.png" id="qrcode" style="max-width:100%" alt="龙榆生词学公众号" /></div>'.replace(/~\//g, depth))[0]);
}
);

