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
        <div id="viewBody">
            <div class="row">
                <div class="col-md-8">
                    <div class="clearfix align-content-center">
                        <img
                                class="avatar me-2 float-md-start bg-light p-2"
                                src="https://raw.githubusercontent.com/twbs/icons/main/icons/person-fill.svg"
                        />
                        <p>
                            <span class="fw-bold">${post.userId}</span> <br/>
                            <span>${sidoName} </span>
                            <span>${gugunName} </span>
                            <span class="text-secondary fw-light"> ${post.createdAt} 조회 : ${post.hit} </span>
                        </p>
                    </div>
                </div>
                <div class="col-md-4 align-self-center text-end"></div>
                <div class="divider mb-3"></div>
                <div class="text-secondary">

                    <div id="postImg">
                        <img src="../upload_img/${fileInfos[0].saveFolder}/${fileInfos[0].saveFile}"
                             alt="${fileInfo[0].originalFile}">
                    </div>


                    <text>
                        <br>
                        ${post.content}
                    </text>
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

                            var postId = "${post.postId}";


                            // ===============================삭제 버튼=============================
                            document.getElementById('btn-delete').addEventListener('click', function () {
                                console.log('/posting/delete/' + postId);
                                fetch('/posting/delete/' + postId, {
                                    method: 'POST',
                                })
                                    .then(response => {
                                        if (!response.ok) {
                                            throw new Error('Network response was not ok');
                                        }
                                        // 요청이 성공하면 페이지를 새로고침하거나 다른 동작을 수행합니다.
                                        location.href = "/posting/list";
                                    })
                                    .catch(error => console.error('Error:', error));
                            });


                            // ===============================수정 버튼=============================
                            document.getElementById('btn-mv-modify').addEventListener('click', function () {
                                location.href = '/posting/modify/' + postId;
                            });


                        </script>
                    </c:if>
                </div>
            </div>
        </div>
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
<script src="../../assets/js/signup.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

