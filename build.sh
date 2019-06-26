cd src
zip -r ../game.love ./*
cd ../
cat bin/love.exe game.love > bin/ppa_road_to_imortal.exe

cd bin/
zip -r ../ppa_road_to_imortal.zip SDL2.dll OpenAL32.dll ppa_road_to_imortal.exe license.txt love.dll lua51.dll mpg123.dll msvcp120.dll msvcr120.dll
