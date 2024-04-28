<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page
        contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"
        import="com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity"
        import="java.util.*"
%>


<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<link
        rel="stylesheet"
        href="../../assets/stylesheet/basicstyle.css"
>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
/>
<body>

<%@ include file="../common/loginnav.jsp" %> <!-- 로그인 페이지 조각 추가 -->


<div id="writeForm" class="row justify-content-center">
    <div class="col-lg-8 col-md-10 col-sm-12">
        <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="sky">글쓰기</mark>
        </h2>
    </div>
    <div class="col-lg-8 col-md-10 col-sm-12">
        <form id="form-register" method="POST" enctype="multipart/form-data" action="/posting/write">
            <input type="hidden" name="pgno" value="1">
            <input type="hidden" name="key" value="">
            <input type="hidden" name="word" value="">
            <div class="mb-3">
                <label for="search-sido" class="sido-label">시도 : </label>
                <select id="search-sido" class="form-select form-select-sm ms-1 me-2 w-50 sido-form-select"
                        name="sidoCode" aria-label="Default select example">
                    <option value="0" selected>검색 할 시, 도 선택</option>
                    <option value="1">서울</option>
                    <option value="2">인천</option>
                    <option value="3">대전</option>
                    <option value="4">대구</option>
                    <option value="5">광주</option>
                    <option value="6">부산</option>
                    <option value="7">울산</option>
                    <option value="8">세종특별자치시</option>
                    <option value="31">경기도</option>
                    <option value="32">강원도</option>
                    <option value="33">충청북도</option>
                    <option value="34">충청남도</option>
                    <option value="35">경상북도</option>
                    <option value="36">경상남도</option>
                    <option value="37">전라북도</option>
                    <option value="38">전라남도</option>
                    <option value="39">제주도</option>
                </select>
                <label for="search-gugun" class="gugun-label">구군 : </label>
                <select id="search-gugun" name="gugunCode"
                        class="form-select form-select-sm ms-1 me-2 w-50 gugun-form-select"
                        aria-label="Default select example">
                    <option value="0" selected>검색 할 구, 군 선택</option>
                </select>
                <br>

                <label for="subject" class="form-label">제목 : </label>
                <input
                        type="text"
                        class="form-control"
                        id="subject"
                        name="title"
                        placeholder="제목..."
                />
                <div id="titleError" class="alert alert-danger" style="display: none;">제목을 입력해주세요</div>
            </div>
            <div class="mb-3">
                <label for="content" class="form-label">내용 : </label>
                <textarea class="form-control" id="content" name="content" rows="7"></textarea>
                <div id="contentError" class="alert alert-danger" style="display: none;">내용을 입력해주세요</div>
            </div>
            <div class="mb-3">
                <label for="upfile" class="form-label">파일:</label>
                <input type="file" class="form-control border" id="upfile" name="upfile" multiple="multiple">
            </div>

            <div class="col-auto text-center">
                <button type="submit" id="btn-register" class="btn btn-outline-primary mb-3">
                    글작성
                </button>
                <a href="/posting/list">
                    <button type="button" id="btn-list" class="btn btn-outline-danger mb-3">
                        목록으로이동...
                    </button>
                </a>
            </div>
        </form>
    </div>
    ${errorMsg}
</div>
<footer>@광주_5반 황성민 선장과 일등항해사 이인준</footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../../assets/js/mypage.js"></script>
<script src="../../assets/js/postwrite.js"></script>
<script src="../../assets/js/findpwd.js"></script>
<%--<script src="../assets/js/api.js"></script>--%>
<script src="../../assets/js/login.js"></script>
<script src="../../assets/js/signup.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>