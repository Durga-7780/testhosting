<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
<link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">
    <style>
       body {
    background-color: #f4f4f4;
    font-family: 'Ubuntu', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.register-card {
    background-color: #ffffff;
    width: 400px;
    height: auto;
    margin: 7em auto;
    border-radius: 1.5em;
    box-shadow: 0px 11px 35px 2px rgba(0, 0, 0, 0.14);
    text-align: center;
    padding-top: 40px;
    padding-bottom: 40px;
}

.register-card h2 {
    color: #004d40; /* Dark green to match the dashboard and login header */
    font-weight: bold;
    font-size: 23px;
}

.register-card input[type="text"],
.register-card input[type="password"] {
    width: 76%;
    color: rgb(38, 50, 56);
    font-weight: 700;
    font-size: 18px;
    letter-spacing: 1px;
    background: #e0f2f1; /* Light green background for input fields */
    padding: 10px 20px;
    border: none;
    border-radius: 20px;
    outline: none;
    box-sizing: border-box;
    border: 2px solid #004d40;
    margin-bottom: 27px;
    margin-left: 2%;
    text-align: center;
    font-family: 'Ubuntu', sans-serif;
}

.register-card input[type="text"]:focus,
.register-card input[type="password"]:focus {
    border: 2px solid #00796b; /* Darker green for focus */
}

.register-card label {
    color: #004d40; /* Dark green for labels */
    font-size: 14px;
    font-weight: 700;
    margin-left: 11%;
}

.register-card .btn {
    cursor: pointer;
    border-radius: 5em;
    color: #fff;
    background: linear-gradient(to right, #004d40, #00796b); /* Green gradient for button */
    border: 0;
    padding: 10px 40px;
    font-family: 'Ubuntu', sans-serif;
    font-size: 13px;
    box-shadow: 0 0 20px 1px rgba(0, 0, 0, 0.04);
    transition: background 0.3s;
}

.register-card .btn:hover {
    background: linear-gradient(to right, #00796b, #004d40); /* Hover effect for button */
}

.register-card .forgot {
    color: #004d40;
    padding-top: 15px;
}

.register-card a {
    color: #004d40;
    text-decoration: none;
}

.errorMessage1,
.errorMessage2 {
    display: none;
    color: red;
    font-weight: bold;
}

@media (max-width: 600px) {
    .register-card {
        border-radius: 0px;
    }
}

    </style>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="register-card">
        <h2>Employee Registration</h2>
        <form id=registrationForm autocomplete=off>
          <!--  <input type="hidden" name="csrf_token" value="YOUR_CSRF_TOKEN">  Example hidden tag for CSRF protection -->
            
            <label for="employee_name">Full Name</label>
            <input type="text" id="employee_name" name="name"  size="32" required><br>
            
            <label for="employee_id">Mobile number</label>
            <input type="text" id="mobile" name="mobile" size="32"  class="empid" required><br>            
            
            <label for="username">Username</label><br>
            <input type="text" id="username" name="username" size="32"  class="username" required><br>
            
            <label for="password">Password</label><br>
            <input type="password" id="password" name="password"  size="32" required><br>
            
            <input type="submit" class="btn" value="Register">
        </form>
        <p class="forgot">Already have an account? <a href="login">Login here</a></p>
        <span class="errorMessage1"></span>
        <span class="errorMessage2"></span>
    </div>
    <script>
        var err=document.getElementsByClassName('errorMessage1')[0];
        var err2=document.getElementsByClassName('errorMessage2')[0];
        
    	$('.btn').click(()=>{
    		var empname=document.getElementById('employee_name');
    		var mobile=document.getElementById('mobile');
    		var user=document.getElementById('username');
    		var pass=document.getElementById('password');
    		
    		if((empname.value).trim()!=''&&(mobile.value).trim()!=''&&(user.value).trim()!=''&&(pass.value).trim()!=''&&err.style.display=='none'&&err2.style.display=='none')
    		{
	    		var jsondata={
	    				'empname':empname.value,
	    				'mobile':mobile.value,
	    				'user':user.value,
	    				'pass':pass.value
	    		}
	    		$.ajax({
	    			url:'saveregdata',
	    			data:JSON.stringify(jsondata),
	    			contentType: 'application/json',
	    			datatype:'json',
	    			type:'POST',
	    			success:(res,statuscode)=>{
	    			if(res.messg=="login")
	    				window.location.replace('login');
	    			else window.location.replace('registerPage');
	    			},
	    			error:(obj,err,messge)=>{
	    				console.log(messge);
	    			}
	    		})
    		}
    		else alert("All fields must be filled ");
    		})
    		
    		var btn=document.getElementsByClassName('btn')[0];
    		// mobile number validation
    		$('#mobile').keyup(()=>{
    			var val=$('#mobile').val().trim();
    			if(val.match("^[6789][0-9]{9}$")){
    				err.style.display='none';
    			}
    			else{
    				err.style.display='block';
    				err.textContent='Invalid Mobile number';
    			}    			   			
    		})
    		
    		// checking username already exists
    		
    		$('#username').keyup(()=>{
    			var val=$('#username').val().trim();
    			
    			$.ajax({
    				url:'checkusername',
    				dataType:'json',
    				type:'POST',
    				contentType:'application/json',
    				data:JSON.stringify({'id':val}),
    				success:(res)=>{
    					if(res){
    						err2.style.display='block';
    						err2.textContent='Username already exists';
    					}
    					else{
    						err2.style.display='none';    						
    					}
    				}
    				
    			})
    		})
    </script>
</body>
</html>