/*document.getElementById("showMyPageModalBtn").addEventListener("click", function () {
  let modal = new bootstrap.Modal(document.getElementById("MyPageModal"));

  // 현재 로그인한 사용자의 이름을 가져옴
  var userName = document.getElementById("user-name").innerText;

  // 로컬 스토리지에서 현재 사용자 정보를 찾음
  var savedUsers = JSON.parse(localStorage.getItem("users"));
  var currentUser = savedUsers.find((user) => user.name === userName);
  // 모달에 현재 사용자 정보를 표시
  if (currentUser) {
    document.getElementById("MyPageForm").innerHTML = `
      <div class="mb-3">이름: ${currentUser.name}</div>
      <div class="mb-3">아이디: ${currentUser.userId}</div>
      <div class="mb-3">비밀번호: ${currentUser.password}</div>
      <div class="mb-3">
        <label for="newPassword" class="form-label">새 비밀번호</label>
        <input
          type="password"
          class="form-control"
          id="newPassword"
          required
          pattern="[a-z0-9]{5,20}"
        />
        <div id="newPasswordError" class="invalid-feedback">
          숫자와 영어 소문자로 5자리 이상 20자리 이하여야 합니다.
        </div>
      </div>
      <div class="mb-3">
        <label for="confirmNewPassword" class="form-label">새 비밀번호 확인</label>
        <input type="password" class="form-control" id="confirmNewPassword" required />
        <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
      </div><div class="mb-3 form-check">
        <input type="checkbox" class="form-check-input" id="showPasswordCheckbox" />
        <label class="form-check-label" for="showPasswordCheckbox">비밀번호 보이기</label>
      </div>
      <button id="password-chg-btn" class="btn btn-outline-warning">비밀번호 변경</button>
      <div class="modal-footer">
        <button id="Membership-Withdrawal-btn" class="btn btn-outline-danger">탈퇴</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
        취소
        </button>
      </div>
    `;



    document.getElementById("password-chg-btn").addEventListener("click", () => {
      var newPassword = document.getElementById("newPassword");
      var confirmNewPassword = document.getElementById("confirmNewPassword");
      if (newPassword.value !== confirmNewPassword.value) {
        confirmNewPassword.setCustomValidity("비밀번호가 일치하지 않습니다.");
      } else {
        // 새로운 비밀번호를 로컬 스토리지에서 업데이트
        var userName = document.getElementById("user-name").innerText;
        var savedUsers = JSON.parse(localStorage.getItem("users"));
        // 현재 사용자 정보를 찾아서 비밀번호를 업데이트
        var updatedUsers = savedUsers.map((user) => {
          if (user.name === userName) {
            console.log(newPassword.value);
            return {...user, password: newPassword.value };
          } else {
            return user;
          }
        });

        // 업데이트된 사용자 정보를 다시 로컬 스토리지에 저장
        localStorage.setItem("users", JSON.stringify(updatedUsers));

        alert("비밀번호가 성공적으로 변경되었습니다.\n 바뀐 비밀번호로 다시 로그인해주세요");
        // 비밀번호 변경이 성공적으로 이루어졌음을 사용자에게 알릴 수 있는 코드 추가
      }
    });

    document.getElementById("Membership-Withdrawal-btn").addEventListener("click", function () {
      deleteUser(currentUser.userId); // newPasswordInput도 함께 전달
    });

    // 사용자 삭제 함수
    function deleteUser(userId) {
      // 확인 대화 상자를 띄우고 사용자가 "예"를 선택했을 때만 탈퇴 진행
      if (confirm("진짜 탈퇴하겠습니까?")) {
        var savedUsers = JSON.parse(localStorage.getItem("users"));
        var updatedUsers = savedUsers.filter(function (user) {
          return user.userId !== userId;
        });
        localStorage.setItem("users", JSON.stringify(updatedUsers));

        document.getElementById("showLoginModalBtn").style.display = "block"; // 로그인 버튼 보이기
        document.getElementById("showSignupModalBtn").style.display = "block"; // 회원 가입 버튼 보이기
        document.getElementById("logoutBtn").style.display = "none"; // 로그아웃 버튼 숨기기
        document.getElementById("showMyPageModalBtn").style.display = "none"; // 게시판 버튼 숨기기
        document.getElementById("showMMModalBtn").style.display = "none"; // 게시판 버튼 숨기기
        document.getElementById("user-name").innerText = "";

        $("#MyPageModal").modal("hide");
      }
    }
  }
  modal.show();
});*/

