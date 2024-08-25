// app/javascript/packs/comments.js

function toggleMenu(id, type) {
    const menu = document.getElementById(`${type}-menu-${id}`);
    menu.style.display = menu.style.display === 'none' ? 'block' : 'none';
  }
  
  function deleteComment(id) {
    if (confirm('Are you sure you want to delete this comment?')) {
      fetch(`/posts/${postId}/comments/${id}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
      }).then(response => {
        if (response.ok) {
          document.getElementById(`comment-${id}`).remove();
        } else {
          alert('Error deleting comment.');
        }
      });
    }
  }
  
  function editComment(id) {
    window.location.href = `/posts/${postId}/comments/${id}/edit`;
  }
  