-- ====================================================================================
-- TUM.LOGGER - LOGS WARNINGS, ERRORS AND DEBUG INFO
-- ====================================================================================
-- (enum) TUM.logger.
-- TUM.logger.debug(text, ...)
-- TUM.logger.error(text, ...)
-- TUM.logger.formatText(text, ...)
-- TUM.logger.info(text, ...)
-- TUM.logger.print(level, text)
-- TUM.logger.splitText(text)
-- TUM.logger.trace(text, ...)
-- TUM.logger.warn(text, ...)
-- ====================================================================================

TUM.logger = {}

TUM.logger.logLevel = {
    TRACE = -2,
    DEBUG = -1,
    INFO = 0,
    WARNING = 1,
    ERROR = 2
}

function TUM.logger.debug(text, ...)
    if TUM.DEBUG_MODE then
        text = TUM.logger.formatText(text, arg)
        TUM.logger.print(TUM.logger.logLevel.DEBUG, text)
    end
end

function TUM.logger.error(text, ...)
    text = TUM.logger.formatText(text, arg)
    local mText = text
    if debug and debug.traceback then
        mText = mText .. "\n" .. debug.traceback()
    end
    TUM.logger.print(TUM.logger.logLevel.ERROR, mText)
end

function TUM.logger.formatText(text, ...)
    if not text then
        return ""
    end
    if type(text) ~= 'string' then
        text = TUM.p(text)
    else
        local args = ...
        if args and args.n and args.n > 0 then
            local pArgs = {}
            for i=1,args.n do
                pArgs[i] = TUM.p(args[i])
            end
                text = text:format(unpack(pArgs))
            end
        end
    local fName = nil
    local cLine = nil
    if debug and debug.getinfo then
        local dInfo = debug.getinfo(3)
        fName = dInfo.name
        cLine = dInfo.currentline
        -- local fsrc = dinfo.short_src
        --local fLine = dInfo.linedefined
    end
    if fName and cLine then
        return fName .. '|' .. cLine .. ': ' .. text
    elseif cLine then
        return cLine .. ': ' .. text
    else
        return ' ' .. text
    end
end

function TUM.logger.info(text, ...)
    text = TUM.logger.formatText(text, arg)
    TUM.logger.print(TUM.logger.logLevel.INFO, text)
end

function TUM.logger.print(level, text)
    local texts = TUM.logger.splitText(text)
    local levelChar = 'E'
    local logFunction = function(messageForLogfile, messageForUser)
        trigger.action.outText("ERROR: "..messageForUser, 3600)
        env.error(messageForLogfile)
    end
    if level == TUM.logger.logLevel.WARNING then
        levelChar = 'W'
        logFunction = function(messageForLogfile, messageForUser)
            trigger.action.outText("WARNING: "..messageForUser, 10)
            env.warning(messageForLogfile)
        end
    elseif level == TUM.logger.logLevel.INFO then
        levelChar = 'I'
        logFunction = function(messageForLogfile, messageForUser)
            if TUM.DEBUG_MODE then -- Info messages are only printed out if debug mode is enabled
                trigger.action.outText(messageForUser, 3)
            end
            env.info(messageForLogfile)
        end
    elseif level == TUM.logger.logLevel.DEBUG then
        levelChar = 'D'
        logFunction = env.info
    elseif level == TUM.logger.logLevel.TRACE then
        levelChar = 'T'
        logFunction = env.info
    end
    for i = 1, #texts do
        if i == 1 then
            local theText =  'TUM|' .. levelChar .. '|' .. texts[i]
            logFunction(theText, texts[i])
        else
            local theText = texts[i]
            logFunction(theText, theText)
        end
    end
end

function TUM.logger.splitText(text)
    local tbl = {}
    while text:len() > 4000 do
        local sub = text:sub(1, 4000)
        text = text:sub(4001)
        table.insert(tbl, sub)
    end
    table.insert(tbl, text)
    return tbl
end

function TUM.logger.trace(text, ...)
    if TUM.DEBUG_MODE then
        text = TUM.logger.formatText(text, arg)
        TUM.logger.print(TUM.logger.logLevel.TRACE, text)
    end
end

function TUM.logger.warn(text, ...)
    text = TUM.logger.formatText(text, arg)
    TUM.logger.print(TUM.logger.logLevel.WARNING, text)
end
