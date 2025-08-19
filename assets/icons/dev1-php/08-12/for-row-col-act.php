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
  <div class="card-header bg-secondary text-white"><h6 class="m-0">for-end-act</h6></div>
  <div class="card-body mx-auto">
    <form method="post">
        <input type="number" class="form-control mb-2" name="num1" placeholder="Start Number!" required>
        <input type="number" class="form-control mb-2" name="num2" placeholder="End Number!" required>
        <input type="submit" value="Submit" class="bg-danger text-white form-control mt-2" name="submit">
    </form>
  </div>
</div>

<?php
function makeTable($row, $column){
        echo "<div class='pt-3 pb-1 px-5 bg-success'>";
        echo "<table class='table table-bordered'>";
            for($i = 1; $i <= $row ; $i++){
                echo "<tr>";
                    for($j = 1; $j <= $column; $j++){
                        echo "<td class='text-warning'>*</td>";
                    }
                echo "</tr>";
            }
        echo "</table>";
        echo "</div>";
}

function displayNum($row, $column){
    echo "<div class='card card-header bg-success text-white mx-auto my-3' style='max-width: 20rem;'>";
    echo "<div>Row: $row</div>";
    echo "<div>Column: $column</div>";
    echo "</div>";
}

?>


<?php
    if(isset($_POST['submit'])){
        $row = $_POST['num1'];
        $column = $_POST['num2'];
        
        displayNum($row, $column);    
        makeTable($row,$column);
    }
?>
</body>
</html>
