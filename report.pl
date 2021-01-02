use strict;
use warnings;
use utf8;
use feature ':5.16';

use Mojolicious::Lite -signatures;

my $pagetitle = 'Invoice Dollars from Data Warehouse';
my $clipdate  = 'Tuesday January 5 2021';
my $clipday   = '7000000';
my $clipavg   = '5999999';
my $cliptot   = '12999999';

my $avgcolor;
if ($clipavg >= 6000000) { $avgcolor = 'green'; }
elsif ($clipavg < 5000000) { $avgcolor = 'red'; }
else { $avgcolor = 'lightgrey'; }

my $daycolor;
if ($clipday >= 6000000) { $daycolor = 'green'; }
elsif ($clipday < 5000000) { $daycolor = 'red'; }
else { $daycolor = 'lightgrey'; }

# /report
# /report.html
# /report.txt
get '/report' => sub ($c) {
    $c->stash(title     => $pagetitle);
    $c->stash(date      => $clipdate);
    $c->stash(day       => commify($clipday));
    $c->stash(avg       => commify($clipavg));
    $c->stash(tot       => commify($cliptot));
    $c->stash(avgcolor  => $avgcolor);
    $c->stash(daycolor  => $daycolor);
    $c->render(template => 'report');
};

sub commify {
    my $text = shift;
    1 while $text =~ s/ ( \d ) ( \d{3} ) (\D|\z) /$1,$2$3/xms;
    return $text;
}


app->start;
__DATA__

@@ report.html.ep
<!DOCTYPE html>
<html>
  <head>
  <title><%= $date %></title>
  <style>
    body  {
    		background-color: black;
            font-family: Helvetica, Calibri, Arial, sans-serif;
    }
    h1    { 
    		color: grey; 
            font-weight: bolder; 
            font-size:4vw;
    }
    p     { 
    		color: lightgrey; 
    }
    table {
    		border: 0px;
    		table-layout: auto;
            width: 85%;
            border-collapse: collapse;
    }
    tr,
    th,
    td    { 
    		color: lightgrey;
            border-bottom: 1px solid #ddd;
            padding: 15px;
    }
    b,
    strong {
    		font-weight: bolder; 
    }
    
  </style>
  </head>
  <body>
  <div align=center>
  <h1><%= $title %></h1>
  </div>
  <div align=center>
  <table>
  <tr><th colspan=2><i><b style="font-size:3vw;font-family:Garamond,Cambria,Times,serif"><%= $date %></b></i></th></tr>
  <tr><td><b style="font-size:2vw;color:grey">Sales Last Business Day:</b></td>
    <td align=right><b style="font-size:7vw;color:<%= $daycolor %>">$ <%= $day %></b></td></tr>
  <tr><td><b style="font-size:2vw;color:grey">Sales Average MTD:</b></td>
    <td align=right><b style="font-size:7vw;color:<%= $avgcolor %>">$ <%= $avg %></b></td></tr>
  <tr><td><b style="font-size:2vw;color:grey">Sales Total MTD:</b></td>
    <td align=right><b style="font-size:7vw">$ <%= $tot %></b></td></tr>
  </table>
  </div>
  </body>
</html>

@@ detected.txt.ep
TXT is being served.