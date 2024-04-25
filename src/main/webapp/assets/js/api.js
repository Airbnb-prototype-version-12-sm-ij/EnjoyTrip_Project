// index page 로딩 후 전국의 시도 설정.
/*
let serviceKey =
  "d%2FA79SjidmXCAPhbbowI6Xc1SRLrCNC4KyQa0z4EMcSq2q228WXjuW5kn%2F3bamsFn%2BiCGEjzgYK0wQXhyP50TQ%3D%3D";
let areaUrl =
  "https://apis.data.go.kr/B551011/KorService1/areaCode1?serviceKey=" +
  serviceKey +
  "&numOfRows=1000&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json";

fetch(areaUrl, { method: "GET" })
  .then((response) => response.json())
  .then((data) => makeOption(data));
function makeOption(data) {
  let areas = data.response.body.items.item;
  let sel = document.getElementById("search-area");
  areas.forEach((area) => {
    let opt = document.createElement("option");
    opt.setAttribute("value", area.code);
    opt.appendChild(document.createTextNode(area.name));

    sel.appendChild(opt);
  });
}*/

/*
document.getElementById("btn-search").addEventListener("click", () => {

  let sidoCode = document.getElementById("search-sido").value;
  let gugunCode = document.getElementById("search-gugun").value;
  let contentTypeId = document.getElementById("search-content-id").value;
  let keyword = document.getElementById("search-keyword").value;
  
  
  	서블릿으로 보내기
  

  console.log(searchUrl);
  fetch(searchUrl)
    .then((response) => response.json())
    .then((data) => makeList(data));
});
*/


function makeList(data) {/*
  if (
    !(
      data &&
      data.response &&
      data.response.body &&
      data.response.body.items &&
      data.response.body.items.item
    )
  ) {
    alert("검색 결과가 없습니다. 다시 입력해주세요.");
    document.getElementById("search-keyword").value = "";
    return;
  }
  let trips = data.response.body.items.item;
  let tripList = ``;

  trips.forEach((area) => {
    if (!area.firstimage) {
      tripList += `
      <tr>
        <td><img src="/assets/img/no_img.png" width="80px"></td>
        <td>${area.title}</td>
        <td>${area.addr1} ${area.addr2}</td>
        <td width="120px"><button class="btn btn-primary map-button" data-latitude="${area.mapy}" data-longitude="${area.mapx}">정보 보기</button></td>
      </tr>
    `;
    } else {
      tripList += `
      <tr>
        <td><img src="${area.firstimage}" width="100px"></td>
        <td>${area.title}</td>
        <td>${area.addr1} ${area.addr2}</td>
        <td width="120px"><button class="btn btn-primary map-button" data-latitude="${area.mapy}" data-longitude="${area.mapx}">정보 보기</button></td>
      </tr>
    `;
    }
  });*/

    document.getElementById("trip-list").innerHTML = tripList;

    // 클릭 이벤트를 감지하여 모달을 열도록 처리
    document.querySelectorAll(".map-button").forEach(function (button) {
        button.addEventListener("click", function () {
            let latitude = parseFloat(button.getAttribute("data-latitude"));
            let longitude = parseFloat(button.getAttribute("data-longitude"));

            // 해당 위치로 지도 이동
            var moveLatLon = new kakao.maps.LatLng(latitude, longitude);
            map.panTo(moveLatLon); // 지도를 해당 위치로 이동

            // 기존 마커 제거
            if (marker) marker.setMap(null);

            // 새로운 마커 생성
            var marker = new kakao.maps.Marker({
                position: moveLatLon,
                map: map,
            });

            // 관광지 정보 받아오기
            let name = button.closest("tr").querySelector("td:nth-child(2)").textContent;
            let address = button.closest("tr").querySelector("td:nth-child(3)").textContent;
            let trrsrtIntrcn = button.closest("tr").querySelector("td:nth-child(4)").textContent; // 관광지 정보 가져오기

            // 모달의 footer에 정보 추가
            document.getElementById("map-modalfooter").innerHTML = `
      <strong>관광지 이름:</strong> ${name} <br>
      <strong>주소:</strong> ${address}
      `;

            $("#mapModal").modal("show"); // 모달 표시

            // 모달이 열릴 때 resize 이벤트가 발생하도록 함수를 호출하는 코드 추가
            $("#mapModal").on("shown.bs.modal", function () {
                resizeMap();
            });

            function resizeMap() {
                var mapContainer = document.getElementById("map");
                mapContainer.style.width = "100%";
                mapContainer.style.height = "400px";
                // 모달이 열릴 때 지도의 크기가 모달에 맞게 조정되도록 map.relayout() 함수 호출
                map.relayout();
                map.setCenter(moveLatLon);
            }

            function relayout() {
                // 모달이 열릴 때도 relayout 함수 호출
                resizeMap();
                // 기존의 relayout 함수 내용 추가
                map.relayout();
            }

            // 모달이 닫힐 때 resize 이벤트가 발생하도록 함수를 호출하는 코드 추가
            $("#mapModal").on("hidden.bs.modal", function () {
                resizeMap();
            });
        });
    });

}

//--------------------------------------------------------
// 카카오 map key c9c4977a5d4ddc19f25aa9b22c1e264a
var container = document.getElementById("map"); //지도를 담을 영역의 DOM 레퍼런스

resizeMap(container);
var options = {
    //지도를 생성할 때 필요한 기본 옵션
    center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표. 위도(latitude), 경도(longitude) 순
    level: 3, //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

function resizeMap() {
    var mapContainer = document.getElementById("map");
    mapContainer.style.width = "100%";
    mapContainer.style.height = "400px";
}

function relayout() {
    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다
    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
    map.relayout();
}
