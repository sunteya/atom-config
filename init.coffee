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

# https://github.com/callahanrts/multiple-keymaps/blob/master/lib/multiple-keymaps.coffee
for keymap in fs.readdirSync "#{atom.configDirPath}/keymaps"
  atom.keymaps.loadKeymap "#{atom.configDirPath}/keymaps/#{keymap}"

# atom.commands.add 'atom-text-editor', 'custom:leader-put-before', ->
#   element = atom.views.getView(atom.workspace)
#   atom.commands.dispatch(element, 'vim-mode-plus:set-register-name-to-*')
  # atom.commands.dispatch(element, 'vim-mode-plus:set-input-char-*')
  # atom.commands.dispatch(element, 'vim-mode-plus:yank')
# atom.commands.add 'atom-text-editor', 'custom:leader-yank', ->
  # element = atom.views.getView(atom.workspace)
  # atom.commands.dispatch(element, 'vim-mode-plus:set-register-name-to-*')
  # atom.commands.dispatch(element, 'vim-mode-plus:set-input-char-*')
  # atom.commands.dispatch(element, 'vim-mode-plus:yank')
