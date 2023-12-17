<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1,initial-scale=1,viewport-fit=cover">
<meta charset="utf-8">
<title>LOGIN INFORMATION</title>
<style>
fieldset, body, h1 {text-align: center; font-family: garamond; font-size: 100% 100% 100%;}
</style>
</head>
<body>
<div id="header">
 <h1><img src="logo.png"></h1>
<form action="home.php" method="POST">
<br><label for="full name"><strong>Full Name:</strong></label><br>
<input type="text" name="full name" id="full name" required>
<br><label for="nickname"><strong>Nickname</strong></label><br>
<input type="text" name="nickname" id="nickname" required>
<br><label for="password"><strong>Password:</strong></label><br>
<input type="password" name="password" id="password" required display password>
<br><label for="phone number"><strong>Email:</strong></label><br>
<br><input type="email" name="email" id="email" required><br>
<input type="submit" value="Login">
<h1>Welcome back, Earthmate!</h1>
</form>
</body>
</html>
<br>
<?php
    if(isset($_POST["login"])){
        
        if(!empty($_POST["nickname"]) &&
           !empty($_POST["email"])){

        $_SESSION["nickname"] = $_POST["nickname"];
        $_SESSION["email"] = $_POST["email"];

        }
    }   
?>
