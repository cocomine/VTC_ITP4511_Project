package it.itp4511.ea.taglib.content;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class header extends SimpleTagSupport {

    StringWriter sw = new StringWriter();

    public void doTag() throws JspException, IOException {
        getJspBody().invoke(sw);
        String html =
                "<div class=\"page-title-area\">" +
                "   <div class=\"row align-items-center\">" +
                sw.toString() +
                "   </div>" +
                "</div>";
        getJspContext().getOut().println(html);
    }
}
