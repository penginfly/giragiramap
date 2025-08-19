<?php

function displayLengthAndWidth($a, $b){
    echo "<h6 class='text-center '>Length: " . $a . "</h6>";
    echo "<h6 class='text-center '>Width: " . $b . "</h6>";
}

function rectangle($a, $b) {
    return $a*$b;
}

function displayRectangle($a) {
    echo "<h5 class='text-center'>Area of Rectangle: " . $a . "</h5>";
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Activity 3</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
          crossorigin="anonymous">
    <style>
        th, td {
            width: 50%;
        }
    </style>
</head>
<body>

    <div class="card text-dark text-center bg-light mx-auto mt-3 w-25">
        <div class="card-header">
            <h6>pg-arithmetic-act</h6>
        </div>
        <div class="card-body">
            <form action="" method="post">
                <input type="number" class="form-control" name="num1" placeholder="First Number" required>
                <input type="number" class="form-control my-3" name="num2" placeholder="Second Number" required>
                <input type="submit" value="Compute" class="btn btn-primary mt-3" name="compute">
            </form>
        </div>
    </div>

    <?php
    if (isset($_POST['compute'])) {
        $num_1 = $_POST['num1'];
        $num_2 = $_POST['num2'];

      echo "<div class='card bg-success text-white text-center mx-auto mt-3 w-25 p-3'>";
      displayLengthAndWidth($num_1, $num_2);
      displayRectangle(rectangle($num_1, $num_2));
      echo "</div>";
    }
    ?>

</body>
</html>
