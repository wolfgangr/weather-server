# weather-server
Server side stuff matching the fine-weather-sniff.pl script

Version -1
just collecting stuff, presumably not working yet
Wolfgang Rosner - wrosner@tirnet.de
2016-12-30

have fun but don't sue me


raw.sql

database structure to create table that fits the  fine-weather-sniff.pl script
created by phpMyAdmin
possible to load with that, too
should also work with mysql command line tool, i suppose


sqlplot.cgi

script to put into the cgi-bin of your web server
can query databases, send the data to gnuplot and deliver the output as img to the browser
querystring is encoded in URL, so no need to fiddle with plotting in your weather GUI
can also be used interactively for test and weird queries (with some command of SQL , of course)




