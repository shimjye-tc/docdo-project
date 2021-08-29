package com.sootnoon.docdo.example.second.template;

public class BeanTemplateToTest {
	/* multiline-comment-trick-value
	// $docdo-ts={"id":"com.sootnoon.docdo.example.second.BeanToTest"}
package ${packageName};

<#if imports?has_content>
<#list imports as item>
import ${item};
</#list>
</#if>

public class ${className} {

<#if types?has_content>
<#list types as item>
	private ${item.type} ${item.name} = ${item.init};
</#list>
</#if>

<#if types?has_content>
<#list types as item>
	public void set${item.name?cap_first}(${item.type} ${item.name}) {
		this.${item.name} = ${item.name};
	}
	
	public ${item.type} get${item.name?cap_first}() {
		return ${item.name};
	}
</#list>
</#if>

	public String toString() {
		return new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").create().toJson(this);
	}
}
	// $docdo-te
	*/
}
