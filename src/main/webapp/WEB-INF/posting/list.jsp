<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page
        contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"
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


<div id="postList" class="row justify-content-center">
    <div class="col-lg-8 col-md-10 col-sm-12">
        <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="sky">글목록</mark>
        </h2>
    </div>
    <div class="col-lg-8 col-md-10 col-sm-12">
        <%--        <div class="row align-self-center mb-2">--%>
        <div class="col-md-2 text-start">
            <a href="/posting/write" id="btn-mv-register" class="btn btn-outline-primary btn-sm">
                글쓰기
            </a>
        </div>
        <div style="display: flex; align-items: center;">
            <label for="search-sido" class="sido-label">시도 : </label>
            <select id="search-sido" class="form-select form-select-sm ms-1 me-2 w-50 sido-form-select" name="sidoCode"
                    aria-label="Default select example">
                <option value="0" selected>전체</option>
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
            <div class="col-md-6.8 offset-2">
                <form class="d-flex" id="form-search" method="get" action="/posting/list">
                    <input type="hidden" name="pgno" value="1"/>
                    <select
                            name="key"
                            id="key"
                            class="form-select form-select-sm ms-5 me-1 w-50"
                            aria-label="검색조건"
                    >
                        <option value="title" selected>제목</option>
                        <option value="user_id">작성자</option>
                        <option value="sido_code">지역</option>
                    </select>
                    <div class="input-group input-group-sm">
                        <input type="text" name="word" id="word" class="form-control" placeholder="검색어..."/>
                        <button id="btn-search" class="btn btn-dark" type="submit">검색</button>
                    </div>
                </form>
                <%--            </div>--%>
            </div>
        </div>
        <div id="listBody">
            <table class="table table-hover">
                <thead>
                <tr class="text-center">
                    <th scope="col">글번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">작성자</th>
                    <th scope="col">지역</th>
                    <th scope="col">조회수</th>
                    <th scope="col">작성일</th>
                </tr>
                </thead>

                <tbody id="postListBody">
                <c:forEach var="post" items="${postList}" varStatus="idx">
                    <tr class="text-center">
                        <th scope="row">${post.postId}</th>
                        <td class="text-start">
                            <a
                                    href="/posting/${post.postId}"
                                    class="article-title link-dark"
                                    data-no="${post.postId}"
                                    style="text-decoration: none"
                            >
                                    ${post.title}
                            </a>
                        </td>
                        <td>${post.userId}</td>
                        <td>${sidos[idx.index]}</td>
                        <td>${post.hit}</td>
                        <td>${post.createdAt}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        ${navigation.navigator}
    </div>
</div>
<footer>@광주_5반 황성민 선장과 일등항해사 이인준</footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../../assets/js/mypage.js"></script>
<%--<script src="../assets/js/membermanagement.js"></script>--%>
<script src="../../assets/js/findpwd.js"></script>
<%--<script src="../assets/js/api.js"></script>--%>
<script src="../../assets/js/login.js"></script>
<script src="../../assets/js/postlist.js"></script>
<script src="../../assets/js/signup.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>