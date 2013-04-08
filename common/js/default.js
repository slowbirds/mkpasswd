/*#####################################
# default functions
# since:	05.19.2008
# modified: 05.19.2008
# edited:   akato
#####################################*/

//window.event for cross browser
function windowEventX() {
	if(window.attachEvent && document.getElementById) return;//not for ie
	for (var property in Event.prototype){
		if(property.match(/MOUSE|CLICK/)){
			window.addEventListener(property.toLowerCase(), function(e){window.event = e;}, true);
		}
	}
}
//cross browser & array EventListner
function addEventListnerX(target,event,func) {//dom,on**,function
	if(target.length > 1) {
		for(var i=0;i<target.length;i++) {
			if (window.addEventListener) {
				event = event.replace(/^(on)/,"");
				target[i].addEventListener(event,func,false);
			}else if (window.attachEvent && document.getElementById) {
				target[i].attachEvent(event,func);
			}
		}
	}else {
		if (window.addEventListener) {
			event = event.replace(/^(on)/,"");
			target.addEventListener(event,func,false);
		}else if (window.attachEvent && document.getElementById) {
			target.attachEvent(event,func);
		}
	}
}

//rollOverImages
function rollOver() {
	var aPreLoad = new Array();
	var sTempSrc;
	var aImages = document.getElementsByTagName('img');
	for (var i = 0; i < aImages.length; i++) {
		if (aImages[i].className == 'rollover') {
			var src = aImages[i].getAttribute('src');
			var ftype = src.substring(src.lastIndexOf('.'), src.length);
			var hsrc = src.replace(ftype, '_s'+ftype);
			aImages[i].setAttribute('hsrc', hsrc);
			aPreLoad[i] = new Image();
			aPreLoad[i].src = hsrc;
			aImages[i].onmouseover = function() {
				sTempSrc = this.getAttribute('src');
				this.setAttribute('src', this.getAttribute('hsrc'));
			}
			aImages[i].onmouseout = function() {
				if (!sTempSrc) sTempSrc = this.getAttribute('src').replace('_s'+ftype, ftype);
				this.setAttribute('src', sTempSrc);
			}
		}
	}
}

//replace "_blank" tag. for strict XHTML
function blanker() {
	var sTempHref;
	var aLinks = document.getElementsByTagName('a');
	for (var i = 0; i < aLinks.length; i++) {
		if (aLinks[i].getAttribute('rel') == 'external') {
			var href = aLinks[i].getAttribute('href');
			aLinks[i].onclick = function() {
				sTempHref = this.getAttribute('href');
				window.open(sTempHref);
				return false;
			}
		}
	}
}

//readonly textarea
function selectText() {
	var aTextareas = document.getElementsByTagName('textarea');
	var aInputs	= document.getElementsByTagName('input');
	for (var i = 0; i < aTextareas.length; i++) {
		if (aTextareas[i].getAttribute('readonly')) {
			aTextareas[i].onfocus = function() {this.select();}
			aTextareas[i].onclick = function() {this.select();}
		}
	}

	for (var i = 0; i< aInputs.length; i++) {
		if(aInputs[i].getAttribute('type') == 'text' && aInputs[i].getAttribute('readonly')) {
			aInputs[i].onfocus = function() {this.select();}
			aInputs[i].onclick = function() {this.select();}
		}
		
	}

}

//function default javascripts
onload = function() {
	if (!document.getElementById) return
	rollOver();
	blanker();
	selectText();
	windowEventX();
};