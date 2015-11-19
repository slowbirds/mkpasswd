class Mkpasswd

  constructor: (args)->

  ###
  # Utility funxtions
  ###
  $id: (id)->
    return document.getElementById id

  $event: (target, event, func) ->
    this.$id(target).addEventListener event , (e) =>
        func(e)
    return

  getJson: (url,callback) ->
    xhr = new XMLHttpRequest()
    xhr.open 'GET', url

    xhr.onreadystatechange = ()->
      if xhr.readyState == 4 && xhr.status == 200
        callback xhr.responseText
      else if xhr.readyState == 4 && xhr.status != 200
        error xhr.status
      return this

    xhr.send()
    return this

  make: (jsonParsed, lengthSetting, stringType)->
    returnRandStrings = ""
    lengthSetting = lengthSetting - 0
    count = 0
    loop
      # make random from 0-9
      rand0 = Math.floor(Math.random() * 10)
      rand1 = Math.floor(Math.random() * 10)
      jsonStr = (jsonParsed.strings[rand0])[rand1]

      if stringType == "mix_case" && Math.floor(Math.random()*5) == 0
        jsonStr = jsonParsed.symbols[rand1]
        if typeof(jsonStr) == "undefined"
          console.log rand1
      # cases
      if stringType == "upper"
        jsonStr = jsonStr.toUpperCase()
      else if stringType == "lower"
        jsonStr = jsonStr.toLowerCase()

      returnRandStrings += jsonStr
      if ++count >= lengthSetting
        break

    return returnRandStrings

module.exports = Mkpasswd
