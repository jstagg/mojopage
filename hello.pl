use strict;
use warnings;
use utf8;
use feature ':5.16';

use Mojolicious::Lite;

get '/' => {
    text => 'I ♥ Mojolicious!',
    };

app->start;