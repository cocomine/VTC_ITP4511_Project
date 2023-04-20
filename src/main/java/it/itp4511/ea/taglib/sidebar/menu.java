package it.itp4511.ea.taglib.sidebar;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;

import java.io.IOException;
import java.io.StringWriter;

public class menu extends SimpleTagSupport {

    StringWriter sw = new StringWriter();
    private String href;

    public void setHref(String href) {
        this.href = href;
    }

    public void doTag() throws IOException, JspException {
        getJspBody().invoke(sw);
        String html =
                "<div class=\"sidebar-menu\">\n" +
                "    <div class=\"sidebar-header\">\n" +
                "        <div class=\"logo\">\n" +
                "            <a href=\"" + href + "\">EPL</a>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "    <div class=\"main-menu\">\n" +
                "        <div class=\"menu-inner\">\n" +
                "            <nav>\n" +
                "                <ul class=\"metismenu\" id=\"menu\">\n" +
                sw.toString() +
                "                </ul>\n" +
                "            </nav>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "</div>";
        getJspContext().getOut().println(html);
    }
}
