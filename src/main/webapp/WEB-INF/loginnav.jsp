<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.ssafy.enjoytrip.domain.member.entity.MemberEntity" %>

<%
    MemberEntity loginMember = (MemberEntity)request.getSession().getAttribute("memberDto");
%>

<!DOCTYPE html>
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
            로그인
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
            회원 가입
        </button>
    </li>
    <%} else {%>
    <li class="nav-item d-flex align-items-center pe-lg-3">
        <div id="user-name"><%=loginMember.getUserName()%> 님</div>
    </li>
    <li class="nav-item p-1">
        <button id="logoutBtn" class="btn btn-primary">로그아웃</button>
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
            회원관리
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
            마이 페이지
        </button>
    </li>
    <%} %>
</ul>
