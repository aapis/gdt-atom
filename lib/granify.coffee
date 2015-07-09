class Granify
  recompile: ->
    console.log("recompiling")

  resync: ->
    console.log('derp')

  startup: ->
    console.log('derp')

  workingon: ->
    console.log('workingon')

  toggle: ->
    console.log 'Test was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

module.exports = Granify