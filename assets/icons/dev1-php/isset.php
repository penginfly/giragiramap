<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Handing</title>
    <!--  CDN CSS Bootstrap -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
      crossorigin="anonymous"
    />
</head>
<body>
    <h1>Form Handling with isset</h1>

    <form action="" method="post" class="w-50 mx-auto">
        <label for="fullname" class="form-label">Full Name</label>
        <input type="text" class="form-control" name="fullname" id="fullname" placeholder="First Name Last Name">

        <label for="email" class="form-label">Email Address</label>
        <input type="email" class="form-control mb-2" name="email" id="email" placeholder="youremail@gmail.com">

        <input type="password" class="form-control mb-2" name="password" id="*********">

        <input type="submit" class="btn btn-primary w-100" name="send" value="SEND">
    </form>

</body>
</html>

<?php
    // isset function
    if(isset($_POST['send'])){
        //rule 
        $btn_submit = $_POST['send'];

        echo "You clicked the send button!:value--$btn_submit";

        echo "<h2 class='text-center text-white bg-danger'>My full name is  " . $_POST['fullname'] . "</h2>";
        echo "<P class='text-center text-white bg-secondary'>Email Address: " . $_POST['email'] . "</p>";

        $full_name = $_POST['fullname'];
        $email =$_POST['email'];

        echo "<div class='w-50 mx-auto text-center bg-success'>";
        echo "<h1>My Full name is $full_name.</h1>";
        echo "<P>Email Adress: $email</p>";
        echo "</div>";
    }

?>
