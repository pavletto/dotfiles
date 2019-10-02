local awful         = require("awful")
local beautiful     = require("beautiful")
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = true } },

    -- Set Firefox to always map on the first tag on screen 1.
    { rule = { class = "Firefox" },
      properties = { tag = awful.util.tagnames[1] } },

    
    { rule = { class = "IntelliJ IDEA" },
      properties = { tag = awful.util.tagnames[3] } },


    { rule = { class = "Skype"},
      properties = {  tag = awful.util.tagnames[5]} },
 

    { rule = { class = "Chromium"},
      properties = {   tag = awful.util.tagnames[1]} },
 
    { rule = { class = "Subl3" },
      properties = {  tag = awful.util.tagnames[3]  } },
 
    { rule = { class = 'Telegram'},
      properties = {  tag = awful.util.tagnames[4]  }},


    { rule = { class = "urxvt" },
      properties = {  tag = awful.util.tagnames[4],switchtotag = true}}
}
-- }}}
