<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farm Dashboard</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
    <script async defer src="https://apis.google.com/js/api.js"></script>
    <script src="https://apis.google.com/js/api.js"></script>
    
	    
    <style>
		.date-time {
		    font-size: 16px;
		    color: #555;
		}
		.name,.username{
		font-size:18px;
		color:black;
		}
		
		.profile-section {
		    display: flex;
		    align-items: center;
		    position: relative;
		    z-index:1;
		}
		
		.profile-image {
		    width: 40px;
		    height: 40px;
		    border-radius: 50%;
		    cursor: pointer;
		}
		
		.profile-info {
		    display: none; /* Hidden initially */
		    flex-direction: column;
		    position: absolute;
		    top: 50px;
		    right: 0;
		    width:705%;
		    background-color: #fff;
		    padding: 10px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    border-radius: 5px;
		}
		
		.profile-info p {
		    margin: 5px 0;
		}
		
		.logout-btn {
		    padding: 5px 10px;
		    background-color: #ff4b4b;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		}
		
		.logout-btn:hover {
		    background-color: #ff3333;
		}
		.header {
		    grid-column: span 3;
		    background-color: #004d40;
		    color: white;
		    padding: 20px;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		.loadingstoday, .mill-data-section, .farmer-bill-section, .mill-bill-section, .profile-section,.todaytext{
		    margin: 0 10px;
		    padding-top:5px;
		    cursor:pointer;
		    font-size:medium;
		}
		.farmer-details, .mill-data, .add-new-mill, .add-new-farmer, .charts, #todaygraph, #dnmilldata, .formContainer, #addcomission, #displayCommData ,#farmerReceipt, #editform{
		    background-color: #ffffff;
		    padding: 20px;
		    border-radius: 8px;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		    height:41vh;
		    overflow:auto;
		}
		
		.farmer-details{
			width:203%;
		}
		.mill-data{
			width:100%;
			margin-left:104%;
		}
		.add-new-farmer input[type='text'],input[type='number']{
			margin-top:10px;
			margin-bottom:8px;
			width:100%;
		}
		h3 {
		    margin-bottom: 15px;
		}
		
		table {
		    width: 100%;
		    border-collapse: collapse;
		    margin-bottom: 15px;
		}
		
		th, td {
		    text-align: left;
		    padding: 8px;
		    border-bottom: 1px solid #ddd;
		}
		
		form {
		    display: flex;
		    flex-direction: column;
		    gap: 10px;
		}
		
		input[type="text"], input[type="number"] {
		    padding: 8px;
		    border-radius: 4px;
		    border: 1px solid #ccc;
		}

		button {
		    padding: 10px;
		    background-color: #004d40;
		    color: white;
		    border: none;
		    border-radius: 4px;
		    cursor: pointer;
		}
		
		button:hover {
		    background-color: #00796b;
		}
		
		.loading-stats, .bill-stats {
		    font-size: 18px;
		    font-weight: bold;
		} 
		* {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .dashboard {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            grid-template-rows: auto;
            gap: 20px;
            padding: 20px;
        }
        .loadingstoday{
        	margin-left:20%;
        }
    
	    #fbags,#varname{
	    	margin-left:10%;
	    }
		.vb{
			display:flex;
		}
		.accept {
		    background-color: #28a745; /* Green */
		}
		
		.reject {
		    background-color: #dc3545; /* Red */
		}
		#farmerdata{
			width:100%;
		}
		#act{
			width:20%;
		}
		#farname{
			width:30%;
		}
		.chartfooter{
			font-size:large;
			font-weight:bold;
			margin-left:30%;
			margin-top:5%;
		}
		#todaygraph,#dnmilldata,.formContainer,#addcomission,#displayCommData{			
			position:absolute;
			top:15%;
			width:35%;
			left:30%;
			display:none;
			border:2px solid grey;
		}
		#addcomission{
			height:55vh;
		}
		#dnmilldata,.formContainer,#displayCommData{
		width:75%;
		left:12%;
		height:75vh;
		}
		#dnmilldata #hfrom{
			margin-left:4%;
		}
		#dnmilldata #from{
			margin-right:5%;
		}
		#dnmilldata label {
		  margin-right: 10px;
  		  font-size:large;
		}
		#displayCommData{
			margin-left:8%;
		}
		#displayCommData input{
			font-size:20px;
		}
		#displayCommData select{
			font-size:20px;
		} 
		#dnmilldata #millname{
			margin-left:3%;
		}
		#dnmilldata select{
		  width:auto;
		  padding:5px 10px;
		  font-size:20px;
		  border-radius: 4px;
		  border: 1px solid #ccc;
		  text-transform:Capitalize;
		}
		#dnmilldata select option{
			font-size:20px;
			text-transform:Capitalize;
		}
		#dnmilldata input {
		   margin-right: 20px;
		  width: 180px;  
		  height: 35px;  
		  font-size: 16px; 
		  padding: 5px;
		  border-radius: 4px;
		  border: 1px solid #ccc;
		}
		
		#dnmilldata #to
		{
			margin-right:3%;
		}
		
		#GetDetails{
		  background-color: #4CAF50;
		  color: white;
		  border: none;
		  padding: 10px;
		  cursor: pointer;
		  font-weight:bold;
		  font-size:15px;
		  border-radius: 3px;
		}
		
		#GetDetails:hover {
		  background-color: #45a049;
		}
		#close,#millclose,#receiptclose,#editformclose,#addcomissionclose,#displayCommclose{
			font-size:45px;
			color:#dc3545;
			margin-left:94%;
			cursor:pointer;
		}
		#receiptclose{
			margin-left:85%;
			position:absolute;
			top:3%;
		}
		#close:hover{
			color:red;
		}
		#millclose{
			margin-left:60%;
			font-size:40px
		}
		#millclose:hover{
		color:red;
		}
		#addcomissionclose:hover{
		color:red;
		}
	    .downloadSection {
		  text-align: right;
		  margin-bottom: 10px;
		}
		
		.downloadBtn {
		  background-color: #4CAF50;
		  color: white;
		  padding: 10px 20px;
		  font-size: 16px;
		  border: none;
		  border-radius: 5px;
		  cursor: pointer;
		}
		
		.downloadBtn i {
		  margin-right: 5px;
		}
		
		.downloadBtn:hover {
		  background-color: #45a049;
		}
		.bx{
		font-size:30px;
		}
	
		.submitBtn,#receiptbtn, #whatsbtn {
		  padding: 10px 20px;
		  background-color: #4CAF50;
		  color: white;
		  border: none;
		  border-radius: 5px;
		  font-size: 16px;
		  cursor: pointer;
		}
		
		.submitBtn:hover {
		  background-color: #45a049;
		}
		#receiptbtn:hover{
			background-color: #45a049;
		}
		
		.formContainer{
			height:79vh;
		}
		.formCont {
			    margin: 0 auto;
			    padding: 20px;
			    border: 1px solid #ccc;
			    border-radius: 10px;
			    background-color: white;
			    height:65vh;
			}
			
			.formTable {
			    width: 100%;
			    border-collapse: collapse; 
			}
			
			.formTable td {
			    padding: 10px;
			    vertical-align: top; 
			}
			
			.formLabel {
			    display: block;
			    font-size: 16px;
			    margin-bottom: 5px;
			    color: #333;
			}
			
			.formInput,
			.formSelect {
			    width: 80%;
			    padding: 10px;
			    font-size: 18px;
			    border: 1px solid #ccc;
			    border-radius: 5px;
			    box-sizing: border-box; 
			    text-transform:Capitalize;
			}
			.formInput:disabled {
			    background-color: #f0f0f0; 
			    color: #666; 
			    cursor: not-allowed; 
			}
			#millSelected{
				width:100%;
			}
			#comform{
		     	padding:15px 30px;
				border:1px solid #ccc;
				border-radius:6px;
				font-size:20px;
			}
			#comform label{
				font-weight:bold;
			}
			#comform input{
				width:100%;
				font-size:20px;
			}
			#error{
				font-size:18px;
				color:green;
				font-weight:bolder;
				text-transform:capitalize;
			}
			.farmer_place{
			    position:absolute;
				top:31.5%;
				left:24%;
				width:25.3%;
			}
			#vehicle{
				 text-transform: uppercase;
			}
			#farmerReceipt,#editform{
				height:85vh;
				position:absolute;
				top:13%;
				left:30%;
				border:2px solid grey;
				max-width:800px;
				display:none;
			}
			#farmerReceipt table tr td{
				border:0px;
			}
			#farmerReceipt{
				width:38%;
			}
			#receiptname , #receiptmobile, #receiptplace, #receiptVariety, #receiptBags, #receiptCost, #receiptAmt, #receiptWeight, #receiptLoadingAmt,#receiptLabourBill,#receiptOldAmt{
				width:95%;
				font-size:18px;
			}
			#receiptbtn,#whatsbtn,#editsubmit,.getComData{
				width:45%;
			}
			#whatsbtn{
				position:absolute;
				top:87%;
				left:48%;
				padding:7px;
			}
			#whatsbtn .bx{
				font-size:20px;
			}
			#whatsbtn:hover{
				background-color: #45a049;
			}
			#receiptLabourBill{
				width:36%;
			}
			#receiptOldAmt{
				width:36%;
			}
			.left{
			width:45%;
			}
			.right{
				width:50%;
			}
			.l{
				width:85%;
			}
			.r{
			width:90%;
			}
			
			#editform{
			    display:block;
			    width:40%;
			    height:55vh;
				border:1px solid grey;
				padding:15px 20px;
				display:none;
			}
			#editform label{
				font-size:20px;
			}
			#editform input{
				width:100%;
				font-size:18px;
			}
			#editsubmit{
				width:100%;
				font-size:20px
			}
			.getComData{
				width:100%;
				font-size:20px;
				text-transform:capitalize;
				font-weight:bold;
			}
			#addcomissionclose{
				margin:0px;
			}
			#displayCommData{
				width:60%;
				height:70vh;
			}
			
