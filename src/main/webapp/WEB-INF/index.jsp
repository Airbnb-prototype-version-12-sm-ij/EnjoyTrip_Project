<%@ page
        contentType="text/html; charset=utf-8"
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
    <title>스프링 부트 적용 관통</title>


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
                <%@ include file="common/loginnav.jsp" %> <!-- 로그인 페이지 조각 추가 -->
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
                        <div id="loginUserIdError" class="invalid-feedback">
                            숫자와 영어 소문자로 3자리 이상 15자리 이하여야 합니다.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="loginPassword" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="loginPassword" name="loginPassword" required/>
                        <div id="loginPasswordError" class="invalid-feedback">
                            숫자와 영어 소문자로 3자리 이상 15자리 이하여야 합니다.
                        </div>
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
                        <input type="text" class="findPwdUserId form-control" id="findPwdUserId" required/>
                        <div id="findPwdUserIdError" class="invalid-feedback">
                            숫자와 영어 소문자로 5자리 이상 20자리 이하여야 합니다.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="findPwdUserName" class="form-label">이름</label>
                        <input type="text" class="findPwdUserName form-control" id="findPwdUserName" required/>
                        <div id="findPwdUserNameError" class="invalid-feedback">
                            한글만 입력 가능합니다.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">새 비밀번호</label>
                        <input
                                type="password"
                                class="form-control"
                                id="findPassword"
                                name="findPassword"
                                required
                        />
                        <div id="findPasswordError" class="invalid-feedback">
                            숫자와 영어 소문자로 5자리 이상 20자리 이하여야 합니다.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                        <input type="password" class="findConfirmPassword form-control" id="findConfirmPassword"
                               required/>
                        <div id="findConfirmPasswordError" class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="findShowPasswordCheckbox" id="findShowPasswordCheckbox"/>
                        <label class="form-check-label" for="showPasswordCheckbox">비밀번호 보이기</label>
                    </div>

                    <div class="modal-footer">
                        <button id="findMember" type="button" class="btn btn-primary">비밀번호 찾기</button>
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
                    <%--<div class="mb-3">비밀번호: <%=thisPassword %>
                    </div>--%>
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
                <div id="map-container" style="height: 650px">
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
                <form id="signupForm" method="POST" action="/members/join">
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
                    <div class="col-3 d-flex justify-content-center align-items-center">이름</div>
                    <div class="col-2 d-flex justify-content-center align-items-center">아이디</div>
                    <div class="col-2 d-flex justify-content-center align-items-center">등급</div>
                    <div class="col-2 d-flex justify-content-center align-items-center">가입 일시</div>
                    <div class="col-2 d-flex justify-content-center align-items-center">회원 삭제</div>
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
                    <th>
                        <a href="/posting/list" class="btn-light" id="boardButton">게시판</a>
                    </th>

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
<%--<script src="../assets/js/membermanagement.js"></script>--%>
<script src="../assets/js/findpwd.js"></script>
<%--<script src="../assets/js/api.js"></script>--%>
<script src="../assets/js/login.js"></script>
<script src="../assets/js/signup.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 인터셉터로 잡혀서 오면 아래 코드 실행

    <% if(request.getAttribute("msg") != null){ %>
    alert("<%=request.getAttribute("msg")%>");
    <% } %>


    // === 로그인, 로그아웃 관련 기능 ===
    // [1] 로그인 버튼 클릭시, controller 이용해 로그인 시행
    // 기존 코드
    if (document.querySelector("#loginBtn") != null) {
        document.querySelector("#loginBtn").addEventListener("click", function (e) {
            e.preventDefault();
            const username = document.getElementById("loginUserId").value;
            const password = document.getElementById("loginPassword").value;

            fetch("/members/login", {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    userId: username,
                    userPassword: password
                })
            }).then((response) => {
                if (response.ok) {
                    alert('로그인에 성공했습니다.');
                    $("#loginModal").modal("hide");
                    location.reload();
                } else { // 에러가 발생한 경우

                    alert('아이디나 비밀번호를 확인해주세요.');
                }
            });
        });
    }
    // [2] 로그아웃 버튼 클릭시, controller 이용해 로그아웃 시행

    if (document.querySelector("#logoutBtn") != null) {
        document.querySelector("#logoutBtn").addEventListener("click", function () {
            fetch("/members/logout", {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json'
                }
            }).then((response) => {
                if (response.ok) {
                    // 로그아웃 성공시
                    alert('로그아웃 되었습니다.');
                    location.reload();
                } else {
                    // Handle errors here
                    console.error('Logout failed');
                }
            });
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
            regist(); // signup.js에 함수화하였음
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

    // == 회원관리 모달 기능 ==
    // 모달을 열 때마다 실행될 함수
    if (document.getElementById("showMMModalBtn") != null) {
        document.getElementById("showMMModalBtn").addEventListener("click", function MberModal(e) {
            e.preventDefault();
            fetch("/members/info")
                .then(response => response.json())
                .then(data => {
                    let memberList = document.getElementById("memberList");
                    memberList.innerHTML = "";
                    data.forEach(function (user) {
                        let userNames = user.userName;
                        let userId = user.userId;
                        let grade = user.grade;
                        let registrationDate = user.registrationDate;
                        var row = document.createElement("div");
                        row.classList.add("row");
                        let div1 = document.createElement("div");
                        div1.className = "col-3 d-flex justify-content-center align-items-center";
                        div1.textContent = userNames;

                        let div2 = document.createElement("div");
                        div2.className = "col-2 d-flex justify-content-center align-items-center";
                        div2.textContent = userId;

                        let div3 = document.createElement("div");
                        div3.className = "col-2 d-flex justify-content-center align-items-center";
                        div3.textContent = grade;

                        let div4 = document.createElement("div");
                        div4.className = "col-2 d-flex justify-content-center align-items-center";
                        div4.textContent = registrationDate;

                        let button = document.createElement("button");
                        button.type = "button";
                        button.className = "btn btn-outline-danger user-delete";
                        button.dataset.userId = userId;
                        button.textContent = "X";
                        button.addEventListener('click', () => {
                            console.log(button.dataset.userId);
                            fetch("/members/delete", {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json',
                                },
                                body: JSON.stringify({
                                    userId: button.dataset.userId
                                }),
                            })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error('Network response was not ok');
                                    }
                                    MberModal(e);
                                })
                                .catch(error => {
                                    console.error('There has been a problem with your fetch operation:', error);
                                    // 여기에서 필요한 추가 작업을 수행하십시오. 예를 들어, 오류 메시지를 표시합니다.
                                });
                        });
                        let div5 = document.createElement("div");
                        div5.className = "col-2 d-flex justify-content-center align-items-center";
                        div5.appendChild(button);

                        row.appendChild(div1);
                        row.appendChild(div2);
                        row.appendChild(div3);
                        row.appendChild(div4);
                        row.appendChild(div5);
                        memberList.appendChild(row);
                    });
                });
        });
    }

    // 회원 관리 모달 닫기 이벤트
    document.getElementById("MMModal").addEventListener("hidden.bs.modal", function () {
        let backdrop = document.querySelector(".modal-backdrop");
        if (backdrop) {
            backdrop.parentNode.removeChild(backdrop);
        }
        document.getElementById("memberList").innerHTML = "";
    });

    // ==== 검색 ====
    document.getElementById("btn-search").addEventListener("click", () => {
        let sidoCode = document.getElementById("search-sido").value;
        let contentTypeId = document.getElementById("search-content-id").value;
        let keyword = document.getElementById("search-keyword").value;


        // AJAX 요청 보내기
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "<%=root%>/attractions/search?sidoCode=" + sidoCode + "&typeCode=" + contentTypeId + "&title=" + keyword, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // 서버에서 데이터를 받았을 때의 처리
                const attractionList = JSON.parse(xhr.responseText);
                // 받은 데이터를 활용하여 테이블 업데이트
                updateTable(attractionList);

            }
        };
        xhr.send();
    });

    // ====== 관광지 리스트 출력 함수 ======
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
            img.src = attraction.firstImage || 'assets/img/no_img.png';
            img.style = "width: 100px";
            img.alt = '';
            imgCell.appendChild(img);
            titleCell.textContent = attraction.title;

            addrCell.textContent = `${attraction.addr1} ${attraction.addr2}`;

            const button = document.createElement('button');
            button.className = 'btn btn-primary map-button';
            button.dataset.title = attraction.title;
            button.dataset.addr1 = attraction.addr1;
            button.dataset.addr2 = attraction.addr2;
            button.dataset.overview = attraction.overview || '';
            button.dataset.latitude = attraction.latitude;
            button.dataset.longitude = attraction.longitude;
            button.textContent = '정보 보기';
            button.addEventListener('click', function () {
                handleMapButtonClick(attraction);
            });
            locationCell.appendChild(button);

            row.appendChild(imgCell);
            row.appendChild(titleCell);
            row.appendChild(addrCell);
            row.appendChild(locationCell);

            tableBody.appendChild(row);
        });
    }


    // ====== 지도 모달 ======
    function handleMapButtonClick(attraction) {
        let title = attraction.title;
        let addr1 = attraction.addr1;
        let addr2 = attraction.addr2;
        let overview = attraction.overview;
        let latitude = parseFloat(attraction.latitude);
        let longitude = parseFloat(attraction.longitude);

        // 해당 위치로 지도 이동
        let moveLatLon = new kakao.maps.LatLng(latitude, longitude);
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
        };
        var map = new kakao.maps.Map(container, options);

        map.panTo(moveLatLon); // 지도를 해당 위치로 이동


        // 기존 마커 제거
        /*if (marker) marker.setMap(null);*/

        // 새로운 마커 생성
        let marker = new kakao.maps.Marker({
            position: moveLatLon,
            map: map,
        });

        function relayout() {
            // 모달이 열릴 때도 relayout 함수 호출
            resizeMap();
            // 기존의 relayout 함수 내용 추가
            map.relayout();
        }

        // 모달의 footer에 정보 추가
        document.getElementById("map-modalfooter").innerHTML =
            "<strong>관광지 이름:</strong>" + title + "<br>" + "<strong>주소:</strong>" + addr1 + addr2 + "<br>" + "<strong>설명:</strong>" + overview;

        $("#mapModal").modal("show"); // 모달 표시

        // 모달이 열릴 때 resize 이벤트가 발생하도록 함수를 호출하는 코드 추가
        $("#mapModal").on("shown.bs.modal", function () {
            relayout();
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


        // 모달이 닫힐 때 resize 이벤트가 발생하도록 함수를 호출하는 코드 추가
        $("#mapModal").on("hidden.bs.modal", function () {
            resizeMap();
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

    // 비밀번호 입력시 보이기
    document.getElementById("newPassword").addEventListener("input", function () {
        const newPassword = this.value;
        validateNewPassword(newPassword);
    });

    // ====== 새 비밀번호 검사 ======
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

    // ====== 새 비밀번호 확인 검사 ======
    document.getElementById("confirmNewPassword").addEventListener("input", function () {
        const confirmNewPassword = this.value;
        const newpassword = document.getElementById("newPassword").value;
        validateNewPasswordConfirmation(newpassword, confirmNewPassword);
    });

    // ====== 비밀번호 동일 검사 ======
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
        let loginId = "<%=loginMember != null ? loginMember.getUserId() : null%>";
        withdrawal(loginId); // mypage.js에 함수화하였음
    })

</script>
</body>
</html>
