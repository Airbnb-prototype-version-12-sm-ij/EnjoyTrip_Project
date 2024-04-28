/* 회원관리 모달 기능 */
// 모달을 열 때마다 실행될 함수
if (document.getElementById("showMMModalBtn") != null) {
    document.getElementById("showMMModalBtn").addEventListener("click", function MberModal(e) {
        e.preventDefault();
        console.log("회원 관리 모달 오픈");
        fetch("/members/info")
            .then(response => response.json())
            .then(data => {
                let memberList = document.getElementById("memberList");
                memberList.innerHTML = "";
                data.forEach(function (user) {
                    let userNames = user.userName;
                    let userId = user.userId;
                    let grade = user.grade;
                    let registrationDate = user.registrationDate;
                    var row = document.createElement("div");
                    row.classList.add("row");
                    let div1 = document.createElement("div");
                    div1.className = "col-3 d-flex justify-content-center align-items-center";
                    div1.textContent = userNames;

                    let div2 = document.createElement("div");
                    div2.className = "col-2 d-flex justify-content-center align-items-center";
                    div2.textContent = userId;

                    let div3 = document.createElement("div");
                    div3.className = "col-2 d-flex justify-content-center align-items-center";
                    div3.textContent = grade;

                    let div4 = document.createElement("div");
                    div4.className = "col-2 d-flex justify-content-center align-items-center";
                    div4.textContent = registrationDate;

                    let button = document.createElement("button");
                    button.type = "button";
                    button.className = "btn btn-outline-danger user-delete";
                    button.dataset.userId = userId;
                    button.textContent = "X";
                    button.addEventListener('click', () => {
                        fetch("/members/delete", {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify(button.dataset.userId),
                        })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Network response was not ok');
                                }
                                MberModal(e);
                            })
                            .catch(error => {
                                console.error('There has been a problem with your fetch operation:', error);
                                // 여기에서 필요한 추가 작업을 수행하십시오. 예를 들어, 오류 메시지를 표시합니다.
                            });
                    });
                    let div5 = document.createElement("div");
                    div5.className = "col-2 d-flex justify-content-center align-items-center";
                    div5.appendChild(button);

                    row.appendChild(div1);
                    row.appendChild(div2);
                    row.appendChild(div3);
                    row.appendChild(div4);
                    row.appendChild(div5);
                    memberList.appendChild(row);
                });
            });
    });
}

// 회원 관리 모달 닫기 이벤트
document.getElementById("MMModal").addEventListener("hidden.bs.modal", function () {
    let backdrop = document.querySelector(".modal-backdrop");
    if (backdrop) {
        backdrop.parentNode.removeChild(backdrop);
    }
    document.getElementById("memberList").innerHTML = "";
});