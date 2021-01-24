// document.addEventListener("DOMContentLoaded", () => {
//   const PageTopBtn = document.getElementById('scroll-top');
//   PageTopBtn.addEventListener('click', () => {
//     window.scrollTo({
//       top: 0,
//       behavior: 'smooth'
//     });
//   });
// });

document.addEventListener("DOMContentLoaded", () => {
  const PageTopBtn = document.getElementById('scroll-top');
  function getScrolled() {
    return ( window.pageYOffset !== undefined ) ? window.pageYOffset: document.documentElement.scrollTop;
  }
  window.onscroll = () => {
    ( getScrolled() > 1000 ) ? PageTopBtn.classList.add( 'fade-in' ): PageTopBtn.classList.remove( 'fade-in' );
  };
  PageTopBtn.addEventListener('click', () => {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });
});
