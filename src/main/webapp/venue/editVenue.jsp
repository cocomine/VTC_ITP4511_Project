<%! String title = "Edit Venue"; %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../function/head.jsp" %>
<%@ taglib prefix="sidebar" uri="/WEB-INF/sidebar.tld" %>
<%@ taglib prefix="content" uri="/WEB-INF/content.tld" %>
<%@ taglib prefix="alert" uri="/WEB-INF/alert.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" type="it.itp4511.ea.bean.UserBean" scope="session"/>

<!--Menu-->
<sidebar:menu>
    <sidebar:parentItem name="Venue Booking">
        <sidebar:item href="/">Book Venue</sidebar:item>
        <sidebar:item href="/booking">Your Booking</sidebar:item>
    </sidebar:parentItem>
    <!--Only Staff can see-->
    <c:if test="${user.role == 1}">
        <sidebar:parentItem name="Venue Management" active="true">
            <sidebar:item href="/venue" active="true">View Venue</sidebar:item>
            <sidebar:item href="/venue/create">Create Venue</sidebar:item>
            <sidebar:item href="/venue/booking">View Booking</sidebar:item>
        </sidebar:parentItem>
    </c:if>
    <!--Only Senior Management can see-->
    <c:if test="${user.role == 2}">
        <sidebar:parentItem name="Account Management">
            <sidebar:item href="/admin/account">View Account</sidebar:item>
            <sidebar:item href="/admin/account/create">Create Account</sidebar:item>
        </sidebar:parentItem>
    </c:if>
    <sidebar:parentItem name="Operating Data">
        <sidebar:item href="analyticAndReport.jsp">Analytic/Report</sidebar:item>
    </sidebar:parentItem>
</sidebar:menu>

<content:main>
    <content:header>
        <content:directory pageTitle="<%=title%>">
            <li><a href="">Venue Management</a></li>
            <li><span>Edit Venue</span></li>
        </content:directory>
        <content:profile/>
    </content:header>

    <content:content>
        <div class="row">
            <!--Create Account Form Start-->
            <div class="col-12 mt-5">
                <div class="card">
                    <form method="post" action="" novalidate class="needs-validation" enctype="multipart/form-data">
                        <div class="card-body">
                            <h4 class="header-title">Create Venue</h4>

                            <jsp:useBean id="error_msg" scope="request" class="java.lang.String"/>
                            <alert:danger display="${!empty error_msg}">
                                ${error_msg}
                            </alert:danger>

                            <jsp:useBean id="success_msg" scope="request" class="java.lang.String"/>
                            <alert:success display="${!empty success_msg}">
                                ${success_msg}
                            </alert:success>

                            <jsp:useBean id="venue" scope="request" class="it.itp4511.ea.bean.VenueBean"/>
                            <c:if test="${!empty venue.id}">
                                <input name="id" type="hidden" value="${venue.id}">
                                <div class="col-12 mb-2">
                                    <label for="location" class="form-label">Location</label>
                                    <input class="form-control" type="text" id="location" name="location"
                                           value="${venue.location}" required maxlength="100">
                                    <div class="invalid-feedback">Please enter a location.</div>
                                </div>
                                <div class="col-12 mb-2">
                                    <label for="name" class="form-label">Venue Name</label>
                                    <input class="form-control" type="text" id="name" name="name" required
                                           maxlength="50" value="${venue.name}">
                                    <div class="invalid-feedback">Please enter a name.</div>
                                </div>
                                <div class="col-12 mb-2">
                                    <label for="description">Venue Description</label>
                                    <textarea class="form-control" placeholder="Leave a venue description here"
                                              id="description" name="description" required
                                              maxlength="200">${venue.description}</textarea>
                                    <div class="invalid-feedback">Please enter a description.</div>
                                </div>

                                <div class="col-12 mb-2">
                                    <label for="max" class="form-label">Max Capacity</label>
                                    <input class="form-control" type="number" id="max" min="1" name="max" required
                                           value="${venue.max}">
                                    <div class="invalid-feedback">Please enter a valid number.</div>
                                </div>

                                <div class="col-12 mb-2">
                                    <label for="fee" class="form-label">Booking Fee</label>
                                    <input class="form-control" type="number" id="fee" name="fee" min="0" step="0.01"
                                           required value="${venue.fee}">
                                    <div class=" invalid-feedback">Please enter a valid fee.
                                    </div>
                                </div>

                                <div class="col-12 mb-2">
                                    <label for="image" class="form-label">Venue Image(Only 1 pic)</label>
                                    <input class="form-control" type="file" name="image" id="image"
                                           accept="image/png, image/jpeg, image/webp">
                                    <small class="">Leave blank if not change.</small>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary btn-rounded me-2">Submit</button>
                                    <button type="reset" class="btn btn-secondary btn-rounded me-2">Reset</button>
                                </div>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </content:content>
</content:main>

<%@ include file="../function/footer.jsp" %>
