#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
# plugin 'PODRenderer';

get '/' => sub {
	my $c = shift;
	$c->render(template => 'index');
};

post '/post' => sub {
	my $c = shift;

	my $name = $c->req->parameters->{name};
	my $category = $c->req->parameters->{category};


	$c->rendirect('/');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'エンジニア飲み会リスト';
<h1>飲み会リスト</h1>
飲み会のリストをつくります！<br>
元データはこちらをご参照ください！<%= link_to 'スプレッドシート' => 'https://docs.google.com/spreadsheets/d/1pAXG5zc96CAC2aUpw76-A0hayWs6cxVjpz9ZruKUBI0/edit#gid=0' %><br>

<form class="form-inline" method="POST" action="/post">
    <div class="form-group">
        <label>お店の名前</label>
        <input type="text" class="form-control" name="name" placeholder="例: マルミチェ">
    </div>
    <div class="form-group">
        <label>カテゴリ</label>
        <input type="text" class="form-control" name="category" placeholder="イタリアン／ワイン">
    </div>
    <button type="submit" class="btn btn-default">教える</button>
</form>


@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
