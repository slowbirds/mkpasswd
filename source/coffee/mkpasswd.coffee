class Mkpasswd
  symbols = 5
  constructor: (@args)->
    if typeof(this.args) == "undefined"
      this.args = {}
    if !(this.args.symbols < 10)
      this.symbols = 5
    else
      this.symbols = this.args.symbols

  get: (url,callback,error)->
    xhr = new XMLHttpRequest()
    xhr.open 'GET', url
    if typeof(error) == "undefined"
      error = (mes)->
        console.log mes

    xhr.onreadystatechange = ()->
      if xhr.readyState == 4 && xhr.status == 200
        callback xhr.responseText
      else if xhr.readyState == 4 && xhr.status != 200
        error xhr.status
      return this

    xhr.send()
    return this

  check: (json)->
    if typeof(json) == "undefined"
      return false
    if typeof(json.strings) == "undefined"
      return false
    if typeof(json.strings[0]) == "undefined"
      return false
    if typeof(json.strings[0][0]) == "undefined"
      return false
    return true

  make: (json, lengthSetting, stringType)->
    if typeof json == "string"
      json = JSON.parse json
    if !(this.check(json))
      return false
    returnRandStrings = ""
    lengthSetting = lengthSetting - 0
    count = 0
    loop
      # make random from 0-9
      rand0 = Math.floor(Math.random() * 10)
      rand1 = Math.floor(Math.random() * 10)
      jsonStr = (json.strings[rand0])[rand1]

      if stringType == "mix_case" && Math.floor(Math.random()*this.symbols) == 0
        jsonStr = json.symbols[rand1]
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
