-- icon_mapping.lua
function Initialize()
    -- Define a table mapping icon codes to image filenames
    iconMap = {
        ["01d"] = "clear_day.png",
        ["01n"] = "clear_night.png",
        ["02d"] = "partly_cloudy_day.png",
        ["02n"] = "partly_cloudy_night.png",
        ["03d"] = "cloudy.png",
        ["03n"] = "cloudy.png",
        ["04d"] = "broken_clouds.png",
        ["04n"] = "broken_clouds.png",
        ["09d"] = "shower_rain_day.png",
        ["09n"] = "shower_rain_night.png",
        ["10d"] = "rain.png",
        ["10n"] = "rain.png",
        ["13d"] = "snow.png",
        ["13n"] = "snow.png",
        ["50d"] = "mist.png",
        ["50n"] = "mist.png",
    }
end

function Update()
    local iconCode = SKIN:GetMeasure('Icon'):GetStringValue() -- Assuming the icon code is in the 'Icon' measure

    local iconName = iconMap[iconCode] or "default.png"
    
    SKIN:Bang('!SetVariable', 'IconMapping', iconName)
end
