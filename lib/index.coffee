{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null
  controller: null

  activate: (state) ->
    # global command namespace
    @namespace = "granify"

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    commands = [
      "github_merged_today",
      "github_merged_on",
      "github_merged_between",
      "granify_recompile",
      "granify_resync",
      "granify_startup",
      "granify_workingon",
      "granify_toggle",
      "test_granify",
      "test_goliath",
      "test_js"
    ]

    # bind the above commands to their respective functions
    @load(commands)

  deactivate: ->
    @subscriptions.dispose()

  load: (commands) ->
    commands.forEach((cmd) =>
      chunks = cmd.split("_")
      atom_cmd = @namespace + ":" + cmd
      lib = require './'+ chunks[0]

      # remove command namespace to get the raw method name
      chunks.shift()
      method = chunks.join('_')
      instance = new lib()

      if typeof instance[method] == 'function'
        @subscriptions.add(atom.commands.add('atom-workspace', atom_cmd: -> instance[method](14)))
      else
        console.error('Method not found: ', method, atom_cmd)
    )
    atom.menu.update()
