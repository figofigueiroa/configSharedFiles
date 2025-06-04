local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Helper functions for Kitty-like layouts
local function create_tall_layout(window, pane)
	local tab = window:active_tab()
	local panes = tab:panes_with_info()

	if #panes < 2 then
		-- Need at least 2 panes for tall layout
		window:perform_action(wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
		return
	end

	-- Set first pane to take 60% width, others split the remaining 40%
	tab:set_zoomed(false)
	for i, p in ipairs(panes) do
		if i == 1 then
			-- Main pane - resize to take more width
			window:perform_action(wezterm.action.AdjustPaneSize({ "Right", 20 }), p.pane)
		end
	end
end

local function create_fat_layout(window, pane)
	local tab = window:active_tab()
	local panes = tab:panes_with_info()

	if #panes < 2 then
		window:perform_action(wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
		return
	end

	-- Set first pane to take 60% height, others split horizontally below
	tab:set_zoomed(false)
	for i, p in ipairs(panes) do
		if i == 1 then
			window:perform_action(wezterm.action.AdjustPaneSize({ "Down", 20 }), p.pane)
		end
	end
end

local function create_grid_layout(window, pane)
	local tab = window:active_tab()
	local panes = tab:panes_with_info()

	-- Try to arrange panes in a grid pattern
	tab:set_zoomed(false)
	if #panes == 4 then
		-- 2x2 grid - adjust all panes to similar sizes
		window:perform_action(wezterm.action.PaneSelect({ mode = "Activate" }), pane)
	else
		-- For other numbers, just balance the panes
		window:perform_action(wezterm.action.RotatePanes("Clockwise"), pane)
	end
end

-- Configure keys to match Kitty defaults
config.keys = {
	-- Tab Management (Kitty defaults)
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	{ key = "q", mods = "CTRL|SHIFT", action = wezterm.action.QuitApplication },
	{ key = "]", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "[", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = ".", mods = "CTRL|SHIFT", action = wezterm.action.MoveTabRelative(1) },
	{ key = ",", mods = "CTRL|SHIFT", action = wezterm.action.MoveTabRelative(-1) },

	-- Direct tab access (Kitty: Ctrl+Shift+1 through Ctrl+Shift+9)
	{ key = "1", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(8) },

	-- Window/Pane Management
	{ key = "Enter", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "F5", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Window Navigation (Kitty defaults)
	{ key = "[", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Prev") },
	{ key = "]", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Next") },

	-- Directional window navigation
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

	-- Window Resizing
	{ key = "LeftArrow", mods = "CTRL|SHIFT|ALT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT|ALT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT|ALT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT|ALT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

	-- Font Size (Kitty defaults)
	{ key = "=", mods = "CTRL|SHIFT", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CTRL|SHIFT", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CTRL|SHIFT", action = wezterm.action.ResetFontSize },

	-- Scrollback (Kitty defaults)
	{ key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) },
	{ key = "Home", mods = "SHIFT", action = wezterm.action.ScrollToTop },
	{ key = "End", mods = "SHIFT", action = wezterm.action.ScrollToBottom },
	{ key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(1) },

	-- Copy/Paste (Kitty defaults)
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- Selection modes
	{ key = "Space", mods = "CTRL|SHIFT", action = wezterm.action.QuickSelect },

	-- Reload configuration (Kitty: Ctrl+Shift+F5)
	{ key = "F5", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },

	-- Search (Kitty defaults)
	{ key = "f", mods = "CTRL|SHIFT", action = wezterm.action.Search({ CaseSensitiveString = "" }) },

	-- Fullscreen toggle
	{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
	{ key = "Enter", mods = "ALT", action = wezterm.action.ToggleFullScreen },

	-- Show/Hide tab bar
	{ key = "F1", mods = "CTRL|SHIFT", action = wezterm.action.ShowTabNavigator },

	-- Layout switching (Kitty-like behavior)
	{
		key = "l",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			local panes = tab:panes_with_info()

			if #panes == 1 then
				return
			elseif #panes == 2 then
				-- Toggle between horizontal and vertical split
				local current_size = panes[1].size
				if current_size.cols > current_size.rows then
					-- Currently horizontal, switch to vertical
					tab:set_zoomed(false)
					window:perform_action(wezterm.action.AdjustPaneSize({ "Left", -50 }), pane)
				else
					-- Currently vertical, switch to horizontal
					tab:set_zoomed(false)
					window:perform_action(wezterm.action.AdjustPaneSize({ "Up", -50 }), pane)
				end
			else
				-- For more panes, rotate through different arrangements
				window:perform_action(wezterm.action.RotatePanes("Clockwise"), pane)
			end
		end),
	},

	-- Predefined layouts
	{
		key = "t",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, pane)
			-- Tall layout: one main pane on left, others stacked on right
			create_tall_layout(window, pane)
		end),
	},

	{
		key = "f",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, pane)
			-- Fat layout: one main pane on top, others in row below
			create_fat_layout(window, pane)
		end),
	},

	{
		key = "g",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, pane)
			-- Grid layout: arrange panes in grid
			create_grid_layout(window, pane)
		end),
	},

	{
		key = "s",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, pane)
			-- Stack layout: zoom current pane (like stack)
			local tab = window:active_tab()
			tab:set_zoomed(not tab:get_zoomed())
		end),
	},

	-- Debug/Inspector (Kitty equivalents)
	{ key = "I", mods = "CTRL|SHIFT", action = wezterm.action.ShowDebugOverlay },

	-- Additional useful mappings that match Kitty behavior
	{ key = "n", mods = "CTRL|SHIFT", action = wezterm.action.SpawnWindow },
	{ key = "u", mods = "CTRL|SHIFT", action = wezterm.action.CharSelect },

	-- Unicode input (Kitty: Ctrl+Shift+U)
	{
		key = "u",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CharSelect({
			copy_on_select = true,
			copy_to = "ClipboardAndPrimarySelection",
		}),
	},

	-- Clear screen (Kitty behavior)
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		}),
	},

	-- Pass through keys that might be intercepted
	{ key = "Space", mods = "CTRL", action = wezterm.action.SendKey({ key = "Space", mods = "CTRL" }) },
}

-- Mouse bindings to match Kitty behavior
config.mouse_bindings = {
	-- Right click to paste
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	-- Middle click to paste
	{
		event = { Down = { streak = 1, button = "Middle" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("PrimarySelection"),
	},

	-- Ctrl+Click to open links
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- Additional Kitty-like behavior settings
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false

-- Copy behavior similar to Kitty
config.selection_word_boundary = " \t\n{}[]()\"':;.,!?"

-- Terminal bell behavior
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}

-- Cursor behavior
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

-- Window behavior
config.window_close_confirmation = "AlwaysPrompt"
config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
}

return config
