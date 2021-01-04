use strict;
use warnings;
use utf8;
use feature ':5.16';
use Time::Piece;

my $file  = 'dollars.html';
my $title = 'Invoice Dollars from Data Warehouse';
my $date  = '20210101';
my $day   = '7000000';
my $avg   = '5999999';
my $tot   = '12999999';

my $t = Time::Piece->strptime($date, "%Y%m%d");
my $date = $t->strftime("%A %B %d %Y");

my $avgcolor;
if ($avg >= 6000000) { $avgcolor = 'green'; }
elsif ($avg < 5000000) { $avgcolor = 'red'; }
else { $avgcolor = 'lightgrey'; }

my $daycolor;
if ($day >= 6000000) { $daycolor = 'green'; }
elsif ($day < 5000000) { $daycolor = 'red'; }
else { $daycolor = 'lightgrey'; }

commify($day);
commify($avg);
commify($tot);

my $str = <<"HTML";
<!DOCTYPE html>
<html>
  <head>
    <title>$title</title>
    <style>
      body {
        background-color: black;
        font-family: Helvetica, Calibri, Arial, sans-serif;
      }
      h1 {
        color: #FFCC66;
        font-weight: bolder;
        font-size: 4vw;
      }
      p {
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
      td {
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
    <div align="center">
      <h1>$title</h1>
    </div>
    <div align="center">
      <table>
        <tr>
          <th colspan="2">
            <i>
              <b style="font-size: 3vw; font-family: Garamond, Cambria, Times, serif; color: white;">$date</b>
            </i>
          </th>
        </tr>
        <tr>
          <td>
            <b style="font-size: 2vw; color: grey;">Sales Last Business Day:</b>
          </td>
          <td align="right">
            <b style="font-size: 7vw; color:$daycolor;">&#36; $day </b>
          </td>
        </tr>
        <tr>
          <td>
            <b style="font-size: 2vw; color: grey;">Sales Average MTD:</b>
          </td>
          <td align="right">
            <b style="font-size: 7vw; color:$avgcolor;">&#36; $avg </b>
          </td>
        </tr>
        <tr>
          <td>
            <b style="font-size: 2vw; color: grey;">Sales Total MTD:</b>
          </td>
          <td align="right">
            <b style="font-size: 7vw;">&#36; $tot</b>
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>

HTML

print "$str\n";

open(FH,"> $file") or die "Failed opening $file: [$!]";
print FH $str;
close(FH);

sub commify {
    my $text = shift;
    1 while $text =~ s/ ( \d ) ( \d{3} ) (\D|\z) /$1,$2$3/xms;
    return $text;
}

# -30-