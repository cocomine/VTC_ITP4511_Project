package it.itp4511.ea.taglib.sidebar;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class parentItem extends SimpleTagSupport {

    private boolean active = false;
    private String name;
    StringWriter sw = new StringWriter();

    public void setActive(boolean active) {
        this.active = active;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void doTag() throws IOException, JspException {
        getJspBody().invoke(sw);
        String html;
        if(active){
            html =
                    "<li class=\"active\">" +
                    "    <a href=\"javascript:void(0)\" aria-expanded=\"true\"><span>" + name + "</span></a>" +
                    "    <ul class=\"collapse\">" +
                    sw.toString() +
                    "    </ul>" +
                    "</li>";
        }else {
            html =
                    "<li>" +
                    "    <a href=\"javascript:void(0)\" aria-expanded=\"false\"><span>" + name + "</span></a>" +
                    "    <ul class=\"collapse\">" +
                    sw.toString() +
                    "    </ul>" +
                    "</li>";
        }
        getJspContext().getOut().println(html);
    }
}
