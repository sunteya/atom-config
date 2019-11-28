# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"
#
# atom.commands.add 'atom-text-editor', 'user:insert-date': (event) ->
#   editor = @getModel()
#   editor.insertText(new Date().toLocaleString())
atom.commands.add 'atom-text-editor', 'user:toggle-exclude-vcs-ignored-paths', ->
  oldValue = atom.config.get("core.excludeVcsIgnoredPaths") || false
  newValue = !oldValue
  atom.config.set("core.excludeVcsIgnoredPaths", newValue)
  if newValue
    atom.notifications.addSuccess("Enable Exclude VCS Ignored Paths")
  else
    atom.notifications.addWarning("Disable Exclude VCS Ignored Paths")

# https://github.com/callahanrts/multiple-keymaps/blob/master/lib/multiple-keymaps.coffee
for keymap in fs.readdirSync "#{atom.configDirPath}/keymaps"
  atom.keymaps.loadKeymap "#{atom.configDirPath}/keymaps/#{keymap}"


# auto switch im
{ exec } = require('child_process')

fcitx =
  exit: ->
    exec 'fcitx-remote', (err, stdout, stderr) =>
      @origin = stdout.trim()
      if @origin == "2"
        exec 'fcitx-remote -c'
  enter: ->
    "skip"
    # exec 'fcitx-remote -o' if @origin == "2"

consumeService = (packageName, providerName, fn) ->
  disposable = atom.packages.onDidActivatePackage (pack) ->
    return unless pack.name is packageName
    service = pack.mainModule[providerName]()
    fn(service)
    disposable.dispose()

consumeService 'vim-mode-plus', 'provideVimModePlus', (service) ->
  service.observeVimStates (vimState) ->
    vimState.modeManager.onDidDeactivateMode ({mode}) ->
      fcitx.exit() if mode is 'insert'
    vimState.modeManager.onWillActivateMode ({mode}) ->
      fcitx.enter() if mode is 'insert'
