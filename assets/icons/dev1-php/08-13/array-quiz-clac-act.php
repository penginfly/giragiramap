<?php
// 1st function 
function numCountry($num_quiz){
  echo "<div class='card mx-auto mt-4 w-50'>";
    echo "<div class='card-body'>";
      echo "<form method='post'>";
        for($count_input = 0; $count_input < $num_quiz; $count_input++){
          echo "<input type='number' name='quiz_num[]' class='form-control mx-auto my-1' placeholder='Input number' step='any'>";
        }
        echo "<input type='submit' name='cal' value='Caluculate Average' class='btn btn-primary btn-sm mt-2'>";
      echo "</form>";
    echo "</div>";
  echo "</div>";
}

function displayAnswer ($quizs){
        echo "<div class='card card-body mx-auto mt-4' style='max-width: 32rem;'>";
          echo "<ul class='list-unstyled mb-3'>";
          foreach($quizs as $quiz){
            echo "<li class='fs-4'>$quiz</li>";
          }
          echo "</ul>";
          $sum = sumOfNum($quizs);
          $avg = (count($quizs) > 0) ? number_format(averageOfNum($sum, count($quizs)), 4, '.', '') : '0.0000';
          echo "<h4 class='mb-1'>Sum: {$sum}</h4>";
          echo "<h4>Average: {$avg}</h4>";
        echo "</div>";
      }

      function sumOfNum($quizs){
        $sum = 0;
        foreach($quizs as $quiz){
          $sum += (float)$quiz;
        }
        return $sum;
      }

      function averageOfNum($sum, $num_quiz){
        return ($num_quiz > 0) ? ($sum / $num_quiz) : 0;
      }
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Template</title>
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
    <!-- CDN JS Bootstrap -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
      crossorigin="anonymous"
    ></script>

    <div class="card mt-3 w-25 mx-auto">
      <div class="card-header">
        <h5>Quiz Caluculator</h5>
      </div>
      <div class="card-body">
        <form action="" method="post">
          <input
            type="number"
            name="num_quiz"
            id="num_quiz"
            class="form-control my-2"
          />
          <input
            type="submit"
            value="Generate"
            name="submit"
            class="btn btn-success w-100"
          />
        </form>
      </div>
    </div>

    <?php
      if(isset($_POST['submit'])){
        $num_quiz = (int)$_POST['num_quiz'];
        if ($num_quiz > 0) {
          numCountry($num_quiz);
        }
      }

      if(isset($_POST['cal'])){
        $quizs = $_POST['quiz_num'] ?? [];
        displayAnswer($quizs);
      }

      
    ?>
  </body>
</html>
