TestView = require './test-view'
{CompositeDisposable} = require 'atom'

module.exports = Test =
  testView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @testView = new TestView(state.testViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @testView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'test:toggle': => @toggle()

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
