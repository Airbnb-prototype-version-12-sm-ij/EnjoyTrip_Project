<%@ page contentType="text/html; charset=utf-8" import="com.ssafy.enjoytrip.domain.member.entity.MemberEntity" %>
<%
    MemberEntity loginMember = (MemberEntity)request.getSession().getAttribute("memberDto");
%>


<!-- 네비게이션 바 -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container-fluid">
        <!-- 로고로 바꾸기 -->
        <div class="navbar-brand ms-5 ps-5">
            <a href="http://localhost">
                <img src="../../assets/img/logo.png" width="96px" alt="로고"/>
            </a>
        </div>
        <div class="d-flex flex-column-reverse align-items-lg-center">
            <div class="collapse navbar-collapse mt-lg-0" id="navbarSupportedContent">
                <ul class="navbar-nav me-lg-5 d-flexb">
                    <%
                        if (loginMember == null) {
                    %>
                    <li class="nav-item p-1">
                        <button
                                id="showLoginModalBtn"
                                class="btn btn-primary"
                                type="button"
                                data-bs-toggle="modal"
                                data-bs-target="#loginModal"
                        >
                            Login
                        </button>
                    </li>
                    <li class="nav-item p-1">
                        <button
                                id="showSignupModalBtn"
                                class="btn btn-primary"
                                type="button"
                                data-bs-toggle="modal"
                                data-bs-target="#signupModal"
                        >
                            Join
                        </button>
                    </li>
                    <%} else {%>
                    <li class="nav-item d-flex align-items-center pe-lg-3">
                        <div id="user-name"><%=loginMember.getUserName()%> &#x1F60A;</div>
                    </li>
                    <li class="nav-item p-1">
                        <button id="logoutBtn" class="btn btn-primary">Logout</button>
                    </li>
                    <%if (loginMember.getGrade().equals("admin")) { %>
                    <li class="nav-item p-1">
                        <button
                                id="showMMModalBtn"
                                class="btn btn-primary"
                                type="button"
                                data-bs-toggle="modal"
                                data-bs-target="#MMModal"
                        >
                            Manage Member
                        </button>
                    </li>
                    <%} %>
                    <li class="nav-item p-1">
                        <button
                                id="showMyPageModalBtn"
                                class="btn btn-primary"
                                type="button"
                                data-bs-toggle="modal"
                                data-bs-target="#MyPageModal"
                        >
                            My Page
                        </button>
                    </li>
                    <%} %>
                </ul>
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


