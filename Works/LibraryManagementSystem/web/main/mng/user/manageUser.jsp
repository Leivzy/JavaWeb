<%--

  管理员 管理用户页面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="conn.Dao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" href="../../../css/styles5.css">
</head>
<body>
<%
    //==========判断是否已经登录且为管理员登录==========//
    String account = (String) session.getAttribute("account");
    if (account == null || !account.equals("Admin")) {
        // 如果未登录，重定向到错误页面
        response.sendRedirect("../../../jumpJsp/Error1.jsp");
        return;
    }
%>
<%--定义用户表格的开头--%>
<table border="1" class="custom-table">
    <caption>用户管理</caption>
    <tr>
        <td>ID</td>
        <td>账号</td>
        <td>名称</td>
        <td>借阅数量</td>
        <td class="special-td">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>

    <%
        Dao dao = new Dao();//创建Dao对象
        Connection con = dao.connection();//获得连接对象

        Statement stat = con.createStatement();
        String sql = "SELECT id, account,name,count,password FROM user WHERE type = 'nom'";
        ResultSet rs = stat.executeQuery(sql);//执行sql语句，并将获取到值放入rs集合
//==========通过循环，将rs集合中（数据库中）的值取出来并放到表格中==========//
        while (rs.next()) {
            String userID = rs.getString("id");//获取数据库中本次循环得到的的用户编号
            String userAccount = rs.getString("account");//获取数据库中本次循环得到的用户账号
            String userName = rs.getString("name");//获取数据库中本次循环得到的用户名称
            String userCount = rs.getString("count");//获取数据库中本次循环得到的用户借阅数量
            String userPassword = rs.getString("password");//获取数据库中本次循环得到的用户密码
    %>
    <tr>
        <td><%=userID%></td>
        <td><%=userAccount%></td>
        <td><%=userName%></td>
        <td><%=userCount%>本</td>
        <%--创建链接，点击链接跳转到horrowHandle.jsp页，并发送no和name的值--%>
        <td class="special-td">
            <a class="custom-button"
               href="returnBooks/userBooks.jsp?userID=<%=userID%>&userName=<%=userName%>">管理借阅</a></td>
        <td class="special-td"> <a class="custom-button"
               href="../../share/editProfile.jsp?nomID=<%=userID%>&nomName=<%=userName%>&nomPassword=<%=userPassword%>&nomAccount=<%=userAccount%>">修改资料</a></td>
        <td class="special-td"> <a class="custom-button"
               href="delete/deleteUser.jsp?nomID=<%=userID%>">删除用户</a></td>
    </tr>
    <%
        }
    %>
</table>
<%--//返回链接--%>
<%--    <a href="mngHome.jsp">返回</a>--%>
<div class="button-container">
    <%--    <button class="custom-button" >按钮1</button>--%>
    <a class="custom-button" href="../mngHome.jsp">返回</a>
    <a class="custom-button" href="add/addUser.html">创建新用户</a>

</div>

</body>
</html>
