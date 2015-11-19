class Mkpasswd

  constructor: (@args)->
    if typeof(this.args) == "undefined"
      this.args = {}
    if !(this.args.symbols < 10)
      this.args.symbols = 5

  make: (jsonParsed, lengthSetting, stringType)->
    returnRandStrings = ""
    lengthSetting = lengthSetting - 0
    count = 0
    loop
      # make random from 0-9
      rand0 = Math.floor(Math.random() * 10)
      rand1 = Math.floor(Math.random() * 10)
      jsonStr = (jsonParsed.strings[rand0])[rand1]

      if stringType == "mix_case" && Math.floor(Math.random()*this.args.symbols) == 0
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
