<%! String title = "Your Booking"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../function/head.jsp"%>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld"%>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu href="${pageContext.request.contextPath}">
    <sidebar:parentItem name="Venue Booking" active="true">
        <sidebar:item href="${pageContext.request.contextPath}">Book Venue</sidebar:item> <!--All user can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/yourBooking.jsp" active="true">Your Booking</sidebar:item> <!--All user can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Venue Management">
        <sidebar:item href="${pageContext.request.contextPath}/venue">View Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/create">Create Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="${pageContext.request.contextPath}/venue/booking">View Booking</sidebar:item> <!--Only Admin and Operator can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management">
        <sidebar:item href="${pageContext.request.contextPath}/admin/account">View Account</sidebar:item>
        <sidebar:item href="${pageContext.request.contextPath}/admin/account/create">Create Account</sidebar:item>
    </sidebar:parentItem>
    <sidebar:parentItem name="Operating Data">
        <sidebar:item href="analyticAndReport.jsp">Analytic/Report</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Venue Management</a></li>
            <li><span>Your Booking</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Order List Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <div class="card-body">
                        <h4 class="header-title">Booking List</h4>
                        <div class="data-tables datatable-dark">
                            <table id="dataTable" class="text-center">
                                <thead class="text-capitalize">
                                <tr>
                                    <th>Booking ID</th>
                                    <th>Member's Name</th>
                                    <th>Member's Email</th>
                                    <th>Guest List</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Oscar</td>
                                    <td>ccc@abc.com</td>
                                    <td>
                                        <button type="button" class="btn btn-secondary btn-lg btn-rounded me-2" data-bs-toggle="modal" data-bs-target="#exampleModal">See More</button>

                                        <div class="modal fade modal-xl" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Guest List</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form method="" action="">
                                                            <div class="data-tables datatable-dark">
                                                                <table id="dataTable3" class="text-center">
                                                                    <thead class="text-capitalize">
                                                                    <tr>
                                                                        <th>Guest's name</th>
                                                                        <th>Guest's email</th>
                                                                        <th>Action</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <tr>
                                                                        <td>Ada Chan</td>
                                                                        <td>ccc@abc.com</td>
                                                                        <td><i class="ti-close" style="color:red;"></i></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Happy Ho</td>
                                                                        <td>ccc@happy.com</td>
                                                                        <td><i class="ti-close" style="color:red;"></i></td>
                                                                    </tr>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                            <div class="col-lg-6 col-ml-12">
                                                                <div class="row">
                                                                    <div class="col-12 mt-5">
                                                                        <div class="card">
                                                                            <div class="card-body">
                                                                                <div class="form-group">
                                                                                    <label for="guestName" class="col-form-label">Guest's Name:</label>
                                                                                    <input type="text" class="form-control" id="guestName" value="">
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <label for="guestEmail" class="col-form-label">Guest's Email:</label>
                                                                                    <input class="form-control" type="email" value="" id="guestEmail">
                                                                                </div></br>
                                                                                <button type="button" class="btn btn-secondary btn-lg btn-rounded me-2">Add New Guest</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>

                                    <td><i class="ti-pencil"></i><i class="ti-trash" style="color: red;"></i></td>
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

<%@ include file="../function/footer.jsp"%>
