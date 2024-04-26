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
    div#posting {
        width: 80%;
        position: absolute;
        top: 10%;
    }
</style>

<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <!-- 로고로 바꾸기 -->
        <div class="navbar-brand ms-5 ps-5">
            <img src="../assets/img/logo.png" width="96px" alt="로고"/>
        </div>
        <div class="d-flex flex-column-reverse align-items-lg-center">
            <div class="collapse navbar-collapse mt-lg-0" id="navbarSupportedContent">
                <%@ include file="../common/loginnav.jsp" %> <!-- 로그인 페이지 조각 추가 -->
            </div>
            <button
                    class="navbar-toggler"
                    type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
            >
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </div>
</nav>


<div id="posting" class="row justify-content-center">
    <div class="col-lg-8 col-md-10 col-sm-12">
        <h2 class="my-3 py-3 shadow-sm bg-light text-center">
            <mark class="sky">글보기</mark>
        </h2>
    </div>
    <div class="col-lg-8 col-md-10 col-sm-12" style="background-color: #ffffff;">
        <div class="row my-2">
            <h2 class="text-secondary px-5">${post.postId}. ${post.title}</h2>
        </div>
        <div class="row">
            <div class="col-md-8">
                <div class="clearfix align-content-center">
                    <img
                            class="avatar me-2 float-md-start bg-light p-2"
                            src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg"
                    />
                    <p>
                        <span class="fw-bold">${post.userId}</span> <br/>
                        <span class="text-secondary fw-light"> ${post.createdAt} 조회 : ${post.hit} </span>
                    </p>
                </div>
            </div>
            <div class="col-md-4 align-self-center text-end"></div>
            <div class="divider mb-3"></div>
            <div class="text-secondary">
                ${post.content}
            </div>
            <%--            <c:if test="${!empty post.fileInfos}">--%>
            <%--                <div class="mt-3">--%>
            <%--                    <ul>--%>
            <%--                        <c:forEach var="file" items="${post.fileInfos}">--%>
            <%--                        <li>${file.originalFile} <a href="#" class="filedown" sfolder="${file.saveFolder}"--%>
            <%--                                                    sfile="${file.saveFile}" ofile="${file.originalFile}">[다운로드]</a>--%>
            <%--                            </c:forEach>--%>
            <%--                    </ul>--%>
            <%--                </div>--%>
            <%--            </c:if>--%>
            <div class="divider mt-3 mb-3"></div>
            <div class="d-flex justify-content-end">
                <a href="/posting/list" class="btn btn-outline-primary mb-3">
                    글목록
                </a>
                <c:if test="${sessionScope.memberDto.userId eq post.userId}">
                    <button type="button" id="btn-mv-modify" class="btn btn-outline-success mb-3 ms-1">
                        글수정
                    </button>
                    <button type="button" id="btn-delete" class="btn btn-outline-danger mb-3 ms-1">
                        글삭제
                    </button>
                    <%--                    <form id="form-no-param" method="get" action="${root}/board">--%>
                    <%--                        <input type="hidden" id="npgno" name="pgno" value="${pgno}">--%>
                    <%--                        <input type="hidden" id="nkey" name="key" value="${key}">--%>
                    <%--                        <input type="hidden" id="nword" name="word" value="${word}">--%>
                    <%--                        <input type="hidden" id="articleno" name="articleno" value="${post.articleNo}">--%>
                    <%--                    </form>--%>
                    <script>
                        document.querySelector("#btn-mv-modify").addEventListener("click", function () {
                            let form = document.querySelector("#form-no-param");
                            form.setAttribute("action", "${root}/article/modify");
                            form.submit();
                        });

                        document.querySelector("#btn-delete").addEventListener("click", function () {
                            if (confirm("정말 삭제하시겠습니까?")) {
                                let form = document.querySelector("#form-no-param");
                                form.setAttribute("action", "${root}/article/delete");
                                form.submit();
                            }
                        });
                    </script>
                </c:if>
            </div>
        </div>
    </div>
</div>

</body>
</html>