// 비밀번호 변경 기능 함수화
function changePassword(root) {
    //console.log(root);
    let newPassword = document.getElementById("newPassword").value;
    if (!validateNewPassword(newPassword)) {
        return;
    }
    // DB에서 userId를 기반으로 유저 데이터를 수정한다.
    fetch(root + "/trip?action=modify", {
        method: "POST",
        body: JSON.stringify({
            newPwd: newPassword
        })
    }).then((response) => response.json())
        .then((data) => {
            if (data.success) {
                alert("비밀번호 변경에 성공했습니다. 다시 로그인해주세요.");
                location.href = root + "/trip?action=logout";
            } else {
                alert("비밀번호 변경에 실패했습니다.");
            }
        });
    // 비밀번호가 바뀐 직후, 다시 로그인을 시키는걸로 하자.
}

// 탈퇴 기능 함수화
function withdrawal(root, thisId) {
    // DB에서 userId를 기반으로 유저 데이터를 삭제하고, 로그아웃을 시킨다.
    fetch(root + "/trip?action=delete", {
        method: "POST",
        body: JSON.stringify({
            userId: thisId
        })
    }).then((response) => { // 굳이 응답이 필요없으므로 성공유무만 판단
        console.log(response.ok);
        if (response.ok) {
            alert("회원을 탈퇴했습니다. 로그아웃됩니다.");
            $("#MyPageModal").modal("hide");
            location.href = root + "/trip?action=logout";
        } else { // 에러가 발생한 경우
            alert('탈퇴에 실패했습니다.');
        }
    });
}


// 비밀번호 유효성 검사
document.getElementById("newPassword").addEventListener("input", function () {
    const newPassword = this.value;
    validatePassword(newPassword); // newPasswordInput도 함께 전달
});

// 비밀번호 유효성 검사
function validatePassword(newPassword) {
    const newPasswordInput = document.getElementById("newPassword");
    let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$/;
    if (!regex.test(newPassword)) {
        newPasswordInput.classList.add("is-invalid");
        return false;
    } else {
        newPasswordInput.classList.remove("is-invalid");
        return true;
    }
}

// 비밀번호 확인 유효성 검사
document.getElementById("confirmNewPassword").addEventListener("input", function () {
    const confirmNewPassword = this.value;
    const newPassword = document.getElementById("newPassword").value;
    validatePasswordConfirmation(newPassword, confirmNewPassword); // confirmPasswordInput도 함께 전달
});

// 비밀번호 확인 유효성 검사
function validatePasswordConfirmation(newPassword, confirmNewPassword) {
    const confirmNewPasswordInput = document.getElementById("confirmNewPassword");
    if (newPassword !== confirmNewPassword) {
        confirmNewPasswordInput.classList.add("is-invalid");
        return false;
    } else {
        confirmNewPasswordInput.classList.remove("is-invalid");
        return true;
    }
}

// 비밀번호 보이기 감추기
document.getElementById("showNewPasswordCheckbox").addEventListener("change", function () {
    const newPassword = document.getElementById("newPassword");
    const confirmNewPassword = document.getElementById("confirmNewPassword");
    if (this.checked) {
        newPassword.type = "text";
        confirmNewPassword.type = "text";
    } else {
        newPassword.type = "password";
        confirmNewPassword.type = "password";
    }
});


//--------------------------------------------------------

// 모달 닫기 이벤트
document.getElementById("MyPageModal").addEventListener("hidden.bs.modal", function () {
    let backdrop = document.querySelector(".modal-backdrop");
    if (backdrop) {
        backdrop.parentNode.removeChild(backdrop);
    }
    document.getElementById("MyPageForm").reset();
    let invalidFields = document.querySelectorAll(".is-invalid");
    invalidFields.forEach(function (field) {
        field.classList.remove("is-invalid");
    });
});
