<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs fn" version="2.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns="http://www.tei-c.org/ns/1.0">

	<!-- Quelldokument: 00_template.xml -->
	<!-- Zieldokument: 20_response.xml -->

	<xsl:output indent="yes"/>

	<xsl:template match="/">
		<xsl:result-document href="20_response.xml" indent="yes">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="TEI/text//p[1]">
		<xsl:variable name="response" select="document('10_response.xml')"/>
		<list>
			<xsl:for-each select="$response/fn:map/fn:array[@key = 'items']/fn:map/fn:array[@key = 'dcCreator']/fn:string">
				<xsl:sort select="."/>
				<item source="{../../fn:string[@key='id']}">
					<xsl:value-of select="text()"/>
				</item>
			</xsl:for-each>
		</list>
	</xsl:template>

	<!-- identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
