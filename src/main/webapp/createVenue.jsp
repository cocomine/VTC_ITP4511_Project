<%! String title = "Create Venue"; %>
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
        <sidebar:item href="viewVenue.jsp">View Venue</sidebar:item> <!--Only Admin and Operator can see-->
        <sidebar:item href="createVenue.jsp" active="true">Create Venue</sidebar:item> <!--Only Admin and Operator can see-->
    </sidebar:parentItem>
    <sidebar:parentItem name="Account Management">
        <sidebar:item href="viewAccount.jsp">View Account</sidebar:item> <!--Only Admin can see-->
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
            <li><span>Create Venue</span></li>
        </content:directory>
        <content:profile username="${user.username}"/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Create Account Form Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <form method="post" action="">
                        <div class="card-body">
                            <h4 class="header-title">Create Venue</h4>

                            <div class="form-group">
                                <label for="createVenueLocation" class="col-form-label">Location</label>
                                <input class="form-control" type="text" value="" id="createVenueLocation">
                            </div>
                            <div class="form-group">
                                <label for="createVenueName" class="col-form-label">Venue Name</label>
                                <input class="form-control" type="text" value="" id="createVenueName">
                            </div></br>

                            <div class="form-group">
                                <label for="createVenueDescription">Venue Description</label>
                                <textarea class="form-control" placeholder="Leave a venue description here" id="createVenueDescription"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="createVenueCapacity" class="col-form-label">Max Capacity</label>
                                <input class="form-control" type="number" value="" id="createVenueCapacity" min="1">
                            </div>

                            <div class="form-group">
                                <label for="createVenueBookingFee" class="col-form-label">Booking Fee</label>
                                <input class="form-control" type="text" value="" id="createVenueBookingFee">
                            </div>

                            <div class="form-group">
                                <label for="createVenueImage" class="col-form-label">Venue Image(Only 1 pic)</label>
                                <input class="form-control" type="file" value="" name="createVenueImage" id="createVenueImage">
                            </div>

                            <div align="right">
                                <button type="submit" class="btn btn-primary btn-lg btn-rounded me-2">Submit</button>
                                <button type="reset" class="btn btn-primary btn-lg btn-rounded me-2">Reset</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<%@ include file="function/footer.jsp"%>
