package core.model;

public class Property {
	private String javaType;
	private String propertyName;
	public Property(String javaType, String propertyName) {
		super();
		this.javaType = javaType;
		this.propertyName = propertyName;
	}	
	public String getJavaType() {
		return javaType;
	}
	public void setJavaType(String javaType) {
		this.javaType = javaType;
	}
	public String getPropertyName() {
		return propertyName;
	}
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
}
