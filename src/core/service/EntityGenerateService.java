package core.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import core.generator.DAOGenerator;
import core.generator.DAOimplGenerator;
import core.generator.EntityGenerator;
import core.generator.ServiceGenerator;
import core.model.Entity;
import core.model.Property;
import core.util.CompilerHelper;

@Path("/generate")
public class EntityGenerateService {
	@Context HttpServletRequest req; 
	EntityGenerator eg = new EntityGenerator();
	DAOGenerator dg = new DAOGenerator();
	DAOimplGenerator dig = new DAOimplGenerator();
	ServiceGenerator sg = new ServiceGenerator();
	CompilerHelper ch = new CompilerHelper();
	@Path("/entity")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String  generateEntity(){
		Entity entity = new Entity();
		entity.setJavaPackage("sharon");
		//entity.setSuperclass(superclass);
		entity.setClassName("User");
		entity.setConstructors(true);
		List<Property> properties = new ArrayList<Property>();
		properties.add(new Property("Integer", "userID"));
		properties.add(new Property("String", "userName"));
		properties.add(new Property("Integer", "password"));
		entity.setProperties(properties);
		File ef = eg.generateEntityCode(entity);
		File df = dg.generateDAOCode(entity);
		File dif = dig.generateDAOimplCode(entity);
		File sf = sg.generateServiceCode(entity);
		List<File> files = new ArrayList<File>();
		files.add(ef);
		files.add(df);
		files.add(dif);
		files.add(sf);
		ch.compilerJavaFile(files);
		return "";
	}
}
