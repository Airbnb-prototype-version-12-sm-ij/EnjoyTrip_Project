<%@ page contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"
         import="com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity"
         import="java.util.*"
%>
<!-- controller 도메인 : /trip -->
<%
    String root = request.getContextPath();
    List<AttractionEntity> attractionList = (List<AttractionEntity>)request.getAttribute("arrlist");
%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>백엔드 관통</title>
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

        .container {
            /* .container 추가 : 주요 UI(검색 등) 배경에 흰색 네모 박스 추가 */
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            border-radius: 4px;
        }

        .scrollable {
            max-height: 600px;
            overflow-y: auto;
        }

        .custom-btn {
            text-decoration: none; /* 밑줄 제거 */
            color: #999; /* 텍스트 색상 설정 */
        }

        /* 추가 : 네비게이션 바 배경색 변경 */
        .navbar {
            background-color: #05b7ee62;
        }

        .navbar-nav > li {
            padding-left: 15px;
        }

        .btn-primary {
            /* .btn-primary 추가 : 기본 버튼의 색을 변경 */
            background-color: #f79e3e;
            border-color: #f79e3e;
            color: black;
        }

        .btn-primary:hover {
            /* .btn-primary:hover 추가 : 기본 버튼에 마우스를 올렸을 때 변하는 색을 위에서 변경한 색에 맞게 변경 */
            background-color: #ffbf7a;
            border-color: #ffbf7a;
            color: black;
        }

        .row {
            margin-top: 20px; /* 검색 바 아래 여백을 줍니다. */
        }

        .navbar {
            /* .navbar 추가 : UI 위치가 박살나서 추가, 챗GPT가 썼음 */
            position: absolute; /* navbar를 위치 고정으로 설정합니다. */
            top: 0; /* 화면 맨 위에 위치하도록 합니다. */
            left: 0; /* 화면 맨 왼쪽에 위치하도록 합니다. */
            right: 0; /* 화면 맨 오른쪽까지 넓이를 설정합니다. */
        }

        /* .modal-header 추가 : modal-header 색 조정 */
        .modal-header {
            background-color: #05b7ee62;
            color: #ffffff;
        }

        .navbar-toggler {
            width: 60px; /* 원하는 너비로 설정 */
            height: 48px; /* 원하는 높이로 설정 */
        }

        footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: rgba(255, 255, 255, 0.8); /* 풋터 배경색 설정 */
            padding: 10px 0; /* 풋터 안의 내용 여백 설정 */
            text-align: center; /* 풋터 내용 가운데 정렬 */
        }

        #map-modalfooter {
            max-height: calc(40vh - 300px); /* 모달 창 높이에서 헤더와 푸터 높이를 제외한 값 */
            overflow-y: auto;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
    />
    <script
            type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9c4977a5d4ddc19f25aa9b22c1e264a&libraries=services"
    ></script>

    <%
        if (request.getAttribute("err") != null) {
    %>
    <script type="text/javascript">
        alert("<%=request.getAttribute("err")%>");
    </script>
    <%
        }
    %>
