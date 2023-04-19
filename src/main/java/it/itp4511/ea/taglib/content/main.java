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
                "   <div class=\"header-area\">" +
                "       <div class=\"row align-items-center\">" +
                "           <!--Nav Button-->" +
                "           <div class=\"col-md-6 col-sm-8 clearfix\">" +
                "               <div class=\"nav-btn pull-left\">" +
                "                   <span></span>" +
                "                   <span></span>" +
                "                   <span></span>" +
                "               </div>" +
                "           </div>" +
                "       </div>" +
                "   </div>" +
                sw.toString() +
                "</div>";
        getJspContext().getOut().println(html);
    }
}
