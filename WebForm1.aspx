<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="MemberManagement.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    


<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
    <!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <h1>회원관리</h1>
        <h4>* 은 필수기입</h4>
        <hr />
        <br />
        <table border="1">
            <tr>
                <th>사번</th>
                <td colspan ="4"><asp:TextBox ID="pNo" runat="server" ReadOnly="true" /></td>
            </tr>   
            
            <tr>
                <th>*성명</th>
                <td><asp:TextBox ID="username" runat="server"/></td>
                <th>*주민번호</th>
                <td><asp:TextBox ID="front_SSNumber" runat="server" />-</td>
                <td><asp:TextBox ID="back_SSNumber" runat="server" TextMode="Password"/></td>
            </tr>

            <tr>
                <th>이메일</th>
                <td><asp:TextBox ID="email" runat="server"/></td>
                <th>전화번호</th>
                <td colspan="2"><asp:TextBox ID="phone" runat="server"/></td>
            </tr>

            <tr>
                <th>주소</th>
                <td><asp:TextBox ID="psCode" runat="server"/>&nbsp</td>
                <td colspan="3"><asp:TextBox ID="address" runat="server"/></td>
            </tr>

            <tr>
                <th>*부서</th>
                <td>
                <asp:DropDownList ID="dep" runat="server">
                </asp:DropDownList></td>
                <th>*직위</th>
                <td>
                <asp:DropDownList ID="position" runat="server">
                </asp:DropDownList></td>
            </tr>
        </table>
        
        <asp:Button ID="BtnNew" runat="server" OnClick="BtnNew_Click" Text="신규" Height="37px" />
        <asp:Button ID="BtnSave" runat="server" OnClick="BtnSave_Click" Text="저장" Height="37px" />
        <asp:Button ID="BtnDelete" runat="server" OnClick="BtnDelete_Click" Text="삭제" Height="37px" />
        
        
            <asp:GridView ID="GridView1" runat="server" 
                OnRowCommand="GridView1_RowCommand"
                AutoGenerateColumns="False" DataKeyNames="사번" 
                DataSourceID="SqlDataSource2" Height="197px" Width="465px" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="사번">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" Text='<%# Eval("사번").ToString() %>' CommandArgument='<%# Eval("사번").ToString() %>'
                                CommandName="selectNumber"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="성명" HeaderText="성명" SortExpression="성명" />
                    <asp:BoundField DataField="주민번호" HeaderText="주민번호" SortExpression="주민번호" />
                    <asp:BoundField DataField="부서" HeaderText="부서" SortExpression="부서" />
                    <asp:BoundField DataField="직위" HeaderText="직위" SortExpression="직위" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MyConnectionString %>" SelectCommand="SELECT [사번], [성명], [주민번호], [부서], [직위] FROM [회원관리]"></asp:SqlDataSource>
        
    </form>

    <script>

        var getMail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        var getFN = RegExp(/^[0-9]{6,6}$/);
        var getBN = RegExp(/^[0-9]{7,7}$/);
        var getPhone = RegExp(/^[0-9]+$/);
        var getpCode = RegExp(/^[0-9]{4,5}$/);




        $(document).ready(function () {
            $('#<%= BtnSave.ClientID %>').on('click', function () {

                
           

                var username = $('#<%= username.ClientID %>').val();
                var frontNum = $('#<%= front_SSNumber.ClientID %>').val();
                var backNum = $('#<%= back_SSNumber.ClientID %>').val();
                var cEmail = $('#<%= email.ClientID %>').val();
                var cPhone = $('#<%= phone.ClientID %>').val();
                var cPsCode = $('#<%= psCode.ClientID %>').val();
                var cDep = $('#<%= dep.ClientID %>').val();
                var cPosition = $('#<%= position.ClientID %>').val();

                

                
                //성명
                if (username == "") {
                    alert('성명을 입력하세요.');
                    return false;
                }
                //주민번호
                if (!getFN.test(frontNum)) {
                    alert('주민번호 앞자리가 올바르지않습니다.');
                    return false;
                }
                if (!getBN.test(backNum)) {
                    alert('주민번호 뒷자리가 올바르지않습니다.');
                    return false;
                }
                //이메일
                if (!getMail.test(cEmail)) {
                    alert('이메일 형식에 맞게 입력하세요.');
                    return false;
                }
                //전화번호
                if (!getPhone.test(cPhone)) {
                    alert('전화번호 형식에 맞게 입력하세요.');
                    return false;
                }
                //우편번호
                if (!getpCode.test(cPsCode)) {
                    alert('우편번호 형식에 맞게 입력하세요.');
                    return false;
                }
               
                //부서
                if (cDep == '--선택--') {
                    alert('부서를 입력하세요');
                    return false;
                }
                //직위
                if (cPosition == '--선택--') {
                    alert('직위를 입력하세요.');
                    return false;
                }

              });
          });
    </script>

</body>
</html>
