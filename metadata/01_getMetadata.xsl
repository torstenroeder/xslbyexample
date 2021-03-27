<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">

	<!-- Quelldokument: 00_template.xml -->
	<!-- Zieldokument: 10_response.xml -->

	<xsl:output indent="yes"/>

	<xsl:variable name="europeanaBase">https://api.europeana.eu/record/v2/search.json</xsl:variable>

	<xsl:variable name="wskey">*********</xsl:variable>

	<xsl:variable name="query">Gutzkow</xsl:variable>

	<xsl:variable name="url">
		<xsl:value-of select="$europeanaBase"/>
		<xsl:text>?wskey=</xsl:text>
		<xsl:value-of select="$wskey"/>
		<xsl:text>&amp;query=</xsl:text>
		<xsl:value-of select="$query"/>
	</xsl:variable>

	<xsl:template match="TEI/text//p[1]">
		<xsl:result-document href="10_response.xml" indent="yes">
			<xsl:variable name="response" select="json-to-xml(unparsed-text($url))"/>
			<xsl:sequence select="$response"/>
		</xsl:result-document>
	</xsl:template>

	<!-- identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
