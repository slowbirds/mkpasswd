chai = require 'chai'
expect = chai.expect
chai.should()

Mkpasswd = require("../mkpasswd")

describe 'Mkpasswd',->
  t = null

  it "expects constructor {symbols:6} is 6", ->
    t = new Mkpasswd({symbols:6})
    expect(t.symbols).to.equal(6)

  it "expects constructor {symbols:11} is 5", ->
    t = new Mkpasswd({symbols:11})
    expect(t.symbols).to.equal(5)

  it "expects constructor {symbols:'a'} is 5", ->
    t = new Mkpasswd({symbols:"a"})
    expect(t.symbols).to.equal(5)
