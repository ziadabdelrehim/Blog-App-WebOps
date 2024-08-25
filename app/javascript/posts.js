// app/javascript/posts.js
document.addEventListener('DOMContentLoaded', () => {
    const posts = [
        {
            title: 'First Post',
            body: 'This is the body of the first post. It includes some interesting content!',
            author: 'John Doe',
            tags: ['Introduction', 'First'],
            comments: ['Great post!', 'Very informative.']
        },
        {
            title: 'Another Post',
            body: 'Here is another post with more detailed information and some insights.',
            author: 'Jane Smith',
            tags: ['Details', 'Insights'],
            comments: ['Thanks for sharing!', 'I learned a lot.']
        },
        {
            title: 'A Third Post',
            body: 'This post covers a different topic and provides additional context.',
            author: 'Alice Johnson',
            tags: ['Context', 'Information'],
            comments: ['Interesting read!', 'I have a question about this.']
        }
    ];

    function postContent() {
        const title = document.getElementById('postTitle').value;
        const body = document.getElementById('postBody').value;
        const tags = document.getElementById('postTags').value.split(',').map(tag => tag.trim());

        if (title.trim() === '' || body.trim() === '') return;

        const newPost = {
            title: title,
            body: body,
            author: 'Anonymous',
            tags: tags,
            comments: []
        };

        posts.push(newPost);
        document.getElementById('postTitle').value = '';
        document.getElementById('postBody').value = '';
        document.getElementById('postTags').value = '';

        renderPosts();
    }

    function addComment(postIndex) {
        const commentInput = document.getElementById(`commentInput-${postIndex}`);
        const commentText = commentInput.value;
        if (commentText.trim() === '') return;

        posts[postIndex].comments.push(commentText);
        commentInput.value = '';

        renderPosts();
    }

    function toggleMenu(index, type) {
        const menu = document.getElementById(`${type}-menu-${index}`);
        menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
    }

    function renderPosts() {
        const postList = document.getElementById('postList');
        postList.innerHTML = '';

        posts.forEach((post, index) => {
            const postElement = document.createElement('div');
            postElement.classList.add('post');
            postElement.innerHTML = `
                <div class="action-button" onclick="toggleMenu(${index}, 'post')">...</div>
                <div id="post-menu-${index}" class="action-menu">
                    <div onclick="showEditForm(${index})">Edit</div>
                    <div onclick="deletePost(${index})">Delete</div>
                    <div onclick="hidePost(${index})">Hide</div>
                </div>
                <h2>${post.title}</h2>
                <p>${post.body}</p>
                <div class="details">
                    <p><strong>Author:</strong> ${post.author}</p>
                    <p><strong>Tags:</strong> ${post.tags.join(', ')}</p>
                    <p><strong>Comments:</strong> ${post.comments.length}</p>
                </div>
                <div class="comment-form">
                    <input type="text" id="commentInput-${index}" placeholder="Add a comment...">
                    <button onclick="addComment(${index})">Comment</button>
                </div>
                <div class="comments">
                    <h3>Comments:</h3>
                    ${post.comments.map((comment, commentIndex) => `
                        <div class="comment">
                            <div class="comment-header">
                                <img src="your-profile-picture-url.png" alt="Profile Picture" class="profile-pic">
                                <span class="comment-author">Author Name</span>
                            </div>
                            <div class="action-button" onclick="toggleMenu(${index}, 'comment-${commentIndex}')">...</div>
                            <div id="comment-${index}-menu-${commentIndex}" class="action-menu">
                                <div onclick="editComment(${index}, ${commentIndex})">Edit</div>
                                <div onclick="deleteComment(${index}, ${commentIndex})">Delete</div>
                                <div onclick="hideComment(${index}, ${commentIndex})">Hide</div>
                            </div>
                            ${comment}
                        </div>
                    `).join('')}
                </div>
                <div id="editForm-${index}" class="edit-form">
                    <div class="input-group">
                        <input type="text" id="editTitle-${index}" value="${post.title}" placeholder="Edit title...">
                    </div>
                    <div class="input-group">
                        <input type="text" id="editBody-${index}" value="${post.body}" placeholder="Edit body...">
                    </div>
                    <div class="input-group">
                        <input type="text" id="editTags-${index}" value="${post.tags.join(', ')}" placeholder="Edit tags (comma-separated)...">
                    </div>
                    <button onclick="savePost(${index})">Save</button>
                </div>
            `;
            postList.appendChild(postElement);
        });
    }

    function showEditForm(index) {
        document.getElementById(`editForm-${index}`).style.display = 'block';
    }

    function savePost(index) {
        const newTitle = document.getElementById(`editTitle-${index}`).value;
        const newBody = document.getElementById(`editBody-${index}`).value;
        const newTags = document.getElementById(`editTags-${index}`).value.split(',').map(tag => tag.trim());

        if (newTitle.trim() === '' || newBody.trim() === '') return;

        posts[index].title = newTitle;
        posts[index].body = newBody;
        posts[index].tags = newTags;

        document.getElementById(`editForm-${index}`).style.display = 'none';

        renderPosts();
    }

    function deletePost(index) {
        posts.splice(index, 1);
        renderPosts();
    }

    function hidePost(index) {
        posts.splice(index, 1);
        renderPosts();
    }

    function editComment(postIndex, commentIndex) {
        const newComment = prompt('Edit your comment:', posts[postIndex].comments[commentIndex]);
        if (newComment !== null) {
            posts[postIndex].comments[commentIndex] = newComment;
            renderPosts();
        }
    }

    function deleteComment(postIndex, commentIndex) {
        posts[postIndex].comments.splice(commentIndex, 1);
        renderPosts();
    }

    function hideComment(postIndex, commentIndex) {
        posts[postIndex].comments.splice(commentIndex, 1);
        renderPosts();
    }

    // Initial render of posts
    renderPosts();
});
