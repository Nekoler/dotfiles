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
        resize_on_border = true,
        layout           = 'scrolling'
    }
})

hl.config({
    decoration = {
        blur   = {
            enabled = false
        },
        shadow = {
            enabled = false
        }
    }
})

hl.config({
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
        middle_click_paste       = false
    }
})

hl.config({
    input = {
        focus_on_close         = 2,
        follow_mouse_threshold = 600,
        numlock_by_default     = true,
        touchpad               = {
            natural_scroll = true,
            scroll_factor = 0.2
        }
    }
})

hl.config({
    cursor = {
        no_hardware_cursors = 0,
        zoom_disable_aa = true
    }
})

hl.config({
    render = {
        direct_scanout = 1
    }
})

hl.monitor({
    output   = '',
    mode     = '2560x1440@60',
    position = 'auto',
    scale    = 'auto'
})
-- Autostart
hl.on('hyprland.start', function()
    hl.exec_cmd('exec systemctl --user start wayland-session.target')
    hl.exec_cmd('exec fcitx5 --replace')
    hl.exec_cmd('exec swayosd-server')
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
hl.animation({ leaf = 'global', enabled = true, speed = 4, bezier = 'EaseInOut' })

hl.animation({ leaf = 'fade', enabled = true, speed = 3, bezier = 'Slow' })
hl.animation({ leaf = 'fadePopups', enabled = true, speed = 2, bezier = 'Quick' })
hl.animation({ leaf = 'fadeLayersIn', enabled = false })
hl.animation({ leaf = 'fadeLayersOut', enabled = true, speed = 4, bezier = 'Slow' })

hl.animation({ leaf = 'layersIn', enabled = true, speed = 4, bezier = 'Quick', style = 'popin 0%' })
hl.animation({ leaf = 'layersOut', enabled = true, speed = 4, bezier = 'Slow', style = 'popin 0%' })

hl.animation({ leaf = 'windowsIn', enabled = true, speed = 4, bezier = 'EaseInOut', style = 'popin 0%' })
hl.animation({ leaf = 'windowsMove', enabled = true, speed = 5, bezier = 'EaseInOut' })
hl.animation({ leaf = 'windowsOut', enabled = true, speed = 4, bezier = 'EaseInOut', style = 'popin 0%' })

hl.animation({ leaf = 'workspaces', enabled = true, speed = 6, bezier = 'EaseInOut', style = 'slidefadevert' })
-- Rule
hl.window_rule({
    name     = 'xwayland-drag-fix',
    match    = {
        initial_class = '^$',
        initial_title = '^$',
        float         = true,
        xwayland      = true
    },
    no_focus = true
})

hl.window_rule({
    name = 'no-title-float',
    match = {
        initial_title = '^$'
    },
    float = true
})

hl.window_rule({
    name = 'Zotero-float',
    match = {
        initial_class = 'Zotero',
        initial_title = '.+(置|新|度|名|件|blank)$'
    },
    float = true
})

hl.layer_rule({
    name = 'layer-no-animation',
    match = {
        namespace = 'selection|swayosd|waybar|wofi'
    },
    no_anim = true
})

hl.layer_rule({
    name = 'mako-slide',
    match = {
        namespace = 'notifications'
    },
    animation = 'slide right'
})
-- Gesture
hl.gesture({ fingers = 3, direction = "horizontal", action = "scroll_move" })
hl.gesture({ fingers = 3, direction = "vertical", action = "workspace" })
-- Bind
hl.bind('Print', hl.dsp.exec_raw('! pidof slurp && i=$(slurp) && echo "${i}" | grim -g - - | wl-copy'))
hl.bind('SUPER + c', hl.dsp.exec_raw('i=$(cliphist list | wofi --dmenu) && echo "${i}" | cliphist decode | wl-copy'))
hl.bind('SUPER + e', hl.dsp.exec_raw('exec kitty --class=spf -e spf'))
hl.bind('SUPER + l', hl.dsp.exec_raw('. "${HOME}/.config/hypr/powerctl.sh"'), { long_press = true })
hl.bind('SUPER + r', hl.dsp.exec_raw('exec wofi'))
hl.bind('SUPER + t', hl.dsp.exec_raw('exec kitty'))
hl.bind('SUPER + XF86AudioLowerVolume', hl.dsp.exec_raw('exec swayosd-client --brightness=-1'), { repeating = true })
hl.bind('SUPER + XF86AudioRaiseVolume', hl.dsp.exec_raw('exec swayosd-client --brightness=+1'), { repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_raw('exec swayosd-client --output-volume=-1'), { repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_raw('exec swayosd-client --output-volume=mute-toggle'))
hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_raw('exec swayosd-client --output-volume=+1'), { repeating = true })

hl.bind('SUPER + left', hl.dsp.layout('move -col'))
hl.bind('SUPER + right', hl.dsp.layout('move +col'))
hl.bind('SUPER + up', hl.dsp.focus({ direction = 'up' }))
hl.bind('SUPER + down', hl.dsp.focus({ direction = 'down' }))
hl.bind('SUPER + mouse_up', hl.dsp.layout('move -col'))
hl.bind('SUPER + mouse_down', hl.dsp.layout('move +col'))
hl.bind('SUPER + equal', hl.dsp.layout('colresize +0.1'))
hl.bind('SUPER + minus', hl.dsp.layout('colresize -0.1'))
hl.bind('SUPER + BackSpace', hl.dsp.layout('colresize 0.5'))

hl.bind('SUPER + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind('SUPER + mouse:273', hl.dsp.window.resize(), { mouse = true })
hl.bind('SUPER + Tab', hl.dsp.window.float({ action = 'toggle' }))
hl.bind('SUPER + w', hl.dsp.window.close())

for i = 1, 9 do
    hl.bind('SUPER + ' .. i, hl.dsp.focus({ workspace = i }))
    hl.bind('SUPER + SHIFT + ' .. i, hl.dsp.window.move({ workspace = i }))
end

local function zoom(offset)
    local current = hl.get_config('cursor.zoom_factor')
    current = math.max(1.0, current * offset)
    hl.config({ cursor = { zoom_factor = current } })
end
hl.bind('SUPER + SHIFT + mouse_up', function() zoom(1.5) end)
hl.bind('SUPER + SHIFT + mouse_down', function() zoom(0.66) end)
