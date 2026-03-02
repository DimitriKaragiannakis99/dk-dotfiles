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
vim.keymap.set('n', '<leader>oo', ':cd $HOME/Documents/my-obs-vault/<Cr>')
--
-- convert note to template and remove leading white space
vim.keymap.set('n', '<leader>on', ':ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>')

-- convert note to daily todo template
vim.keymap.set('n', '<leader>je', ':ObsidianTemplate journal-entry<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>')

-- convert coding note using template
vim.keymap.set("n", "<leader>cn", function()

    vim.ui.input({ prompt = "Problem URL: " }, function(url)
      if not url then url = "" end

      vim.cmd("ObsidianTemplate coding-note")

      local date = os.date("%Y-%m-%d")
      local buf = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      for i, line in ipairs(lines) do
        lines[i] = line:gsub("{{date}}", date)
        lines[i] = line:gsub("{{URL}}", url)
      end
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end)
  end)

-- must have cursor on title
-- formatting the title for notes
vim.keymap.set('v', '<leader>of', [[:s/-/ /g | s/\<\(\w\)/\u\1/g<CR>]], { noremap = true, silent = true })

-- for review workflow
-- move file in current buffer to zettelkasten folder
vim.keymap.set('n', '<leader>ok', function()
  -- Get full path of current file
  local filepath = vim.fn.expand '%:p'

  -- Destination folder
  local target_dir = '$HOME/Documents/my-obs-vault/zettelkasten'

  -- Run mv via shell
  vim.fn.system { 'mv', filepath, target_dir }

  -- Close the buffer
  vim.cmd 'bd'
end, { noremap = true, silent = true })

-- delete file in current buffer
vim.keymap.set('n', '<leader>odd', ":!rm '%:p'<cr>:bd<cr>")
