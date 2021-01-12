// document.addEventListener("DOMContentLoaded", () => {
//   const sideMenuItems = document.querySelectorAll('.side-menu li a');
//   const sideContents = document.querySelectorAll('.side-content');

//   sideMenuItems.forEach(clickedItem => {
//     clickedItem.addEventListener('click', (e) => {

//       e.preventDefault();

//       sideMenuItems.forEach(item => {
//         item.classList.remove('side-active');
//       });

//       clickedItem.classList.add('side-active');

//       sideContents.forEach(content => {
//         if {}
//         content.classList.remove('side-active')
//         content.classList.add('side-active');
//       });
//       console.log(clickedItem);
//       // document.querySelector('.side-content').classList.add('side-active');
//       // document.getElementById(clickedItem.id).content.classList.add('side-active');

//     })
//   });
// });
document.addEventListener("DOMContentLoaded", () => {
  const tabs = document.getElementsByClassName('tab');
  
  for(let i = 0; i < tabs.length; i++) {
    tabs[i].addEventListener('click', tabSwitch);
  }
  // タブをクリックすると実行する関数
  function tabSwitch(){
    // .tabを名付けた要素のクラスを付け替える処理
    document.getElementsByClassName('side-active')[0].classList.remove('side-active');
    this.classList.add('side-active');
  
    // コンテンツのclassの値を変更
    document.getElementsByClassName('side-show')[0].classList.remove('side-show');
    const arrayTabs = Array.prototype.slice.call(tabs);
    const index = arrayTabs.indexOf(this);
    document.getElementsByClassName('tab-content')[index].classList.add('side-show');
  };
});
