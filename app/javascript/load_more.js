document.addEventListener('DOMContentLoaded', () => {
  const button = document.getElementById('load-more-btn');
  if (!button) return;

  button.addEventListener('click', () => {
    const page = button.dataset.page;
    fetch(`/?page=${page}`, {
      headers: { 'Accept': 'text/javascript' }
    });
  });
});
