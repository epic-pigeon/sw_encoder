pgt = property.getText
function parse(s, i)
	i = i or 1
	if s:sub(i,i) == '"' then
		local res = ""
		i = i + 1
		while i < #s and s:sub(i,i) ~= '"' do
			if s:sub(i,i) == '\\' then
				i = i + 1
				res = res .. s:sub(i,i)
			end
			i = i + 1
		end
		i = i + 1
		return res, i
	elseif s:sub(i,i) == '(' then
		local idx = 1
		local res = {}
		i = i + 1
		if s:sub(i,i) == ')' then return res, i+1 end
		local v, key
		while true do
			if s:sub(i,i) == '[' then
				i = i + 1
				key, i = parse(s, i)
				i = i + 2
				v, i = parse(s, i)
				res[key] = v
			else
				v, i = parse(s, i)
				res[idx] = v
				idx = idx + 1
			end
			if s:sub(i,i) ~= ',' then
				return res, i+1
			end
			i = i + 1
		end
	else
		local ns = ""
		while i <= #s and (s:sub(i,i) == '-' or tonumber(s:sub(i,i)) ~= nil) do
			ns = ns .. s:sub(i,i)
			i = i + 1
		end
		return tonumber(ns), i
	end
end
