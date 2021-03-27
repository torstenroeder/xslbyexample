<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">

	<!-- Quelldokument: 00_example.xml -->
	
	<xsl:output indent="yes" method="xml" encoding="UTF-8"/>
	
	<xsl:template match="/">
		<xsl:result-document method="xml" encoding="UTF-8" href="20_result.xml">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="body//text()">
		<xsl:analyze-string select="." regex="[0-9]{{4}}">
			<xsl:matching-substring>
				<date resp="autodetect">
					<xsl:value-of select="."/>
				</date>
			</xsl:matching-substring>
			<xsl:non-matching-substring>
				<xsl:value-of select="."/>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
	</xsl:template>

	<!-- identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>
