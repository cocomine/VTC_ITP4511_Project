package it.itp4511.ea.taglib.content;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;

public class scriptPath extends SimpleTagSupport {

    private String path;

    public void setPath(String path) {
        this.path = path;
    }

    public void doTag() throws IOException, JspException {
        String html = "\"" + path + "\",";
        getJspContext().getOut().println(html);
    }
}
