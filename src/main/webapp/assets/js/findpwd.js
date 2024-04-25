// 비밀번호 찾기 버튼 클릭 시
/*document.getElementById("findpwd").addEventListener("click", function () {
  var userId = document.getElementById("findPwdUserId").value;
  var name = document.getElementById("findPwdUserName").value;

  // 로컬 스토리지에서 저장된 아이디와 비밀번호 확인
  var savedUsers = JSON.parse(localStorage.getItem("users")); // 로컬 스토리지에서 유저 정보 가져오기
  var userFound = savedUsers.find((user) => user.userId === userId && user.name === name); // 유저 정보 확인

  if (userFound) {
    alert(`비밀 번호는 ${userFound.password}입니다`);
    $("#findPwdModal").modal("hide");
  } else {
    alert("아이디 또는 이름이 올바르지 않습니다.");
  }
});*/

// 모달 표시 이벤트
document.getElementById("showFindPwdModalBtn").addEventListener("click", function () {
    let modal = new bootstrap.Modal(document.getElementById("findPwdModal"));
    modal.show();
});
