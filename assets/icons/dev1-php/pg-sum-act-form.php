<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sum Activity</title>
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
        <div class="card w-50 my-3 mx-auto">
            <div class="card-header text-center">
                <h6 class="text-center my-2">pg-sum-act</h6>
            </div>
            <div class="card-body">
                <form action="pg-sum-act.php" method="send" class="w-50 mx-auto my-3">
                    <input type="int" class="form-control mb-3" name="firstnum" id="firstnum" placeholder="First Number">
                    <input type="int" class="form-control mb-3" name="secondnum" id="secondnum" placeholder="Second Number">
                    <input type="submit" class="btn btn-primary w-100" name="send" value="COMPUTE">
                </form>
            </div>
        </div>
        
    </div>
    
</body>
</html>