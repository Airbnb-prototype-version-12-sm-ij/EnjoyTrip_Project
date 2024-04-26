/*
// 회원가입 버튼 클릭시
document.getElementById("signupForm").addEventListener("submit", function (event) {
  event.preventDefault(); // 기본 동작 중단

  // 입력된 값들 가져오기
  let userId = document.getElementById("userId").value;
  let password = document.getElementById("password").value;
  let confirmPassword = document.getElementById("confirmPassword").value;
  let name = document.getElementById("name").value;

  // 입력값이 유효한지 검사
  if (
    !validateUserId(userId) ||
    !validatePassword(password) ||
    !validatePasswordConfirmation(password, confirmPassword) ||
    !validateName(name)
  ) {
    return;
  }

  let users = JSON.parse(localStorage.getItem("users")) || [];

  // 중복된 아이디 확인
  if (isDuplicateId(users, userId)) {
    alert("이미 사용 중인 아이디입니다. 다른 아이디를 선택해주세요.");
    return;
  }

  let newUser = {
    userId: userId,
    password: password,
    name: name,
  };

  users.push(newUser);

  localStorage.setItem("users", JSON.stringify(users));

  alert("회원 가입 성공");

  $("#signupModal").modal("hide");
});
//--------------------------------------------------------
// 모달창 켜져있을시 엔터 누르면 회원가입 버튼 누르는 이벤트
document.getElementById("name").addEventListener("keydown", function (event) {
  if (event.key === "Enter") {
    event.preventDefault();
    // 입력된 값들 가져오기
    let userId = document.getElementById("userId").value;
    let password = document.getElementById("password").value;
    let confirmPassword = document.getElementById("confirmPassword").value;
    let name = document.getElementById("name").value;

    // 입력값이 유효한지 검사
    if (
      !validateUserId(userId) ||
      !validatePassword(password) ||
      !validatePasswordConfirmation(password, confirmPassword) ||
      !validateName(name)
    ) {
      return;
    }

    let users = JSON.parse(localStorage.getItem("users")) || [];

    // 중복된 아이디 확인
    if (isDuplicateId(users, userId)) {
      alert("이미 사용 중인 아이디입니다. 다른 아이디를 선택해주세요.");
      return;
    }

    let newUser = {
      userId: userId,
      password: password,
      name: name,
    };

    users.push(newUser);

    localStorage.setItem("users", JSON.stringify(users));

    alert("회원 가입 성공");

    $("#signupModal").modal("hide");
  }
});
//--------------------------------------------------------
// 중복된 아이디 확인 함수
function isDuplicateId(users, userId) {
  return users.some((user) => user.userId === userId);
}

//--------------------------------------------------------
// 아이디 유효성 검사
document.getElementById("userId").addEventListener("input", function () {
  const userId = this.value;
  validateUserId(userId);
});

function validateUserId(userId) {
  const userIdInput = document.getElementById("userId");
  let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$/;
  if (!regex.test(userId)) {
    userIdInput.classList.add("is-invalid");
    return false;
  } else {
    userIdInput.classList.remove("is-invalid");
    return true;
  }
}
//--------------------------------------------------------
// 비밀번호 유효성 검사
document.getElementById("password").addEventListener("input", function () {
  const password = this.value;
  validatePassword(password);
});

function validatePassword(password) {
  const passwordInput = document.getElementById("password");
  let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$/;
  if (!regex.test(password)) {
    passwordInput.classList.add("is-invalid");
    return false;
  } else {
    passwordInput.classList.remove("is-invalid");
    return true;
  }
}
//--------------------------------------------------------
// 비밀번호 확인 유효성 검사
document.getElementById("confirmPassword").addEventListener("input", function () {
  const confirmPassword = this.value;
  const password = document.getElementById("password").value;
  validatePasswordConfirmation(password, confirmPassword);
});

function validatePasswordConfirmation(password, confirmPassword) {
  const confirmPasswordInput = document.getElementById("confirmPassword");
  if (password !== confirmPassword) {
    confirmPasswordInput.classList.add("is-invalid");
    return false;
  } else {
    confirmPasswordInput.classList.remove("is-invalid");
    return true;
  }
}
//--------------------------------------------------------

// 비밀번호 보이기 감추기
document.addEventListener("DOMContentLoaded", function () {
  const passwordInput = document.getElementById("password");
  const confirmPasswordInput = document.getElementById("confirmPassword");
  const showPasswordCheckbox = document.getElementById("showPasswordCheckbox");

  showPasswordCheckbox.addEventListener("change", function () {
    if (showPasswordCheckbox.checked) {
      passwordInput.setAttribute("type", "text");
      confirmPasswordInput.setAttribute("type", "text");
    } else {
      passwordInput.setAttribute("type", "password");
      confirmPasswordInput.setAttribute("type", "password");
    }
  });
});
//--------------------------------------------------------
// 이름 유효성 검사
document.getElementById("name").addEventListener("input", function () {
  const name = this.value;
  validateName(name);
});

function validateName(name) {
  let regex = /^[가-힣]+$/;
  if (!regex.test(name)) {
    document.getElementById("name").classList.add("is-invalid");
    return false;
  } else {
    document.getElementById("name").classList.remove("is-invalid");
    return true;
  }
}
*/