</style>
</head>
<body>
    <div class="dashboard">
        <!-- Top Section with Process and Time -->
        <div class="header">
            <h2>Dashboard</h2>
            <div class="loadingstoday">
            <h3 id="todayLoad">Today Loadings</h3>
            </div>

        <!-- New Sections: Download Mill Data, Farmer Bill, Mill Bill -->
        <div class="mill-data-section">
            <h3 id="downloadMillData">Download Mill Data</h3>
        </div>
        <div class="farmer-bill-section">
            <h3 id="farmerBill">Farmer Bill</h3>
        </div>
        <div class="mill-bill-section">
            <h3 id="millBill">Mill Bill</h3>
        </div>
        <div class="mill-bill-section">
        	<h3 id="comission">Commission</h3>
        </div>
            <div class="time-section">
                <span class="todaytext"> Date : </span>
                <span id="dateTime"></span>
            </div>
            <div class="profile-section">
	            <img src="images/manasvi.jpg" alt="Profile Image" class="profile-image" onclick="toggleProfileDetails()">
	
	            <div class="profile-info" id="profile-info">
	            <table>
	            	<tr>
	            		<td>
		                	<p class="name">Name </p>
		                </td>
		                <td class="name" style="font-weight:bold;text-transform:capitalize"><p>${name}</p></td>
	                </tr>
	                <tr>
		                <td>
		                   <p class="username">Username </p>
		                </td>
		                <td class="username" style="font-weight:bold;text-transform:capitalize"><p>${username}</p></td>
	                </tr>
	            </table>
	                <button class="logout-btn" id="logout" style="font-weight:bold;">Logout</button>
	            </div>
	        </div>
        </div>

        <!-- Farmer Details -->
        <div class="farmer-details">
            <h3>Farmer Details</h3>
            
            <table id="farmerdata">
            	<c:if test="${not empty lidata}">
                 <thead id="head">
                    <tr>
                        <th id="farname">Farmer Name</th>
                        <th>Bags</th>
                        <th>Place</th>
                        <th>Mobile</th>
                        <th>Variety</th>
                        <th id='act'>Action</th>
                    </tr>
                </thead>
                <tbody id="tbody">
                	 <c:forEach items="${lidata}" var="obj">
                    <tr>
                        <td>${obj.fname}</td>
                        <td>${obj.fbags}</td>
                        <td>${obj.flocation}</td>
                        <td>${obj.fmobile}</td>
                        <td>${obj.fvariety}</td>
                        <td><button class='reject' onclick=reject('${obj.fmobile}')>remove</button>&nbsp;<button class='accept' onclick=Edit('${obj.fmobile}')>Edit</button></td>
                    </tr>
                </c:forEach> 
                </tbody>
                </c:if>
            </table>
           	<c:if test="${empty lidata}">
           		<p>No Farmer data found</p>
           	</c:if>
           	
        </div>

        <!-- Mill Data -->
        <div class="mill-data">
            <h3>Mill Data</h3>
            <c:if test="${not empty milldata}">
	            <table>
	                <thead>
	                    <tr>
	                        <th>Mill Name</th>
	                        <th>Location</th>
	                    </tr>
	                </thead>
	                <tbody>
	                <c:forEach items="${milldata}" var="obj">
	                    <tr>
	                        <td>${obj.mname}</td>
	                        <td>${obj.mlocation}</td>
	                    </tr>
	                </c:forEach>
	                </tbody>
	            </table>
            </c:if>
            <c:if test="${empty milldata}">
            	<p>No data found</p>
            </c:if>
        </div>
