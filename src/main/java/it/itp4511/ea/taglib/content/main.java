package it.itp4511.ea.taglib.content;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class main extends SimpleTagSupport {

    StringWriter sw = new StringWriter();

    public void doTag() throws JspException, IOException {
        getJspBody().invoke(sw);
        String html =
                "<div class=\"main-content\">" +
                "    <div class=\"header-area\">" +
                "        <div class=\"row align-items-center\">" +
                "            <!--Nav Button-->" +
                "            <div class=\"col-md-6 col-sm-8 clearfix\">" +
                "                <div class=\"nav-btn pull-left\">" +
                "                    <span></span>" +
                "                    <span></span>" +
                "                    <span></span>" +
                "                </div>" +
                "                <!--Directory-->" +
                "                <h4 class=\"page-title pull-left\">View Order</h4>" +
                "                <ul class=\"breadcrumbs pull-left\">" +
                "                    <li><a href=\"\">Order</a></li>" +
                "                    <li><span>View Order</span></li>" +
                "                </ul>" +
                "            </div>" +
                "            <!--User Profile-->" +
                "            <div class=\"col-md-6 col-sm-4 clearfix\">" +
                "                <ul class=\"notification-area pull-right\">" +
                "                    <ul class=\"user-profile pull-right\">" +
                "                        <h4 class=\"user-name dropdown-toggle\" data-bs-toggle=\"dropdown\" id=\"username\"><%-- name --%>" +
                "                            <i class=\"fa fa-angle-down\"></i></h4>" +
                "                        <div class=\"dropdown-menu\">" +
                "                            <a class=\"dropdown-item\" href=\"logout\" id=\"logout\">Log Out</a>" +
                "                        </div>" +
                "                    </ul>" +
                "                </ul>" +
                "            </div>" +
                "        </div>" +
                "    </div>" +
                "    <!--Main-->" +
                "    <div class=\"main-content-inner\">" +
                sw.toString() +
                "    </div>" +
                "</div>";
        getJspContext().getOut().println(html);
    }
}
