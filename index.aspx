<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SignalRRealTimeSQL.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    
    <script src="Scripts/jquery-1.6.4.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.1.min.js"></script>
    <script src="/signalR/hubs"></script>
        <style>
            #tbl{
                width: 100%;
                height: auto;
                font-size: 16px;
                border: 1px solid;
                padding: 10px;
                margin-right: 20px;
            }
            #tbl th {
                background-color: aqua;
                border-bottom: solid;
            }

             #tbl tr {
                border-bottom: 1px dashed;
                text-align: center;
            }
             #tbl tr:nth-child(even){background-color: #f2f2f2;}

            #tbl tr:hover {background-color: #ddd;}
     /*       #tbl td {
                border-left: 1px dashed #000;
            }*/

        </style>
      <script type="text/javascript">

          $(function () {

              // Proxy created on the fly
              var job = $.connection.myHub;

              // Declare a function on the job hub so the server can invoke it
              job.client.displayStatus = function () {
                  getData();
              };

              // Start the connection
              $.connection.hub.start();
              getData();
          });

          function getData() {
              var $tbl = $('#tbl');
              $.ajax({
                  url: 'index.aspx/GetData',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  type: "POST",
                  success: function (data) {
                      debugger;
                      if (data.d.length > 0) {
                          var newdata = data.d;
                          console.log(newdata);
                          $tbl.empty();
                          $tbl.append(' <tr><th scope="col">ID</th><th scope="col" >Mã CP</th><th scope="col">Giá mua 3</th><th scope="col" >Lượng mua 3</th><th scope="col">Giá mua 2</th><th scope="col" >Lượng mua 2</th><th scope="col">Giá mua 1</th><th scope="col">Lượng mua1</th><th scope="col">Giá bán 3</th><th scope="col">Lượng bán 3</th><th scope="col">Giá bán 2</th><th scope="col">Lượng bán 2</th><th scope="col">Giá bán 1</th><th scope="col">Lượng bán 1</th><th scope="col">Giá khớp</th><th scope="col">Lượng khớp</th><th scope="col">Tổng số</th></tr>');
                          var rows = [];
                          for (var i = 0; i < newdata.length; i++) {
                              rows.push(' <tr><td>' + newdata[i].ID + '</td><td>' + newdata[i].MACP + '</td><td>' + newdata[i].GIAMUA3 + '</td><td>' + newdata[i].LUONGMUA3 + '</td><td>' + newdata[i].GIAMUA2 + '</td><td>' + newdata[i].LUONGMUA2 + '</td><td>' + newdata[i].GIAMUA1 + '</td><td>' + newdata[i].LUONGMUA1
                                  + '</td><td>' + newdata[i].GIABAN3 + '</td><td>' + newdata[i].LUONGBAN3 + '</td><td>' + newdata[i].GIABAN2 + '</td><td>' + newdata[i].LUONGBAN2 + '</td><td>' + newdata[i].GIABAN1 + '</td><td>' + newdata[i].LUONGBAN1
                                  + '</td><td>' + newdata[i].GIAKHOP + '</td><td>' + newdata[i].LUONGKHOP + '</td><td>' + newdata[i].TONGSO + '</td></tr>');
                          }
                          $tbl.append(rows.join(''));
                      }
                  }
              });
          }
      </script>

</head>
<body>
<form id="form1" runat="server">
 <div style="padding-left: 200px; padding-top: 20px; display: flex" >
            <div>
                <div class="m-2">
                    <asp:Label ID="Label1" runat="server" Text="Mã cổ phiếu: "></asp:Label>
                     <asp:TextBox runat="server" class="border border-success" id="txtMaCP" type="text"  />
                </div>
                <div class="m-2">
                    <asp:Label ID="Label2" runat="server" Text="Loại Giao dịch: "></asp:Label> 
                    <asp:DropDownList runat="server" class="border border-success" id="cbbLoaiGD" style="width: 190px; height: 30px; text-align-last: left">
                        <asp:ListItem value="M" selected="True">  
                          Mua  
                       </asp:ListItem> 
                        <asp:ListItem value="B">  
                         Bán  
                       </asp:ListItem> 
                      </asp:DropDownList>
                </div>
                <div class="m-2">
                    <asp:Label ID="Label3" runat="server" Text="Số lượng: "></asp:Label>
                     <asp:TextBox runat="server" class="border border-success" id="txtSoLuong" type="number" />
                </div>
                <div class="m-2">
                    <asp:Label ID="Label4" runat="server" Text="Giá đặt: "></asp:Label>
                     <asp:TextBox runat="server"  class="border border-success" id="txtGiaDat" type="number" />
                
                </div>
            </div>
            <div> <asp:Button CssClass ="btn btn-success m-2" ID="btnDatLenh" runat="server" Text="ĐẶT LỆNH" OnClick="btnDatLenh_Click" /></div>
                
        </div>
        <div style="margin-left:20px">
            <h2>BẢNG GIÁ TRỰC TUYẾN</h2>
            <div>
                <table class =" " id="tbl"></table>
            </div>
        </div>
    </form>
</body>
</html>