<br>
       
        <!-- Add New Mill -->
        <div class="add-new-mill">
            <h3>Add New Mill</h3>
            <form autocomplete=off>
                <label for="millName">Mill Name :</label>
                <input type="text" id="millname" name="mname" placeholder="Enter Mill Name">

                <label for="location">Location :</label>
                <input type="text" id="mlocation" name="mlocation" placeholder="Enter Location">

                <label for="capacity">Mobile :</label>
                <input type="text" id="mmobile" name="mmobile" placeholder="Enter Mobile">

                <button type="submit" id="addmillbtn">Add Mill</button>
            </form>
        </div>
		<!-- Adding new Farmer -->
		
		<div class="add-new-farmer">
			<h3>Enter New Farmer Details</h3>
			<form autocomplete=off >
				<div class="">
					<label for="name">Full Name : </label><br>
					<input type="text" id="fname" name="fname" placeholder="Enter Full Name"/><br>
					<label for="mobile">Mobile : </label><br>
					<input type="text" id="fmobile" name="fmobile" placeholder="Enter Mobile Number"/>
					<br>
					<label for="flocation">Place : </label><br>
					<input type="text" id="flocation" name="flocation" placeholder="Enter Location"/>
					
					<div class="vb">
						<div>
							<label for="fvariety" >Variety : </label><br>
							<input type="text" id="fvariety" name="fvariety" placeholder="Enter variety"/>
						</div>
						<div>
							<label for="fbags" id="varname">No of Bags : </label><br>
							<input type="number" id="fbags" name="fbags" placeholder="Enter no of bags"/>
						</div>
					</div>
				</div>
				<button class="btn1" type="submit">Submit</button>
			</form>
		</div>
		
			<div class="charts">		
	       		 <canvas id="myChart" style="width:100%;max-width:600px;"></canvas>
	       		 <p class="chartfooter">Remaining Stock Details</p>
			</div>
			
			<!-- Today loadings graph -->
			<div id="todaygraph">
				<canvas id="todayChart" style="width:100%;max-width:600px"></canvas>
				<p class="chartfooter">Today Loading Details</p>
			</div>
			
			<!-- download mill data -->
			<div id="dnmilldata">
			  <i class='bx bxs-message-alt-x' id="close"></i>
			  <br><br>
			  <label for="millname" id="millname">Mill name</label>
			  <select id="selectmill" autocomplete=off>
			  	<option>Select</option>
			  	<c:if test="${not empty milldata}">
				  	<c:forEach items="${milldata}" var="obj">
				  		<option value="${obj.mname}">${obj.mname}&nbsp;&nbsp;&nbsp;</option>
				  	</c:forEach>
			  	</c:if>
			  </select>
			  <label for="from" id="hfrom">From: </label>
			  <input type="date" id="from" autocomplete=off/>
			  
			  <label for="to" id="hto">To: </label>
			  <input type="date" id="to" autocomplete=off/>
			  
			  <button id="GetDetails">Get Details</button><br><br>
			  <p>&nbsp;&nbsp;&nbsp;**************************************************************************************************************************************************************************************************</p>
			  <br>
			  <div id="millbilldetails">
			  		<div class="downloadSection">
					  <button class="downloadBtn">
					    <i class="fas fa-download"></i> Download
					  </button>
					</div>
					<p id="err"></p>
			  		<table>
					  <thead id="thead">
					    <tr>
					      <th>S.No</th>
					      <th>Date</th>
					      <th>Farmer Name</th>
					      <th>Vehicle No</th>
					      <th>Variety</th>
					      <th>Bags</th>
					      <th>Rate</th>
					      <th>Weight</th>
					      <th>Amount</th>
					    </tr>
					  </thead>
					  <tbody id="millrow">
					  </tbody>
					</table>
			  </div>
			</div>
			
			<!-- Mill data form -->
  			<div class="formContainer">
  			<h3 style="margin-left:40%;font-size:30px;text-transform:Capitalize">Registration Bill <i class='bx bxs-message-alt-x' id="millclose"></i></h3>
  			 
		    <p>&nbsp;&nbsp;*************************************************************************************************************************************************************************************************</p>
		<form class="formCont" autocomplete="off">
			    <table class="formTable">
			        <tr>
			            <td class="left">
			                <label for="farmername" class="formLabel">Farmer Name</label>
			                <input type="text" class="formInput l" placeholder="Enter Full name" id="farmername" />
			            </td>
			            <td class="right">
			                <label for="selectCommision" class="formLabel">Commission Person</label>
			                <select class="formSelect r" id="selectCommision">
			                    
			                </select>
			            </td>
			        </tr>
			        <tr>
			        	<td class="left">
			        		<label for="MillMObile" class="formLabel">Mobile Number</label>
			                <input type="text" class="formInput l" id="MillMObile" placeholder="Farmer Mobile Number" />
			        	</td>
			        	<td class="right">
			        		<label for="Milldate" class="formLabel">Date</label>
								
								<%@ page import="java.text.SimpleDateFormat" %>
								<%@ page import="java.util.Date" %>
								<%
								    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
								    String currentDate = sdf.format(new Date());
								%>
			                <input type="text" class="formInput r" disabled value="<%= currentDate %>" id="Milldate" />
			        	</td>
			        </tr>
			        <tr>
			            <td class="left">
				                <label for="farmerplace" class="formLabel">Farmer Location </label>
				                <input type="text" class="formInput l" placeholder="Enter Farmer Location" id="farmerplace"/>
			            	</td>
			            <td class="right">
			                <label for="vehicle" class="formLabel">Vehicle No</label>
			                <input type="text" class="formInput r" id="vehicle" placeholder="AP37AJ1575" />
			            </td>
			        </tr>
			        <tr>
			            <td class="left">
			                <label for="MillVariety" class="formLabel">Variety</label>
			                <input type="text" class="formInput l" id="MillVariety" placeholder="Enter Variety " />
			            </td>
			            <td class="right">
			                <label for="millbags" class="formLabel">Bags</label>
			                <input type="text" class="formInput r" id="millbags" placeholder="Enter No of Bags" />
			            </td>
			        </tr>
			        <tr>
			            <td class="left">
			                <label for="weight" class="formLabel">Weight</label>
			                <input type="text" class="formInput l" placeholder="Only supports Numbers" id="millweight" />
				    		<label for="millSelected" class="formLabel" style="margin-top:6%;font-size:20px"><b>Mill Name<b></label>
			            </td>
			            <td class="right">
			                <label for="rate" class="formLabel">Cost</label>
			                <input type="text" class="formInput r" placeholder="Enter Cost in Rs." id="millcost"/>
			                 <select class="formSelect r" id="millSelected" style="margin-top:2.5%;width:90%">
			                    <option>Select</option>
			                    <c:if test="${not empty milldata}">
			                        <c:forEach items="${milldata}" var="obj">
			                            <option value="${obj.mname}">${obj.mname} (${obj.mlocation})</option>
			                        </c:forEach>
			                    </c:if>
			                </select>
			            </td>
			        </tr>
			    </table>
			    <input type="submit" value="Submit" class="submitBtn" id="millbillbtn" />
			</form>
			</div>
			
			<div id="addcomission">
			     <i class='bx bxs-message-alt-x' style="margin-left:90%;font-size:40px" id="addcomissionclose"></i>
				<h3 style="margin-left:15%;font-size:25px;text-transform:Capitalize">Add Commission Person Details &nbsp;&nbsp;</h3>
  			 
		    <p>&nbsp;****************************************************************************************</p>
		 
			  <form id="comform" autocomplete=off>
					<table>
						<tr>
							<td>
								<label>
									Name 
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Name " id="comname"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Mobile
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Mobile " id="commobile"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Place
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Location " id="complace"/>
							</td>
						</tr>
					</table>
					<input type="submit" value="Submit" class="submitBtn" id="combtn"/>
				</form><br>
				<button class="getComData">Get Commissions Data</button>
				<span id="error"></span>
			</div>
			
			<div id="farmerReceipt">
			        <i class='bx bxs-message-alt-x' id="receiptclose"></i>
					<h3 style="font-size:30px;margin-left:33%">Farmer Bill </h3>
					<p>&nbsp;&nbsp;**********************************************************************************************</p>
			  <form id="Receipt" autocomplete=off>
					<table>
						<tr>
							<td>
								<label>
									Name 
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Name " id="receiptname" name="inp"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Mobile
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Mobile " id="receiptmobile" name="inp"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Place
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Location " id="receiptplace" name="inp"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Variety
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Variety" id="receiptVariety" name="inp"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Bags
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Bags" id="receiptBags" name="inp"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>Weight </label>
							</td>
							<td>
								<input type="text" placeholder="Enter Weight" id="receiptWeight"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Rate
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Cost" id="receiptCost" name="inp"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Amount
								</label>
							</td>
							<td>
								<input type="text" placeholder="Enter Amount" id="receiptAmt" name="inp"/>
								<input type="hidden" value=""id="receiptDate"/>
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Loading Amount
								</label>
							</td>
							<td>
								<input type="text" placeholder="Loading amount" id="receiptLoadingAmt" />
							</td>
						</tr>
						<tr>
							<td>
								<label>
									Labour Bill
								</label>
							</td>
							<td>
								<input type="text" placeholder="Labour Bill" id="receiptLabourBill"  />
								<label>
									&nbsp;&nbsp;&nbsp;Due Amount&nbsp;
								</label>
								<input type="text" placeholder="Amount due" id="receiptOldAmt" />
							</td>
						</tr>
					</table>
								<input type="submit" value="Submit" style="width:96%" class="receiptBtn" id="receiptbtn"/>
								<!--  <button id=whatsbtn><i class='bx bxl-whatsapp' ></i> Whatsapp</button> -->
								<span class="error" id="receipterr" style="font-size:18px;color:red;display:none"></span>
				</form>
			</div>
			
			<div id="editform">
			        <i class='bx bxs-message-alt-x' id="editformclose"></i>
				<h1 style="margin-left:30%">Edit Farmer Details</h1><br>
				<p>*******************************************************************************************************</p>
				<table>
					<tr>
						<td>
							<label for="name">Farmer name </label>
						</td>
						<td>
							<input type="text" id="editFname"/>
						</td>
					</tr>
					<tr>
						<td>
							<label for="bags">Bags </label>
						</td>
						
						<td>
							<input type="text" id="editFbag"/>
						</td>
					</tr>
					<tr>
						<td>
							<label for="place">Place </label>
						</td>
						<td>
							<input type="text" id="editFplace" />
						</td>
					</tr>
					<tr>
						<td>
							<label for="mobile">Mobile </label>
						</td>
						<td>
							<input type="text" id="editFmobile"/>
							<input type="hidden" id="edithidden"/> 
						</td>
					</tr>
					<tr>
						<td>
							<label for="variety">Variety </label>
						</td>
						<td>
							<input type="text" id="editFvariety"/>
						</td>
					</tr>
				</table>
				<button class="submitbtn" id="editsubmit">Submit</button>
			</div>
			
			<div id="displayCommData" >
					<h4 style="margin-left:35%;font-size:30px">Select Comission Person</h4>
					<i class='bx bxs-message-alt-x' id="displayCommclose"></i>
				  <br><br>
				  <label for="CommName" style="font-size:20px">&nbsp;&nbsp;&nbsp;</label>
				  <select id="selectCom" autocomplete=off style="cursor:pointer">
				  	
				  </select>
				  <label for="from" style="font-size:20px">&nbsp;&nbsp;From: </label>
				  <input type="date" id="comdatafrom" autocomplete=off/>
				  
				  <label for="to" style="font-size:20px">&nbsp;&nbsp;To: </label>
				  <input type="date" id="comdatato" autocomplete=off/>
				  &nbsp;&nbsp;
				  <button id="comgetdata" style="font-weight:bold;font-size:18px">Get Details</button><br><br>
				  <p>&nbsp;&nbsp;&nbsp;******************************************************************************************************************************************************</p>
				  <br>
				  
				  <div id="comdetails">
			  		<div class="downloadSection">
					  <button class="downloadBtn" id="comdwbtn">
					    <i class="fas fa-download"></i> Download
					  </button>
					</div>
					<p id="comerr"></p>
			  		<table>
					  <thead id="comthead">
					    <tr>
					      <th>S.No</th>
					      <th>Date</th>
					      <th>Farmer Name</th>
					      <th>Bags </th>
					      <th>Variety</th>
					      <th>Rate </th>
					      <th>Weight</th>
					      <th>Amount</th>
					    </tr>
					  </thead>
					  <tbody id="comrow">
					  </tbody>
					</table>
			  </div>
			</div>
        </div>	<!-- Dashboard  -->
        
     <script src="javscript/dashboard.js"></script>
</body>
</html>

