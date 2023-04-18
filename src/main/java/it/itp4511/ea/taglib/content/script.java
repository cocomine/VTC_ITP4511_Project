package it.itp4511.ea.taglib.content;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class script extends SimpleTagSupport {

    StringWriter sw = new StringWriter();

    public void doTag() throws IOException, JspException {
        getJspBody().invoke(sw);
        String html = "<script>const load_script = [" + sw.toString() + "]</script>";
        getJspContext().getOut().println(html);
    }
}
