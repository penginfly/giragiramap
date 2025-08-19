<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Days of the Week Activity</title>
    <!--  CDN CSS Bootstrap -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
      crossorigin="anonymous"
    />
</head>
<body>
    <div class="container">
        <div class="card w-55 my-3 mx-auto">
            <div class="card-header text-center">
                <h6>pg-day-act</h6>
            </div>
            <div class="card-body">
                <form action="" method="post" class="w-55 text-center">
                    <button type="submit" class="btn bg-primary text-white rounded-2 border-0 px-2 py-2 mx-1 w-auto" name="day" value="Monday">Monday</button>
                    <button type="submit" class="btn bg-secondary text-white rounded-2 border-0 px-2 py-2 mx-1 w-auto" name="day" value="Tuesday">Tuesday</button>
                    <button type="submit" class="btn bg-success text-white rounded-2 border-0 px-2 py-2 mx-1 w-auto" name="day" value="Wednesday">Wednesday</button>
                    <button type="submit" class="btn bg-danger text-white rounded-2 border-0 px-2 py-2 mx-1 w-auto" name="day" value="Thursday">Thursday</button>
                    <button type="submit" class="btn bg-warning text-dark rounded-2 border-0 px-2 py-2 mx-1 w-auto" name="day" value="Friday">Friday</button>
                    <button type="submit" class="btn bg-dark text-white rounded-2 border-0 px-2 py-2 mx-1 w-auto" name="day" value="Saturday">Saturday</button>
                    <button type="submit" class="btn bg-info text-white rounded-2 border-0 px-2 py-2 mx-1 w-auto" name="day" value="Sunday">Sunday</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

<?php
if (isset($_POST['day'])) {
    $selected_day = $_POST['day'];
    echo "
        <div class='card w-50 my-3 mx-auto'>
            <div class='card-header text-center'>
                <h6 class='fw-bold'>$selected_day</h6>
            </div>
        </div>
    ";
}
?>


