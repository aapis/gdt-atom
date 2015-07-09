TestView = require './test-view'
{CompositeDisposable} = require 'atom'

module.exports = Granify =
  testView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @testView = new TestView(state.testViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @testView.getElement(), visible: false)
    @namespace = @.prototype.toString().toLowerCase()
    console.log(@namespace)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # granify:github_merged_today
    # granify:github_merged_on
    # granify:github_merged_between
    # granify:recompile
    # granify:resync
    # granify:startup
    # granify:test_granify
    # granify:test_goliath
    # granify:test_js
    # granify:workingon

    # Register command that toggles this view
    @subscriptions.add(atom.commands.add('atom-workspace', 'granify:recompile': => @toggle()))

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @testView.destroy()

  serialize: ->
    testViewState: @testView.serialize()

  toggle: ->
    console.log 'Test was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
