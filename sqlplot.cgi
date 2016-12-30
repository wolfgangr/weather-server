#!/usr/bin/perl -w
#
# sqlplot
#
# part of diskwatch package by Wolfgang Rosner
# plots any sql-data by using gnuplot
#
#
###################################################################################################
#
# cgi-parameters on call:
# 
# query="SELECT ....."         SQL-Statement that retrieves the data
#                              first column is for x-values
# context=someidentifier       to resolve for user, passwd, database and server
# time=unix/mysql              x-values are datetime-values 
#                              (seconds since 1.1.1970 or yyyy-mm-dd hh:mm:ss)
# grid=true                    show grid lines
#                              force x-range limits
# title=, ylabel=              label the chart and the y-axis (x and series labels from dataset)
# test=true                    print est image to check colors an basic operation
# color1=ffffff,color2=..      set color for the lines
# command=                     any gnuplot command
#
# check for proper URL-Quoting!
# (use "+" for space and %xx as any ASCII-Hex Value
#
# Example: (write everything on one line)
#    http://someserver.com/diskwatch/cgi/sqlplot.cgi
#    ?context=diskwatch
#    &query=Select+from_unixtime(timestamp)+as+datum,(bused/1024)+from%20df+
#    WHERE+server='otherserver.com'+AND+device='/dev/hda5'
#    &time=mysql&ylabel=MByte&Title=Was+wei�+denn+ich&command=set+xlabel+"some+text"
#
####################################################################################################


######### Parameter area following


$gnuplot = "/usr/bin/gnuplot";
# $tempfile_prefix="/usr/local/httpd/htdocs/html/tmp/sqlplot-"; 
$tempfile_prefix="/var/www/tmp/sqlplot/plot-";


# (now the data for the context
# given as an hash of arrays, the context name as key,
#    the array containing DBhost, database, user, passwd
#
# $contextlist = {
#   'testlamp'     => ['localhost',             'test_lamp',       'userx',             'pswdXYZ'     ],
#   'thiswontwork' => ['1.2.3.4',                 'nirwana',     'sbdelse',             'verySECret'  ],
# };

# context now outside main script
require ("context.pli");


###################################################### End of parameter area #######################
#
# don't change anything after this point :-o
# 


#######################################################################
#

use DBD::mysql;
# use DBI;
use CGI ;
use Time::Local;
use Time::localtime;
$driver         = "mysql";

#######################################################################


# ----- initialize the gnuplot stuff

$tempfile_body = $tempfile_prefix . time; 
$temppng  = $tempfile_body . '.png';
$tempdata = $tempfile_body . '.data';
$templog  = $tempfile_body . '.log';



# $command= <<ENDOFCOMMAND;
# set term png
# set output "$temppng"
# ENDOFCOMMAND

# ------- start evaluation of cgi-params ------

$cgiquery = new CGI;


