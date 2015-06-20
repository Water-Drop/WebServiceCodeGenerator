package ${entity.javaPackage};

import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import core.util.JDBCHelper;
import ${entity.javaPackage}.${entity.className};
import ${entity.javaPackage}.${entity.className}DAO;


public class ${entity.className}DAOimpl implements ${entity.className}DAO{
	JDBCHelper jh = new JDBCHelper();
    public List<${entity.className}> getAll${entity.className}s(){
    	Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<${entity.className}> ${entity.className?uncap_first}s = new ArrayList<${entity.className}>();
		try {
			conn = jh.getConnection();
			ps = conn.prepareStatement("SELECT <#list entity.properties as property>${property.propertyName}<#if property_has_next>,</#if></#list> FROM ${entity.javaPackage}_${entity.className} WHERE _status!=2");
			rs = ps.executeQuery();
			while (rs.next()){
				${entity.className} ${entity.className?uncap_first} = new ${entity.className}();
				<#list entity.properties as property>
				${entity.className?uncap_first}.set${property.propertyName?cap_first}(rs.get<#if property.javaType?cap_first == "Integer">Int<#else>${property.javaType?cap_first}</#if>("${property.propertyName}"));
				</#list>
				${entity.className?uncap_first}s.add(${entity.className?uncap_first});
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jh.close(conn);
		}
    	return ${entity.className?uncap_first}s;
    }
    public ${entity.className} get${entity.className?cap_first}ById(Integer id){
    	Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
    	${entity.className} ${entity.className?uncap_first} = new ${entity.className}();
		try {
			conn = jh.getConnection();
			ps = conn.prepareStatement("SELECT <#list entity.properties as property>${property.propertyName}<#if property_has_next>,</#if></#list> FROM ${entity.javaPackage}_${entity.className} WHERE _id=? AND _status!=2");
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if (rs.first() != false){
				<#list entity.properties as property>
				${entity.className?uncap_first}.set${property.propertyName?cap_first}(rs.get<#if property.javaType?cap_first == "Integer">Int<#else>${property.javaType?cap_first}</#if>("${property.propertyName}"));
				</#list>
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jh.close(conn);
		}
    	return ${entity.className?uncap_first};
    }
    public Integer add${entity.className?cap_first}(${entity.className} ${entity.className?uncap_first}){
        Connection conn = null;
		PreparedStatement ips = null;
		PreparedStatement sps = null;
		ResultSet rs = null;
		Integer newid = -1;
		try {
			conn = jh.getConnection();
			conn.setAutoCommit(false);
			ips = conn.prepareStatement("INSERT INTO ${entity.javaPackage}_${entity.className} (<#list entity.properties as property>${property.propertyName}<#if property_has_next>,</#if></#list>) VALUES (<#list entity.properties as property>?<#if property_has_next>,</#if></#list>)");
			<#list entity.properties as property>
			ips.set<#if property.javaType?cap_first == "Integer">Int<#else>${property.javaType?cap_first}</#if>(${property_index+1},${entity.className?uncap_first}.get${property.propertyName?cap_first}());
			</#list>
			sps = conn.prepareStatement("SELECT LAST_INSERT_ID()");
			ips.execute();
			rs = sps.executeQuery();
			conn.commit();
			conn.setAutoCommit(true);
			rs.last();
			Integer count = rs.getRow();
			if (count != 0){
				rs.first();
				newid = Integer.parseInt(rs.getBigDecimal(1).toString());
				}
			} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException sqle) {
				sqle.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			jh.close(conn);
		}
		return newid;
    }
    public Integer delete${entity.className?cap_first}ById(Integer id){
    	Connection conn = null;
		PreparedStatement ps = null;
		Integer rtn = -1;
		try {
			conn = jh.getConnection();
			ps = conn.prepareStatement("UPDATE ${entity.javaPackage}_${entity.className} SET _status=2 WHERE _id=?");
			ps.setInt(1, id);
			Integer num = ps.executeUpdate();
			if (num == 0){
				rtn = 1;
			} else {
				rtn = 0;
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			jh.close(conn);
		}
		return rtn;
    }
}