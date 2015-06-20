package core.util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.tools.JavaCompiler;
import javax.tools.JavaCompiler.CompilationTask;
import javax.tools.JavaFileObject;
import javax.tools.StandardJavaFileManager;
import javax.tools.ToolProvider;

public class CompilerHelper {
	public Integer compilerJavaFile(List<File> files){
		JavaCompiler javac=ToolProvider.getSystemJavaCompiler(); 
	    StandardJavaFileManager javafile=javac.getStandardFileManager(null, null, null);  
	    Iterable<? extends JavaFileObject> units=javafile.getJavaFileObjectsFromFiles(files);
        List<String> options = new ArrayList<String>();  
        options.add("-classpath");  
        options.add(this.getClass().getResource("/").toString() 
        		+ ":" + this.getClass().getResource("/").toString().replace("classes/", "") + "lib/json-lib-2.2.3-jdk13.jar");
        CompilationTask t=javac.getTask(null, javafile, null, options, null, units);  
	    t.call();  
	    try {
	    	javafile.close();  
	    } catch (IOException e) {
	    	e.printStackTrace();
	    	}
	    return 0;
	}
}
