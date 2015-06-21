package ${entity.javaPackage};

import java.util.List;
import ${entity.javaPackage}.${entity.className};

public interface ${entity.className}DAO {
    public List<${entity.className}> getAll${entity.className}s();
    public ${entity.className} get${entity.className?cap_first}ById(Integer id);
    public Integer add${entity.className?cap_first}(${entity.className} ${entity.className?uncap_first});
    public Integer delete${entity.className?cap_first}(Integer id);
    public Integer modify${entity.className?cap_first}(${entity.className} ${entity.className?uncap_first});
}