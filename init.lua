-- Register bypass priv
minetest.register_privilege("news_bypass", {
	description = "Skip the news display on login.",
	give_to_singleplayer = false
})

-- Create formspec from text file
local function get_formspec(name)
	-- Lookup player language preference
	local player_info = minetest.get_player_information(name)
	local lang = player_info.lang_code
	if lang == "" then
		lang = "en"
	end
	-- Lookup news file to display, trying by language first, with a default news.txt
	-- fallback.
	local news_filename = minetest.get_worldpath().."/news_"..lang..".txt", "r"
	local news_file = io.open(news_filename, "r")
	if not news_file then
		news_filename = minetest.get_worldpath().."/news.txt", "r"
		news_file = io.open(news_filename, "r")
	end
	minetest.log("verbose",
		"Displaying news to player "..name.." in "..lang.." from file "..news_filename)
	-- Display the formspec for the server news
	local news_fs = 'size[12,8.25]'..
		"button_exit[-0.05,7.8;2,0.8;exit;OK]"
	if news_file then
		local news = news_file:read("*a")
		news_file:close()
		news_fs = news_fs.."hypertext[0.25,0;12.1,9;news;"..minetest.formspec_escape(news).."]"
	else
		news_fs = news_fs.."hypertext[0.25,0;12.1,9;news;<b>No current news.</b>]"
	end
	minetest.log("verbose", "news_fs => "..news_fs)
	return news_fs
end

-- Show news formspec on player join, unless player has bypass priv
minetest.register_on_joinplayer(function (player)
	local name = player:get_player_name()
	if minetest.get_player_privs(name).news_bypass then
		return
	else
		minetest.show_formspec(name, "news", get_formspec(name))
	end
end)

-- command to display server news at any time
minetest.register_chatcommand("news", {
	description = "Shows server news to the player",
	func = function (name)
		local player = minetest.get_player_by_name(name)
		minetest.show_formspec(name, "news", get_formspec(name))
	end
})
