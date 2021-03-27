<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">

	<!-- Quelldokument: 32_listPerson-sorted.xml -->

	<xsl:template match="/">
		<xsl:result-document indent="yes" method="xml" byte-order-mark="yes"
			href="34_listPerson-lobid.xml" encoding="UTF-8">
			<xsl:apply-templates/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="person">
		<!-- Namen zusammenfügen mit %20 als Trennzeichen (URL-Kodierung) -->
		<xsl:variable name="QUERY" select="replace(normalize-space(persName), ' ', '%20')"/>
		<!-- URL für LOBID-Suche zusammensetzen -->
		<xsl:variable name="URL"
			select="concat('http://lobid.org/gnd/search?q=',$QUERY,'&amp;filter=%2B(type%3APerson)&amp;format=json')"/>
		<!-- Suchergebnis als JSON holen -->
		<xsl:variable name="RESPONSE" select="json-to-xml(unparsed-text($URL))"/>
		<xsl:variable name="GND"
			select="$RESPONSE/*:map/*:array[@key = 'member']/*:map/*:string[@key = 'gndIdentifier']/text()"/>
		<xsl:variable name="RESULTS" select="$RESPONSE/*:map/*:number[@key = 'totalItems']/text()"/>
		<person>
			<!-- vorhandene Attribute und Elemente kopieren -->
			<xsl:apply-templates select="@* | node()"/>
			<!-- wurden GNDs gefunden? -->
			<xsl:choose>
				<xsl:when test="$GND != ''">
					<!-- alle GNDs einfügen -->
					<xsl:for-each select="$GND">
						<idno type="GND" resp="autocomplete">
							<xsl:text>http://d-nb.info/gnd/</xsl:text>
							<xsl:value-of select="."/>
						</idno>
					</xsl:for-each>
					<!-- falls es mehr als 10 Ergebnisse gibt, die Gesamtzahl ausgeben -->
					<xsl:if test="$RESULTS > 10">
						<xsl:comment>
						<xsl:text>total results: </xsl:text>
						<xsl:value-of select="$RESULTS"/>
					</xsl:comment>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- XML-Kommentar anfügen -->
					<xsl:comment>no GND found</xsl:comment>
				</xsl:otherwise>
			</xsl:choose>
			<!-- XML-Kommentar anfügen -->
			<xsl:comment>
				<xsl:text>autocomplete source: </xsl:text>
				<xsl:value-of select="$URL"/>
			</xsl:comment>
		</person>
	</xsl:template>

	<!-- identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
