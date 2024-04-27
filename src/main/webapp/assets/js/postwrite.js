document.getElementById('form-register').addEventListener('submit', function (event) {
    var title = document.getElementById('subject').value;
    var content = document.getElementById('content').value;

    var titleError = document.getElementById('titleError');
    var contentError = document.getElementById('contentError');

    // 초기화
    titleError.style.display = 'none';
    contentError.style.display = 'none';

    if (!title || title.trim() === '') {
        titleError.style.display = 'block';
        event.preventDefault(); // 폼 제출 중단
    }

    if (!content || content.trim() === '') {
        contentError.style.display = 'block';
        event.preventDefault(); // 폼 제출 중단
    }
});

document.getElementById('search-sido').addEventListener('change', function () {
    var selectedValue = this.value;
    if (selectedValue) {
        fetch('/posting/getGugun/' + selectedValue)
            .then(response => response.json())
            .then(data => {
                var select = document.getElementById('search-gugun');
                // 기존의 옵션을 모두 제거합니다.
                select.innerHTML = '';
                // 새로운 옵션을 추가합니다.
                data.forEach(function (item) {
                    var option = document.createElement('option');
                    option.value = item.gugunCode;
                    option.text = item.gugunName;
                    select.add(option);
                });
            })
            .catch(error => console.error('Error:', error));
    }
});