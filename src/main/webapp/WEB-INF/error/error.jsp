<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>스프링 부트 적용 관통</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
    />
    <style>
        /* 추가 : 원격 폰트 불러오는 리스트 */
        /* [1] 카페24슈퍼매직 */
        @font-face {
            font-family: "Cafe24Supermagic-Bold-v1.0";
            src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2307-2@1.0/Cafe24Supermagic-Bold-v1.0.woff2") format("woff2");
            font-weight: 700;
            font-style: normal;
        }

        /* [2] 국민연금체 */
        @font-face {
            font-family: "NPSfontBold";
            src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2310@1.0/NPSfontBold.woff2") format("woff2");
            font-weight: 700;
            font-style: normal;
        }

        /* [3] 마포배낭여행*/
        @font-face {
            font-family: "MapoBackpacking";
            src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/MapoBackpackingA.woff") format("woff");
            font-weight: normal;
            font-style: normal;
        }

        /* 원격 폰트 리스트 종료 */
        body {
            /* 배경 이미지 추가 및 폰트 적용 */
            background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
            url("../assets/img/background1.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            font-family: "Cafe24Supermagic-Bold-v1.0";
            /* 좌우 여백 설정 */
            /* 아래쪽으로만 늘어나는 높이 조정 */
            min-height: 100vh;
            /* 위쪽 여백 설정 */
            /* 여기에 적절한 값을 넣어줍니다. */
            padding: 10% 20px 0;
        }

        .navbar-nav > li {
            padding-left: 15px;
        }

        footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: rgba(255, 255, 255, 0.8); /* 풋터 배경색 설정 */
            padding: 10px 0; /* 풋터 안의 내용 여백 설정 */
            text-align: center; /* 풋터 내용 가운데 정렬 */
        }

        div {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            height: 50vh;
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
    />

</head>
<body>
<div>
    <h1>잘못 오셨습니다.</h1>
    <br>
    <a href="/" class="btn btn-secondary">돌아가기</a>
</div>
<footer>@광주_5반 황성민 선장과 일등항해사 이인준</footer>
</body>

</html>
