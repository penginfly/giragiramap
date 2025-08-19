<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Activity 3 - Odd or Even</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="card text-dark text-center bg-light mx-auto mt-3" style="max-width: 20rem;">
  <div class="card-header bg-secondary text-white"><h6 class="m-0">if-odd-even-act</h6></div>
  <div class="card-body mx-auto">
    <form method="post">
      <input type="number" class="form-control mb-2" name="num" placeholder="Enter any Number!" required>
      <input type="submit" value="Check" class="bg-danger text-white form-control mt-2" name="check">
    </form>
  </div>
</div>

<?php
function displayOddEvenResult($n){
    $n = $n;

    if ($n % 2 === 0) {
        $msg = "{$n} is Even Number!";
        $color = "bg-primary";
    } else {
        $msg = "{$n} is Odd Number!";
        $color = "bg-danger"; 
    }

    echo "<div class='card card-body {$color} text-white text-center mx-auto mt-3 fw-bold' style='max-width: 20rem;'>{$msg}</div>";
}


if (isset($_POST['check'])) {
  displayOddEvenResult($_POST['num']);
}
?>
</body>
</html>
