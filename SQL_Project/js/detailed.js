$(function () {
    $("#md_name").click(function () {
        $(this).addClass("text_box_click");
        $("#md_note").removeClass("text_box_click");
    })
    $("#md_note").click(function () {
        $(this).addClass("text_box_click");
        $("#md_name").removeClass("text_box_click");
    })
})