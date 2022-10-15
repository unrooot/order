local Insanity = {}

--[[
	Have I ever told you the definition of insanity?

	Insanity is doing the same f***ing thing over and over again, and expecting
	something to change.

	- Vaas, Far Cry 3
]]--

-- Continuously tries to execute the given function until it succeeds. Default
-- delay between retries is 2 seconds. If the function does not succeed, the
-- error will be printed to output along with any provided custom message.
function Insanity:Do(thing: (any) -> (), retryDelay: number?, customMessage: any?): any?
	retryDelay = retryDelay or 2
	local result
	local success, message
	while not success do
		success, message = pcall(thing)
		if not success then
			if customMessage then
				warn(customMessage)
			end
			warn(message)
			task.wait(retryDelay)
		else
			result = message
		end
	end

	return result
end

-- Continuously tries to execute the given function until it succeeds. Default
-- delay between retries is 2 seconds. If the function does not succeed, the
-- error will be printed to output along with any provided custom message.
function Insanity:DoAsync(thing: (any) -> (), retryDelay: number?, customMessage: any?): any?
	retryDelay = retryDelay or 2
	local result
	task.spawn(function()
		local success, message
		while not success do
			success, message = pcall(thing)
			if not success then
				if customMessage then
					warn(customMessage)
				end
				warn(message)
				task.wait(retryDelay)
			else
				result = message
			end
		end
	end)

	return result
end

return Insanity
