<%@ page
        contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"
        import="com.ssafy.enjoytrip.domain.attraction.entity.AttractionEntity"
        import="java.util.*"
%>
<!-- controller 도메인 : /trip -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<%
    String root = request.getContextPath();
    List<AttractionEntity> attractionList = (List<AttractionEntity>)request.getAttribute("arrlist");
%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"
/>
<link
        rel="stylesheet"
        href="../assets/stylesheet/basicstyle.css"
>
<script
        type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c9c4977a5d4ddc19f25aa9b22c1e264a&libraries=services"
></script>

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>스프링 부트 적용 관통</title>
    <%
        if (request.getAttribute("err") != null) {
    %>
    <script type="text/javascript">
        alert("<%=request.getAttribute("err")%>");
    </script>
    <%
        }
    %>

</head>
<body>
<%@ include file="common/loginnav.jsp" %> <!-- 로그인 페이지 조각 추가 -->


<!-- 지도 모달  -->
<div
        class="modal fade"
        id="mapModal"
        tabindex="-1"
        aria-labelledby="mapModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="mapModalLabel">지도</h5>
                <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                ></button>
            </div>
            <div class="modal-body">
                <div id="map-container" style="height: 650px">
                    <div id="map" style="height: 400px"></div>
                    <div id="map-modalfooter" class="pt-2"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 메인 화면 -->
<div class="container mb-1">
    <!-- 타이틀 -->
    <h1>어디로 갈까?</h1>
    <p>원하는 관광지 검색</p>
    <!-- 검색바 -->
    <div class="container mt-3">
        <!-- 관광지 검색 start -->
        <form class="d-flex mt-3" role="search">
            <select id="search-sido" class="form-select" aria-label="Default select example">
                <option value="0" selected>검색 할 시, 도 선택</option>
                <option value="1">서울</option>
                <option value="2">인천</option>
                <option value="3">대전</option>
                <option value="4">대구</option>
                <option value="5">광주</option>
                <option value="6">부산</option>
                <option value="7">울산</option>
                <option value="8">세종특별자치시</option>
                <option value="31">경기도</option>
                <option value="32">강원도</option>
                <option value="33">충청북도</option>
                <option value="34">충청남도</option>
                <option value="35">경상북도</option>
                <option value="36">경상남도</option>
                <option value="37">전라북도</option>
                <option value="38">전라남도</option>
                <option value="39">제주도</option>
            </select>
            <select id="search-content-id" class="form-select" aria-label="Default select example">
                <option value="0" selected>관광지 유형</option>
                <option value="12">관광지</option>
                <option value="14">문화시설</option>
                <option value="15">축제공연행사</option>
                <option value="25">여행코스</option>
                <option value="28">레포츠</option>
                <option value="32">숙박</option>
                <option value="38">쇼핑</option>
                <option value="39">음식점</option>
            </select>
            <input
                    id="search-keyword"
                    class="form-control me-2"
                    type="search"
                    placeholder="검색어"
                    aria-label="검색어"
            />
            <button id="btn-search" class="btn btn-primary" type="button">
                <i class="fas fa-search"></i>
            </button>
        </form>
        <div class="row">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>대표이미지</th>
                    <th>관광지명</th>
                    <th>주소</th>
                    <th>위치</th>
                </tr>
                </thead>
                <tbody id="trip-list" style="max-height: 10vh; overflow-y: auto">

                </tbody>
            </table>
        </div>
        <!-- 관광지 검색 end -->
    </div>
    <!-- 게시판 뉴스 공지사항 -->
    <div class="row">
        <div class="col">
            <!-- 게시판 테이블 -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>
                        <a href="/posting/list" class="btn-light" id="boardButton">게시판</a>
                    </th>

                </tr>
                </thead>
                <tbody>
                <!-- 게시물들 -->
                <tr>
                    <th>게시물제목 + 작성자</th>
                </tr>
                <tr>
                    <th>게시물내용</th>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="col">
            <!-- 뉴스 테이블 -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>뉴스</th>
                </tr>
                </thead>
                <tbody>
                <!-- 뉴스 기사들 -->
                <tr>
                    <th>뉴스기사 제목 + 작성자</th>
                </tr>
                <tr>
                    <th>뉴스기사 내용</th>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="col">
            <!-- 공지사항 테이블 -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>공지사항</th>
                </tr>
                </thead>
                <tbody>
                <!-- 공지사항 내용들 -->
                <tr>
                    <th>공지사항내용</th>
                </tr>
                </tbody>
            </table>

        </div>
    </div>
</div>


