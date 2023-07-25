<%-- 
    Document   : StudentExam
    Created on : 17-Jul-2023, 9:35:59 am
    Author     : asifk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Sharp" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="shortcut icon" href="./images/manuuLogo1.png">
    <link rel="stylesheet" href="style.css">

    <style>
        body{overflow: hidden;}
        header{position: relative;}
        .exam{
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            height: 80vh;
            width: 80%;
            margin: auto;
        }
    </style>
</head>
<body>
     <header>
            <div class="logo">
                <img src="./images/manuuLogo1.png" alt="">
                <h2>D<span class="danger">M</span>S</h2>
            </div>
            <div class="navbar">
                <a href="StudentIndex.jsp">
                    <span class="material-icons-sharp">home</span>
                    <h3>Home</h3>
                </a>
                <a href="StudentTimeTable.jsp" onclick="timeTableAll()">
                    <span class="material-icons-sharp">today</span>
                    <h3>Time Table</h3>
                </a> 
                <a href="StudentAssignment.jsp">
                    <span class="material-symbols-outlined">assignment</span>
                    <h3>Assignment</h3>
                </a>
                <a href="StudentExam.jsp" class="active">
                    <span class="material-icons-sharp">grid_view</span>
                    <h3>Examination</h3>
                </a>
                <a href="index.html" >
                    <span class="material-icons-sharp">password</span>
                    <h3>Change Password</h3>
                </a>
                <a href="index.html">
                    <span class="material-icons-sharp">logout</span>
                    <h3>Logout</h3>
                </a>
            </div>
            <div id="profile-btn" style="display: none;">
                <span class="material-icons-sharp">person</span>
            </div>
            <div class="theme-toggler">
                <span class="material-icons-sharp active">light_mode</span>
                <span class="material-icons-sharp">dark_mode</span>
            </div>
        </header>

    <main>
        <div class="exam timetable">
            <h2>Exam Available</h2>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Subject</th>
                        <th>Room no.</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>3 Feb 2023</td>
                        <td>09-12 AM</td>
                        <td>BTCS111EST</td>
                        <td>F24</td>
                    </tr>
                    <tr>
                        <td>7 Feb 2023</td>
                        <td>09-12 AM</td>
                        <td>BTCS412PCT</td>
                        <td>F25</td>
                    </tr>
                    <tr>
                        <td>12 Feb 2023</td>
                        <td>09-12 AM</td>
                        <td>BTCS101BST</td>
                        <td>F24</td>
                    </tr>
                    <tr>
                        <td>14 Feb 2023</td>
                        <td>09-12 AM</td>
                        <td>BTCS612PCT</td>
                        <td>F25</td>
                    </tr>
                    <tr>
                        <td>18 Feb 2023</td>
                        <td>09-12 AM</td>
                        <td>BTCS511EST</td>
                        <td>F24</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </main>
    </main>

</body>

<script src="app.js"></script>
</html>