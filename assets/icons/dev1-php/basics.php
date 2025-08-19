<?php
    // Single line comment
    /**
     *   multi-line comment
     * 
     *  
     */

    //Echo
    echo "Hello World!";
    echo "<br>";
    echo 'Welcome to PHP Programming!';
    echo "<h1>This is a heading 1</h1>";
    echo "John Does, ", "Jane Doe, ", "Naruto Uzumaki";
    echo "<br>";
    echo 4 + 3;
    echo "<br>";

    //Print
    Print "Hello World!";
    Print "<br>";
    Print 'Welcome to PHP Programming!';
    Print "<h1>This is a heading 1</h1>";
    // Print "John Does, ", "Jane Doe, ", "Naruto Uzumaki"; error because it's multiple argument

    // --Concatenation = join/connect together the arguments--
    echo "<h2> --Concatenation-- </h2>";
        // multiple arguments(, )
        echo "John Does, ", "Jane Doe, ", "Naruto Uzumaki";
        
        echo "<br/>";

        //single argument(.)
        echo "John Does, ". "Jane Doe, ". "Naruto Uzumaki";
        print "<h2>My name is " . "Doraemon" . "</h2>";
    
    // ---Cariables ---
    echo "<h2>---Variables---</h2>";

        // create variable
        $variable_name = "to store data";
        $first_name = "Shiori";
        $student = "male student 1";
        
        echo "<p>What is vriable? It's used $variable_name</p>";
        echo "<p>Who is $first_name?</p>";

    //---Data Types = value---
    echo "<h2>Data Types</h2>";

        $last_name = "Steve"; //string data type
        $age = -25; //int data type
        $height = 37.5; //
        $single = true;
        $married = false;
        $joe = null;

        //var-dump() function = display the value and data type of our variable/s

        //1. String = text/sequence of characters or words
            var_dump(21);
            echo "<br/>";

        //2. Integer = whole numbers(-/+)
            var_dump($age);
            echo "<br/>";

        //3. Float/Double = numbers with decimal point
            var_dump($height);
            echo "<br/>";

        //4. Boolean = true(1)/false(0)
            var_dump($single);
            var_dump($married);
            echo "<br/>";
        
        //5. Null = empty or nothing at all
            var_dump($joe);

    // ------OPERATOS------

        // ---Arithmetic Operators(+,-,*,/,%)
        echo "<h2>Arithmetic Operators</h2>";
            
            $num1 = 6;
            $num2 = 3;

            //Addition(+)
            $sum = $num1 + $num2;
            echo "<p>Sum is  $sum </p>";

            //Subtraction(-)
            $difference = $num1 - $num2;
            echo "<p>Difference is  $difference </p>";

            //Multiplication(*)
            $product = $num1 * $num2;
            echo "<p>Product is  $product </p>";

            //Division(/)
            $quotient = $num1 / $num2;
            echo "<p>Difference is  $quotient </p>";

            //module(%) = remainder
            $remainder = $num1 % $num2;
            echo "<p>Remainder is $remainder</p>";
        
        echo "<h2>Assignment Operator(=)</h2>";

            $x = 5;
            $y = 3;

            $x = $y;
            echo "<p>The new value of x is $x</p>";
            // echo $x = $x + $y;
            echo $x += $y; //short hand

        //---Increment(++) and Decrement(--)
        echo "<h2>Increment(++) and Decrement(--)</h2>";
        
            echo "<h3>Preincrement</h3>";
                $num5 = 10;
                echo $num5;
                echo ++$num3;
                echo ++$num3;

            echo "<h3>Postincrement</h3>";
                $num4 = 20;
                echo $num4;
                echo $num4++;
                echo $num4++;

            echo "<h3>Predecrement</h3>";
                $num5 = 10;
                echo $num5;
                echo --$num5;
                echo --$num5;

            echo "<h3>Postincrement</h3>";
                $num6 = 20;
                echo $num6;
                echo $num6--;
                echo $num6--;

        //---Comparison Operators---

            echo "<h2>Comparison Operator</h2>";

                $a = 8;
                $b = '8';
            
            //equal to(==)
            if($a == $b) {
                echo "<p>Variable a is equal to variable b</p>";
            }

            //identical to(===)
            if($a === $b) {
                echo "<p>Variable a is identical to cariable b</p>";
            }

            //not equal to(!=)
            if($a != $b) {
                echo "<p>Variable a is not equal to variable b</p>";
            }

        echo "<h3>Logical Operators</h3>"
            $c = 20;
            $d = 15;
            $e = 10;
            $f = 5;

            echo "<h4>AND(&&)</h4>";
            if($c > $d && $e > $f && $c < $e) {
                echo "True";
            }

            echo "<h4>OR(||)</h4>";
            if($c > $d || $e > $f || $c < $e) {
                echo "True";
            }
?>