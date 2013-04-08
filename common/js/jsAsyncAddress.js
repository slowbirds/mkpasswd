/*************************************************

	author:   akinori kato
	since:	2008-07-30
	modified: 2009-11-05
	package:  jsAsyncAddress.js
	comment:  respect for swfAddress.
			  simple implement.
	
	methods:
		trim:  trimming URI parameters.(remain"#/")
		query: set&read URI parameters.
			   auto judgement from argments
		uri:   extract plain URI.
			   return removal parameters.

*************************************************/
var jsAsyncAddress = function(){};
jsAsyncAddress.prototype = {
	trim : function() {
		var nowAddress = location.href;
		if(nowAddress.match(/#/)) {
			location.href=nowAddress.replace(/#.+/,"#/");
		}else {
			location.href += "#/";
		}
		return location.href;
	},
	querySet: function(setQuery) {
		var nowAddress = location.href;
		var setQueryBody = "";
		if(this.isArray(setQuery)) {
			for(var i = 0;i<setQuery.length;i++) {
				setQueryBody += encodeURIComponent(setQuery[i])+"/";
			}
		}else {
			setQueryBody = encodeURIComponent(setQuery);
		}
		var query = setQueryBody;
		if(nowAddress.match(/#\//)) {
			location.href=nowAddress.replace(/#.+/,"#/"+query);
		}else {
			location.href += "#/"+query;
		}
		return location.href;
	},
	queryGet: function() {
		var nowAddress = location.href;
		if(!nowAddress.match(/#/)) return false;
		var qeuryURI = nowAddress.replace(/.+#\//,"");
		qeuryURI = qeuryURI.replace(/\/$/,"");
		var query = decodeURIComponent(qeuryURI);
		query = query.split("/");
		return query;
	}, 
	query : function(setQuery) {
		if(setQuery) return this.querySet(setQuery);
		return this.queryGet();
	},
	uri : function() {
		var nowAddress = location.href;
		nowAddress = this.trim();
		nowAddress = nowAddress.replace(/#\//,"");
		return nowAddress;
	},
	isArray : function(val) {
		return(val.constructor===Array);
	}
};