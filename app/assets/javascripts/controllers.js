'use strict';


angular


    .module('app', ['angularFileUpload'])

    

    .controller('AppController', ['$scope', 'FileUploader', function($scope, FileUploader) {



         

         //Random String generator
            var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz=-)(/";
            var string_length = 60;
            var randomstring = '';
                for (var i=0; i<string_length; i++) {
                    var rnum = Math.floor(Math.random() * chars.length);
                    randomstring += chars.substring(rnum,rnum+1);
                }

    	var csrf_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        var uploader = $scope.uploader = new FileUploader({
            url: 'http://localhost:3000/igorpollo/photos?token=' + randomstring,
            headers : {
        'X-CSRF-TOKEN': csrf_token // X-CSRF-TOKEN is used for Ruby on Rails Tokens
    }
        });

        // FILTERS

        uploader.filters.push({
            name: 'imageFilter',
            fn: function(item /*{File|FileLikeObject}*/, options) {
                var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
                return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
            }
        });

        // CALLBACKS

        uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
            console.info('onWhenAddingFileFailed', item, filter, options);
        };
        uploader.onAfterAddingFile = function(fileItem) {
            
            var number = Math.floor((Math.random() * 900) + 1);
        

                console.log(fileItem);
                fileItem.file.dataForm = number;
                fileItem.file.photoToken = randomstring;

         

            var p = document.getElementsByClassName("formPhoto")[0];
         
            var i = p.cloneNode(true); //input element, text
            i.className = "formPhoto";
            i.setAttribute('data-form', number);

            var hidden = document.createElement("input");
            hidden.setAttribute('type', 'hidden');
            hidden.setAttribute('name', 'photo[photo_token]');
            hidden.setAttribute('value', randomstring);

            i.appendChild(hidden);

            
            document.getElementById("myForms").appendChild(i);
        };
        uploader.onAfterAddingAll = function(addedFileItems) {
            
            $('.upload_box').hide(1500, 'swing');

        };



        uploader.onBeforeUploadItem = function(item) {
            var csrf_token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
            var dataForm = item.file.dataForm;
            var form = $('div[data-form="' + dataForm + '"] :input');

            $.ajax({
                 beforeSend: function (request)
            {
                request.setRequestHeader("X-CSRF-TOKEN", csrf_token);
            },
                url: 'http://localhost:3000/igorpollo/photos',
                method: 'POST',
                data: form.serialize(),
                success: function(data) {
                    xhr.send(form);
                }
            });
            

        };
        uploader.onProgressItem = function(fileItem, progress) {
            
        };
        uploader.onProgressAll = function(progress) {
            $('.upload_Btn').hide();
            $('.upload_box').show(1500, 'swing');
            $('.progressAll').show();
            
        };
        uploader.onSuccessItem = function(fileItem, response, status, headers) {
            
        };
        uploader.onErrorItem = function(fileItem, response, status, headers) {
            
        };
        uploader.onCancelItem = function(fileItem, response, status, headers) {
            
        };
        uploader.onCompleteItem = function(fileItem, response, status, headers) {
           
        };
        uploader.onCompleteAll = function() {
            
        };

        console.info('uploader', uploader);
    }]);