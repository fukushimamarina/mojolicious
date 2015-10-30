#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
# plugin 'PODRenderer';
plugin 'TagHelpers';

get '/' => sub {
	my $c = shift;

	$c->render(template => 'index');
};

post '/post' => sub {
	my $c = shift;

	my $name = $c->param('name');
	my $category = $c->param('category');

	$c->stash('name' => $name);
	$c->stash('category' => $category);

#	$c->redirect_to('/list');
	$c->render();
} => 'list';

#get '/list' => sub {
#	my $c = shift;
#	$c->render(templete => 'list');
#};


app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'エンジニア飲み会リスト';

<h1>みんなでつくる！飲み会リスト</h1>
飲み会のリストをつくります！<br>
元データはこちらをご参照ください！<%= link_to 'スプレッドシート' => 'https://docs.google.com/spreadsheets/d/1pAXG5zc96CAC2aUpw76-A0hayWs6cxVjpz9ZruKUBI0/edit#gid=0' %><br>

%= form_for post => (method => 'post') => begin
	%= label_for name => '店名'
	%= input_tag 'name', type => 'text', placeholder => 'マルミチェ'
	%= label_for name => 'カテゴリー'
	%= input_tag 'category', type => 'text', placeholder => 'イタリアン'
	%= submit_button '追加する！'
% end

@@ list.html.ep
% layout 'default';
% title 'リスト一覧';

<h1>飲み会リスト一覧</h1>
一覧になってます。<br>

<div class="list">
<table class="table" border="1">
	<thead>
		<tr>
			<th>店名</th>
			<th>カテゴリ</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><%= $name %></td>
			<td><%= $category %></td>
		</tr>
	</tbody>	
</table>
<div>


@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
	<head>
		<title><%= title %></title>
	</head>
	<body>
		<%= content %>
	</body>
</html>