</head>
<body>
<!-- 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <!-- 로고로 바꾸기 -->
        <div class="navbar-brand ms-5 ps-5">
            <img src="../assets/img/logo.png" width="96px" alt="로고"/>
        </div>
        <div class="d-flex flex-column-reverse align-items-lg-center">
            <div class="collapse navbar-collapse mt-lg-0" id="navbarSupportedContent">
                <%@ include file="loginnav.jsp" %> <!-- 로그인 페이지 조각 추가 -->
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
<!-- 로그인 모달 -->
<div
        class="modal fade"
        id="loginModal"
        tabindex="-1"
        aria-labelledby="loginModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">로그인</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <form id="loginForm" method="POST">
                    <input type="hidden" name="action" value="login"/>
                    <div class="mb-3">
                        <label for="loginUserId" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="loginUserId" name="loginUserId" required/>
                    </div>
                    <div class="mb-3">
                        <label for="loginPassword" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="loginPassword" name="loginPassword" required/>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="loginBtn">로그인</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            취소
                        </button>
                        <button id="showFindPwdModalBtn" type="button" class="btn btn-link custom-btn">
                            비밀번호 찾기
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 비밀번호 찾기 모달 -->
<div
        class="modal fade"
        id="findPwdModal"
        tabindex="-1"
        aria-labelledby="findPwdModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="findPwdModalLabel">비밀 번호 찾기</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <form id="findPwdForm">
                    <div class="mb-3">
                        <label for="findPwdUserId" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="findPwdUserId" required/>
                    </div>
                    <div class="mb-3">
                        <label for="findPwdUserName" class="form-label">이름</label>
                        <input type="text" class="form-control" id="findPwdUserName" required/>
                    </div>
                    <div class="modal-footer">
                        <button id="findpwd" type="button" class="btn btn-primary">비밀번호 찾기</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            취소
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 마이 페이지 모달 -->
<div
        class="modal fade"
        id="MyPageModal"
        tabindex="-1"
        aria-labelledby="MyPageModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="MyPageModalLabel">마이 페이지</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <form id="MyPageForm">
                    <!-- my page form이 들어가는 자리 -->

                    <% // 세션 로그인 객체에서 정보를 가져온다
                        String thisName, thisId, thisPassword;
                        if (loginMember != null) {
                            thisName = loginMember.getUserName();
                            thisId = loginMember.getUserId();
                            thisPassword = loginMember.getUserPassword();
                        } else {
                            thisName = "알 수 없음";
                            thisId = "알 수 없음";
                            thisPassword = "알 수 없음";
                        }
                    %>
                    <div class="mb-3">이름: <%=thisName %>
                    </div>
                    <div class="mb-3">아이디: <%=thisId %>
                    </div>
                    <div class="mb-3">비밀번호: <%=thisPassword %>
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">새 비밀번호</label>
                        <input
                                type="password"
                                class="form-control"
                                id="newPassword"
                                required
                        />
                        <div id="newPasswordError" class="invalid-feedback">
                            숫자와 영어 소문자로 5자리 이상 20자리 이하여야 합니다.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmNewPassword" class="form-label">새 비밀번호 확인</label>
                        <input type="password" class="form-control" id="confirmNewPassword" required/>
                        <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="showNewPasswordCheckbox"/>
                        <label class="form-check-label" for="showNewPasswordCheckbox">비밀번호 보이기</label>
                    </div>
                    <button id="password-chg-btn" class="btn btn-outline-warning">비밀번호 변경</button>
                    <div class="modal-footer">
                        <button id="Membership-Withdrawal-btn" class="btn btn-outline-danger">탈퇴</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            취소
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 지도 모달  -->
<div
        class="modal fade"
        id="mapModal"
        tabindex="-1"
        aria-labelledby="mapModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="mapModalLabel">지도</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <div id="map-container" style="height: 450px">
                    <div id="map" style="height: 400px"></div>
                    <div id="map-modalfooter" class="pt-2"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 회원 가입 모달 -->
