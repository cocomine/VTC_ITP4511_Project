<%! String title = "View Venue"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="function/head.jsp"%>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Venue Booking">
        <sidebar:item href="index.jsp">Book Venue</sidebar:item> <!--All user can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Venue Management" active="true">
        <sidebar:item href="viewVenue.jsp" active="true">View Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="createVenue.jsp">Create Venue</sidebar:item> <!--Only Admin and Operator can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management">
        <sidebar:item href="viewAccount.jsp">View Account</sidebar:item> <!--Only Admin  can see-->
        <sidebar:item href="createAccount.jsp">Create Account</sidebar:item> <!--Only Admin can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Operating Data">
        <sidebar:item href="analyticAndReport.jsp">Analytic/Report</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Venue Management</a></li>
            <li><span>View Venue</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Venue List</h4>
                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Venue Image</th>
                                    <th>Venue ID</th>
                                    <th>Location</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Max Capacity</th>
                                    <th>Booking Fee</th>
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
                                    <td>Admin</td>
                                    <td>Admin</td>
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

<%@ include file="function/footer.jsp"%>
