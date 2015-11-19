Mkpasswd = require "./mkpasswd"
mkpasswd = new Mkpasswd()

Help = require "./helper"
help = new Help()

config = {
  json: "./resources/crypt.json"
  length: [4,5,6,8,12,14,15,16,24,32,48]
  target: "contents"
}
jsonParsed = {};

###
# Views
###
makeLengthList = ()->
  selectBox = '<label for="lengthList">Length</label><select id="lengthList">'
  for i in config.length
    selectBox += '<option value="'+i+'"> '+i+'</option>'
  selectBox += '</select>'
  return selectBox

makeStrTypeSelecta = ()->
  selectBox  = '<label for="strType">StringsType</label>'
  selectBox += '<select id="strType">'
  selectBox += '<option value="mix_case">Symbol Mixed</option>'
  selectBox += '<option value="mix">Upper/Lower Mixed</option>'
  selectBox += '<option value="lower">Lower Case</option>'
  selectBox += '<option value="upper">Upper Case</option>'
  selectBox += '</select>'
  return selectBox

makeForm = ()->
  return '<form action="#" method="get" id="makeRandInput"></form>'

putHTML = ()->
  help.$id(config.target).innerHTML = makeForm()
  inputs = makeLengthList() + makeStrTypeSelecta()
  help.$id("makeRandInput").innerHTML = inputs
  child = document.createElement("p")
  child.innerHTML = '<textarea id="randStringResult">password here</textarea>'
  help.$id(config.target).appendChild child

###
# controllers
###
formEventHandlr = ()->
  event = new Event('submit',{
    'bubbles': true
    'cancelable': true
  })

  help.$event "makeRandInput", "submit", (e)->
    e.preventDefault();
    lengthSetting = help.$id("lengthList").value
    stringType    = help.$id("strType").value
    randomString  = mkpasswd.make(jsonParsed, lengthSetting,stringType)
    putRandomString(randomString)

  help.$event "lengthList", "change", ()->
    help.$id("makeRandInput").dispatchEvent(event)

  help.$event "strType", "change", ()->
    help.$id("makeRandInput").dispatchEvent(event)

putRandomString = (randomString) ->
  help.$id("randStringResult").value = randomString

successFunc = (jsonData) ->
  jsonParsed = JSON.parse(jsonData)
  putHTML()
  formEventHandlr()

###
# init
###
help.getJson config.json,(json)->
  jsonData = json
  successFunc(jsonData)