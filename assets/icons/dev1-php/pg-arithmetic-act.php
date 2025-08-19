<?php
if (isset($_POST['firstnum']) && isset($_POST['secondnum'])) {
    $num_1 = $_POST['firstnum'];
    $num_2 = $_POST['secondnum'];

    $sum = $num_1 + $num_2;
    $pro = $num_1 * $num_2;

    if ($num_2 != 0) {
        if ($num_1 > $num_2) {
            $dif = $num_1 - $num_2;
            $quo = $num_1 / $num_2;
        } else {
            $dif = $num_2 - $num_1;
            $quo = $num_1 / $num_2;
        }
    } else {
        $dif = 'Undefined';
        $quo = 'Undefined';
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Arithmetic Activity</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet"
  />
</head>
<body>
  <div class="container">
    <div class="card w-50 my-3 mx-auto">
      <div class="card-header text-center">
        <h6 class="my-2">pg-arithmetic-act</h6>
      </div>
      <div class="card-body">
        <form action="" method="post" class="mx-auto text-center my-3">
          <input type="number" class="form-control mb-3" name="firstnum" placeholder="First Number" />
          <input type="number" class="form-control mb-3" name="secondnum" placeholder="Second Number" />
          <input type="submit" class="btn btn-primary w-auto" value="Compute" />
        </form>
      </div>
    </div>

    <?php
    if (isset($_POST['firstnum']) && isset($_POST['secondnum'])) {
        echo '
        <div class="bg-secondary text-white text-center rounded-1 p-2 mb-2 w-50 mx-auto">
          First Number: ' . $num_1 . '<br>
          Second Number: ' . $num_2 . '
        </div>
        <div class="bg-primary text-white text-center rounded-1 p-2 w-50 mx-auto">
          The sum is: ' . $sum . '<br>
          The difference is: ' . $dif . '<br>
          The product is: ' . $pro . '<br>
          The quotient is: ' . $quo . '
        </div>';
    }
    ?>
  </div>
</body>
</html>
