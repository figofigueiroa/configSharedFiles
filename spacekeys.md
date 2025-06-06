

```yaml
# Spacekeys Plugin Configuration - LazyVim Style
# Based on LazyVim keybindings structure

items:
  # Single key shortcuts (LazyVim style)
  TAB: workspace:next-tab
  "/": global-search:open
  "?": switcher:open
  e: file-explorer:reveal-active-file
  E: file-explorer:open

  # File operations (Space + f)
  f:
    description: File
    items:
      f: switcher:open                    # Find file
      r: switcher:open                    # Recent files  
      n: file-explorer:new-file           # New file
      s: editor:save-file                 # Save file
      S: editor:save-file                 # Save all (same as save in Obsidian)
      t: file-explorer:reveal-active-file # File tree
      "/": editor:open-search             # Search in file
      
      # File operations submenu
      c:
        description: Config
        items:
          c: app:open-settings            # Open settings
          r: app:reload                   # Reload config

  # Buffer/Tab operations (Space + b)
  b:
    description: Buffer
    items:
      b: switcher:open                    # Buffer list
      d: workspace:close                  # Delete buffer
      D: workspace:close-others           # Delete other buffers
      n: workspace:next-tab               # Next buffer
      p: workspace:previous-tab           # Prev buffer
      f: switcher:open                    # Find buffer
      l: workspace:goto-last-tab          # Last buffer

  # Search operations (Space + s)
  s:
    description: Search
    items:
      s: editor:open-search               # Search in file
      g: global-search:open               # Global search (live grep)
      r: editor:open-search-replace       # Search and replace
      w: global-search:open               # Search word under cursor
      f: global-search:open               # Find files
      h: global-search:open               # Search help
      k: command-palette:open             # Search keymaps
      c: command-palette:open             # Search commands

  # Window operations (Space + w)
  w:
    description: Window
    items:
      s: workspace:split-horizontal       # Split horizontal
      v: workspace:split-vertical         # Split vertical
      c: workspace:close                  # Close window
      o: workspace:close-others           # Close other windows
      h: editor:focus-left                # Focus left
      j: editor:focus-bottom              # Focus down
      k: editor:focus-top                 # Focus up
      l: editor:focus-right               # Focus right
      w: workspace:next-tab               # Switch windows
      "=": workspace:close                # Balance windows (close approximation)
      
      # Window management
      H: workspace:move-to-new-window     # Move window left
      J: workspace:move-to-new-window     # Move window down
      K: workspace:move-to-new-window     # Move window up
      L: workspace:move-to-new-window     # Move window right

  # Code/LSP operations (Space + c)
  c:
    description: Code
    items:
      a: command-palette:open             # Code actions
      d: command-palette:open             # Diagnostics
      f: command-palette:open             # Format
      r: command-palette:open             # Rename
      s: command-palette:open             # Document symbols
      S: global-search:open               # Workspace symbols

  # Git operations (Space + g)
  g:
    description: Git
    items:
      g: command-palette:open             # Git status (open git commands)
      c: command-palette:open             # Git commit
      p: command-palette:open             # Git push
      P: command-palette:open             # Git pull
      b: command-palette:open             # Git branches
      l: command-palette:open             # Git log
      s: command-palette:open             # Git status
      d: command-palette:open             # Git diff

  # Toggle operations (Space + t)
  t:
    description: Toggle
    items:
      t: app:toggle-theme                 # Toggle theme
      s: app:toggle-left-sidebar          # Toggle sidebar
      S: app:toggle-right-sidebar         # Toggle right sidebar
      f: editor:toggle-focus              # Toggle focus mode
      z: editor:toggle-zen-mode           # Toggle zen mode
      w: editor:toggle-fold               # Toggle word wrap
      n: editor:toggle-line-numbers       # Toggle line numbers
      r: app:toggle-ribbon                # Toggle ribbon
      p: editor:toggle-source             # Toggle preview mode

  # UI/Interface (Space + u)
  u:
    description: UI
    items:
      f: file-explorer:toggle             # File explorer
      o: outline:toggle                   # Outline
      t: tag-pane:toggle                  # Tags
      s: global-search:open               # Search panel
      c: command-palette:open             # Command palette
      h: help:open                        # Help

  # Notes/Navigation (Space + n)
  n:
    description: Notes
    items:
      n: file-explorer:new-file           # New note
      f: switcher:open                    # Find note
      r: workspace:edit-file-title        # Rename note
      d: app:delete-file                  # Delete note
      c: file-explorer:duplicate-file     # Copy note
      t: file-explorer:new-file           # New note from template
      l: editor:insert-link               # Insert link
      b: app:go-back                      # Go back
      F: app:go-forward                   # Go forward

  # Help/Info (Space + h)
  h:
    description: Help
    items:
      h: help:open                        # Help
      k: command-palette:open             # Keymaps
      c: command-palette:open             # Commands
      m: command-palette:open             # Man pages
      t: command-palette:open             # Help tags

  # Quit operations (Space + q)
  q:
    description: Quit
    items:
      q: app:quit                         # Quit
      Q: app:quit                         # Quit without saving
      r: app:reload                       # Restart

  # LazyVim-style direct access
  x:
    description: Diagnostics/Trouble
    items:
      x: command-palette:open             # Diagnostics
      w: command-palette:open             # Workspace diagnostics
      d: command-palette:open             # Document diagnostics
      q: command-palette:open             # Quickfix
      l: command-palette:open             # Location list

  # Additional LazyVim patterns
  "?": command-palette:open               # Which-key help
  ":": command-palette:open               # Command mode
  ";": command-palette:open               # Repeat last command

  # Text objects/editing (Space + x for text operations)
  # Using existing text commands from your template
  o:
    description: Open/Options
    items:
      o: switcher:open                    # Open file
      r: switcher:open                    # Open recent
      f: file-explorer:toggle             # Open file explorer
      t: outline:toggle                   # Open outline
      p: command-palette:open             # Open palette

  # Insert mode helpers (Space + i)
  i:
    description: Insert
    items:
      l: editor:insert-link               # Insert link
      i: editor:attach-file               # Insert image
      c: editor:insert-codeblock          # Insert code block
      t: editor:insert-tag                # Insert tag
      e: editor:insert-embed              # Insert embed
      m: editor:insert-mathblock          # Insert math
      r: editor:insert-horizontal-rule    # Insert rule
```