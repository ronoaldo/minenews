-- Register bypass priv
minetest.register_privilege("news_bypass", {
	description = "Skip the news display on login.",
	give_to_singleplayer = false
})

-- Create formspec from text file
-- formspec_version[5]
-- size[20,16]
-- button_exit[16.8,14.8;3,1;close;OK]
-- image[0.2,14.8;1,1;minenews_discord]
-- field[1.3,14.8;15.3,1;discord_invite;;https://]
-- textarea[0.2,0.3;19.6,14.2;news;;]
local function get_formspec(name)
	-- Lookup player language preference
	local player_info = minetest.get_player_information(name)
	local lang = player_info.lang_code
	if lang == "" then
		lang = "en"
	end
	-- Lookup news file to display, trying by language first, with a default news.md
	-- fallback.
	local news_filename = minetest.get_worldpath().."/news_"..lang..".md", "r"
	local news_file = io.open(news_filename, "r")
	if not news_file then
		news_filename = minetest.get_worldpath().."/news.md", "r"
		news_file = io.open(news_filename, "r")
	end
	minetest.log("verbose", "Displaying news to player "..name.." in "..lang.." from file "..news_filename)
	
	-- Display the formspec for the server news
	local news_fs = "formspec_version[5]"..
		"size[20,16]"..
		"button_exit[16.8,14.8;3,1;close;OK]"
	
	local discord_link = minetest.settings:get("minenews.discord_invite") or ""
	if discord_link ~= "" then
		news_fs = news_fs..
			"image[0.2,14.8;1,1;minenews_discord.png]"..
			"field[1.3,14.8;15.3,1;discord_invite;;"..discord_link.."]"
	end

	local news = "No news for today."
	if news_file then
		news = news_file:read("*a")
		news_file:close()
	end
	news_fs = news_fs..md2f.md2f(0.2, 0.5, 19.6, 13.7, news)
	return news_fs
end

-- Show news formspec on player join, unless player has bypass priv
minetest.register_on_joinplayer(function (player)
	local name = player:get_player_name()
	if player:get_hp() <= 0 then
		return
	elseif minetest.get_player_privs(name).news_bypass then
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
