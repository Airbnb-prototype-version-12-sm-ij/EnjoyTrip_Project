document.getElementById('search-sido').addEventListener('change', function () {
    var selectedValue = this.value;
    if (selectedValue) {
        fetch('/posting/list/' + selectedValue)
            .then(response => response.json())
            .then(data => {
                var postList = document.getElementById('postListBody');
                var html = '';
                data.forEach(post => {
                    html += `<tr class="text-center">
                                <th scope="row">${post.postId}</th>
                                <td class="text-start">
                                    <a href="/posting/${post.postId}" class="article-title link-dark" data-no="${post.postId}" style="text-decoration: none">
                                        ${post.title}
                                    </a>
                                </td>
                                <td>${post.userId}</td>
                                <td>${post.sidoName}</td>
                                <td>${post.hit}</td>
                                <td>${post.createdAt}</td>
                            </tr>`;
                });
                postList.innerHTML = html;
            })
            .catch(error => console.error('Error:', error));
    }
});