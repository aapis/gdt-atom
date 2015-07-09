TestView = require './hadoken'
{CompositeDisposable} = require 'atom'

module.exports =
  testView: null
  modalPanel: null
  subscriptions: null
  controller: null

  activate: (state) ->
    @testView = new TestView(state.testViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @testView.getElement(), visible: false)
    @namespace = "granify"

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    commands = [
      "github_merged_today",
      "github_merged_on",
      "github_merged_between",
      "recompile",
      "resync",
      "startup",
      "test_granify",
      "test_goliath",
      "test_js",
      "workingon"
    ]

    @load(commands)

    commands.forEach((cmd) =>
      # Register command that toggles this view
      atom_cmd = @namespace + ":" + cmd

      if @controller[cmd]
        @subscriptions.add(atom.commands.add('atom-workspace', atom_cmd: => @controller[cmd]))
      else
        console.error("CMD NOT FOUND: ", atom_cmd)
    )

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @testView.destroy()

  load: (commands) ->
    commands.forEach((cmd) => 
      chunks = cmd.split("_")
      is_namespaced = chunks.length > 1

      if is_namespaced
        path = './'+ chunks[0]
        lib = require [path]
        console.log(lib)
        # namespace = cmd.split("_")[0]
        # @controller = new lib()
      else
        lib = require './granify'
        @controller = new lib()
    )

  serialize: ->
    testViewState: @testView.serialize()

  toggle: ->
    console.log 'Test was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
