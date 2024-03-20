document.addEventListener("DOMContentLoaded", function() {
  document.addEventListener('click', function(event) {
    const likeButton = event.target.closest('.movie .like-icon button.btn.text-warning');
    if (likeButton) {
      likeButton.classList.toggle('like-clicked');
    }
  });
});
