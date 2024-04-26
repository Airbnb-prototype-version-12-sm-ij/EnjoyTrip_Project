function adminlist(root) {
    fetch(root + "/members/info", {
        method: "GET"
    }).then((response) => (response.json()))
        .then((data) => {
            console.log(data);
            let memberList = document.getElementById("memberList");
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