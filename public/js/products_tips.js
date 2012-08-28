$(document).ready(
function()
{
  $("#products_tips dt").click(
  function()
  {
    if($(this).parent().html() == $("#products_tips .current").html())
    {
      $(this).parent().removeClass("current");
    }
    else
    {
    // $("#products_tips dl").removeClass("current");
     $(this).parent().addClass("current");
    }
  }
  );
  $("#recruitcontent dt").click(
  function()
  {
   if($(this).parent().html() == $("#recruitcontent .current").html())
   {
      $(this).parent().removeClass("current");
   }
   else
   {
     //$("#recruitcontent dl").removeClass("current");
     $(this).parent().addClass("current");
   }
  }
  );
}
);