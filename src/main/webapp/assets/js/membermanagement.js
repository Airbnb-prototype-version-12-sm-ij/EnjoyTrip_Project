// 회원 조회 모달 표시 이벤트
/*document.getElementById("showMMModalBtn").addEventListener("click", function () {
  let modal = new bootstrap.Modal(document.getElementById("MMModal"));
  modal.show();

  // 로컬 스토리지에서 저장된 회원 정보 가져오기
  
  
  var savedUsers = JSON.parse(localStorage.getItem("users"));
  var memberList = document.getElementById("memberList"); 

  // 회원 정보를 동적으로 생성하여 모달에 추가
  
  
  savedUsers.forEach(function (user) {
    var row = document.createElement("div");
    row.classList.add("row");
    row.innerHTML = `
      <div class="col-3 d-flex align-items-center">${user.name}</div>
      <div class="col-3 d-flex align-items-center">${user.userId}</div>
      <div class="col-3 d-flex align-items-center">${user.password}</div>
      <div class="col-3 d-flex align-items-center">
      <button type="button" class="btn btn-outline-danger user-delete" data-user-id="${user.userId}">X</button>
      </div>
    `;
    memberList.appendChild(row);
  });

  // 삭제 버튼에 이벤트 추가
  var deleteButtons = document.querySelectorAll(".user-delete");
  deleteButtons.forEach(function (button) {
    button.addEventListener("click", function () {
      var userId = button.getAttribute("data-user-id");
      deleteUser(userId);
    });
  });
});

// 사용자 삭제 함수
function deleteUser(userId) {
  var savedUsers = JSON.parse(localStorage.getItem("users"));
  var updatedUsers = savedUsers.filter(function (user) {
    return user.userId !== userId;
  });
  localStorage.setItem("users", JSON.stringify(updatedUsers));
  // 모달 다시 로드
  document.getElementById("MMModal").dispatchEvent(new Event("hidden.bs.modal"));
}*/
function adminlist(root) {
    fetch(root + "/trip?action=list", {
        method: "GET"
    }).then((response) => (response.json()))
        .then((data) => {
            console.log(data);
            // 데이터 잘 들어오는거 확인 완료
            /*
            {grade: 'default', userPwd: '1234', userName: '관리자', userId: 'admin'}
            {grade: 'admin', userPwd: '1234', userName: '이인준', userId: 'dldlswns'}
            {grade: 'admin', userPwd: '1798', userName: '주수아', userId: 'joo1798'}
            {grade: 'default', userPwd: '1234', userName: '김싸피', userId: 'ssafy'}
            */
            let memberList = document.getElementById("memberList");
            // 호출할 때마다 새로 그리도록 만듦
            memberList.innerHTML = "";
            data.forEach(function (user) {
                var row = document.createElement("div");
                row.classList.add("row");
                row.innerHTML = `
		      <div class="col-3 d-flex align-items-center">${user.userName}</div>
		      <div class="col-3 d-flex align-items-center">${user.userId}</div>
		      <div class="col-3 d-flex align-items-center">${user.userPwd}</div>
		      <div class="col-3 d-flex align-items-center">
		      <button type="button" class="btn btn-outline-danger user-delete" data-user-id="${user.userId}">X</button>
		      </div>
		    `;
                memberList.appendChild(row);
            });
            // 삭제 버튼에 이벤트 추가
            // 현재 자신이 로그인한 계정을 삭제하려고 하면 alert하도록 만들고 싶다...
            // 서블릿한테서 받아오는걸로.
            let currentId;
            fetch(root + "/trip?action=currentId", {
                method: "GET"
            }).then((response) => (response.json()))
                .then((data) => {
                    if (data.exist) { // 현재 로그인이 되어있는 경우
                        currentId = data.id;
                    } else {
                        currentId = null;
                    }
                });
            // currentId가 잘 나오는지 확인
            console.log("current id : " + currentId);
            var deleteButtons = document.querySelectorAll(".user-delete");
            deleteButtons.forEach(function (button) {
                button.addEventListener("click", function () {
                    let deleteId = button.getAttribute("data-user-id");
                    if (deleteId === currentId) {
                        alert("현재 로그인한 계정은 삭제할 수 없습니다.");
                    } else {
                        alert("계정을 삭제합니다 : " + deleteId);
                        fetch(root + "/trip?action=delete", {
                            method: "POST",
                            body: JSON.stringify({
                                userId: deleteId
                            })
                        }).then((response) => {
                            if (response.ok) {
                                // 삭제가 되었다면, 화면을 다시 갱신
                                // 재귀 호출... 괜찮겠지?
                                adminlist(root);
                            } else {
                                alert("계정 삭제에 실패했습니다.");
                            }
                        });
                    }
                });
            });
        });
}


// 모달 닫기 이벤트
document.getElementById("MMModal").addEventListener("hidden.bs.modal", function () {
    let backdrop = document.querySelector(".modal-backdrop");
    if (backdrop) {
        backdrop.parentNode.removeChild(backdrop);
    }
    document.getElementById("memberList").innerHTML = "";
});
