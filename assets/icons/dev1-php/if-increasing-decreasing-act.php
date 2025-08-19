<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Activity 4 - Increasing / Decreasing</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="card text-dark text-center bg-light mx-auto mt-3" style="max-width: 20rem;">
  <div class="card-header bg-secondary text-white"><h6 class="m-0">if-leap-act</h6></div>
  <div class="card-body mx-auto">
    <form method="post">
      <input type="number" class="form-control mb-2" name="num1" placeholder="First Number" required>
      <input type="number" class="form-control mb-2" name="num2" placeholder="Second Number" required>
      <input type="number" class="form-control mb-2" name="num3" placeholder="Third Number" required>
      <input type="submit" value="Check" class="btn btn-danger form-control mt-2" name="check">
    </form>
  </div>
</div>

<?php
function increaseOrDecrease($a, $b, $c){
    if ($a < $b && $b < $c) return "Increasing";
    elseif ($a > $b && $b > $c) return "Decreasing";
    return "Neither";
}



if (isset($_POST['check'])) {
    $a = (int)$_POST['num1'];
    $b = (int)$_POST['num2'];
    $c = (int)$_POST['num3'];

    echo "<div class='card card-header mx-auto mt-3 text-center' style='max-width: 20rem;'>";
    echo "<div>1st#: $a</div>";
    echo "<div>2nd#: $b</div>";
    echo "<div>3rd#: $c</div>";

    $label = increaseOrDecrease($a, $b, $c);
    echo "<div class='bg-info bg-secondary text-white text-center mt-3 p-2 rounded'>$label</div>";
    echo "</div>";
}
?>
</body>
</html>
