package core.generator;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import core.model.Entity;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapperBuilder;
import freemarker.template.Template;
import freemarker.template.Version;

public class DAOimplGenerator {
	public File generateDAOimplCode(Entity entity){
		try {
		//String relativelyPath= this.getClass().getResource(".").getFile().toString();  
		//System.out.println(relativelyPath);
		 File f = new File(this.getClass().getResource("/").getPath() + "template");
         System.out.println(f);
		//File f = new File("../" + relativelyPath + "template");
		// File f = new File("template");
         //System.out.println(f.getAbsolutePath());

            Configuration cfg = new Configuration(new Version("2.3.22"));
            // 指定模板文件从何处加载的数据源，这里设置成一个文件目录
            cfg.setDirectoryForTemplateLoading(new File(this.getClass().getResource("/").getPath() + "template"));
            
           
            cfg.setObjectWrapper(new DefaultObjectWrapperBuilder(new Version("2.3.22")).build());
             
            // 获取或创建模板
            Template template = cfg.getTemplate("daoimpl.ftl");
             
            // 将模板和数据模型合并 输出到Console
            
            String packageSubPath = entity.getJavaPackage().replace('.', '/');
            File packagePath = new File("/Users/Water/Documents/JavaWorkspace4/mbmp/src/", packageSubPath);
            File file = new File(packagePath, entity.getClassName() + "DAOimpl.java");
            if(!packagePath.exists()){
            	packagePath.mkdirs();
            }
            
            //Writer out = new OutputStreamWriter(System.out);
            Map<String, Object> root = new HashMap<String, Object>();
            root.put("entity", entity);
            if(file != null){
                Writer javaWriter = new FileWriter(file);
                template.process(root, javaWriter);
                javaWriter.flush();
                System.out.println(file.getCanonicalPath());
                javaWriter.close();
            }
            return file;
        } 
		 catch (Exception e) {
            e.printStackTrace();
        }
		return null;	
	}
}
