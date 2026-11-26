package vn.iotstar.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Gán default decorator nếu không có path cụ thể
        builder.addDecoratorPath("/*", "web.jsp")
                // Map decorator cho đường dẫn admin
                .addDecoratorPath("/admin/*", "/admin.jsp")
                // Loại trừ các đường dẫn xác thực và API khỏi SiteMesh decorator
                .addExcludedPath("/login*").addExcludedPath("/login/*")
                .addExcludedPath("/register*").addExcludedPath("/register/*")
                .addExcludedPath("/alogin*").addExcludedPath("/alogin/*")
                .addExcludedPath("/api/**").addExcludedPath("/api/**");
    }
}
