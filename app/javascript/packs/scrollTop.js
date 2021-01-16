document.addEventListener("DOMContentLoaded", () => {
  const PageTopBtn = document.getElementById('scroll-top');
  PageTopBtn.addEventListener('click', () => {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });
});
