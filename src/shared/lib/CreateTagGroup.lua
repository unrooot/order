local CollectionService = game:GetService("CollectionService")

-- Returns a set of all instances with the given tag. Auto updates when tags are
-- added or removed from objects. You can iterate over the set with the
-- following syntax:
-- ```lua
-- for instance in tagGroup do
--     -- ...
-- end
-- ```
return function(tag: string): {[Instance]: true?}
	local tagGroup = {}
	CollectionService:GetInstanceAddedSignal(tag):Connect(function(instance)
		tagGroup[instance] = true
	end)
	CollectionService:GetInstanceRemovedSignal(tag):Connect(function(instance)
		tagGroup[instance] = nil
	end)
	for _, instance in pairs(CollectionService:GetTagged(tag)) do
		tagGroup[instance] = true
	end
	return tagGroup
end
