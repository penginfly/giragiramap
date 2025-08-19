<?php

function displayCircumference($circumference) {

    echo "<div class='card w-25 mx-auto'>
        <p>Circumference =  $circumference </p>
        </div>";
}

function circumference($r, $pi) {
    return 2 * $pi * $r;
}


?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>circumference of a Circle</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
    crossorigin="anonymous"
  />
  <style>
    th, td {
      width: 50%;
    }
  </style>
</head>
<body>

  <div class="card text-dark text-center bg-light mx-auto mt-3 w-25">
    <div class="card-header">
      <h4>Circumference of a Circle</h4>
    </div>
    <div class="card-body">
      <form action="" method="post">
        <input type="number" class="form-control" name="num1" placeholder="Radius" required>
        <input type="submit" value="Submit" class="form-control bg-primary text-white mt-3" name="compute">
      </form>
    </div>
  </div>

  <?php
  if (isset($_POST['compute'])) {
      $r = $_POST['num1'];
      displayCircumference(circumference($r, pi()));
  }
  ?>

</body>
</html>
