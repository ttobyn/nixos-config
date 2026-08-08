local waywall = require("waywall")
local helpers = require("waywall.helpers")
return function(config)
    -- Add any extra code here
local crosshair_image = nil
local crosshair_active = nil
local cfg = {
    -- Change your resolution here to your playing resolution, e.g. this is 1440p:
    resx = 1920,
    resy = 1080,
    size = 100,
    key = "L",
    path = os.getenv("HOME") .. "/.config/waywall/resources/Crosshair.png",
}
config.actions[cfg.key] = function()
    if crosshair_image then
        crosshair_image:close(); crosshair_image = nil
    end
    if crosshair_active then
        crosshair_active = false
    else
        crosshair_active = true
        crosshair_image = waywall.image(cfg.path, {
            dst = {
                x = (cfg.resx - cfg.size) / 2,
                y = (cfg.resy - cfg.size) / 2,
                w = cfg.size,
                h = cfg.size,
            }
        })
    end
end
end
