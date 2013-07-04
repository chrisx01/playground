<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:ws="http://schemas.xmlsoap.org/wsdl/" xmlns:ws2="http://www.w3.org/ns/wsdl" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:local="http://tomi.vanek.sk/xml/wsdl-viewer" version="1.0" xmlns:exclude-result-prefixes="ws ws2 xsd soap local">  
<xsl:strip-space elements="*"/>
   <xsl:param name="ENABLE-OPERATIONS-PARAGRAPH" select="true()"/>   
   <xsl:param name="ENABLE-INOUTFAULT" select="true()"/> 
   <xsl:param name="ENABLE-ANTIRECURSION-PROTECTION" select="true()"/>
   <xsl:param name="ANTIRECURSION-DEPTH">3</xsl:param>
  
   <xsl:variable name="global.wsdl-name" select="/*/*[(local-name() = 'import' or local-name() = 'include') and @location][1]/@location"/>
   <xsl:variable name="consolidated-wsdl" select="/* | document($global.wsdl-name)/*"/>
   <xsl:variable name="global.xsd-name" select="($consolidated-wsdl/*[local-name() = 'types']//xsd:import[@schemaLocation] | $consolidated-wsdl/*[local-name() = 'types']//xsd:include[@schemaLocation])[1]/@schemaLocation"/>
   <xsl:variable name="consolidated-xsd" select="(document($global.xsd-name)/xsd:schema/xsd:*|/*/*[local-name() = 'types']/xsd:schema/xsd:*)[local-name() = 'complexType' or local-name() = 'element']"/>
   <xsl:variable name="consolidated-xsd-type" select="(document($global.xsd-name)/xsd:schema/xsd:*|/*/*[local-name() = 'types']/xsd:schema/xsd:*)[local-name() = 'complexType']"/>
   <xsl:variable name="global.service-name" select="concat($consolidated-wsdl/ws:service/@name, $consolidated-wsdl/ws2:service/@name)"/>
   <xsl:variable name="global.binding-name" select="concat($consolidated-wsdl/ws:binding/@name, $consolidated-wsdl/ws2:binding/@name)"/>
