$(function () {
  $(document).on("mouseover", ".content_post", function () {
    $(this).css(
      { "background-color": "blue" },
      { "transition-duration": "1s" },
      { "transition-timing-function": "linear" }
    );
  }).on("mouseout", ".content_post", function () {
    $(this).css({ "background-color": "" },
    { "transition-duration": "0.1s" },
    { "transition-timing-function": "linear" }
    );
  })
});