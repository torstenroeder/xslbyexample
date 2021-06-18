<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml">

	<!-- this writes the output into a file -->
	<xsl:template match="/">
		<xsl:result-document href="example4.html" method="xhtml" encoding="utf-8">
			<xsl:apply-templates/>
		</xsl:result-document>
	</xsl:template>

	<!-- this imports the HTML code from Zotero -->
	<xsl:template match="*:div[@id = 'zotero']">
		<xsl:apply-templates mode="htmlNamespace"
			select="document('https://api.zotero.org/groups/354807/collections/QA4642MV/items/top?format=bib&amp;style=geistes-und-kulturwissenschaften-heilmann&amp;linkwrap=1')"
		/>
	</xsl:template>

	<!-- this is required to import xml with empty namespace -->
	<xsl:template match="*" mode="htmlNamespace">
		<xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates mode="htmlNamespace"/>
		</xsl:element>
	</xsl:template>

	<!-- this copies all elements from the template -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
