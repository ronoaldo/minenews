# minenews

Localized and simple server news for [Minetest](https://www.minetest.net/) servers.
Original version by Shara RedCat, forked and improved by Ronoaldo.

This displays a news formspec when the player joins. To set the news text
make a file named `news_*lang_code*.txt` in your world directory, falling back
to a `news.txt` file.

The contents of this file will display as the news. When changing the contents
of the file, there is no need to restart the server for it to update in game.

Players can also type `/news` to display the formspec at any time.

Players with the news\_bypass privilege will not see the formspec when they
sign in, but can still use the /news command.

## Screenshots

Sample news dialog in English:

![News in English](./img/news_en.png)

And a translated news file shown for the user if the language is set to `pt_BR`:

![News in Portuguese](./img/news_pt.png)

# License

Code for this mod is released under MIT (https://opensource.org/licenses/MIT).

Images for this mod are released under Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) (https://creativecommons.org/licenses/by-sa/4.0/)

Discord logo is Copyright (C) Discord.