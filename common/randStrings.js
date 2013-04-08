/*********************************************************************
* random String outputter with jQuery
* since:		2009-01-06
* lastmodified:	2010-02-01
* edited:   akato

* modified memo:
*	2010-02-02: make "mix_case" property.make a random signs(!@#^[])
**********************************************************************/
$(function() {
	/*****************************************************************
	* config
	******************************************************************/
	var config;
	configJson = "./modules/crypt.json";
	configLength = [4,5,6,8,12,14,15,16,24,32,48];
	configTarget = "div#contents";

	/****************************************************************
	* vars
	*****************************************************************/
	var jsonParth;
	var url = new jsAsyncAddress();
	
	/****************************************************************
	* make HTML elements
	*****************************************************************/
	var makeLengthList = function() {
		var selectBox = '<label for="lengthList">文字数</label>&nbsp;<select id="lengthList">';
		for(var i=0;i<configLength.length;i++) {
			selectBox += '<option value="'+configLength[i]+'"> '+configLength[i]+' 桁</option>';
		}
		selectBox += '</select>&nbsp;|&nbsp;';
		return selectBox;
	};
	var makeStrTypeSelecta = function() {
		var selectBox = '<label for="strType">文字タイプ</label>&nbsp;';
		selectBox += '<select id="strType">'
		selectBox += '<option value="mix_case">記号混在</option>';
		selectBox += '<option value="mix">混在</option>';
		selectBox += '<option value="lower">小文字</option>';
		selectBox += '<option value="upper">大文字</option>';
		selectBox += '</select>&nbsp;|&nbsp;';
		return selectBox;
	};
	var makeBtnBox = function() {
		var btnBox = '<button type="submit" value="submit"> make!! </button>';
		return btnBox;
	};
	var makeForm = function() {
		var formBox = '<form action="#" method="get" id="makeRandInput"></form>';
		return formBox;
	};
	var putHTML = function() {
		$(configTarget).html(makeForm());
		$("form#makeRandInput").html(makeLengthList()+makeStrTypeSelecta()+makeBtnBox());
		$(configTarget).append('<p><textarea id="randStringResult">ここに乱数が！</textarea></p>');
	};
	
	/*****************************************************************
	* eventHandlr
	******************************************************************/
	var formEventHandlr = function() {
		$("form#makeRandInput").submit(function() {
			var lengthSetting = $("select#lengthList").val();
			var stringType    = $("select#strType").val();
			var randomString  = makeRandString(lengthSetting,stringType);
			putRandomString(randomString);
			return false;
		});
		$("textarea#randStringResult").click(function() {
			this.select();
		});
	}
	
	/****************************************************************
	* methods
	*****************************************************************/
	var makeRandString = function(lengthSetting,stringType) {
		var returnRandStrings = "";
		
		lengthSetting = lengthSetting-0;
		for(var i=0;i<lengthSetting;i++){
			var randStrParent = Math.floor((99-10+1)*Math.random()+10)+"";
			var randStr0 = randStrParent.charAt(0);
			var randStr1 = randStrParent.charAt(1);
			
			var jsonStr = ((jsonParth[randStr0])[0])[randStr1];
			if(stringType === "upper") {
				jsonStr = jsonStr.toUpperCase();
			}else if(stringType === "lower") {
				jsonStr = jsonStr.toLowerCase();
			}
			returnRandStrings += jsonStr;
		}
		if(stringType === "mix_case") {
			returnRandStrings = returnRandStrings.replace(/[EeD]/,"[");
			returnRandStrings = returnRandStrings.replace(/[Ii1]/,"!");
			returnRandStrings = returnRandStrings.replace(/[aA]/,"^");
			returnRandStrings = returnRandStrings.replace(/[0o]/,"]");
			returnRandStrings = returnRandStrings.replace(/[Zz2]/,"@");
			returnRandStrings = returnRandStrings.replace(/[Kk]/,"#");
			returnRandStrings = returnRandStrings.replace(/[g3]/,"$");
		}
		return returnRandStrings;
	};
	var putRandomString = function(randomString) {
		$("textarea#randStringResult").html(randomString);
		url.query(randomString);
	};
	
	/****************************************************************
	* loading events
	*****************************************************************/
	var successFunc = function(jsonData) {
		jsonParth = jsonData.items[0];
		putHTML();
		formEventHandlr();
		if(url.query()[0]) $("textarea#randStringResult").html(url.query()[0]);
	};
	$.getJSON(configJson,function(json) {
		jsonData = json;
		successFunc(jsonData);
		return;
	});
});
