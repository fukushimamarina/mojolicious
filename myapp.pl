#!/usr/bin/env perl
use Mojolicious::Lite;
use DBIx::Custom;
use DBD::mysql;


plugin 'TagHelpers';

#my $c = DBIx::Custom->connect(
#  dsn => 'dbi:mysql:database=mojo',
#  user => 'root'
#);

get '/' => sub {
	my $c = shift;

	$c->render('index');
};

post '/post' => sub {
	my $c = shift;

	my $dbi = DBIx::Custom->connect(
		dsn => 'dbi:mysql:database=mojo',
		user => 'root'
	);

	my $name = $c->param('name');
	my $category = $c->param('category');
	my $place = $c->param('place');

	$dbi->insert({
		name => [$name], 
		category => [$category], 
		place => [$place]
		},table => 'shop'); 


	$c->stash('name' => $name);
	$c->stash('category' => $category);
	$c->stash('place' => $place);

	$c->render('list');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'エンジニア飲み会リスト';

<h1>みんなでつくる！飲み会リスト</h1>
<p>飲み会のリストをつくります！</p>
<p>元データは<%= link_to 'こちら' => 'https://docs.google.com/spreadsheets/d/1pAXG5zc96CAC2aUpw76-A0hayWs6cxVjpz9ZruKUBI0/edit#gid=0' %>をご参照ください！</p>


%= form_for post => (method => 'post') => begin
	%= label_for name => '店名'
	%= input_tag 'name', type => 'text', placeholder => 'マルミチェ'
<br>
	%= label_for name => 'カテゴリー'
	%= input_tag 'category', type => 'text', placeholder => 'イタリアン'
<br>
	%= label_for name => '場所'
	%= input_tag 'place', type => 'text', placeholder => '五反田'
<br>
	%= submit_button '追加する！'
% end

@@ list.html.ep
% layout 'default';
% title 'リスト一覧';

<h1>飲み会リスト一覧</h1>
<p>一覧になってます。</p>

<div class="list">
<table class="table" border="1">
	<thead>
		<tr>
			<th>店名</th>
			<th>カテゴリ</th>
			<th>場所</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><%= $name %></td>
			<td><%= $category %></td>
			<td><%= $place %></td>
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



