<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Activity 4 - Leap Year</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- parent div -->
<div class="card text-dark text-center bg-light mx-auto mt-3" style="max-width: 20rem;">
  <div class="card-header bg-secondary text-white"><h6 class="m-0">if-leap-act</h6></div>
  <div class="card-body mx-auto">
    <form method="post">
      <input type="number" class="form-control mb-2" name="year" placeholder="Enter any Year!" required>
      <input type="submit" value="Check" class="btn btn-danger form-control mt-2" name="check_leap">
    </form>
  </div>
</div>

<?php

function displayLeapYearResult($y){
    $y = $y;

    if (($y % 4 == 0 && $y % 100 != 0) || ($y % 400 == 0)) {
        $msg = "{$y} is a Leap Year!";
        $color = "bg-success";
    } else {
        $msg = "{$y} is NOT a Leap Year!";
        $color = "bg-danger";
    }

    echo "<div class='card card-body {$color} text-white text-center mx-auto mt-3' style='max-width: 20rem;'>{$msg}</div>";
}



if (isset($_POST['check_leap'])) {
  displayLeapYearResult($_POST['year']);
}
?>
</body>
</html>
