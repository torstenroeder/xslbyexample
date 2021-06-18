<?php?>
<!DOCTYPE html>
<html lang="de">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" type="text/css" href="style.css" />
		<title>Zotero Example with PHP</title>
	</head>
	<body>
		<h1>Hello World!</h1>
		<? echo file_get_contents('https://api.zotero.org/groups/354807/collections/QA4642MV/items/top?format=bib&style=geistes-und-kulturwissenschaften-heilmann&linkwrap=1'); ?>
	</body>
</html>
