package ${entity.javaPackage};
 
public class ${entity.className} <#if entity.superclass?has_content>extends ${entity.superclass}</#if>{
	<#--properties-->
	<#list entity.properties as property>
    private ${property.javaType} ${property.propertyName};
	</#list> 
	private Integer _status; 
	private Integer _id; 
	
	<#--constructors--> 
	<#if entity.constructors>
    public ${entity.className}() {    
    }
    public ${entity.className}(<#list entity.properties as property>${property.javaType} ${property.propertyName}<#if property_has_next>, </#if></#list>) {
    <#list entity.properties as property>
    	this.${property.propertyName} = ${property.propertyName};
    </#list>
    }
	</#if>

	public Integer get_id() {
    	return _id;
    }
    public void set_id(Integer _id) {
    	this._id = _id;
    }
	<#--getter and setter--> 
	<#list entity.properties as property>
    public ${property.javaType} get${property.propertyName?cap_first}() {
        return ${property.propertyName};
    }
    public void set${property.propertyName?cap_first}(${property.javaType} ${property.propertyName}) {
        this.${property.propertyName} = ${property.propertyName};
    }
    </#list>
    public Integer get_status() {
    	return _status;
    }
    public void set_status(Integer _status) {
    	this._status = _status;
    }
}
