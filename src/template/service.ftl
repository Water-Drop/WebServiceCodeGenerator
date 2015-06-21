package ${entity.javaPackage};

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import ${entity.javaPackage}.${entity.className};
import ${entity.javaPackage}.${entity.className}DAO;
import ${entity.javaPackage}.${entity.className}DAOimpl;

public class ${entity.className}Service{
    ${entity.className}DAO ${entity.className?uncap_first}Dao = new ${entity.className}DAOimpl();
    public String getAll${entity.className}s(String param){
        Integer status = -1;
        Map<String, String> map = new HashMap<String, String>();
        List<${entity.className}> ${entity.className?uncap_first}s = ${entity.className?uncap_first}Dao.getAll${entity.className}s();
        if (${entity.className?uncap_first}s.size() > 0){
			status = 0;
			List<String> e_jsons = new ArrayList<String>();
			for (int i = 0; i < ${entity.className?uncap_first}s.size(); i++){
			Map<String, String> e_map = new HashMap<String, String>();
        	<#list entity.properties as property>
            	e_map.put("${property.propertyName}",${entity.className?uncap_first}s.get(i).get${property.propertyName?cap_first}().toString());
			</#list>
			JSONObject e_json = JSONObject.fromObject(e_map);
			e_jsons.add(e_json.toString());
      	    }
      	    JSONArray jsonArray = JSONArray.fromObject(e_jsons);
			map.put("${entity.className}s", jsonArray.toString());
      	} else {
      		status = 1;
      	}
		map.put("status", status.toString());
		JSONObject json = JSONObject.fromObject(map);
		return json.toString();
    }
    public String get${entity.className?cap_first}ById(String param){
    	Integer status = -1;
    	Map<String, String> map = new HashMap<String, String>();
		JSONObject paramjson = JSONObject.fromObject(param);
		${entity.className} ${entity.className?uncap_first} = new ${entity.className}();
		${entity.className?uncap_first} = ${entity.className?uncap_first}Dao.get${entity.className?cap_first}ById(paramjson.getInt("${entity.className?uncap_first}Id"));
	  	if (${entity.className?uncap_first}.get_status() != 2) {//_status = 2 means no such entity for the id
	  		status = 0;
	  		<#list entity.properties as property>
	  		map.put("${property.propertyName}",${entity.className?uncap_first}.get${property.propertyName?cap_first}().toString());
   			</#list>
	  	} else {
			status = 1;// no such entity for the id
			}
		map.put("status", status.toString());
		JSONObject json = JSONObject.fromObject(map);
		return json.toString();	
    }
    public String add${entity.className?cap_first}(String param){
    	Integer status = -1;
		Integer ${entity.className?uncap_first}id = -1;
		JSONObject paramjson = JSONObject.fromObject(param);
		${entity.className} ${entity.className?uncap_first} = new ${entity.className}();
		<#list entity.properties as property>
			${entity.className?uncap_first}.set${property.propertyName?cap_first}(paramjson.get<#if property.javaType?cap_first == "Integer">Int<#else>${property.javaType?cap_first}</#if>("${property.propertyName}"));
   		</#list>
   		${entity.className?uncap_first}id = ${entity.className?uncap_first}Dao.add${entity.className?cap_first}(${entity.className?uncap_first});
		if (${entity.className?uncap_first}id > 0){
			status = 0;
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("status", status.toString());
		map.put("${entity.className?uncap_first}id", ${entity.className?uncap_first}id.toString());
		JSONObject json = JSONObject.fromObject(map);
		return json.toString();
    }
    public String modify${entity.className?cap_first}(String param){
    	Integer status = -1;
		JSONObject paramjson = JSONObject.fromObject(param);
		${entity.className} ${entity.className?uncap_first} = new ${entity.className}();
		<#list entity.properties as property>
			${entity.className?uncap_first}.set${property.propertyName?cap_first}(paramjson.get<#if property.javaType?cap_first == "Integer">Int<#else>${property.javaType?cap_first}</#if>("${property.propertyName}"));
   		</#list>
   		status = ${entity.className?uncap_first}Dao.modify${entity.className?cap_first}(${entity.className?uncap_first});
		Map<String, String> map = new HashMap<String, String>();
		map.put("status", status.toString());	
		JSONObject json = JSONObject.fromObject(map);
		return json.toString();
    }
    public String delete${entity.className?cap_first}(String param){
    	Integer status = -1;
		JSONObject paramjson = JSONObject.fromObject(param);
		status = ${entity.className?uncap_first}Dao.delete${entity.className?cap_first}(paramjson.getInt("${entity.className?uncap_first}Id"));
		Map<String, String> map = new HashMap<String, String>();
		map.put("status", status.toString());
		JSONObject json = JSONObject.fromObject(map);
		return json.toString();
    }
}