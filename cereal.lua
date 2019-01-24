local env = {}

function env.serialise(tbl)
	local out = {"{","}"}
	local x = 0
	for k,v in pairs(tbl) do
		x = x + 1
		if type(v) == "table" then
			if type(k) == "number" then
				table.insert(out, #out, "["..k.."] = "..env.serialise(v))
			elseif type(k) == "string" then
				table.insert(out, #out, "['"..k.."'] = "..env.serialise(v))
			end
		end
		if type(v) == "string" then
			if type(k) == "number" then
				table.insert(out, #out,"["..k.."] = ".."'"..v.."'")
			elseif type(k) == "string" then
				table.insert(out, #out,"['"..k.."'] = ".."'"..v.."'")
			end
		end
		if type(v) == "number" then
			if type(k) == "number" then
				table.insert(out, #out,"["..k.."] = "..string.format ("%18.0f",v))
			elseif type(k) == "string" then
				table.insert(out, #out,"['"..k.."'] = "..string.format ("%18.0f",v))
			end
		end

		if type(v) == "boolean" then
			if type(k) == "number" then
				table.insert(out, #out,"["..k.."] = "..tostring(v))
			elseif type(k) == "string" then
				table.insert(out, #out,"['"..k.."'] = "..tostring(v))
			end
		end
		if x ~= #tbl then
			table.insert(out,#out,",")
		end
 	end
	return table.concat(out)
end

function env.unserialise(str)
	f = io.open(".temp.temp","w")
	f:write("return "..str)
	f:close()
	x = dofile ".temp.temp"
	os.remove(".temp.temp")
	return x
end

function env.savetoFile(tbl,fl)
	h = io.open(fl,"w")
	h:write(env.serialise(tbl))
	h:close()
end

function env.loadfromFile(fl)
	h = io.open(fl,"r")
	return env.unserialise(h:read("*a"))
end
return env