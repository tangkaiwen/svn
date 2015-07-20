﻿<%@ Page Language="C#" MasterPageFile="~/master/m.master" AutoEventWireup="true" CodeFile="newsdetails.aspx.cs" Inherits="newsdetails" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="mbody">
    <style>
        .new-list ul li { border-bottom: 1px dotted #000; padding: 10px; font-size: 14px; }
        a { text-decoration: none; }
        .new-title { }
        .news-date { float: right; }
    </style>
    <div class="d-content">
        <div class="d-nvtitle">
            <span class="ico"></span>
            <a href="/">首页</a>
            <span class="guai">></span>
            <a href="/news.html">相关新闻</a>
        </div>
        <div class="new-list">

            <%if (DtNews != null && DtNews.Rows.Count > 0)
              {
                  foreach (System.Data.DataRow item in DtNews.Rows)
                  { 
            %>
            <div>
                <div style="font: bold; font-size: 20px; text-align: center;"><%=item["Title"] %></div>
                <div style="font: bold; font-size: 12px; text-align: center;">发布日期：<%=Convert.ToDateTime(item["CreateTS"]).ToString("yyyy-MM-dd HH:mm")%> <span style="margin-left: 10px;">浏览量：<%=item["ClickCount"]%></span></div>

                <div style="padding-bottom: 10px;"><%=item["Content"] %></div>
            </div>
            <% 
                  }
              }
              else
              {%>
                暂时无新闻
                <% } %>
        </div>
    </div>
</asp:Content>
