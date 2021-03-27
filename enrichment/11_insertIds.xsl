<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">

	<!-- Quelldokument: 10_basetext-persNames.xml -->
	
	<xsl:template match="/">
		<xsl:result-document indent="yes" method="xml" byte-order-mark="yes"
			href="20_basetext-persNames-ids.xml" encoding="UTF-8">
			<xsl:apply-templates select="@* | node()"/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="TEI/text//persName">
		<!-- ID vergeben -->
		<persName ref="{generate-id()}">
			<xsl:apply-templates select="@* | node()"/>
		</persName>
	</xsl:template>

	<!-- identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
