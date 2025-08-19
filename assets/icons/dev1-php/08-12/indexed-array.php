<?php
    // Index Array
        // Shortsyntax
            $fruits = ['banana', 'apple', 'orange', 'kiwi', 'pineapple', 'mango'];

        // Language construct;
            // $fruit = array('banana', 'apple', 'orange', 'kiwi', 'pineapple', 'mango');

        // helpful function
        print_r($fruits); //display the keys and values of an array and used for read-only information.

        echo count($fruits); // return the size(number of values) of an array.

        // Assign Using Index
        $age[0] = 24;
        $age[1] = 35;
        $age[5] = 43;
        $single[1] = true;

        // --Display an individual value
        echo "<h2> Display an individual value</h2>";
        echo $fruits[3];
        echo $fruits[4];
        echo $fruits[0];

        // --Display All
        Echo "<h2>-Displya All</h2>";
            // loops --foreach()
            $count_loop = 0;
            foreach($fruits as $item ){
                if($item != 'orange'){
                    echo "<p> $item </p>";
                    $count_loop++;
                }else {
                    echo "<h2> $item </h2>";
                }
            }

            echo "Total Loop: $count_loop";
        
?>