<div
        class="modal fade"
        id="signupModal"
        tabindex="-1"
        aria-labelledby="signupModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="signupModalLabel">회원 가입</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <form id="signupForm" method="POST" action="">
                    <input type="hidden" name="action" value="regist"/>
                    <div class="mb-3">
                        <label for="userId" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="userId" name="userId" required/>
                        <div class="invalid-feedback">
                            숫자와 영어 소문자로 5자리 이상 20자리 이하여야 합니다.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">비밀번호</label>
                        <input
                                type="password"
                                class="form-control"
                                id="password"
                                name="password"
                                required
                        />
                        <div id="passwordError" class="invalid-feedback">
                            숫자와 영어 소문자로 5자리 이상 20자리 이하여야 합니다.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">비밀번호 확인</label>
                        <input type="password" class="form-control" id="confirmPassword" required/>
                        <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="showPasswordCheckbox"/>
                        <label class="form-check-label" for="showPasswordCheckbox">비밀번호 보이기</label>
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" class="form-control" id="name" name="name" required/>
                        <div class="invalid-feedback">한글만 입력 가능합니다.</div>
                    </div>
                    <div class="modal-footer">
                        <button id="registBtn" type="submit" class="btn btn-primary">회원 가입</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            취소
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- 회원 조회 모달 -->
<div
        class="modal fade"
        id="MMModal"
        tabindex="-1"
        aria-labelledby="Member-management-ModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <!-- modal-lg 클래스를 추가하여 큰 모달로 지정 -->
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="Member-management-ModalLabel">회원 관리</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body" style="max-height: 60vh; overflow-y: auto">
                <!-- 스크롤 추가를 위해 스타일 추가 -->
                <div class="row">
                    <div class="col-3">이름</div>
                    <div class="col-3">아이디</div>
                    <div class="col-3">비밀번호</div>
                    <div class="col-3">정보 수정</div>
                </div>
                <div id="memberList">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 메인 화면 -->
<div class="container mb-1">
    <!-- 타이틀 -->
    <h1>어디로 갈까?</h1>
    <p>원하는 관광지 검색</p>
    <!-- 검색바 -->
    <div class="container mt-3">
        <!-- 관광지 검색 start -->
        <form class="d-flex mt-3" role="search">
            <select id="search-sido" class="form-select" aria-label="Default select example">
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
            <select id="search-content-id" class="form-select" aria-label="Default select example">
                <option value="0" selected>관광지 유형</option>
                <option value="12">관광지</option>
                <option value="14">문화시설</option>
                <option value="15">축제공연행사</option>
                <option value="25">여행코스</option>
                <option value="28">레포츠</option>
                <option value="32">숙박</option>
                <option value="38">쇼핑</option>
                <option value="39">음식점</option>
            </select>
            <input
                    id="search-keyword"
                    class="form-control me-2"
                    type="search"
                    placeholder="검색어"
                    aria-label="검색어"
            />
            <button id="btn-search" class="btn btn-primary" type="button">
                <i class="fas fa-search"></i>
            </button>
        </form>
        <div class="row">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>대표이미지</th>
                    <th>관광지명</th>
                    <th>주소</th>
                    <th>위치</th>
                </tr>
                </thead>
                <tbody id="trip-list" style="max-height: 10vh; overflow-y: auto">
                <%--<%
                <%
                    if (attractionList != null) {
                        for (AttractionEntity attraction : attractionList) {
                %>
                <tr>
                    <%
                        if (attraction.getFirstImage().isEmpty()) {
                    %>
                    <td><img src="<%=root %>/src/main/webapp/assets/img/no_img.png" width="100px" alt=""></td>
                    <%
                    } else {
                    %>
                    <td><img src="<%=attraction.getFirstImage()%>" width="100px" alt=""></td>
                    <%
                        }
                    %>
                    <td><%=attraction.getTitle() %>
                    </td>
                    <td><%=attraction.getAddr1() %> <%=attraction.getAddr2() %>
                    </td>
                    <td width="120px">
                        <button class="btn btn-primary map-button"
                                data-title="<%=attraction.getTitle() %>"
                                data-addr="<%=attraction.getAddr1() %> <%=attraction.getAddr2() %>"
                                data-overview="<%=attraction.getOrverview() %>"
                                data-latitude="<%=attraction.getLatitude() %>"
                                data-longitude="<%=attraction.getLongitude() %>">정보 보기
                        </button>
                    </td>
                </tr>
                }
                    }
                %>--%>
                </tbody>
            </table>
        </div>
        <!-- 관광지 검색 end -->
    </div>
    <!-- 게시판 뉴스 공지사항 -->
    <div class="row">
        <div class="col">
            <!-- 게시판 테이블 -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>게시판</th>
                </tr>
                </thead>
                <tbody>
                <!-- 게시물들 -->
                <tr>
                    <th>게시물제목 + 작성자</th>
                </tr>
                <tr>
                    <th>게시물내용</th>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="col">
            <!-- 뉴스 테이블 -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>뉴스</th>
                </tr>
                </thead>
                <tbody>
                <!-- 뉴스 기사들 -->
                <tr>
                    <th>뉴스기사 제목 + 작성자</th>
                </tr>
                <tr>
                    <th>뉴스기사 내용</th>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="col">
            <!-- 공지사항 테이블 -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>공지사항</th>
                </tr>
                </thead>
                <tbody>
                <!-- 공지사항 내용들 -->
                <tr>
                    <th>공지사항내용</th>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<footer>@광주_5반 황성민 선장과 일등항해사 이인준</footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="../assets/js/mypage.js"></script>
