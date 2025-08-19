<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Activity 4 - Letter Check</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="card text-dark text-center bg-light mx-auto mt-3" style="max-width: 20rem;">
  <div class="card-header bg-secondary text-white"><h6 class="m-0">if-consonant-vowel</h6></div>
  <div class="card-body mx-auto">
    <form method="post">
      <input type="text" class="form-control mb-2" name="something" placeholder="Enter one letter" required>
      <input type="submit" value="Check" class="btn btn-danger form-control mt-2" name="check">
    </form>
  </div>
</div>

<?php
function inputLetter($a){
    if (is_numeric($a)) {
        echo "<div class='card card-header bg-danger text-white text-center mx-auto mt-3' style='max-width: 20rem;'>Input one letter! not number</div>";
        return false;
    }
    if (strlen($a) !== 1) {
        echo "<div class='card card-header bg-danger text-white text-center mx-auto mt-3' style='max-width: 20rem;'>Input one letter! not a string with more than 1 character</div>";
        return false;
    }
    echo "<div class='card card-header bg-success text-white text-center mx-auto mt-3' style='max-width: 20rem;'>";
    echo "<div class='text-center mt-3'>Letter: $a</div>";
    return true;
}

function isConsonantOrVowel($a){
    $a = strtolower($a);
    if ($a=="a" || $a=="i" || $a=="u" || $a=="e" || $a=="o"){
        return "Vowel";
    } else {
        return "Consonant";
    }
}



if (isset($_POST['check'])) {
    
    $a = $_POST['something'];
    if (inputLetter($a)) {
        $ans = isConsonantOrVowel($a);
        echo "<h5>$ans</h5></div>";
    }
}
?>
</body>
</html>