if ($cgiquery->param('test') eq 'true') {

  # ===== test shows line styles and proofs graphik part ==============

#  $command .="test\n";

$command= <<ENDOFCOMMAND;
set term png
set output "$temppng"
test
ENDOFCOMMAND


  #  ===== sql query found, try to process =============================
  #

} elsif ($cgiquery->param('query') =~ /^select.*/i ) {
  $sql=$cgiquery->param('query');


  # ---- now check for some format CGI params ----

  # colors: Background, borders, x-, y, Axis, plots
  @defcol =('eeeeee','000000','000000',
      '0000ff','ff0000','44ff44','ffff00','ff00ff','44ffff');

  $command= "set term png";

  # my  @color;
  foreach $i ('b','e','a',(1..9)) {
    $tmp = shift(@defcol);
    if ($cgiquery->param("color$i")) { $tmp =$cgiquery->param("color$i");}
    if ($tmp) { $command .= " x$tmp"; }
  }
  $command .= "\n";

  $command .="set output \"$temppng\"\n";

  # $tmp = $cgiquery->param('border');
  # if ($tmp) {
  #   $command .= "set border 31 lw $tmp \n";
  # }

  if ($cgiquery->param('grid') eq 'true') {
    $command .= "set grid\n";
  }


  # if to plot time, set in and out format
  # 
  $timetype=$cgiquery->param('time');

  if ($timetype =~ /(^unix|^mysql)/i) {
    $command .= <<EOFCMD;
set xdata time
set format x "%H:%M\\n%d.%b\\n%Y"
set timefmt "%Y-%m-%d %H:%M:%S"
EOFCMD
  }


  if ($cgiquery->param('timestamp') eq 'true') {
    $command .= "set timestamp \"\%d.\%m.\%Y \%H:\%M\"\n";
  }

  $tmp = $cgiquery->param('ylabel');
  if ($tmp) {
    $command .= "set ylabel \"$tmp\"\n";
  }

  $tmp = $cgiquery->param('title');
  if ($tmp) {
    $command .= "set title \"$tmp\" \n";
    # $command .= "set title \"$charttitle\" \"Helvetica,24\"\n";
  }

  # credits as default :-)
  $tmp = $cgiquery->param('credits');
  unless ($tmp eq 'false') {
    $command .= 
      "set label \"SQLplot by Wolfgang Rosner\" at screen 0.985, graph 0 rotate\n";
  }



  # ----  now try to evaluate the context and get db parameters ----
  #
  $context = $$contextlist{$cgiquery->param('context')}; 
 
  $DBHost    = $$context[0];
  $database  = $$context[1];
  $user      = $$context[2];
  $passwd    = $$context[3];

  unless ($DBHost && $database) {error ("context not valid"); }

  # ---- try to connect to db with that values ------
  #
  $dsn = "DBI:$driver:$database;$DBHost";
  $dbh = DBI->connect($dsn, $user, $passwd) || sqlerror($dbh, "", "Could not connect: $DBI::errstr\n");

  $sth = $dbh->prepare($sql);
  $sth->execute || sqlerror($sth, $sql, "could not execute statement");

  $labels = $sth->{NAME};              # get all column headings
  $isnum  = $sth->{mysql_isnum};       # have we numbers?
  $colnum = $sth->{NUM_OF_FIELDS} -1;  # max index = No of y-rows

  if ($colnum == 0) { sqlerror($sth, $sql, "statement did not produce a result:"); }

  unless ($$isnum[0]) {
    # error ("$$isnum[0]:  x values not numeric, maybe datetime processing lateron");
  }   
 
  # seems to be fine till now, so try to produce data file

  open (DATAFILE, ">".$tempdata) || error ("could not create temp data file $tempdata");  


  while ( $rowref = $sth->fetch) {
     if ($sth->err) { error ("something went wrong while retrieving rows"); }   
     
     foreach $i (1..$colnum) {
       print DATAFILE  $$rowref[$i], " ";       # first output y values
     }

     # do we have to output time?
     $xval = $$rowref[0];
     if ($timetype =~ /^unix/i) {
       # print DATAFILE ($$rowref[0]-982333806), "\n";  convert unix to gnuplot time
       print DATAFILE MySQLdatetimestring($xval), "\n"; 
       # for mysql time format, direct output should work
     } else {
         print DATAFILE $xval, "\n";         # and x ist last (maybe datetime)
     } 
  }

  close DATAFILE || error ("could not close temp data file $tempdata");

  # error ("NO!, seems we have made a datafile!?");

  $command .= "set data style lines\n";
  $command .= "set xlabel \"$$labels[0]\"\n";

 
  # insert whatever gnuplot commands are specified by cgi-var "command"
  #
  @arbtrycmds = $cgiquery->param('command');
  foreach $tmp ( @arbtrycmds) {  
    $command .= $tmp . "\n";
  }


  # now the command for plotting
  #
  $command .= "plot";
  $xcol=$colnum+1;
  foreach $i (1..$colnum) {
    $command .= " \"$tempdata\" using $xcol:$i title \"$$labels[$i]\","; 
  }
  chop $command;
  $command .="\n";

} else {

  error ("could not resolve parameters");
}

##### Fine if me made it till here - seems like we have a successful 
#####  seems like we have a successful command for gnuplot

# print "Content-type: image/png\n\n";

open GNUPLOT, "| $gnuplot > $templog 2>&1" || error ("cannot open gnuplot")   ;
print GNUPLOT $command    || error ("cannot send data to gnuplot") ;
close GNUPLOT             || gnuploterror($command, $templog);

print "Content-type: image/png\n\n";
print `cat -u $temppng`;   

exit;   # leave the stuff for debugging

unlink $temppng;        # don't check for an error any more
unlink $tempdata;
unlink $templog;


exit;

#################################################################
########## End of Main Program here ############################
################################################################

sub error {

  my ($errmessg) = @_;

  print "Content-type: text/html\n\n";
  print "<html><head><title>Fehler bei SQL-Plot</title></head><body>\n";
  print "<h1>Fehler:</h1>";
  print "<h2>$errmessg</h2>";
  print "</body></html>";

  exit;
}


sub sqlerror {

  my ($handle, $statement, $errmessg) = @_;

  print "Content-type: text/html\n\n";
  print "<html><head><title>SQL Error </title></head><body>\n";
  print "<h1>SQL Database Error</h1>";
  print "\n\n<h2>$errmessg</h2>";

  print "\n\n<p><b>DB-Error-Code: </b>", $handle->err;
  print "\n<br><b>SQLSTATE: </b>", $handle->state;
  print "\n<br><b>DB-Message: </b>", $handle->errstr;
  print "\n<br>\n";

  if ($statement) {
    print "<p><b>offending SQL-Statement:</b></p>";
    print "\n<pre>\n$statement\n<\pre>\n";
  }

  $dbh->disconnect;

  print "</body></html>";

  # $dbh->disconnect;

  exit;
}


sub MySQLdatetimestring {
  my ($timeserial) = @_;
  my ($tl);
  $tl = localtime($timeserial);
  return(sprintf("%02d-%02d-%02d %02d:%02d:%02d",
        $tl->year+1900, $tl->mon+1, $tl->mday,  $tl->hour, $tl->min, $tl->sec ));
}

sub gnuploterror {

  my ($command, $logfile) = @_;

  print "Content-type: text/html\n\n";
  print "<html><head><title>Gnuplot Error </title></head><body>\n";
  print "<h1>Gnuplot Error:</h1>";

  print "<h3>gnuplot reported:</h3>\n"; 
  print "<pre>\n";
  print  `cat -u $logfile`;
  print "</pre>\n";

  print "<h1>gnuplot command was:</h1>\n";
  print "<pre>\n";
  print  $command;
  print "</pre>\n";

  print "</body></html>";

  # $dbh->disconnect;

  exit;
}
