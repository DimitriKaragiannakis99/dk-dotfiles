--------------
-- obsidian --
--------------
--
-- >>> oo # from shell, navigate to vault (optional)
--
-- # NEW NOTE
-- >>> on "Note Name" # call my "obsidian new note" shell script (~/bin/on)
-- >>>
-- >>> ))) <leader>on # inside vim now, format note as template
-- >>> ))) # add tag, e.g. fact / blog / video / etc..
-- >>> ))) # add hubs, e.g. [[python]], [[machine-learning]], etc...
-- >>> ))) <leader>of # format title
--
-- # END OF DAY/WEEK REVIEW
-- >>> or # review notes in inbox
-- >>>
-- >>> ))) <leader>ok # inside vim now, move to zettelkasten
-- >>> ))) <leader>odd # or delete
-- >>>
-- >>> og # organize saved notes from zettelkasten into notes/[tag] folders
-- >>> ou # sync local with Notion
--
-- navigate to vault
vim.keymap.set('n', '<leader>oo', ':cd /Users/dimitrikaragiannakis/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-root<Cr>')
--
-- convert note to template and remove leading white space
vim.keymap.set('n', '<leader>on', ':ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>')

-- convert note to daily todo templace
vim.keymap.set('n', '<leader>td', ':ObsidianTemplate todo<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>')

-- must have cursor on title
vim.keymap.set('n', '<leader>of', ':.s/-/ /g<CR>')

-- for review workflow
-- move file in current buffer to zettelkasten folder
vim.keymap.set('n', '<leader>ok', function()
  -- Get full path of current file
  local filepath = vim.fn.expand '%:p'

  -- Destination folder
  local target_dir = '/Users/dimitrikaragiannakis/Library/Mobile Documents/iCloud~md~obsidian/Documents/obsidian-root/zettelkasten'

  -- Run mv via shell
  vim.fn.system { 'mv', filepath, target_dir }

  -- Close the buffer
  vim.cmd 'bd'
end, { noremap = true, silent = true })

-- delete file in current buffer
vim.keymap.set('n', '<leader>odd', ":!rm '%:p'<cr>:bd<cr>")
