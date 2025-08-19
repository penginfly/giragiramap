<?php
    // while loop
    echo "<h2>While Loop</h2>"

        // syntax
            $num = 0;
            while($num < 5){
                // loop body statement
                echo "<p>$num is less than 5</p>";

                $num++; //update statement


            }

    echo "<h2>Do While Loop</h2>";

            $num1 = 0;

            do {
                //loop body statement
                echo "<p>$sum is less than 5</p>";

                $num++;
            } while($num1 < 5);

    // for loop 
    echo "<h2>For Loop</h2>";
            
            // syntax
            /**
             * for(initial_counter; condition; update_statement){
             *      loop body statement
             * }
             */

            for($i=0; $i<5; $i++){
                echo "<p>$i is less than 5</p>";
            }

            echo "<h3>Decreent</h3>";
            for($i=5; $i>0; $i--){
                echo "<p>$i is greater than 0</p>";
            }
?>