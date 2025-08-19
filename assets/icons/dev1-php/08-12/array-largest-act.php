<?php
    // Index Array
        // Shortsyntax
            $nums = [1, 90, 5.9, 30, 40, 6.7, 70, 58];
    
            // loops --foreach()
            $max = $nums[0];
            foreach($nums as $item ){
                if($item > $max){
                    $max = $item;
                }
                echo "$item|";
            }
        echo "<br>";
        echo "Lagest: $max";
        
?>