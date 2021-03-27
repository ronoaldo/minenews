# minenews

Localized Simple server news for [Minetest](https://www.minetest.net/) servers.
Original version by Shara RedCat, forked and improved by Ronoaldo.

This displays a news formspec when the player joins. To set the news text
make a file named `news_*lang_code*.txt` in your world directory, falling back
to a `news.txt` file.

The contents of this file will display as the news. When changing the contents
of the file, there is no need to restart the server for it to update in game.

Players can also type `/news` to display the formspec at any time.

Players with the news\_bypass privilege will not see the formspec when they
sign in, but can still use the /news command.


# License

Code for this mod is released under MIT (https://opensource.org/licenses/MIT).
