<?php include "adress.html"; ?>
<?php
file_put_contents('data/'.$_POST['date'], $_POST['time'],$_POST['nx'], $_POST['ny']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>기상청 날씨 API 연습</title>

</head>
<body>
    <h1>기상청 날씨</h1>
    <h2>지역 날씨</h2>
    <? echo "날짜: $_POST['date']"; ?><? echo "시간:  $_POST['time']"; ?><? echo "x좌표: $_POST['nx']"; ?><? echo "y좌표:  $_POST['ny']"; ?>
    <p class="result">
        <!--20230402, 1400, -7입니다.--> 
    </p>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
    <script>
        
        $.getJSON('https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=k2FhBBQxor2i%2B9pBvFADgh%2B6ld8CDQul1g46DdYsfyg40rzqKGlBNpHWPcgV88Nj0FFBbu2iFfC24Q3cNzUCXg%3D%3D&pageNo=1&numOfRows=1000&dataType=JSOn&base_date={$date}&base_time={$time}&nx=${nx}&ny={ny}',function(data){
            console.log(data);
            console.log(data.response.body.items.item[3].obsrValue); //item배열의 3번째에 있는 온도를 출력 
            let item = data.response.body.items.item[3];
            let content= item.baseDate +"일 "+ item.baseTime+" 기준 온도는"+ item.obsrValue+"입니다"; //item배열의 3번째 값에 있는 날짜, 시간, 온도를 변수명 content로 선언
            $(".result").text(content); 
        });
    </script>
</body>
</html>