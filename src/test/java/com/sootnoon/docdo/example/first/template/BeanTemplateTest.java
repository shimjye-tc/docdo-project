package com.sootnoon.docdo.example.first.template;

public class BeanTemplateTest {
	/* multiline-comment-trick-value
	// $docdo-ts={"id":"com.sootnoon.docdo.example.first.BeanTest"}
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
	// $docdo-te
	*/
}
