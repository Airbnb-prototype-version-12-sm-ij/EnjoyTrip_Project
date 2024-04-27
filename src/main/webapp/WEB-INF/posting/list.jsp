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
<body>


<style>
    div#postList {
        width: 80%;
        position: absolute;
        top: 10%;
    }
</style>

<%@ include file="../common/loginnav.jsp" %> <!-- 로그인 페이지 조각 추가 -->


<div id="postList" class="row justify-content-center">
    <div class="col-lg-8 col-md-10 col-sm-12">
        <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="sky">글목록</mark>
        </h2>
    </div>
    <div class="col-lg-8 col-md-10 col-sm-12">
        <div class="row align-self-center mb-2">
            <div class="col-md-2 text-start">
                <a href="/posting/write" id="btn-mv-register" class="btn btn-outline-primary btn-sm">
                    글쓰기
                </a>
            </div>
            <div class="col-md-7 offset-3">
                <form class="d-flex" id="form-search" action="">
                    <input type="hidden" name="pgno" value="1"/>
                    <select
                            name="key"
                            id="key"
                            class="form-select form-select-sm ms-5 me-1 w-50"
                            aria-label="검색조건"
                    >
                        <option selected>검색조건</option>
                        <option value="subject">제목</option>
                        <option value="userid">작성자</option>
                    </select>
                    <div class="input-group input-group-sm">
                        <input type="text" name="word" id="word" class="form-control" placeholder="검색어..."/>
                        <button id="btn-search" class="btn btn-dark" type="button">검색</button>
                    </div>
                </form>
            </div>
        </div>
        <table class="table table-hover">
            <thead>
            <tr class="text-center">
                <th scope="col">글번호</th>
                <th scope="col">제목</th>
                <th scope="col">작성자</th>
                <th scope="col">조회수</th>
                <th scope="col">작성일</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="post" items="${postList}">
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

                    <td>${post.hit}</td>

                    <td>${post.createdAt}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="row">
        ${navigation.navigator}
    </div>
</div>

</body>
</html>