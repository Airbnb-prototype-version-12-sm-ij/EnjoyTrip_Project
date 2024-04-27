/* 로그인 관현 js */

// 모달 표시~ 닫기 이벤트는 기존의 이벤트 리스너를 그대로 사용.
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

// === 회원가입 기능 ===
if (document.querySelector("#registBtn") != null) {
    document.querySelector("#registBtn").addEventListener("click", function (e) {
        e.preventDefault();
        regist(); // signup.js에 함수화하였음
    });
}


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

// 아이디 유효성 검사
document.getElementById("loginUserId").addEventListener("input", function () {
    const loginUserId = this.value;
    validateloginUserId(loginUserId);
});

function validateloginUserId(loginUserId) {
    let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{3,15}$/;
    if (!regex.test(loginUserId)) {
        document.getElementById("loginUserId").classList.add("is-invalid");
        return false;
    } else {
        document.getElementById("loginUserId").classList.remove("is-invalid");
        return true;
    }
}

// 비밀번호 유효성 검사
document.getElementById("loginPassword").addEventListener("input", function () {
    const loginPassword = this.value;
    validateloginPassword(loginPassword);
});

function validateloginPassword(loginPassword) {
    let regex = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{3,15}$/;
    if (!regex.test(loginPassword)) {
        document.getElementById("loginPassword").classList.add("is-invalid");
        return false;
    } else {
        document.getElementById("loginPassword").classList.remove("is-invalid");
        return true;
    }
}