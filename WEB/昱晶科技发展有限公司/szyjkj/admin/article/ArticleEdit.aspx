﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ArticleEdit.aspx.cs" Inherits="admin_article_ArticleEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="/js/jquery-1.8.3.js" type="text/javascript"></script>
    <link href="/meditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/meditor/third-party/jquery.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/meditor/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/meditor/umeditor.min.js"></script>
    <script type="text/javascript" src="/meditor/lang/zh-cn/zh-cn.js"></script>
    <link href="/admin/style/admin.css" rel="stylesheet" type="text/css" />
    <script src="/js/layer.js" type="text/javascript"></script>
    <link href="/style/layer.css" rel="stylesheet" type="text/css" />
    <script src="/js/jquery-twExt.js"></script>
    <script>
        $(function () { 
            var id = '<%=ID%>';
            var ue = UM.getEditor('editor'); //实例化编辑器  
            init();
            $("#btn_ok").click(function () {
                var _layer = $.layer({ type: 3 });
                var title = $(".txt_title").val();
                var showindex = $(".txt_showindex").val();
                var content = encodeURIComponent(ue.getContent());
                var typeid = $("#sel_type").val();
                var imgurl = $(".u-imgaddress").attr("src");
                var summary = $(".txt_summary").val();
                /**/
                $.post("/admin/article/ActionArticle.aspx", {
                    action: "SaveArticle",
                    id: id,
                    title: title,
                    showindex: showindex,
                    content: content,
                    typeid: typeid,
                    imgurl: imgurl,
                    summary: summary
                }).success(function (result) {
                    layer.close(_layer);
                    if (result.res == 1) {
                        layer.alert(result.desc, 1, function () {
                            location.href = "/admin/article/ArticleManager.aspx";
                        });
                    }
                    else { layer.alert(result.desc, 9); }

                }).fail(function (ex) { layer.close(_layer); layer.alert("请求失败," + ex.responseText, 9); });
                /**/
                //alert(details.toString());
            });
            //初始化
            function init() {
                if (typeof (jsonarticletype) != 'undefined' && jsonarticletype.length > 0) {
                    for (var i = 0; i < jsonarticletype.length; i++) {
                        var op = '<option value="' + jsonarticletype[i].ID + '">' + jsonarticletype[i].Name + '</option>';
                        $("#sel_type").append(op);
                    }
                }
                if (typeof (jsonarticle) != 'undefined' && jsonarticle.length > 0) {
                    $(".txt_title").val(jsonarticle[0].Title);
                    $(".txt_showindex").val(jsonarticle[0].ShowIndex);
                    $("#sel_type").val(jsonarticle[0].ArticleTypeID);
                    $(".u-imgaddress").attr("src", jsonarticle[0].ImgUrl)
                    $(".txt_summary").val(jsonarticle[0].Summary);
                    ue.setContent(jsonarticle[0].Content);
                }

            }
            $(".btn_uploadimg").click(function () {
                $.tw.photo.uploadImage({ single: true, area: ['800px', '400px'] }).done(function (result) {
                    var tn = result.result[0].tn;
                    var id = result.result[0].id;
                    $(".u-imgaddress").attr("src", tn);
                });
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="e_box">
            <div class="e-item">
                <span class="sp150">标题：</span>
                <input type="text" maxlength="200" class="txt_title" runat="server" id="txt_title" />
            </div>
            <div class="e-item">
                <span class="sp150">分类：</span>
                <select id="sel_type">
                </select>
            </div>
            <div class="e-item">
                <span class="sp150">排序：</span>
                <input type="text" maxlength="5" class="txt_showindex" value="1" runat="server" id="txt_showindex" />
            </div>
            <div class="e-item">
                <span class="sp150">图片：</span>
                <img class="u-imgaddress" width="200" height="130" src="" />
                <a class="inpbbut3 btn_uploadimg">选择图片</a>
            </div>
            <div class="e-item">
                <span class="sp150">简介：</span>
                <textarea class="txt_summary " maxlength="500" style="width: 500px; height: 90px;"></textarea>
            </div>

            <div class="e-item clearfix">
                <span class="sp150" style="float: left;">内容：</span>
                <div class="clearfix " style="float: left">
                    <script id="editor" type="text/plain" style="width: 1000px; max-height: 400px; min-height: 250px;"></script>
                </div>
            </div>
            <div class="btn-content fl" style="margin-left: 200px; margin-top: 10px;">
                <input type="button" id="btn_ok" class="inpbbut3" value="确认" />
            </div>
        </div>

    </form>
</body>
</html>
