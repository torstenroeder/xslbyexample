<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:ecrm="http://erlangen-crm.org/current/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

	<!-- Quelldokument: 20_basetext-persNames-ids.xml -->

	<xsl:output indent="yes"/>

	<xsl:template match="/">
		<xsl:result-document indent="yes" method="xml" byte-order-mark="yes" href="52_relations.xml"
			encoding="UTF-8">
			<RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
				xmlns:ecrm="http://erlangen-crm.org/current/">
				<xsl:apply-templates/>
			</RDF>
		</xsl:result-document>
	</xsl:template>
	
	<xsl:template match="text//persName[@ref]">
		<Description rdf:about="{/TEI/teiHeader/fileDesc/sourceDesc/bibl/ref}">
			<ecrm:P67_refers_to>
				<xsl:variable name="PERSON" select="document('42_listPerson-dates.xml')//person[@xml:id=current()/@ref]"/>
				<xsl:choose>
					<xsl:when test="$PERSON/idno[@type='GND']">
						<xsl:text>http://d-nb.info/gnd/</xsl:text>
						<xsl:value-of select="$PERSON/idno"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- falls keine GND vorhanden ist, einfach den Namen als Zeichenkette einfügen -->
						<xsl:value-of select="normalize-space($PERSON/persName)"/>
					</xsl:otherwise>
				</xsl:choose> 
			</ecrm:P67_refers_to>
		</Description>
	</xsl:template>
	
	<!-- ignore all text nodes -->
	<xsl:template match="text()"/>

</xsl:stylesheet>
