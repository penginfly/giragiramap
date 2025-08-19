<?php

    // Associative Array

        // shortsyntax
        
        $grocery = ['fruit' => 'banana', 'vegetable' => 'cucumber', 'meat' => 'pork', 'ingredient' => 'black Pepper', 'sweet' => 'candy'];

        // language construct
            // $grocery = array('fruit' => 'banana', 'vegetable' => 'cucumber', 'meat' => 'pork', 'ingredient' => 'black Pepper', 'sweet' => 'candy');

        print_r($grocery);

        // Assign using named keys
        $age['joe'] = 45;
        $age['haruka'] = 23;
        $age['miki'] = true;
        $age['shiori'] = "Shiori hasegawa";

        // Individual Value
        echo "<h2>Individual Value</h2>";
            echo "Grocery Fruit: " . $grocery['fruit'] . "<br>";
                echo "Grocery Meat: " .$grocery['meat'];

            echo "<h2>Display Value</h2>";
                foreach($grocry as $named_key => $value){
                    echo "<h3>Named Key: $named_key</h3>";
                    echo "<p>Value: $value</p";
                }
            
        // display inside select element
        echo "<fromm method='post'>"
        echo "<select name='category'>"
                echo "<option value='' hidden> Select your category</option>";
                foreach($grocery as $vategory => $item){
                    echo "<option value='$item'>$category</option>";
                }

        echo "</select>";
        echo "<input type='submit' name='send' value='SEND'>";

    echo "</form>";

    if(isset($_POST['send'])){
        $category_item = $_POST['category'];

        echo "<h2>The category item coming form the select element is $category_item</h2>";
    }
?>