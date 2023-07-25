<%-- 
    Document   : FacultyTimeTable
    Created on : 17-Jul-2023, 9:42:30 am
    Author     : asifk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard</title>
    <link rel="shortcut icon" href="./images/manuuLogo1.png">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="style.css">
</head>
<body>
   <header>
            <div class="logo" title="University Management System">
                <img src="./images/manuuLogo1.png" alt="">
                <h2>D<span class="danger">M</span>S</h2>
            </div>
            <div class="navbar">
                <a href="FacultyIndex.jsp" >
                    <span class="material-icons-sharp">home</span>
                    <h3>Home</h3>
                </a>
                <a href="FacultyAttendence.jsp">
                    <span class="material-icons-sharp">calendar_today</span>
                    <h3>Attendance</h3>
                </a>
                <a href="FacultyAssignment.jsp">
                    <span class="material-symbols-outlined">assessment</span>
                    <h3>Assignment & Notes</h3>
                </a>
                <a href="FacultyTimeTable.jsp" class="active">
                    <span class="material-icons-sharp">today</span>
                    <h3>Time Table</h3>
                </a>
                <a href="index.html">
                    <span class="material-icons-sharp">password</span>
                    <h3>Change Password</h3>
                </a>
                <a href="index.html">
                    <span class="material-icons-sharp" onclick="">logout</span>
                    <h3>Logout</h3>
                </a>
            </div>
            <div id="profile-btn">
                <span class="material-icons-sharp">person</span>
            </div>
            <div class="theme-toggler">
                <span class="material-icons-sharp active">light_mode</span>
                <span class="material-icons-sharp">dark_mode</span>
            </div>

        </header>
    
    <div class="container">
        <aside>
            <div class="profile">
                <div class="top">
                    <div class="profile-photo">
                        <img src="./images/KhalidaAfroaz.jpg" alt="">
                    </div>
                    <div class="info">
                        <p>Hey, <b>Khaleda Afroaz</b></p>
                        <small class="text-muted">Department of Computer Science</small>
                    </div>
                </div>
                <div class="about">
                    <h5>Qualification</h5>
                    <p>Ph.D in Computer Science</p>
                    <h5>Research Interests</h5>
                    <p>Data Mining, Machine Learning, Artificial Intelligence</p>
                    <h5>Contact</h5>
                    <p>9999999999</p>
                    <h5>Email</h5>
                    <p>khaledaafroaz@manuu.edu.in</p>
                    <h5>Address</h5>
                    <p>123 Main Street, Hyderabad</p>
                </div>
            </div>
        </aside>
        <main>
            <div class="timetable" id="timetable">
                <div>
                    <span id="prevDay">&lt;</span>
                    <h2>Today's Timetable</h2>
                    <span id="nextDay">&gt;</span>
                </div>
                <span class="closeBtn" onclick="timeTableAll()">X</span>
                <table>
                    <thead>
                        <tr>
                            <th>Time</th>
                            <th>Room No.</th>
                            <th>Subject</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <div class="timetable" id="timetable">

                <h2>See time table</h2>
                        <label for="faculty-id">Faculty ID:</label>
                        <input type="text" id="faculty-id">
                        <button onclick="getTimetable()">View Timetable</button>
                
                        <div id="timetable-container"></div>
            </div>
            
        </main>
        <div class="right">
            <div class="announcements">
                <h2>Recent Activity</h2>
                <div class="updates">

                    <div class="message">
                        <p> <b>New Notification</b> have a new notification from the university management. Please check your email for more details.</p>
                        <small class="text-muted">5 minutes ago</small>
                    </div>
                    <div class="message">
                        <p> <b>New Assignment submissions</b> Md Asif submited his assignment.</p>
                        <small class="text-muted">10 minutes ago</small>
                    </div>
                </div>
            </div>
            <div class="announcements">
                <h2>Announcements</h2>
                <div class="updates">
                    <div class="message">
                        <p> <b>Academic</b> Summer training internship with Live Projects.</p>
                        <small class="text-muted">2 Minutes Ago</small>
                    </div>
                    <div class="message">
                        <p> <b>Co-curricular</b> Global internship oportunity by Student organization.</p>
                        <small class="text-muted">10 Minutes Ago</small>
                    </div>
                    <div class="message">
                        <p> <b>Examination</b> Instructions for Mid Term Examination.</p>
                        <small class="text-muted">Yesterday</small>
                    </div>
                    
                </div>
            </div>
           
        </div>
        </div>
    

	<script>
		const facultyData = {
			"Khalid": [
				["Monday", "09:00 AM - 11:00 AM", "Classroom 101"],
				["Monday", "11:00 AM - 01:00 PM", "Classroom 102"],
				["Tuesday", "09:00 AM - 11:00 AM", "Classroom 103"],
				["Tuesday", "11:00 AM - 01:00 PM", "Classroom 101"],
				["Wednesday", "09:00 AM - 11:00 AM", "Classroom 102"],
				["Wednesday", "11:00 AM - 01:00 PM", "Classroom 103"],
				["Thursday", "09:00 AM - 11:00 AM", "Classroom 101"],
				["Thursday", "11:00 AM - 01:00 PM", "Classroom 102"],
				["Friday", "09:00 AM - 11:00 AM", "Classroom 103"],
				["Friday", "11:00 AM - 01:00 PM", "Classroom 101"]
			],
			"Khaleda": [
				["Monday", "09:00 AM - 11:00 AM", "Classroom 102"],
				["Monday", "11:00 AM - 01:00 PM", "Classroom 103"],
				["Tuesday", "09:00 AM - 11:00 AM", "Classroom 101"],
				["Tuesday", "11:00 AM - 01:00 PM", "Classroom 102"],
				["Wednesday", "09:00 AM - 11:00 AM", "Classroom 103"],
				["Wednesday", "11:00 AM - 01:00 PM", "Classroom 101"],
				["Thursday", "09:00 AM - 11:00 AM", "Classroom 102"],
				["Thursday", "11:00 AM - 01:00 PM", "Classroom 103"],
				["Friday", "09:00 AM - 11:00 AM", "Classroom 101"],
				["Friday", "11:00 AM - 01:00 PM", "Classroom 102"]
			]
			// Add more faculty data here if needed
		};

		function getTimetable() {
			const facultyId = document.getElementById("faculty-id").value;

			// Retrieve the timetable data for the selected faculty
			const timetableData = facultyData[facultyId];

			// Display the timetable data
			const timetableContainer = document.getElementById("timetable-container");
			if (timetableData) {
				const table = document.createElement("table");
				const tableHeader = table.createTHead();
				const tableHeaderRow = tableHeader.insertRow();
				const dayHeader = tableHeaderRow.insertCell();
				dayHeader.innerHTML =			"<b>Day</b>";
			const timeHeader = tableHeaderRow.insertCell();
			timeHeader.innerHTML = "<b>Time</b>";
			const locationHeader = tableHeaderRow.insertCell();
			locationHeader.innerHTML = "<b>Location</b>";
			const tableBody = table.createTBody();

			timetableData.forEach(data => {
				const row = tableBody.insertRow();
				const dayCell = row.insertCell();
				dayCell.innerHTML = data[0];
				const timeCell = row.insertCell();
				timeCell.innerHTML = data[1];
				const locationCell = row.insertCell();
				locationCell.innerHTML = data[2];
			});

			// Clear any existing timetable data and display the new table
			timetableContainer.innerHTML = "";
			timetableContainer.appendChild(table);
		} else {
			timetableContainer.innerHTML = "<p>Invalid faculty ID</p>";
		}
	}
</script>
    <script src="facultytimetable.js"></script>
       <script src="script.js"></script>
       <script src="app.js"></script>
</body>
</html>



