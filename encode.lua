function stringify(val)
	if type(val) == "string" then return '"' .. val:gsub('%\\', '\\\\'):gsub('%"', '\\"') .. '"' end
	if type(val) == "number" then return tostring(val) end
	local res = "("
	local nf = false
	local l = #val
	for i = 1, l do
		if nf then res = res .. "," end
		nf = true
		res = res .. stringify(val[i])
	end
	for i, v in pairs(val) do
		if type(i) ~= "number" or i < 1 or i > l then
			if nf then res = res .. "," end
			nf = true
			res = res .. "[" .. stringify(i) .. "]" .. "=" .. stringify(v)
		end
	end
	return res .. ")"
end

function encodeToController(name, value)
	local start = '<?xml version="1.0" encoding="UTF-8"?><microprocessor name="Encoded" description="Encoded value" width="1" length="1" id_counter="1" id_counter_node="0"><nodes/><group><data type="1073741824"><inputs/><outputs/></data><components>'
	local mid = '</components><components_bridge/><groups/><component_states>'
	local fin = '</component_states><component_bridge_states/><group_states/></group></microprocessor>'

	local str = stringify(value):gsub("%&", "&amp;"):gsub("%\"", "&quot;")
	return start ..
			'<c type="58"><object id="1" n="' .. name .. '" v="' .. str .. '"/></c>' ..
			mid ..
			'<c0 id="1" n="' .. name .. '" v="' .. str .. '"/>' ..
			fin
end
