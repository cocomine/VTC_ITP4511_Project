package it.itp4511.ea.taglib.alert;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class success extends SimpleTagSupport {

        private boolean display;
        StringWriter sw = new StringWriter();

        public void setDisplay(boolean display) {
            this.display = display;
        }

        public void doTag() throws IOException, JspException {
            if(!display) return;

            getJspBody().invoke(sw);
            String html = "<div class=\"alert alert-success\" role=\"alert\"><i class=\"fa fa-check me-2\"></i>" + sw.toString() + "</div>";
            getJspContext().getOut().println(html);
        }
}
