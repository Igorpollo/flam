
$(window).load(function () {
    $('.flow').collagePlus({
        'fadeSpeed'     : 2000,
        'targetHeight'  : 450,
        'effect'        : 'effect-2',
        'direction'     : 'vertical',
        'allowPartialLastRow'       : true
    });


});





$(document).ready(function() {


    $('.search_box').focus(function()
{
    /*to make this flexible, I'm storing the current width in an attribute*/
    $(this).attr('data-default', $(this).width());
    $(this).animate({ width: 200 }, 500);
    $(this).css('border', '1px solid #ddd')
}).blur(function()
{
    /* lookup the original width */
    var w = $(this).attr('data-default');
    $(this).animate({ width: w }, 500);
    $(this).css('border', '0')
});


$('body').on('click', '.favIconCapt', function() {
   event.preventDefault();
   $(this).removeClass('favIconCapt');
   $(this).addClass('favIconCapt-marked');
   var photoId = $(this).attr('data-photo');
    $.ajax({
        url: Routes.profile_favorites_path('<%= current_user.profile_name %>', {photo_id: photoId}),
        method: "post",
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        },
        success: function() {
        }

    });
});

$('body').on('click', '.favIconCapt-marked', function() {
   event.preventDefault();
   $(this).removeClass('favIconCapt-marked');
   $(this).addClass('favIconCapt');
   var photoId = $(this).attr('data-photo');
    $.ajax({
        url: Routes.profile_favorites_path('<%= current_user.profile_name %>', {photo_id: photoId}),
        method: "post",
        data: {'_method': 'delete'},
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        },
        success: function() {
        }

    });
});



$('body').on('click', '.likeIconCapt', function() {
   event.preventDefault();
   $(this).removeClass('likeIconCapt');
   $(this).addClass('likeIconCapt-marked');
   var photoId = $(this).attr('data-photo');
    $.ajax({
        url: Routes.profile_likes_path('<%= current_user.profile_name %>', {photo_id: photoId}),
        method: "post",
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        },
        success: function() {
        }

    });
});



$('body').on('click', '.likeIconCapt-marked', function() {
   event.preventDefault();
   $(this).removeClass('likeIconCapt-marked');
   $(this).addClass('likeIconCapt');
   var photoId = $(this).attr('data-photo');
    $.ajax({
        url: Routes.profile_likes_path('<%= current_user.profile_name %>', {photo_id: photoId}),
        method: "post",
        data: {'_method': 'delete'},
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        },
        success: function() {
        }

    });
});



    $(".capa").backstretch("http://31.media.tumblr.com/f0cb0d2bc887555434fa3afe0530e1cf/tumblr_n1ipr3bTo11st5lhmo1_1280.jpg");

});