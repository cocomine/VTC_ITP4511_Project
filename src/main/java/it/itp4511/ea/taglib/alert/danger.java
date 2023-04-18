package it.itp4511.ea.taglib.alert;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class danger extends SimpleTagSupport {

        private boolean display;
        StringWriter sw = new StringWriter();

        public void setDisplay(boolean display) {
            this.display = display;
        }

        public void doTag() throws IOException, JspException {
            if(!display) return;

            getJspBody().invoke(sw);
            String html = "<div class=\"alert alert-danger\" role=\"alert\"><i class=\"fa fa-warning me-2\"></i>" + sw.toString() + "</div>";
            getJspContext().getOut().println(html);
        }
}