<!--
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Begin of included transformation: wsdl-viewer-util.xsl
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
-->
<xsl:template match="@*" mode="qname.normalized">
	<xsl:variable name="local" select="substring-after(., ':')"/>
	     <xsl:choose>
			<xsl:when test="$local">
				<xsl:value-of select="$local"/>
			</xsl:when>
		    <xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
	     </xsl:choose>
   </xsl:template>
  <xsl:template match="xsd:documentation" mode="operations.message.part"/>
  <xsl:template match="xsd:element[parent::xsd:schema]" mode="operations.message.part">
	    <xsl:param name="anti.recursion"/>
	    <xsl:variable name="recursion.label" select="concat('[', @name, ']')"/>
	    <xsl:variable name="recursion.test">
			<xsl:call-template name="recursion.should.continue">
				<xsl:with-param name="anti.recursion" select="$anti.recursion"/>
			    <xsl:with-param name="recursion.label" select="$recursion.label"/>
		    </xsl:call-template>
	    </xsl:variable>
	    <xsl:choose>
		<xsl:when test="string-length($recursion.test) != 0">
			<xsl:variable name="type-name">
				<xsl:call-template name="xsd.element-type"/>
            </xsl:variable>
			<xsl:variable name="elem-type" select="$consolidated-xsd[generate-id() != generate-id(current()) and $type-name and @name=$type-name and contains(local-name(), 'Type')][1]"/>
			<xsl:if test="$type-name != @name">		
				<xsl:apply-templates select="*" mode="operations.message.part">
					<xsl:with-param name="anti.recursion" select="concat($anti.recursion, $recursion.label)"/>
				</xsl:apply-templates>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
		</xsl:otherwise>
	    </xsl:choose>
	</xsl:template>
	<xsl:template match="xsd:attribute" mode="checkAttributes">
	
	    <xsl:choose>
			<xsl:when test="string-length(@name) &gt; 0 ">
				<xsl:if test="position()&lt;=1"><xsl:text>?</xsl:text>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="xsd:documentation" mode="checkAttributes"/>
	<xsl:template match="xsd:documentation" mode="attributes"/>
	<xsl:template match="xsd:attribute" mode="attributes"><xsl:text> </xsl:text><xsl:value-of select="@name"/> ="?" </xsl:template>
	<xsl:template match="xsd:element" mode="operations.message.part">
		<xsl:param name="anti.recursion"/>
		<xsl:if test="@minOccurs='0'"><xsl:text>&lt;!--Optional:--&gt;</xsl:text></xsl:if><xsl:text>&lt;urn:</xsl:text>
		<xsl:variable name="type-name"><xsl:call-template name="xsd.element-type"/></xsl:variable> 
		<xsl:variable name="part-type-3" select="$consolidated-xsd-type[@name = $type-name and not(xsd:simpleType)][1]"/>
		<xsl:variable name="local-ref" select="concat(@name, substring-after(@ref, ':'))"/>
		<xsl:variable name="elem-name">
			<xsl:choose>
				<xsl:when test="@name"><xsl:value-of select="@name"/>
					<xsl:apply-templates select="$part-type-3" mode="attributes"><xsl:sort select="@name"/></xsl:apply-templates>
					<xsl:text>&gt;</xsl:text>
				</xsl:when>
				<xsl:when test="$local-ref"><xsl:value-of select="$local-ref"/><xsl:text>&gt;</xsl:text></xsl:when>
				<xsl:when test="@ref"><xsl:value-of select="@ref"/><xsl:text>&gt;</xsl:text></xsl:when>
				<xsl:otherwise><xsl:text>anonymous</xsl:text></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="$elem-name"/>
		<xsl:variable name="elem-type" select="$consolidated-xsd[@name = $type-name and not(xsd:simpleType) and  contains(local-name(), 'Type')][1]"/>	
			<xsl:choose>
				<xsl:when test="$elem-type">
					<xsl:variable name="part-type-4" select="$consolidated-xsd-type[@name = $elem-type/@name][1]"/>
					<xsl:apply-templates select="$part-type-4" mode="checkAttributes"/></xsl:when>
					<xsl:otherwise><xsl:text>?</xsl:text></xsl:otherwise></xsl:choose>
					<xsl:apply-templates select="$elem-type | *" mode="operations.message.part">
						<xsl:with-param name="anti.recursion" select="$anti.recursion"/>
					</xsl:apply-templates>
					<xsl:choose>
						<xsl:when test="@name">
							<xsl:text>&lt;/urn:</xsl:text><xsl:value-of select="@name"/><xsl:text>&gt;</xsl:text>
						</xsl:when>
						<xsl:when test="$local-ref"><xsl:text>&lt;/urn:</xsl:text><xsl:value-of select="$local-ref"/>&gt;</xsl:when>
						<xsl:when test="@ref"><xsl:text>&lt;/urn:</xsl:text><xsl:value-of select="@ref"/>&gt;</xsl:when>
						<xsl:otherwise><xsl:text>anonymous</xsl:text></xsl:otherwise>
					</xsl:choose>
	</xsl:template>
	<xsl:template match="xsd:attribute[ @*[local-name() = 'arrayType'] ]" mode="operations.message.part">
		<xsl:param name="anti.recursion"/>
	    <xsl:variable name="array-local-name" select="substring-after(@*[local-name() = 'arrayType'], ':')"/>
	    <xsl:variable name="type-local-name" select="substring-before($array-local-name, '[')"/>
	    <xsl:variable name="array-type" select="$consolidated-xsd[@name = $type-local-name][1]"/>
		<xsl:variable name="recursion.label" select="concat('[', $type-local-name, ']')"/>
	    <xsl:variable name="recursion.test">
			<xsl:call-template name="recursion.should.continue">
				<xsl:with-param name="anti.recursion" select="$anti.recursion"/>
				<xsl:with-param name="recursion.label" select="$recursion.label"/>
		    </xsl:call-template>
	    </xsl:variable>
	    <xsl:choose>
	        <xsl:when test="string-length($recursion.test) != 0">
				<xsl:apply-templates select="$array-type" mode="operations.message.part">
					<xsl:with-param name="anti.recursion" select="concat($anti.recursion, $recursion.label)"/>
			    </xsl:apply-templates>
		    </xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="xsd.element-type">
	    <xsl:variable name="ref-or-type">
			<xsl:choose>
				<xsl:when test="@type">
					<xsl:value-of select="@type"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@ref"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="type-local-name" select="substring-after($ref-or-type, ':')"/>
	    <xsl:variable name="type-name">
			<xsl:choose>
				<xsl:when test="$type-local-name">
					<xsl:value-of select="$type-local-name"/>
				</xsl:when>
				<xsl:when test="$ref-or-type">
					<xsl:value-of select="$ref-or-type"/>
				</xsl:when>
				<xsl:otherwise><xsl:text>undefined</xsl:text></xsl:otherwise>
			</xsl:choose>
	    </xsl:variable>
	    <xsl:value-of select="$type-name"/>
	</xsl:template> 
    <xsl:template match="*" mode="render-type"/>
	<xsl:template match="xsd:element | xsd:complexType | xsd:simpleType | xsd:complexContent" mode="render-type">
	    <xsl:param name="anti.recursion"/>
	    <xsl:apply-templates select="*" mode="render-type">
			<xsl:with-param name="anti.recursion" select="$anti.recursion"/>
	    </xsl:apply-templates>
	</xsl:template>
	<xsl:template match="xsd:restriction[ parent::xsd:simpleType ]" mode="render-type">
	    <xsl:param name="anti.recursion"/>
	    <xsl:variable name="type-local-name" select="substring-after(@base, ':')"/>
	    <xsl:variable name="type-name">
			<xsl:choose>
				<xsl:when test="$type-local-name">
					<xsl:value-of select="$type-local-name"/>
				</xsl:when>
				<xsl:when test="@base">
					<xsl:value-of select="@base"/>
				</xsl:when>
				<xsl:otherwise><xsl:text>undefined</xsl:text></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:text> - </xsl:text>
			<!-- <xsl:call-template name="render-type.write-name">
				   <xsl:with-param name="type-local-name" select="$type-local-name"/>
			 </xsl:call-template>-->
		<xsl:text> with </xsl:text>
		<xsl:value-of select="local-name()"/>
		<xsl:apply-templates select="*" mode="render-type">
			<xsl:with-param name="anti.recursion" select="$anti.recursion"/>
		</xsl:apply-templates>
    </xsl:template>
	<xsl:template match="xsd:simpleType/xsd:restriction/xsd:*[not(self::xsd:enumeration)]" mode="render-type">
	     <!--<xsl:text> </xsl:text>-->
	     <xsl:value-of select="local-name()"/>
	     <xsl:text>(</xsl:text>
	     <xsl:value-of select="@value"/>
	     <xsl:text>)</xsl:text>
	</xsl:template>
	<xsl:template match="/">	     
	     <xsl:call-template name="body.render"/>	    
	</xsl:template> 


   <!--
