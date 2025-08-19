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
    <h1>Form Handling</h1>

    <!-- <form action="file2.php" method="get">
        <label for="fullname">Full Name</label>
        <input type="text" name="fullname" id="fullname" placeholder="First Name Last Name">

        <label for="email">Email Address</label>
        <input type="email" name="email" id="email" placeholder="youremail@gmail.com">

        <input type="password" name="password" id="*********">

        <input type="submit" name="send" value="SEND">
    </form> -->

    <form action="file2.php" method="post" class="w-50 mx-auto">
        <label for="fullname" class="form-label">Full Name</label>
        <input type="text" name="fullname" id="fullname" placeholder="First Name Last Name">

        <label for="email" class="form-label">Email Address</label>
        <input type="email" class="form-control mb-2" name="email" id="email" placeholder="youremail@gmail.com">

        <input type="password" class="form-control mb-2" name="password" id="*********">

        <input type="submit" class="btn btn-primary" name="send" value="SEND">
    </form>

</body>
</html>