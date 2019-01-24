env = {}

overseerSTR = [[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!^@#$)(*&,<>./\?| :;{}][=+-_"'`~]]
function hashy(str,seed)
	if str ~= nil and seed ~= nil then
		local function setupChars()
			chars = overseerSTR
			local charst = {}
			for i = 1, #chars do
				table.insert(charst,#charst+1,chars:sub(i,i))
			end
			return charst
		end
		local function seeder(str)
			local str2 = {}
			for i = 1, #str do
				table.insert(str2,#str2+1,str:sub(i,i):byte())
			end
			str = table.concat(str2)
			return tonumber(str)
		end
		gchars = overseerSTR
		locate = {}
		charst = {}
		for i = 1, #gchars do
			locate[gchars:sub(i,i)] = i
		end
		for i = 1, #gchars do
			table.insert(charst,#charst+1,gchars:sub(i,i))
		end
		local tbl = {}
		for i = 1, #str do
			table.insert(tbl, #tbl+1, str:sub(i,i))
		end
		local characterTable = setupChars()
		math.randomseed(seeder(seed))
		for i = 1, #characterTable do
			rn1 = math.random(1,#characterTable)
			rn2 = math.random(1,#characterTable)
			characterTable[rn1], characterTable[rn2] = characterTable[rn2], characterTable[rn1]
		end
		for k,v in pairs(tbl) do
			tbl[k] = characterTable[locate[v]]
		end
		str = table.concat(tbl)
		str = str:gsub(" ","_.._")
		return str
	end
end

function unhashy(str,seed)
	if str ~= nil and seed ~= nil then
		str = str:gsub("_.._"," ")
		local function setupChars()
			chars = overseerSTR
			local charst = {}
			for i = 1, #chars do
				table.insert(charst,#charst+1,chars:sub(i,i))
			end
			return charst
		end
		local function seeder(str)
			local str2 = {}
			for i = 1, #str do
				table.insert(str2,#str2+1,str:sub(i,i):byte())
			end
			str = table.concat(str2)
			return tonumber(str)
		end
		gchars = overseerSTR
		locate = {}
		charst = {}
		for i = 1, #gchars do
			locate[gchars:sub(i,i)] = i
		end
		for i = 1, #gchars do
			table.insert(charst,#charst+1,gchars:sub(i,i))
		end
		local tbl = {}
		local locallocate = {}
		for i = 1, #str do
			table.insert(tbl, #tbl+1, str:sub(i,i))
		end
		local characterTable = setupChars()
		math.randomseed(seeder(seed))
		for i = 1, #characterTable do
			rn1 = math.random(1,#characterTable)
			rn2 = math.random(1,#characterTable)
			characterTable[rn1], characterTable[rn2] = characterTable[rn2], characterTable[rn1]
		end
		for i = 1, #characterTable do
			locallocate[characterTable[i]] = i
		end
		tabl = {}
		for k,v in pairs(tbl) do
			for ka,va in pairs(characterTable) do
				if v == va then
					tbl[k] = charst[ka]
				end
			end
		end
		return table.concat(tbl)
	end
end


env.encrypt = hashy
env.decrypt = unhashy
hashy = nil
unhashy = nil
return env