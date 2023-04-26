package it.itp4511.ea.taglib.content;

import it.itp4511.ea.bean.UserBean;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.PageContext;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;

public class profile extends SimpleTagSupport {



    public void doTag() throws JspException, IOException {
        PageContext pageContext = (PageContext) getJspContext();
        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

        UserBean user = (UserBean) request.getSession().getAttribute("user");
        String html =
                "<div class=\"col-md-6 col-sm-4 clearfix\">" +
                "    <ul class=\"notification-area pull-right\">" +
                "        <ul class=\"user-profile pull-right\">" +
                "            <h4 class=\"user-name dropdown-toggle\" data-bs-toggle=\"dropdown\" id=\"username\">" + user.getUsername() +
                "                <i class=\"fa fa-angle-down\"></i></h4>" +
                "            <div class=\"dropdown-menu\">" +
                "                <a class=\"dropdown-item\" href=\""+ request.getContextPath() +"/logout\" id=\"logout\">Log Out</a>" +
                "            </div>" +
                "        </ul>" +
                "    </ul>" +
                "</div>";
        getJspContext().getOut().println(html);
    }
}
