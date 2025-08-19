<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Function with Input</title>
    <!--  CDN CSS Bootstrap -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
      crossorigin="anonymous"
    />

    <!-- CDN Font Awesome -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css"
      integrity="sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
  </head>
  <body>

    <h1>Function with Input</h1>
    <form action="" method="post">
      <label for="firstname">First Name</label>
      <input type="text" name="firstname" id="firstname" placeholder="your first name">
      <input type="number" class="form-control my-2" name="num1" placeholder="first number">
      <input type="number" class="form-control my-2" name="num2" placeholder="second number">
      <input type="submit" name="submit" value="send">
    </form>
    <!-- CDN JS Bootstrap -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
      crossorigin="anonymous"
    ></script>
  </body>
</html>

<?php
  //create a function
  function getFirstName($first_name) {
    // echo "<p>My first name is $first_name</p>";
    return "<p>My first name is $first_name</p>";
  }

  function addNumber($a,$b) {
                $sum = $a + $b;
                // echo $sum;
                // return $sum;
                return $a + $b;
            }

  function getMinus($c,$d) {
      $minus = $c - $d;
      // echo $minus;
      return $minus;
  }

  if(isset($_POST['submit'])){
    $first_name = $_POST['firstname'];
    $num1 = $_POST['num1'];
    $num2 = $_POST['num2'];

    // call to function
    echo getFirstName($first_name);
    echo "sum " . addNumber($num1, $num2);
    echo "<br>";
    echo "minus " . getMinus($num1, $num2);

  }
?>