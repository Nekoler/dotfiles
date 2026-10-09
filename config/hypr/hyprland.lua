-- Config
hl.config({
    ecosystem = {
        enforce_permissions = true
    }
})

hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})

hl.config({
    general = {
        gaps_in          = 0,
        gaps_out         = 0,
        col              = {
            active_border   = '#007F7FFF',
            inactive_border = '#808080FF'
        },
        allow_tearing    = true,
        resize_on_border = true,
        layout           = 'scrolling'
    }
})

hl.config({
    decoration = {
        shadow = {
            enabled = false
        },
        blur   = {
            enabled = false
        }
    }
})

hl.config({
    animations = {
        enabled = true
    }
})

hl.config({
    misc = {
        force_default_wallpaper  = -1,
        disable_hyprland_logo    = false,
        middle_click_paste       = false,
        disable_splash_rendering = true
    }
})

hl.config({
    input = {
        numlock_by_default = true,
        touchpad           = {
            natural_scroll = true,
            scroll_factor = 0.2
        }
    }
})

hl.config({
    cursor = { zoom_disable_aa = true }
})

hl.monitor({
    output   = '',
    mode     = '2560x1440@60',
    position = 'auto',
    scale    = 'auto'
})
-- Autostart
hl.on('hyprland.start', function()
    hl.exec_cmd('exec fcitx5 --replace')
    hl.exec_cmd('exec swayosd-server')
    hl.exec_cmd('exec systemctl --user start activate-graphical-session.target')
    hl.exec_cmd('exec udiskie --smart-tray')
    hl.exec_cmd('exec wl-paste --watch cliphist store')
end)
-- Permission
hl.permission({ binary = '/usr/bin/grim', type = 'screencopy', mode = 'allow' })
hl.permission({ binary = '/usr/libexec/xdg-desktop-portal-.+', type = 'screencopy', mode = 'allow' })
-- Animation
hl.curve('EaseInOut', { type = 'bezier', points = { { 0.7, 0 }, { 0.3, 1 } } })
hl.curve('Linear', { type = 'bezier', points = { { 0.25, 0.25 }, { 0.75, 0.75 } } })
hl.curve('Quick', { type = 'bezier', points = { { 0, 0.9 }, { 0.1, 1 } } })
hl.curve('Slow', { type = 'bezier', points = { { 0.9, 0 }, { 1, 0.1 } } })
hl.animation({ leaf = 'border', enabled = false })
-- hl.animation({ leaf = 'fadeLayers', enabled = false })
-- hl.animation({ leaf = 'layers', enabled = false })
hl.animation({ leaf = 'global', enabled = true, speed = 4, bezier = 'EaseInOut' })
hl.animation({ leaf = 'fade', enabled = true, speed = 3, bezier = 'Slow' })
hl.animation({ leaf = 'fadePopupsIn', enabled = true, speed = 2, bezier = 'Quick' })
hl.animation({ leaf = 'fadePopupsOut', enabled = true, speed = 2, bezier = 'Quick' })
hl.animation({ leaf = 'windowsMove', enabled = true, speed = 5, bezier = 'EaseInOut' })
hl.animation({ leaf = 'workspaces', enabled = true, speed = 6, bezier = 'EaseInOut', style = 'slidefadevert' })
-- Rule
hl.window_rule({
    name     = 'fix-xwayland-drags',
    match    = {
        class    = '^$',
        title    = '^$',
        float    = true,
        xwayland = true
    },
    no_focus = true
})

hl.window_rule({
    name = 'popup-float',
    match = {
        title = '^$|.*(?:设置|更新)$'
    },
    float = true
})

hl.layer_rule({
    name = 'wofi-no-animation',
    match = {
        namespace = 'wofi'
    },
    no_anim = true
})
-- Gesture
hl.gesture({ fingers = 3, direction = "horizontal", action = "scroll_move" })
hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
-- Bind
hl.bind('SUPER + e', hl.dsp.exec_raw('exec kitty --class=spf -e spf'))
hl.bind('SUPER + l', hl.dsp.exec_raw('exec ${HOME}/.config/hypr/powerctl.sh'), { long_press = true })
hl.bind('SUPER + r', hl.dsp.exec_raw('exec wofi'))
hl.bind('SUPER + t', hl.dsp.exec_raw('exec kitty'))

hl.bind('Print', hl.dsp.exec_raw('slurp | grim -g - - | wl-copy'))
hl.bind('SUPER + c', hl.dsp.exec_raw('exec ${HOME}/.config/hypr/clipboard.sh'))
hl.bind('SUPER + XF86AudioLowerVolume', hl.dsp.exec_raw('exec swayosd-client --brightness=-1'), { repeating = true })
hl.bind('SUPER + XF86AudioRaiseVolume', hl.dsp.exec_raw('exec swayosd-client --brightness=+1'), { repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_raw('exec swayosd-client --output-volume=-1'), { repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_raw('exec swayosd-client --output-volume=mute-toggle'))
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_raw('exec swayosd-client --output-volume=+1'), { repeating = true })

hl.bind('SUPER + up', hl.dsp.focus({ direction = 'up' }))
hl.bind('SUPER + down', hl.dsp.focus({ direction = 'down' }))
hl.bind('SUPER + left', hl.dsp.layout('move -col'))
hl.bind('SUPER + right', hl.dsp.layout('move +col'))
hl.bind('SUPER + mouse_up', hl.dsp.layout('move -col'))
hl.bind('SUPER + mouse_down', hl.dsp.layout('move +col'))
hl.bind('SUPER + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind('SUPER + mouse:273', hl.dsp.window.resize(), { mouse = true })

hl.bind('SUPER + Tab', hl.dsp.window.float({ action = 'toggle' }))
hl.bind('SUPER + w', hl.dsp.window.close())

for i = 0, 10 do
    local key = i % 10
    hl.bind('SUPER + ' .. key, hl.dsp.focus({ workspace = i }))
    hl.bind('SUPER + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))
end

local function zoom(offset)
    local current = hl.get_config('cursor.zoom_factor')
    current = math.max(1.0, current * offset)
    hl.config({ cursor = { zoom_factor = current } })
end
hl.bind('SUPER + SHIFT + mouse_up', function() zoom(1.5) end)
hl.bind('SUPER + SHIFT + mouse_down', function() zoom(0.66) end)
