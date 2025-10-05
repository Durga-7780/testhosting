<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <title>Employee Login</title>
    <link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">
	<style>
      body {
    background-color: #f4f4f4;
    font-family: 'Ubuntu', sans-serif;
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.header {
    display: flex;
    align-items: center;
    margin-top: 20px;
}

.header img {
    margin-right: 10px;
    height: 100px;
    width: 100px;
}

.header h1 {
    font-size: 4.5em;
    color: #004d40; /* Dark green for header text */
}

.login-card {
    background-color: #ffffff;
    width: 400px;
    height: auto;
    margin: 2em auto;
    border-radius: 1.5em;
    box-shadow: 0px 11px 35px 2px rgba(0, 0, 0, 0.14);
    text-align: center;
    padding: 40px;
}

.login-card h2 {
    color: #004d40; /* Dark green for subheader */
    font-weight: bold;
    font-size: 23px;
}

.login-card input[type="text"],
.login-card input[type="password"] {
    width: 76%;
    color: rgb(38, 50, 56);
    font-weight: 700;
    font-size: 14px;
    letter-spacing: 1px;
    background: #e0f2f1; /* Light green for input background */
    padding: 10px 20px;
    border: none;
    border-radius: 20px;
    outline: none;
    box-sizing: border-box;
    border: 2px solid #004d40;
    margin-bottom: 27px;
    margin-left: 5%;
    text-align: center;
}

.login-card input[type="text"]:focus,
.login-card input[type="password"]:focus {
    border: 2px solid #00796b; /* Slightly darker green for focus */
}

.login-card label {
    color: #004d40;
    font-size: 14px;
    font-weight: 700;
    margin-left: 5%;
}

.login-card .btn {
    cursor: pointer;
    border-radius: 5em;
    color: #fff;
    background: linear-gradient(to right, #004d40, #00796b); /* Dark green gradient for button */
    border: 0;
    padding: 10px 40px;
    font-size: 13px;
    box-shadow: 0 0 20px 1px rgba(0, 0, 0, 0.04);
    transition: background 0.3s;
}

.login-card .btn:hover {
    background: linear-gradient(to right, #00796b, #004d40); /* Hover effect */
}

.login-card .forgot {
    color: #004d40;
    padding-top: 15px;
}

.login-card a {
    color: #004d40;
    text-decoration: none;
}

.error {
    font-size: medium;
    color: red;
    font-weight: bold;
    display: none;
}

@media (max-width: 600px) {
    .login-card {
        border-radius: 0px;
    }
    .header {
        flex-direction: column;
        align-items: center;
    }
    .header img {
        margin-bottom: 10px;
    }
}

    </style>
</head>
<body>
    <div class="header">
        <img src="/images/harvesting.png" alt="Logo" height="50" width="65">
        <h1 style="font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;">Company Name</h1><br>
    </div>
    <div class="login-card">
        <h2>User Login</h2>
        <form autocomplete=off> 
           <!-- <input type="hidden" name="csrf_token" value="YOUR_CSRF_TOKEN"> <!-- Example hidden tag for CSRF protection -->
            
            <label for="username">Username</label>
            <input type="text" id="username" name="username" autocomplete=off size="32"  required>
            
            <label for="password">Password</label>
            <input type="password" id="password" name="password" autocomplete=off size="32" required>
            
            <input type="submit" class="btn" value="Login">
        </form>
        <p class="forgot">Don't have an account? <a href="registerPage">Register here</a></p>
        <p class="error" style="display: none;">Invalid credentials, please try again.</p>
    </div>
    <script>
    	var user=document.getElementById('username');
    	var pass=document.getElementById('password');
    	var btn=document.getElementsByClassName('btn')[0];
    	var err=document.getElementsByClassName('error')[0];
    	
    	btn.addEventListener('click',(e)=>{
		  e.preventDefault();
    		if((user.value).trim()!='' && (pass.value).trim()!='')
    		{
    			err.style.display='none';
    			var jsondata={
    					"username":user.value,
    					"password":pass.value
    			}
    			console.log(jsondata);
    			fetch('/checklogindata',{
    				method:'POST',
    				headers:{
    					'Content-Type':'application/json'
    				},
    				body:JSON.stringify(jsondata)
    			}).then(res=>{
    				if(!res.ok)
    					throw new Error('Response error')
    				return res.json()
    			}).then(data=>{
    				if(data.messg=='success')
    					{
    						window.location.href='dashboard';
    					}
    				else if(data.messg=='admin')
    					window.location.href='getAdmindata';
    				else{
    					err.style.display='block';
    					err.textContent='Username or Password incorrect / Please contact admin';  
    					setTimeout(()=>{
    						err.style.display='none';
    					},5000);
    				}
    			})
    			.catch(err=>console.log(err))
    		}
    		else{
    			err.style.display='block';
    		}
    	})
    	
    </script>
</body>
</html>