<?php 
    session_start();
    ?>

<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width,maximum-scale=1,minimum-scale=1,initial-scale=1,viewport-fit=cover">
<meta charset="utf-8">
<title>Registration Form</title>
<style>
body, h1, h2, p, hr, #li {text-align: center; font-family: garamond; font-size: 100% 100% 100%;}
form {text-align: center}
</style>
</head>
<body>
<div id="header">
 <h1><img src="logo.png"></h1>
<form method="POST" action="home.php">
<div class= "container" width="30" height="30">
<h1>REGISTER|<strong><a href="login.php">LOGIN</a></h1>
<p>Please fill in this form to create a user account</p>
<hr>
<ul>
<li><label for="first name">
<b>Full Name</b></label>
<input type="text" placeholder="Enter full Name" name="full_name" id="full name" required></li>
<li><label for="Last name">
<b>Nickname</b></label>
<input type="text" placeholder="Enter Nickname" name="nickname" id="nickname" required></li>
<li><label for="Date Of Birth">
<b>Date Of Birth</b></label>
<input type="text" placeholder="DD-MM-YYYY" name="date_of_birth" id="date of birth" required></li>
<li><label for="email">
<b>Email</b></label>
<input type="text" placeholder="Enter Email" name="email" id="email" required></li>
<li><label for="address">
<b>City</b></label>
<input type="text" placeholder="Enter your City" name="city" id="city" required></li>
<li><label for="province">
<b>Province</b></label>
<input type="text" placeholder="Enter your Province" name="province" id="province" required></li>
<li><label for="phone number">
<b>Phone Number</b></label>
<input type="text" placeholder="Enter Phone Number" name="phone_number" id="phone number" required></li>
<li><label for="psw">
<b>Password</b></label>
<input type="text" placeholder="Enter Password" name="password" id="password" required></li>
<input type="radio" name="gender" value="Male"> Male
<input type="radio" name="gender" value="Female"> Female
<input type="submit" value="REGISTER">
</ul>
<hr> 
<p>By creating an account, you agree to our Terms & Privacy</p>
</div>
</form>
</body>
</html>

<?php 
    if(isset($_POST["REGISTER"])){
  
    if(!empty($_POST["nickname"]) &&
        !empty($_POST["email"])){

            $_SESSION["nickname"] = $_POST["nickname"];
            $_SESSION["email"] = $_POST["email"];
        
            echo $_SESSION["nickname"] . "<br>";
            echo $_SESSION["email"] . "<br>";
        }
    }  
    ?>
<?php { 
    include("footer.html");
}
?>
 