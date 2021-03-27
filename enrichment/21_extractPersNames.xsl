<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">

	<!-- Quelldokument: 16_basetext-persNames-ids.xml -->

	<xsl:template match="/">
		<!-- Resultat der Transformation in eine Datei schreiben -->
		<xsl:result-document indent="yes" method="xml" byte-order-mark="yes"
			href="22_listPerson.xml" encoding="UTF-8">
			<!-- TEI-Dokument erzeugen -->
			<TEI xmlns="http://www.tei-c.org/ns/1.0">
				<teiHeader>
					<fileDesc>
						<titleStmt>
							<title>Register</title>
						</titleStmt>
						<publicationStmt>
							<p>unpublished</p>
						</publicationStmt>
						<sourceDesc>
							<p>born digital</p>
						</sourceDesc>
					</fileDesc>
				</teiHeader>
				<text>
					<body>
						<!-- andere Templates aufrufen -->
						<xsl:apply-templates/>
					</body>
				</text>
			</TEI>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="TEI">
		<listPerson>
			<xsl:apply-templates/>
		</listPerson>
	</xsl:template>

	<xsl:template match="persName">
		<person xml:id="{@ref}">
			<persName>
				<xsl:value-of select="."/>
			</persName>
		</person>
	</xsl:template>

	<!--<xsl:template match="persName">
		<person>
			<xsl:attribute name="xml:id">
				<xsl:value-of select="@ref"/>
			</xsl:attribute>
			<persName>
				<xsl:value-of select="."/>
			</persName>
		</person>
	</xsl:template>-->
	
	<!-- ignore all text nodes -->
	<xsl:template match="text()"/>

</xsl:stylesheet>
