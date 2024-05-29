function Initialize()
    lang = SKIN:GetVariable('lang')
end

function Update()
    local phrases = {}
    local phrasesFile = nil
    local phrasesPath = SKIN:GetVariable('@') .. 'phrases_' .. lang .. '.lua'

    -- Attempt to load the phrases file
    local success, result = pcall(dofile, phrasesPath)
    
    if not success then
        SKIN:Bang('!Log', 'Error loading file: ' .. phrasesPath .. '. Error: ' .. tostring(result), 'Error')
        return
    end

    -- Ensure the GetPhrase function is available and call it
    if result and result.GetPhrase then
        phrases = result.GetPhrase().phrases
    else
        SKIN:Bang('!Log', 'GetPhrase function not found in file', 'Error')
        return
    end

    if #phrases == 0 then
        SKIN:Bang('!Log', 'No phrases loaded', 'Error')
        return "No phrases loaded"
    end

    local weatherCondition = string.lower(SKIN:GetMeasure('Main'):GetStringValue())
    local found = false
    local phrase = {}

    for _, p in ipairs(phrases) do
        if p.condition and string.lower(p.condition) == weatherCondition then
            phrase = p
            found = true
            break
        end
    end

    if found and type(phrase) == "table" then
        SKIN:Bang('!SetOption', 'PhraseText', 'Text', phrase.title)
        SKIN:Bang('!SetOption', 'SublineText', 'Text', phrase.subline)
        SKIN:Bang('!SetOption', 'PhraseText', 'InlineSetting', 'Color | ' .. phrase.color)
        SKIN:Bang('!SetOption', 'PhraseText', 'InlinePattern', '(' .. phrase.highlight[1] .. ')')
        return phrase.title
    else
        SKIN:Bang('!Log', 'No matching phrase found', 'Error')
        SKIN:Bang('!SetOption', 'PhraseText', 'Text', "Loading...")
        SKIN:Bang('!SetOption', 'SublineText', 'Text', "Go make a coffee.")
        SKIN:Bang('!SetOption', 'PhraseText', 'InlineSetting', '')
        SKIN:Bang('!SetOption', 'PhraseText', 'InlinePattern', '')
        return "Loading..."
    end
end
