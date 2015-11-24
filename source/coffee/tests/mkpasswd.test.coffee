chai = require 'chai'
expect = chai.expect
chai.should()

Mkpasswd = require("../mkpasswd")

describe 'Mkpasswd',->
  t = null
  json = null

  before ->
    t = new Mkpasswd()
    json  = [
      '{"title":"crypt","strings":['
      '["a","2","D","3","w","J","S","f","8","5"],'
      '["b","s","H","5","8","k","N","4","m","E"],'
      '["6","9","V","R","3","g","e","t","x","Z"],'
      '["d","g","F","4","h","D","3","t","n","8"],'
      '["d","5","Y","f","7","k","8","G","r","2"],'
      '["H","s","4","Y","g","h","7","M","2","a"],'
      '["8","4","Q","j","5","f","k","2","W","m"],'
      '["d","s","8","X","U","2","k","5","h","N"],'
      '["g","v","d","G","a","h","4","y","R","8"],'
      '["s","3","A","f","n","5","N","3","S","2"]'
      '],'
      '"symbols":'
      '["!","@","#","$","%","^","&","*","(",")"]'
      '}'
    ].join('')

  it "expects constructor {symbols:6} is 6", ->
    t2 = new Mkpasswd({symbols:6})
    expect(t2.symbols).to.equal(6)

  it "expects constructor {symbols:11} is 5", ->
    t2 = new Mkpasswd({symbols:11})
    expect(t2.symbols).to.equal(5)

  it "expects constructor {symbols:'a'} is 5", ->
    t2 = new Mkpasswd({symbols:"a"})
    expect(t2.symbols).to.equal(5)

  it "check json must be true", ->
    expect(t.check(JSON.parse(json))).to.be.true

  it "make 200 length, must returned 200 strings", ->
    expect(t.make(json, 200, 'mix_case')).to.have.length(200)

  it "json is not formatted, then returned null", ->
    expect(t.make({}, 10, 'mix_case')).to.be.null
