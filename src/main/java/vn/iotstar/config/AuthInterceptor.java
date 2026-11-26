package vn.iotstar.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import vn.iotstar.entity.User;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");

        if (account == null) {
            String uri = request.getRequestURI();
            response.sendRedirect("/login?redirect=" + uri);
            return false;
        }

        if (!"ADMIN".equalsIgnoreCase(account.getRole())) {
            response.sendRedirect("/?error=access_denied");
            return false;
        }

        return true;
    }
}