<script src="../assets/js/membermanagement.js"></script>
<script src="../assets/js/findpwd.js"></script>
<%--<script src="../assets/js/api.js"></script>--%>
<script src="../assets/js/login.js"></script>
<script src="../assets/js/signup.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>


    // === 로그인, 로그아웃 관련 기능 ===
    // [1] 로그인 버튼 클릭시, controller 이용해 로그인 시행
    // 기존 코드
    if (document.querySelector("#loginBtn") != null) {
        document.querySelector("#loginBtn").addEventListener("click", function (e) {
            e.preventDefault();
            let form = document.getElementById("loginForm"); // form 정보를 받아온다
            const username = document.getElementById("loginUserId").value;
            const password = document.getElementById("loginPassword").value;
            fetch("<%=root %>/trip?action=login", {
                method: "POST",
                body: JSON.stringify({
                    loginUserId: username,
                    loginPassword: password
                })
            }).then((response) => {
                console.log(response.ok);
                if (response.ok) {
                    alert('로그인에 성공했습니다.');
                    $("#loginModal").modal("hide");
                    location.reload();
                } else { // 에러가 발생한 경우
                    alert('아이디나 비밀번호를 확인해주세요.');
                }
            });
            // 로그인하고 모달을 꺼야하는데 메인으로 그냥 보내면 되겠지?
        });
    }
    // [2] 로그아웃 버튼 클릭시, controller 이용해 로그아웃 시행
    if (document.querySelector("#logoutBtn") != null) {
        document.querySelector("#logoutBtn").addEventListener("click", function () {
            location.href = "<%=root %>/trip?action=logout";
        });
    }
    // [3] 로그인 이후, 성공여부 표기
    <% 
    String msg = (String)request.getSession().getAttribute("loginFail");
    if(msg != null) {%>
    alert("<%=msg%>");
    <%	request.getSession().removeAttribute("loginFail");
  }%>
    // === 회원가입 기능 ===
    if (document.querySelector("#registBtn") != null) {
        document.querySelector("#registBtn").addEventListener("click", function (e) {
            e.preventDefault();
            let root = "<%=root%>";
            regist(root); // signup.js에 함수화하였음
        });
    }
    // 회원가입 이후, 성공여부 표기
    <% if(request.getAttribute("registSuccess") != null){
    	
        if(request.getAttribute("registSuccess").equals("yes")){
      %>
    alert("가입에 성공했습니다. 로그인해주세요.");
    <%} else {%>
    alert("가입에 실패했습니다. 다시 시도해주세요.");
    <% }
    }%>

    // == 지도 모달 ==
    /* // 클릭 이벤트를 감지하여 모달을 열도록 처리
     document.querySelectorAll(".map-button").forEach(function (button) {
         button.addEventListener("click", function () {
             let title = button.getAttribute("data-title");
             let addr = button.getAttribute("data-addr");
             let overview = button.getAttribute("data-overview")
             let latitude = parseFloat(button.getAttribute("data-latitude"));
             let longitude = parseFloat(button.getAttribute("data-longitude"));

             // 해당 위치로 지도 이동
             let moveLatLon = new kakao.maps.LatLng(latitude, longitude);
             map.panTo(moveLatLon); // 지도를 해당 위치로 이동

             // 기존 마커 제거
             if (marker) marker.setMap(null);

             // 새로운 마커 생성
             let marker = new kakao.maps.Marker({
                 position: moveLatLon,
                 map: map,
             });

             // 모달의 footer에 정보 추가
             document.getElementById("map-modalfooter").innerHTML =
                 "<strong>관광지 이름:</strong>" + title + "<br>" + "<strong>주소:</strong>" + addr + "<br>" + "<strong>설명:</strong>" + overview;

             $("#mapModal").modal("show"); // 모달 표시

             // 모달이 열릴 때 resize 이벤트가 발생하도록 함수를 호출하는 코드 추가
             $("#mapModal").on("shown.bs.modal", function () {
                 resizeMap();
             });

             function resizeMap() {
                 var mapContainer = document.getElementById("map");
                 mapContainer.style.width = "100%";
                 mapContainer.style.height = "400px";
                 // 모달이 열릴 때 지도의 크기가 모달에 맞게 조정되도록 map.relayout() 함수 호출
                 map.relayout();
                 map.setCenter(moveLatLon);
             }

             function relayout() {
                 // 모달이 열릴 때도 relayout 함수 호출
                 resizeMap();
                 // 기존의 relayout 함수 내용 추가
                 map.relayout();
             }

             // 모달이 닫힐 때 resize 이벤트가 발생하도록 함수를 호출하는 코드 추가
             $("#mapModal").on("hidden.bs.modal", function () {
                 resizeMap();
             });
         });
     });

     //--------------------------------------------------------
     // 카카오 map key c9c4977a5d4ddc19f25aa9b22c1e264a
     var container = document.getElementById("map"); //지도를 담을 영역의 DOM 레퍼런스

     resizeMap(container);
     var options = {
         //지도를 생성할 때 필요한 기본 옵션
         center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표. 위도(latitude), 경도(longitude) 순
         level: 3, //지도의 레벨(확대, 축소 정도)
     };

     var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

     function resizeMap() {
         var mapContainer = document.getElementById("map");
         mapContainer.style.width = "100%";
         mapContainer.style.height = "400px";
     }

     function relayout() {
         // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
         // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다
         // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
         map.relayout();
     }
 */
    // == 비밀번호 찾기 모달 기능 ==
    document.getElementById("findpwd").addEventListener("click", function (e) {
        e.preventDefault();
        var userId = document.getElementById("findPwdUserId").value;
        var name = document.getElementById("findPwdUserName").value;

        // DB에서 userId를 기반으로 유저를 검색한다.
        fetch("<%=root %>/trip?action=findPwd", {
            method: "POST",
            body: JSON.stringify({
                findUserId: userId,
                findUserName: name
            })
        }).then((response) => response.json())
            .then((data) => {
                console.log(data.success);
                if (data.success) {
                    alert("비밀번호는 " + data.password + "입니다.");
                } else {
                    alert("일치하는 정보가 없습니다.");
                }
            });
    });

    // == 회원관리 모달 기능 ==
    // 모달을 열 때마다 실행될 함수
    if (document.getElementById("showMMModalBtn") != null) {
        document.getElementById("showMMModalBtn").addEventListener("click", function (e) {
            // 아주 만약에 admin이 아닌데 접근하려고 하면 막아야 함.
            <% if(loginMember != null && loginMember.getGrade().equals("default")){ %>
            alert("관리자만 접근할 수 있는 페이지 입니다.");
            return;
            <% }%>
            e.preventDefault();
            let root = "<%=root%>";
            adminlist(root); // membermanagement.js에 함수화하였음
        });
    }

    // ==== 검색 ====
    document.getElementById("btn-search").addEventListener("click", () => {
        let sidoCode = document.getElementById("search-sido").value;
        let contentTypeId = document.getElementById("search-content-id").value;
        let keyword = document.getElementById("search-keyword").value;

        console.log(sidoCode, contentTypeId, keyword);

        // AJAX 요청 보내기
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "<%=root%>/attractions/search?sidoCode=" + sidoCode + "&typeCode=" + contentTypeId + "&title=" + keyword, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // 서버에서 데이터를 받았을 때의 처리
                const attractionList = JSON.parse(xhr.responseText);
                // 받은 데이터를 활용하여 테이블 업데이트
                console.log(attractionList);
                updateTable(attractionList);

            }
        };
        xhr.send();
    });

    function updateTable(attractionList) {
        const tableBody = document.getElementById('trip-list');
        tableBody.innerHTML = ''; // 기존의 내용을 비워줌
        attractionList.forEach(attraction => {
            const row = document.createElement('tr');
            const imgCell = document.createElement('td');
            const titleCell = document.createElement('td');
            const addrCell = document.createElement('td');
            const locationCell = document.createElement('td');
            const img = document.createElement('img');
            img.src = attraction.firstImage || '<%=root %>/src/main/webapp/assets/img/no_img.png';
            img.style = "width: 100px";
            img.alt = '';
            imgCell.appendChild(img);

            titleCell.textContent = attraction.title;

            addrCell.textContent = `${attraction.addr1} ${attraction.addr2}`;

            const button = document.createElement('button');
            button.className = 'btn btn-primary map-button';
            button.dataset.title = attraction.title;
            button.dataset.addr = `${attraction.addr1} ${attraction.addr2}`;
            button.dataset.overview = attraction.overview || '';
            button.dataset.latitude = attraction.latitude;
            button.dataset.longitude = attraction.longitude;
            button.textContent = '정보 보기';
            locationCell.appendChild(button);

            row.appendChild(imgCell);
            row.appendChild(titleCell);
            row.appendChild(addrCell);
            row.appendChild(locationCell);

            tableBody.appendChild(row);
        });
    }


    // == 마이페이지 비밀번호 바꾸기 기능 ==
    // 현재 새 비밀번호-새 비밀번호 확인 정책 검사가 제대로 되지 않는 문제가 있음...
    // 일단은 새 비밀번호 창의 값을 기반으로 비밀번호를 바꾸도록 하자.
    document.getElementById("password-chg-btn").addEventListener("click", function (e) {
        e.preventDefault();
        let root = "<%=root%>";
        changePassword(root); // mypage.js에 함수화하였음
    });

    document.getElementById("newPassword").addEventListener("input", function () {
        const newPassword = this.value;
        validateNewPassword(newPassword);
    });

    function validateNewPassword(newPassword) {
        const newpasswordInput = document.getElementById("newPassword");
        let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$/;
        if (!regex.test(newPassword)) {
            newpasswordInput.classList.add("is-invalid");
            return false;
        } else {
            newpasswordInput.classList.remove("is-invalid");
            return true;
        }
    }

    document.getElementById("confirmNewPassword").addEventListener("input", function () {
        const confirmNewPassword = this.value;
        const newpassword = document.getElementById("newPassword").value;
        validateNewPasswordConfirmation(newpassword, confirmNewPassword);
    });

    function validateNewPasswordConfirmation(newpassword, confirmNewPassword) {
        const confirmNewPasswordInput = document.getElementById("confirmNewPassword");
        if (newpassword !== confirmNewPassword) {
            confirmNewPasswordInput.classList.add("is-invalid");
            return false;
        } else {
            confirmNewPasswordInput.classList.remove("is-invalid");
            return true;
        }
    }

    // == 마이페이지 탈퇴 기능 ==
    document.getElementById("Membership-Withdrawal-btn").addEventListener("click", function (e) {
        e.preventDefault();
        let root = "<%=root%>";
        let loginId = "<%=thisId%>";
        withdrawal(root, loginId); // mypage.js에 함수화하였음
    })

</script>
</body>
</html>
