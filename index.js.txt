// Store registered users in localStorage for demo purposes
// In real apps, use backend API/database
let users = JSON.parse(localStorage.getItem('users')) || {};

// Elements
const registerDiv = document.getElementById('register-div');
const loginDiv = document.getElementById('login-div');
const dashboardDiv = document.getElementById('dashboard');

const registerForm = document.getElementById('registerForm');
const loginForm = document.getElementById('loginForm');

const toLoginBtn = document.getElementById('toLoginBtn');
const toRegisterBtn = document.getElementById('toRegisterBtn');
const logoutBtn = document.getElementById('logoutBtn');

const welcomeMsg = document.getElementById('welcomeMsg');

// Show login form
document.getElementById('toLoginBtn').addEventListener('click', () => {
  registerDiv.style.display = 'none';
  loginDiv.style.display = 'block';
  dashboardDiv.style.display = 'none';
});

// Show register form
document.getElementById('toRegisterBtn').addEventListener('click', () => {
  registerDiv.style.display = 'block';
  loginDiv.style.display = 'none';
  dashboardDiv.style.display = 'none';
});

// Logout
logoutBtn.addEventListener('click', () => {
  alert('Logged out!');
  showRegister();
});

// Register validation and save
registerForm.addEventListener('submit', (e) => {
  e.preventDefault();

  const name = document.getElementById('name').value.trim();
  const age = document.getElementById('age').value.trim();
  const address = document.getElementById('address').value.trim();
  const userid = document.getElementById('userid').value.trim();
  const password = document.getElementById('password').value.trim();
  const gender = document.getElementById('gender').value;

  // Basic validations
  if (!name || !address || !userid || !password || !gender || !age) {
    alert('Please fill all fields');
    return;
  }

  if (users[userid]) {
    alert('UserID already exists!');
    return;
  }

  // Save user
  users[userid] = {
    name,
    age,
    address,
    password,
    gender
  };
  localStorage.setItem('users', JSON.stringify(users));
  alert('Registration successful! You can now login.');
  showLogin();
});

// Login validation
document.getElementById('loginForm').addEventListener('submit', (e) => {
  e.preventDefault();

  const userid = document.getElementById('login-userid').value.trim();
  const password = document.getElementById('login-password').value.trim();

  if (!users[userid]) {
    alert('User not found!');
    //return;
  }

  if (users[userid].password !== password) {
    alert('Incorrect password!');
   // return;
  }

  fetch("http://localhost:8081/checklogin",{
  method: "POST", 
    headers: {
      "Content-Type": "application/json" // Indicate JSON payload
    },
    body: JSON.stringify({
      id: userid,      // Replace with actual user ID
      password: password // Replace with actual password
    })
  })
  .then(response => response.text())
  .then(data => {
	alert(data);
    console.log(data);
	showDashboard(userid);
  })
  .catch(error => {
    // Handle errors here
	alert(error);
    console.error("Error:", error);
  });
  
  // Successful login
  //showDashboard(userid);
});

// Functions to toggle views
function showRegister() {
  registerDiv.style.display = 'block';
  loginDiv.style.display = 'none';
  dashboardDiv.style.display = 'none';
}

function showLogin() {
  registerDiv.style.display = 'none';
  loginDiv.style.display = 'block';
  dashboardDiv.style.display = 'none';
}

function showDashboard(userid) {
  registerDiv.style.display = 'none';
  loginDiv.style.display = 'none';
  dashboardDiv.style.display = 'block';

  const user = users[userid];
  welcomeMsg.innerText = `Hello, ${user.name}! Welcome to the Dashboard.`;
}