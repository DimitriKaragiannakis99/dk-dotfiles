# 🌱 Dotfiles

Welcome to my personal **dotfiles**!  
This repository contains the configuration and small automations I use daily to customize my dev environment.  

---

### NVIM
- `/nvim` contains my entire nvim config including lazy
- `/nvim/lua/workflows.lua` has paths that need to be updated
- `/nvim/lua/plugins/obsidian.lua` has paths that need to be updated

1. Clone this repo
2. Make sure nvim is installed 
3. Symlink the nvim config directory

```bash
ln -s ~/{path-to-dotfiles}/dk-dotfiles/nvim ~/.config/nvim
```
4. Open nvim and let lazy download all the dependencies

### ⚙️ Bin Scripts
- `bin/` contains small executables I wrote to automate repetitive tasks:  
  - 🗂️ **Zettelkasten Organizer** → keeps my notes structured automatically.  

All scripts in `bin/` are executable and can be called directly once the folder is on your `$PATH`.

### 🐚 Zsh
- `.zshrc` includes my shell customizations:
  - Aliases for frequent commands.  
  - Plugin & prompt setup for a cleaner workflow.  

1. Clone this repo 
2. Make sure your system has **zsh** and **ghostty** downloaded
3. Symlink the zsh config files

```bash
ln -s ~/{path-to-dotfiles}/dk-dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/{path-to-dotfiles}/dk-dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
```
4. Run zsh

---

### Progress Bar
- Made in bash
- Progress bar for the processing of the transfer of files from my zettelkasten folder to their respective note folders


![progress-bar-video-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/80a091c3-932b-4740-a223-a202b15811eb)