<footer>@광주_5반 황성민 선장과 일등항해사 이인준</footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../assets/js/mypage.js"></script>
<script src="../assets/js/mberManagement.js"></script>
<script src="../assets/js/findpwd.js"></script>
<%--<script src="../assets/js/api.js"></script>--%>
<script src="../assets/js/login.js"></script>
<script src="../assets/js/signup.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 인터셉터로 잡혀서 오면 아래 코드 실행

    <% if(request.getAttribute("msg") != null){ %>
    alert("<%=request.getAttribute("msg")%>");
    <% } %>


    // ==== 검색 ====
    document.getElementById("btn-search").addEventListener("click", () => {
        let sidoCode = document.getElementById("search-sido").value;
        let contentTypeId = document.getElementById("search-content-id").value;
        let keyword = document.getElementById("search-keyword").value;


        // AJAX 요청 보내기
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "/attractions/search?sidoCode=" + sidoCode + "&typeCode=" + contentTypeId + "&title=" + keyword, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                // 서버에서 데이터를 받았을 때의 처리
                const attractionList = JSON.parse(xhr.responseText);
                // 받은 데이터를 활용하여 테이블 업데이트
                updateTable(attractionList);

            }
        };
        xhr.send();
    });

    // ====== 관광지 리스트 출력 함수 ======
    function updateTable(attractionList) {
        const tableBody = document.getElementById('trip-list');
        tableBody.innerHTML = ''; // 기존의 내용을 비워줌
        attractionList.forEach(attraction => {
            const row = document.createElement('tr');
            const imgCell = document.createElement('td');
            const titleCell = document.createElement('td');
            const addrCell = document.createElement('td');
            const locationCell = document.createElement('td');
            const img = document.createElement('img');
            img.src = attraction.firstImage || 'assets/img/no_img.png';
            img.style = "width: 100px";
            img.alt = '';
            imgCell.appendChild(img);
            titleCell.textContent = attraction.title;

            addrCell.textContent = `${attraction.addr1} ${attraction.addr2}`;

            const button = document.createElement('button');
            button.className = 'btn btn-primary map-button';
            button.dataset.title = attraction.title;
            button.dataset.addr1 = attraction.addr1;
            button.dataset.addr2 = attraction.addr2;
            button.dataset.overview = attraction.overview || '';
            button.dataset.latitude = attraction.latitude;
            button.dataset.longitude = attraction.longitude;
            button.textContent = '정보 보기';
            button.addEventListener('click', function () {
                handleMapButtonClick(attraction);
            });
            locationCell.appendChild(button);

            row.appendChild(imgCell);
            row.appendChild(titleCell);
            row.appendChild(addrCell);
            row.appendChild(locationCell);

            tableBody.appendChild(row);
        });
    }


    // ====== 지도 모달 ======
    function handleMapButtonClick(attraction) {
        let title = attraction.title;
        let addr1 = attraction.addr1;
        let addr2 = attraction.addr2;
        let overview = attraction.overview;
        let latitude = parseFloat(attraction.latitude);
        let longitude = parseFloat(attraction.longitude);

        // 해당 위치로 지도 이동
        let moveLatLon = new kakao.maps.LatLng(latitude, longitude);
        var container = document.getElementById('map');
        var options = {
            center: new kakao.maps.LatLng(33.450701, 126.570667),
            level: 3
        };
        var map = new kakao.maps.Map(container, options);

        map.panTo(moveLatLon); // 지도를 해당 위치로 이동


        // 기존 마커 제거
        /*if (marker) marker.setMap(null);*/

        // 새로운 마커 생성
        let marker = new kakao.maps.Marker({
            position: moveLatLon,
            map: map,
        });

        function relayout() {
            // 모달이 열릴 때도 relayout 함수 호출
            resizeMap();
            // 기존의 relayout 함수 내용 추가
            map.relayout();
        }

        // 모달의 footer에 정보 추가
        document.getElementById("map-modalfooter").innerHTML =
            "<strong>관광지 이름:</strong>" + title + "<br>" + "<strong>주소:</strong>" + addr1 + addr2 + "<br>" + "<strong>설명:</strong>" + overview;

        $("#mapModal").modal("show"); // 모달 표시

        // 모달이 열릴 때 resize 이벤트가 발생하도록 함수를 호출하는 코드 추가
        $("#mapModal").on("shown.bs.modal", function () {
            relayout();
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


        // 모달이 닫힐 때 resize 이벤트가 발생하도록 함수를 호출하는 코드 추가
        $("#mapModal").on("hidden.bs.modal", function () {
            resizeMap();
        });
    }


</script>
</body>
</html>
