<?php
    // if Statement

    $num1 = 230;
    $num2 = 300;
    $num3 = 250;

        // nested if 
        if ($num2 > $num1){
            // block of statements
            if ($num2 > $num3){
                echo "<h2>Variable num2:$num2 is the greatest number</h2>";
            }
        }

        //logical operator
            if($num1 > $num2 && $num1 > $num3){
                echo "<h2>Variable num2:$num1 is the greatest number</h2>"; 
            }
        
        // if else statement
        echo "<h2>if else statement</h2>";
            
            if($num3 > $num1){
                if($num3 > $num2){
                    echo "<h2>Variable num3:$num3 is the greatest number</h2>";
                } else {
                    echo "<h2>Variable num3:$num3 is less than variable num2:$num2</h2>";
                }
            } else {
                echo "<h2>Variable num3:$num3 is less than variable num1:$num1</h2>";
            }
        
        // if elseif else 
        
        echo "<h2>if elseif else</h2>";

        /**
         *      below 18 = teenager
         *      18 to 30 = young adult
         *      31 to 59 = middle age person
         *      60 above = senior citizen
         * 
         * 
         */

            $age = 17;

            if($age < 18){
                echo "Teenageer";
            } elseif ($age >= 18 && $age <= 30){
                echo "young adult";
            } elseif ($age >=31 && $age <= 59){
                echo "middle aged person";
            } elseif($age >= 60){
                echo "Senior Citizen";
            }
?>