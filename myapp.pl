#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
# plugin 'PODRenderer';

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'エンジニア飲み会リスト';
<h1>飲み会リスト</h1>
飲み会のリストをつくります！
<%= link_to 'here' => '/perldoc' %>.


@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
