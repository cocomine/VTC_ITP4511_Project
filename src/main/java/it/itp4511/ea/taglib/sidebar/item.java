package it.itp4511.ea.taglib.sidebar;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class item extends SimpleTagSupport {

    private boolean active = false;
    private String href;
    StringWriter sw = new StringWriter();

    public void setActive(boolean active) {
        this.active = active;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public void doTag() throws IOException, JspException {
        getJspBody().invoke(sw);
        String html = active ? "<li class=\"active\"><a href=\"" + href + "\">" + sw.toString() + "</a></li>" : "<li><a href=\"" + href + "\">" + sw.toString() + "</a></li>";
        getJspContext().getOut().println(html);
    }
}
