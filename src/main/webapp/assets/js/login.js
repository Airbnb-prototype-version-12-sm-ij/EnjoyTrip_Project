/*
// 페이지 로드 시 실행
window.onload = function () {
  // 초기에는 로그인과 회원 가입 버튼만 보이도록 설정
  document.getElementById("logoutBtn").style.display = "none"; // 로그아웃 버튼 숨기기
  document.getElementById("showMyPageModalBtn").style.display = "none"; // 마이페이지 버튼 숨기기
  document.getElementById("showMMModalBtn").style.display = "none"; // 회원관리 버튼 숨기기
  document.getElementById("user-name").style.display = "none";
};

// 로그인 버튼 클릭 시
document.getElementById("loginBtn").addEventListener("click", function () {
  var userId = document.getElementById("loginUserId").value;
  var password = document.getElementById("loginPassword").value;

  // 로컬 스토리지에서 저장된 아이디와 비밀번호 확인
  var savedUsers = JSON.parse(localStorage.getItem("users")); // 로컬 스토리지에서 유저 정보 가져오기
  var userFound = savedUsers.find((user) => user.userId === userId && user.password === password); // 유저 정보 확인

  if ("123" === userId && "123" === password) {
    // 관리자 로그인 성공 시
    alert("관리자 로그인 성공!");
    $("#loginModal").modal("hide");
    document.getElementById("showLoginModalBtn").style.display = "none"; // 로그인 버튼 숨기기
    document.getElementById("showSignupModalBtn").style.display = "none"; // 회원 가입 버튼 숨기기
    document.getElementById("logoutBtn").style.display = "block"; // 로그아웃 버튼 보이기
    document.getElementById("showMMModalBtn").style.display = "block"; // 회원관리 버튼 보이기
    document.getElementById("user-name").style.display = "block";
    document.getElementById("user-name").innerText = "관리자";
  } else if (userFound) {
    // 로그인 성공 시
    alert("로그인 성공!");
    $("#loginModal").modal("hide");
    document.getElementById("showLoginModalBtn").style.display = "none"; // 로그인 버튼 숨기기
    document.getElementById("showSignupModalBtn").style.display = "none"; // 회원 가입 버튼 숨기기
    document.getElementById("logoutBtn").style.display = "block"; // 로그아웃 버튼 보이기
    document.getElementById("showMyPageModalBtn").style.display = "block"; // 게시판 버튼 보이기
    document.getElementById("user-name").style.display = "block";
    document.getElementById("user-name").innerText = `${userFound.name}`;
  } else {
    // 로그인 실패 시
    alert("아이디 또는 비밀번호가 올바르지 않습니다.");
  }
});

// 로그아웃 버튼 클릭 시
document.getElementById("logoutBtn").addEventListener("click", function () {
  document.getElementById("showLoginModalBtn").style.display = "block"; // 로그인 버튼 보이기
  document.getElementById("showSignupModalBtn").style.display = "block"; // 회원 가입 버튼 보이기
  document.getElementById("logoutBtn").style.display = "none"; // 로그아웃 버튼 숨기기
  document.getElementById("showMyPageModalBtn").style.display = "none"; // 게시판 버튼 숨기기
  document.getElementById("showMMModalBtn").style.display = "none"; // 게시판 버튼 숨기기
  document.getElementById("user-name").innerText = "";
});
*/

// 모달 표시~ 닫기 이벤트는 기존의 이벤트 리스너를 그대로 사용.

// 모달 표시 이벤트
if (document.getElementById("showLoginModalBtn") != null) {
    document.getElementById("showLoginModalBtn").addEventListener("click", function () {
        let modal = new bootstrap.Modal(document.getElementById("loginModal"));
        modal.show();
    });
}

// 모달 닫기 이벤트
if (document.getElementById("loginModal") != null) {
    document.getElementById("loginModal").addEventListener("hidden.bs.modal", function () {
        let backdrop = document.querySelector(".modal-backdrop");
        if (backdrop) {
            backdrop.parentNode.removeChild(backdrop);
        }
        document.getElementById("loginForm").reset();
    });
}

