document.getElementById("showFindPwdModalBtn").addEventListener("click", function () {
    let modal = new bootstrap.Modal(document.getElementById("findPwdModal"));
    modal.show();
});

// ========================================== 아이디 검사 =================================================
document.getElementById("findPwdUserId").addEventListener("input", function () {
    const findPwdUserId = this.value;
    validateUserId(findPwdUserId);
});

function validateUserId(findPwdUserId) {
    let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$/;
    if (regex.test(findPwdUserId)) {
        document.getElementById("findPwdUserId").classList.remove("is-invalid");
        return true;
    } else {
        document.getElementById("findPwdUserId").classList.add("is-invalid");
        return false;
    }
}

// ======================================================================================================
// ========================================== 비밀번호 검사 ===============================================
document.getElementById("findPassword").addEventListener("input", function () {
    const findPassword = this.value;
    validatePassword(findPassword);
});

function validatePassword(findPassword) {
    let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,20}$/;
    if (!regex.test(findPassword)) {
        document.getElementById("findPassword").classList.add("is-invalid");
        return false;
    } else {
        document.getElementById("findPassword").classList.remove("is-invalid");
        return true;
    }
}

// ======================================================================================================
// ==================================== 비밀번호 재입력 확인 ===============================================
document.getElementById("findConfirmPassword").addEventListener("input", function () {
    const findConfirmPassword = this.value;
    const findPassword = document.getElementById("findPassword").value;
    validatePasswordConfirmation(findPassword, findConfirmPassword);
});

function validatePasswordConfirmation(findPassword, findConfirmPassword) {
    if (findPassword !== findConfirmPassword) {
        document.getElementById("findConfirmPassword").classList.add("is-invalid");
        return false;
    } else {
        document.getElementById("findConfirmPassword").classList.remove("is-invalid");
        return true;
    }
}

// ======================================================================================================
// ==================================== 사용자 이름 확인 ===================================================

document.getElementById("findPwdUserName").addEventListener("input", function () {
    const findPwdUserName = this.value;
    validateName(findPwdUserName);
});

function validateName(findPwdUserName) {
    let regex = /^[가-힣]+$/;
    if (!regex.test(findPwdUserName)) {
        document.getElementById("findPwdUserName").classList.add("is-invalid");
        return false;
    } else {
        document.getElementById("findPwdUserName").classList.remove("is-invalid");
        return true;
    }
}

// ======================================================================================================
// ==================================== 비밀번호 체크 박스 ===================================================

const showPasswordCheckbox = document.getElementById("findShowPasswordCheckbox");

showPasswordCheckbox.addEventListener("change", function () {
    const findPasswordInput = document.getElementById("findPassword");
    const findConfirmPasswordInput = document.getElementById("findConfirmPassword");
    if (this.checked) {
        findPasswordInput.type = "text";
        findConfirmPasswordInput.type = "text";
    } else {
        findPasswordInput.type = "password";
        findConfirmPasswordInput.type = "password";
    }
});

document.getElementById("userId").addEventListener("input", function () {
    const userId = this.value;
    validateUserId(userId);
});

// ======================================================================================================
// ==================================== 비밀번호 변경 API 호출 함수 =========================================
document.getElementById("findMember").addEventListener("click", function () {
    const userId = document.getElementById("findPwdUserId").value;
    const userName = document.getElementById("findPwdUserName").value;
    const userPassword = document.getElementById("findConfirmPassword").value;

    fetch("/members/find", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            userId: userId,
            userName: userName,
            userPassword: userPassword
        })
    }).then((response) => {
        if (response.ok) {
            alert("비밀번호 찾아 변경 성공")
            $("#findPwdModal").modal("hide");
        } else {
            alert("정보 확인하세요")
        }
    }).catch((error) => {
        console.error('Error:', error);
    });
});