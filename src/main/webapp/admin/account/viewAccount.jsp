<%! String title = "View Staff"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../function/head.jsp"%>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu href="${pageContext.request.contextPath}">
    <sidebar:parentItem name="Order">
        <sidebar:item href="viewOrder">View Order</sidebar:item>
        <sidebar:item href="createOrder">Create Order</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management" active="true">
        <sidebar:item href="${pageContext.request.contextPath}/admin/account" active="true">View Account</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/admin/account/create">Create Account</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Operating Data">
        <sidebar:item href="analyticAndReport.jsp">Analytic/Report</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Account Management</a></li>
            <li><span>View Account</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Account List</h4>
                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Account ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Position</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Ada Chan</td>
                                    <td>ccc@abc.com</td>
                                    <td>97684664</td>
                                    <td>Admin</td>
                                    <td><i class="ti-pencil"></i><i class="ti-trash" style="color:red;"></i></td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Una Lee</td>
                                    <td>una@abc.com</td>
                                    <td>97585721</td>
                                    <td>Staff</td>
                                    <td><i class="ti-pencil"></i><i class="ti-trash" style="color:red;"></i></td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>Brendon Au</td>
                                    <td>brendon@gmail.com</td>
                                    <td>97556721</td>
                                    <td>Customer</td>
                                    <td><i class="ti-pencil"></i><i class="ti-trash" style="color:red;"></i></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<%@ include file="../../function/footer.jsp"%>
