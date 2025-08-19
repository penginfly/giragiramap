<?php
    //$_GET[];
    // echo "<h2>My full name is  " . $_GET['fullname'] . "</h2>";
    // echo "<P>Email Address: " . $_GET['email'] . "</p>";

    //     $full_name = $_GET['fullname'];
    //     $email =$_GET['email'];

    //     echo "<h1>My Full name is $full_name.</h1>";
    //     echo "<P>Email Adress: $email</p>";

    //$_POST[];
    echo "<h2>My full name is  " . $_POST['fullname'] . "</h2>";
    echo "<P>Email Address: " . $_POST['email'] . "</p>";

        $full_name = $_POST['fullname'];
        $email =$_POST['email'];

        echo "<h1>My Full name is $full_name.</h1>";
        echo "<P>Email Adress: $email</p>";
?>