<?php
    // ---------functions----------
        // built-in function

        $first_name = "Naruto";
        $last_name = "Uzumaki";

        echo "<h2>My name is " . strtolower($first_name) . " " . strtoupper($last_name) . "</h2>";

    // user-defined function
        // create a function
        function displayMessage(){
            //block of statements/codes
            echo "<h2>Welcome to the world of PHP Function!</h2>";
            echo "<p>This is a user-defined function.</p>";
        }

        function getTotal(){
            $total = 100 + 50 + 80;
            echo "<p>Total is: $total</p>";
        }

        // call a function / Invoke a function
        displayMessage();
        displayMessage();
        displayMessage();

        getTotal();
        getTotal();

        // ----Function using argument/s-----
            // --argument are values/data passed to a function when it is called

            // --parameters(placeholder) are variables defined in a function that accept the argument passed to it

            function getFirstName($first_name, $last_name){
                echo "<p>My first name is $first_name</p>";
            }

            //pass an argument to the function
            $a = "Shiori";
            $f_name = "Haruka";
            $first_Name = "Miki";

            getFirstName("joe", $a);
            // getFirstName(25);
            // getFirstName($a);
            // getFirstName($f_name);
            // getFirstName($first_name);
        
            // --- Function using return ---

            echo "<h2>Function using Return</h2>";
                $x = 10;
                $y = 5;
                $w = 6;
                $z = 3;

            function addNumber($a,$b) {
                $sum = $a + $b;
                // echo $sum;
                // return $sum;
                return $a + $b;
            }

            function getMinus($c,$d) {
                $minus = $c - $d;
                // echo $minus;
                return $minus;
            }

            echo addNumber($x,$y);
            echo "<br>";
            echo getMinus($w,$z);

            echo "<h3>Get the quotient</h3>";
            echo addNumber($x, $y) / getMinus($w, $z);

            echo "<h3>Get the product</h3>";
            echo addNumber(6,3) * getMinus(4,2);
?>