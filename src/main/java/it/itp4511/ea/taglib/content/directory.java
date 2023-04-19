package it.itp4511.ea.taglib.content;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class directory extends SimpleTagSupport {

    private String pageTitle;
    StringWriter sw = new StringWriter();

    public void setPageTitle(String pageTitle) {
        this.pageTitle = pageTitle;
    }

    public void doTag() throws JspException, IOException {
        getJspBody().invoke(sw);
        String html =
                "<div class=\"col-sm-6\">" +
                "   <div class=\"breadcrumbs-area clearfix\">" +
                "       <h4 class=\"page-title pull-left\">" + pageTitle + "</h4>" +
                "       <ul class=\"breadcrumbs pull-left\">" +
                sw.toString() +
                "       </ul>" +
                "    </div>" +
                "</div>";
        getJspContext().getOut().println(html);
    }
}