==================================================================
	Rendering: HTML body
==================================================================
-->

	<xsl:template name="body.render">   
		<xsl:call-template name="content.render"/>	           
	</xsl:template>

   <!--
==================================================================
	Rendering: content
==================================================================
-->

	<xsl:template name="content.render">
		<xsl:if test="$ENABLE-OPERATIONS-PARAGRAPH">
			<xsl:call-template name="operations.render"/>
	    </xsl:if>
	</xsl:template>      
   <!--
==================================================================
	Rendering: WSDL operations - detail
==================================================================
-->

	<xsl:template name="operations.render">
     	<xsl:apply-templates select="$consolidated-wsdl/ws:portType" mode="operations">
			<xsl:sort select="@name"/>
		</xsl:apply-templates>      
	</xsl:template>
	<xsl:template match="ws:portType" mode="operations">
		<xsl:text>&lt;soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="</xsl:text> 
		<xsl:value-of select="$consolidated-wsdl/@targetNamespace"/><xsl:text>"&gt;</xsl:text>		
		<!--Operation use for replacing name for dynamic -->
        <xsl:apply-templates select="ws:operation[@name='OperationName']" mode="operations">
			<xsl:sort select="@name"/>
        </xsl:apply-templates>
		<xsl:text>&lt;/soapenv:Body&gt;</xsl:text>
		<xsl:text>&lt;/soapenv:Envelope&gt;</xsl:text>
		
	    <xsl:text>&lt;soapAction&gt;</xsl:text>	
			<xsl:value-of select="$consolidated-wsdl/ws:binding/ws:operation[@name='OperationName']/soap:operation/@soapAction"/> 
		<xsl:text>&lt;/soapAction&gt;</xsl:text>			
    </xsl:template>
	<xsl:template match="ws:operation" mode="operations">
	    <xsl:variable name="binding-info" select="$consolidated-wsdl/ws:binding[@type = current()/../@name or substring-after(@type, ':') = current()/../@name]/ws:operation[@name = current()/@name]"/>
		<xsl:apply-templates select="ws:input" mode="operations.message">
			<xsl:with-param name="binding-data" select="$binding-info"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="ws:input" mode="operations.message">
	    <xsl:param name="binding-data"/>
	    <xsl:if test="$ENABLE-INOUTFAULT">
			<xsl:variable name="msg-local-name" select="substring-after(@message, ':')"/>
			<xsl:variable name="msg-name">
				<xsl:choose>
					<xsl:when test="$msg-local-name">
						<xsl:value-of select="$msg-local-name"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@message"/>
					</xsl:otherwise>
				</xsl:choose>
		    </xsl:variable>
			<xsl:variable name="msg" select="$consolidated-wsdl/ws:message[@name = $msg-name]"/>			   
			<xsl:choose>
				<xsl:when test="$msg">
					<xsl:apply-templates select="$msg" mode="operations.message">
						<xsl:with-param name="binding-data" select="$binding-data/ws:*[local-name(.) = local-name(current())]/*"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
   
	<xsl:template match="ws:message" mode="operations.message">  
		<xsl:param name="binding-data"/>
		<xsl:if test="$binding-data">
			<xsl:text>&lt;soapenv:Header&gt;</xsl:text>
			
			<xsl:for-each select="$binding-data">
				<xsl:if test="local-name(current())='header'">								
					<xsl:variable name="part" select="@part"/>
					<xsl:if test="$part">
						<xsl:text>&lt;urn:</xsl:text>
						<xsl:value-of select="$part"/>
						<xsl:text>&gt;</xsl:text>
						
						<xsl:variable name="part-type" select="$consolidated-xsd[@name = $part and not(xsd:simpleType)][1]"/>
						<xsl:apply-templates select="$part-type" mode="operations.message.part"/>
						<xsl:text>&lt;/urn:</xsl:text>
						<xsl:value-of select="$part"/>
						<xsl:text>&gt;</xsl:text>
						
					</xsl:if>
				</xsl:if>
			</xsl:for-each>					
		</xsl:if>
		<xsl:text>&lt;/soapenv:Header&gt;</xsl:text>
		<xsl:text>&lt;soapenv:Body&gt;</xsl:text> 
	    <xsl:apply-templates select="ws:part" mode="operations.message"/>
	</xsl:template>
   
    <xsl:template match="ws:part" mode="operations.message">
		<xsl:text>&lt;urn:</xsl:text><xsl:value-of select="substring-after(@element, ':')"/>&gt;
		<xsl:choose>
			<xsl:when test="string-length(@name) &gt; 0">
				<xsl:variable name="elem-or-type">
					<xsl:choose>
						<xsl:when test="@type"/>
						<xsl:otherwise><xsl:value-of select="@element"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="type-local-name" select="substring-after($elem-or-type, ':')"/>
				<xsl:variable name="type-name">
					<xsl:choose>
						<xsl:when test="$type-local-name"><xsl:value-of select="$type-local-name"/></xsl:when>
						<xsl:when test="$elem-or-type"><xsl:value-of select="$elem-or-type"/></xsl:when>
						<xsl:otherwise>unknown</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="part-type" select="$consolidated-xsd[@name = $type-name and not(xsd:simpleType)][1]"/>
				<xsl:variable name="part-type-2" select="$consolidated-xsd-type[@name = $type-name and not(xsd:simpleType)][1] "/>
				<xsl:choose>
					<xsl:when test="$part-type/@type !=''">
						<xsl:apply-templates select="$part-type-2" mode="operations.message.part"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="$part-type" mode="operations.message.part"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&lt;/urn:</xsl:text>
		<xsl:value-of select="substring-after(@element, ':')"/>
		<xsl:text>&gt;</xsl:text>   
	</xsl:template>
	<xsl:template name="recursion.should.continue">
		<xsl:param name="anti.recursion"/>
	    <xsl:param name="recursion.label"/>
	    <xsl:param name="recursion.count">1</xsl:param>
	    <xsl:variable name="has.recursion" select="contains($anti.recursion, $recursion.label)"/>
	    <xsl:variable name="anti.recursion.fragment" select="substring-after($anti.recursion, $recursion.label)"/>
	    <xsl:choose>
			<xsl:when test="$recursion.count &gt; $ANTIRECURSION-DEPTH"/>
			<xsl:when test="not($ENABLE-ANTIRECURSION-PROTECTION) or string-length($anti.recursion) = 0 or not($has.recursion)">
				<xsl:text>1</xsl:text>
		    </xsl:when>
		</xsl:choose>
	</xsl:template>    
</xsl:stylesheet>