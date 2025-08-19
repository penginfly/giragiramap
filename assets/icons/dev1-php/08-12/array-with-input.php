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
        <h4 class="diplay-4">Countries Visited</h4>
      </div>
      <div class="card-body">
        <form action="" method="post">
          <label for="num_country">Number of Countries Visited</label>
          <input
            type="number"
            name="num_country"
            id="num_country"
            class="form-control my-2"
          />

          <input
            type="submit"
            value="SET"
            name="submit"
            class="btn btn-danger w-100"
          />
        </form>
      </div>
    </div>

    <?php
      // 1st isset to get the number of country
      if(isset($_POST['submit'])){
        $num_country = $_POST['num_country'];
        numCountry($num_country);
      }

      // 1st function 
      function numCountry($num_country){
        echo "<div class='card bg-success text-white mx-auto mt-4 w-50'>";
          echo "<div class='card-body'>";
            echo "<form method='post'>";
              for($count_input = 0; $count_input < $num_country;
              $count_input++){
                echo "<input type'text' name='name_countries[]' class='form-control mx-auto my-1' placeholder='Name of country'>";
              }
              echo "<input type='submit' name='save' value='SAVE' class='btn btn-danger btn-sm mt-2'>";
            echo "</form>";
          echo "</div>";

        echo "</div>";
      }


      // second isset to get the name of the countries
        if(isset($_POST['save'])){
          $countries = $_POST['name_countries'];

          // print_r($countries);
          // echo "<h2>Display one country only</h2>";
          //   echo $countries[1];

          // echo "<h2>Display all country</h2>";
          //   echo "<ol>";
          //   foreach($countries as $country){
          //     echo "<li>$country</li>";
          //   }
          //   echo "</ol>";
        }

        function displayCountries ($countries){
          echo "<div class='card card-body bg-success text-white mx-auto mt-4>";
            echo "<h2>Display one country only</h2>";
            echo $countries[1];

          echo "<h2>Display all country</h2>";
            echo "<ol>";
            foreach($countries as $country){
              echo "<li>$country</li>";
            }
            echo "</ol>";
          echo "</div>";

        }
    ?>
  </body>
</html>

<?php 

?>