// 회원가입 기능 함수화
function regist(root) {
    console.log(root);
    let userId = document.getElementById("userId").value;
    let userPwd = document.getElementById("password").value;
    let confirmPwd = document.getElementById("confirmPassword").value;
    let userName = document.getElementById("name").value;
    if (
        !validateUserId(userId) ||
        !validatePassword(userPwd) ||
        !validatePasswordConfirmation(userPwd, confirmPwd) ||
        !validateName(userName)
    ) {
        return;
    }
    let form = document.getElementById("signupForm"); // form 정보를 받아온다
    fetch(root + "/members/join", {
        method: "POST",
        headers:{
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            userId: userId,
            userPassword: userPwd,
            userName: userName
        })
    }).then((response) => {
        console.log(response.ok);
        if (response.ok) {
            alert('회원가입에 성공했습니다.');
            $("#loginModal").modal("hide");
            location.reload();
        } else { // 에러가 발생한 경우
            alert('에러 : 화원가입에 실패했습니다.');
        }
    });
    // 회원가입 이후 모달 종료 (새로고침)
}

document.getElementById("userId").addEventListener("input", function () {
    const userId = this.value;
    validateUserId(userId);
});

// 회원가입 유효성 검사 함수들
function validateUserId(userId) {
    const userIdInput = document.getElementById("userId");
    let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$/;
    if (!regex.test(userId)) {
        userIdInput.classList.add("is-invalid");
        return false;
    } else {
        userIdInput.classList.remove("is-invalid");
        return true;
    }
}

document.getElementById("password").addEventListener("input", function () {
    const password = this.value;
    validatePassword(password);
});

function validatePassword(password) {
    const passwordInput = document.getElementById("password");
    let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$/;
    if (!regex.test(password)) {
        passwordInput.classList.add("is-invalid");
        return false;
    } else {
        passwordInput.classList.remove("is-invalid");
        return true;
    }
}

document.getElementById("confirmPassword").addEventListener("input", function () {
    const confirmPassword = this.value;
    const password = document.getElementById("password").value;
    validatePasswordConfirmation(password, confirmPassword);
});

function validatePasswordConfirmation(password, confirmPassword) {
    const confirmPasswordInput = document.getElementById("confirmPassword");
    if (password !== confirmPassword) {
        confirmPasswordInput.classList.add("is-invalid");
        return false;
    } else {
        confirmPasswordInput.classList.remove("is-invalid");
        return true;
    }
}

document.getElementById("name").addEventListener("input", function () {
    const name = this.value;
    validateName(name);
});

function validateName(name) {
    let regex = /^[가-힣]+$/;
    if (!regex.test(name)) {
        document.getElementById("name").classList.add("is-invalid");
        return false;
    } else {
        document.getElementById("name").classList.remove("is-invalid");
        return true;
    }
}

// 비밀번호 보이기
const showPasswordCheckbox = document.getElementById("showPasswordCheckbox");

showPasswordCheckbox.addEventListener("change", function () {
    const passwordInput = document.getElementById("password");
    const confirmPasswordInput = document.getElementById("confirmPassword");
    if (this.checked) {
        passwordInput.type = "text";
        confirmPasswordInput.type = "text";
    } else {
        passwordInput.type = "password";
        confirmPasswordInput.type = "password";
    }
});

//--------------------------------------------------------
// 모달 표시 이벤트
if (document.getElementById("showSignupModalBtn") != null) {
    document.getElementById("showSignupModalBtn").addEventListener("click", function () {
        let modal = new bootstrap.Modal(document.getElementById("signupModal"));
        modal.show();
    });
}

// 모달 닫기 이벤트
if (document.getElementById("signupModal") != null) {
    document.getElementById("signupModal").addEventListener("hidden.bs.modal", function () {
        let backdrop = document.querySelector(".modal-backdrop");
        if (backdrop) {
            backdrop.parentNode.removeChild(backdrop);
        }
        document.getElementById("signupForm").reset();
        let invalidFields = document.querySelectorAll(".is-invalid");
        invalidFields.forEach(function (field) {
            field.classList.remove("is-invalid");
        });
    });
}

