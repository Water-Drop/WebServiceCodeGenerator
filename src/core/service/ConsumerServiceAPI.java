package core.service;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import net.sf.json.JSONObject;

@Path("/ConsumerRestService")
public class ConsumerServiceAPI {
	@Context HttpServletRequest req; 
	@Path("/ConsumerRestAPI")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	public String PublicRestAPIHandler(String param){
		String rtn = "";
		Map<String, String> map = new HashMap<String, String>();
		try {  
			JSONObject json_param = JSONObject.fromObject(param);
			String bizClassName = json_param.getString("bizcname");
			String bizMethodName = json_param.getString("bizmname");
			String mParam = json_param.getString("mparam");
			
			String userIdentifier = json_param.getString("userIdentifier");
			JSONObject mObject = JSONObject.fromObject(mParam);

			bizClassName = userIdentifier + "." + bizClassName + "Service";
	        Class<?> bizClass = Class.forName(bizClassName);  
	        Method bizMethod =  bizClass.getMethod(bizMethodName, Class.forName("java.lang.String")) ;
	        rtn = bizMethod.invoke(bizClass.newInstance(), mObject.toString()).toString();
	    } catch (ClassNotFoundException e) { 
	    	map.put("status", "-101");
	    	map.put("msg", "Class not found exception.");
	    	rtn = map.toString();
	    } catch (NoSuchMethodException e) {  
	    	map.put("status", "-102");
	    	map.put("msg", "No such method exception.");
	    	rtn = map.toString();
	    } catch (Exception e) {
	    	map.put("status", "-100");
	    	map.put("msg", e.getMessage());
	    	rtn = map.toString();
	    }
		return rtn;
	}  
}
