--[[

     Multicolor Awesome WM theme 2.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")
local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.confdir                                   = os.getenv("HOME") .. "/.config/awesome/themes/multicolor"
theme.wallpaper                                 = theme.confdir .. "/wall.jpg"
theme.font                                      = "Roboto Light 9"
theme.colors = {}
beautiful.taglist_font  = 'Font Awesome 9'
-- Solorized dark colorscheme {{{
theme.colors.transparent = "#00000000"
theme.colors.base3   = "#002b36"
theme.colors.base2   = "#073642"
theme.colors.base1   = "#586e75"
theme.colors.base0   = "#657b83"
theme.colors.base00  = "#839496"
theme.colors.base01  = "#93a1a1"
theme.colors.base02  = "#eee8d5"
theme.colors.base03  = "#fdf6e3"
theme.colors.yellow  = "#b58900"
theme.colors.orange  = "#cb4b16"
theme.colors.red     = "#dc322f"
theme.colors.magenta = "#d33682"
theme.colors.violet  = "#6c71c4"
theme.colors.blue    = "#268bd2"
theme.colors.cyan    = "#2aa198"
theme.colors.green   = "#859900"
-- }}}

theme.fg_normal  = theme.colors.base02
theme.fg_focus   = theme.colors.cyan
theme.fg_urgent  = theme.colors.base3

theme.bg_normal  = theme.colors.base3
-- theme.bg_focus   = theme.colors.green
-- theme.bg_urgent  = theme.colors.red
theme.bg_systray = "#37374300"
theme.fg_systray = "#373743"
-- }}}

-- {{{ Borders
theme.border_width  = 2
theme.border_normal = theme.bg_normal
theme.border_focus  = theme.colors.cyan
theme.border_marked = theme.bg_urgent
-- }}}

theme.taglist_fg_focus    = theme.colors.violet
theme.taglist_fg_occupied = theme.colors.cyan
theme.taglist_fg_urgent   = theme.colors.red
theme.taglist_fg_empty    = "#828282"
theme.taglist_spacing     = 0
-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.colors.transparent
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = theme.colors.green
theme.useless_gap                               = 8

theme.menu_border_width                         = 5
theme.menu_width                                = 130

-- load the widget code
local calendar = require("calendar")

-- attach it as popup to your text clock widget:
local markup = lain.util.markup

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock( markup("#7788af","  " .. "%A %d %B ") .. markup("#535f7a", ">") .. markup("#de5e1e", " %H:%M "))
mytextclock.font = theme.font
calendar({}):attach(mytextclock)

-- Calendar
-- theme.cal = lain.widget.calendar({
--     attach_to = { mytextclock },
--     notification_preset = {
--         font = "xos4 Fira Code 10",
--         fg   = theme.fg_normal,
--         bg   = theme.bg_normal
--     }
-- })

-- [[ Mail IMAP check
-- commented because it needs to be set before use
local mailicon = wibox.widget.imagebox()
local mail = lain.widget.imap({
    timeout  = 180,

    settings = function()
        if mailcount > 0 then
            mailicon:set_image(theme.widget_mail)
            widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
        else
            widget:set_text("")
            --mailicon:set_image() -- not working in 4.0
            mailicon._private.image = nil
            mailicon:emit_signal("widget::redraw_needed")
            mailicon:emit_signal("widget::layout_changed")
        end
    end
})
--]]

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, theme.colors.orange, " ".. cpu_now.usage .. "% "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc ~= "N/A" and bat_now.perc .. "%" or bat_now.perc

        if bat_now.ac_status == 1 then
            perc = perc .. " plug"
        end
        -- local icon
        -- if bat_now.perc < 100
        --    perc = "  " .. perc
        -- else if bat_now.perc < 80
        --     perc ="  ".. perc
        -- else if bat_now.perc <  60
        --     perc ="  ".. perc
        -- else if bat_now.perc <  40
        --     perc ="  ".. perc
        -- else if bat_now.perc <  20
        --     perc = "  " .. perc

        widget:set_markup(markup.fontfg(theme.font, theme.fg_normal,  "  " .. perc .. " "))
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup.fontfg(theme.font, theme.colors.base02, " " .. volume_now.level .. "% "))
    end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", " ".. mem_now.used .. "M "))
    end
})

--
local systray = wibox.widget.systray()
systray.opacity = 0

-- MPD
local mpdicon = wibox.widget.imagebox()
theme.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }

        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(theme.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            --mpdicon:set_image() -- not working in 4.0
            mpdicon._private.image = nil
            mpdicon:emit_signal("widget::redraw_needed")
            mpdicon:emit_signal("widget::layout_changed")
        end
        widget:set_markup(markup.fontfg(theme.font, "#e54c62", artist) .. markup.fontfg(theme.font, "#b2b2b2", title))
    end
})

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 22, bg = theme.colors.transparent, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
            mpdicon,
            theme.mpd.widget,
        },
        -- s.mytasklist, -- Middle widget
        nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mailicon,
            mail.widget,
            volicon,
            theme.volume.widget,
            memicon,
            memory.widget,
            cpuicon,
            cpu.widget,
            baticon,
            bat.widget,
            clockicon,
            mytextclock,
            systray,
        },
    }

end


return theme
