package com.hxd.site.listener;

import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.hxd.bean.User;
import com.hxd.site.filter.ShiroCache;

public class OnlineUserListener  implements ServletContextListener,ServletContextAttributeListener,
									HttpSessionListener,HttpSessionAttributeListener {
	
	public static final String APPLCATION_USER_KEY = "ApplcationUser";
	public static final String SESSION_USER_KEY = "SessionUser";
	public static final String SHIRO_KEY = "org.apache.shiro.subject.support.DefaultSubjectContext_PRINCIPALS_SESSION_KEY";
	

	@Override
	public void attributeAdded(HttpSessionBindingEvent se) {	   
		 if (se.getName().equals(SHIRO_KEY)) {
			 System.out.println("@@@### attributeAdded obj=" + se.getValue());
			 
		 }
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent se) {
		if (se.getName().equals(SHIRO_KEY)) {
			User u = ShiroCache.getUser();
			if (u!=null) {
				ShiroCache.onlineUserMap.remove(u.getLoginname());
				System.out.println("###@@@ 当前在线数:"+ShiroCache.onlineUserMap.size());
				System.out.println("###@@@ session移除 loginname="+u.getLoginname());
			}
			
		}
		
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent se) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attributeAdded(ServletContextAttributeEvent scab) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attributeRemoved(ServletContextAttributeEvent scab) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attributeReplaced(ServletContextAttributeEvent scab) {
		// TODO Auto-generated method stub
		
	}
	
	
	public void contextInitialized(ServletContextEvent sce) {
	
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		
	}  

	
	
	
	
}  