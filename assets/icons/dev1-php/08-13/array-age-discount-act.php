<?php
function num($num){
  echo "<div class='card mx-auto mt-4 w-50 rounded-0'>";
    echo "<div class='card-header bg-white'>";


    echo "<div class='card-body'>";
      echo "<form method='post' class='text-center'>";
        for($count_input = 0; $count_input < $num; $count_input++){
          echo "<input type='number' name='peopleAge[]' class='form-control mx-auto my-1' placeholder='Enter age here'>";
        }
        echo "<input type='submit' name='save' value='SAVE' class='btn btn-primary w-75 mt-2'>";
      echo "</form>";
    echo "</div>";
  echo "</div>";
}

// inner funciton
function caluculateDiscount($ageOfEachPerson){
    if($AgeOfEachPerson < 6){
        return 0;
    } elseif ($AgeOfEachPerson < 10){
        return 325*0.9;
    } elseif ($AgeOfEachPerson > 60){
        return 325*0.95;
    }
    return 325;
}

function arrayOfPeople($ageOfPeople){
    $index = 0;
    $priceOfPeople = [];
    foreach($ageOfEachPeople as $ageOfEachPerson){
        $priceOfPeople[$index] = caluculateDiscount($ageOfEachPeople);
        $index++;
    }
}

?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Template</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  </head>
  <body>
    <div class="card mt-3 w-50 mx-auto rounded-0 text-center">
      <div class="card-header bg-white">
        <h1 class="diplay-1 fw-light">How many people are going to eat?</h1>
      </div>
      <div class="card-body">
        <form action="" method="post">
          <input type="number" name="num" class="form-control my-2" placeholder="number of people"/>
          <input type="submit" value="SUBMIT" name="submit" class="btn btn-success w-75" />
        </form>
      </div>
    </div>

    <?php
      if(isset($_POST['submit'])){
        $num = $_POST['num'];
        numCountry($num);
      }

      if(isset($_POST['save'])){
        $nums = $_POST['peopleAge'];
        
      }

      function displayAnswer ($quizs){
        echo "<div class='card card-body mx-auto mt-4'>";

          echo "<ul class='list-unstyled'>";
          foreach($quizs as $quiz){
            echo "<li class='display-6'>$quiz</li>";
          }
          echo "</ul>";

          echo "<h4>Sum: " . sumOfNum($quizs) . "</h4>";
          echo "<h4>Average: " . number_format(averageOfNum(sumOfNum($quizs), count($quizs)), 4) . "</h4>";
        echo "</div>";
      }

      function sumOfPrice($prices){
        $sum = 0;
        foreach($prices as $price){
          $sum += $price;
        }
        return $sum;
      }

      function averageOfNum($sum, $num){
        return $sum/$num_quiz;
      }

      fun
    ?>
  </body>
</html>
