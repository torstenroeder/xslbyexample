<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">

	<!-- Quelldokument: 40_listPerson-gnds.xml -->

	<xsl:template match="/">
		<xsl:result-document indent="yes" method="xml" byte-order-mark="yes"
			href="42_listPerson-dates.xml" encoding="UTF-8">
			<xsl:apply-templates/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="person[idno[@type='GND']]">
		<!-- URL für LOBID-Abfrage zusammensetzen -->
		<xsl:variable name="URL" select="concat('http://lobid.org/gnd/', idno[1], '?format=json')"/>
		<!-- Suchergebnis als JSON holen -->
		<xsl:variable name="RESPONSE" select="json-to-xml(unparsed-text($URL))"/>
		<xsl:variable name="BIRTH"
			select="$RESPONSE/*:map/*:array[@key = 'dateOfBirth']/*:string/text()"/>
		<xsl:variable name="DEATH"
			select="$RESPONSE/*:map/*:array[@key = 'dateOfDeath']/*:string/text()"/>
		<person>
			<!-- vorhandene Attribute und Elemente kopieren -->
			<xsl:apply-templates select="@* | node()"/>
			<!-- wurden Daten gefunden? -->
			<xsl:choose>
				<xsl:when test="$BIRTH != '' or $DEATH != ''">
					<!-- Geburtsdatum einfügen -->
					<xsl:if test="$BIRTH != ''">
						<birth resp="lobid">
							<xsl:value-of select="$BIRTH"/>
						</birth>
					</xsl:if>
					<!-- Sterbedatum einfügen -->
					<xsl:if test="$DEATH != ''">
						<death resp="lobid">
							<xsl:value-of select="$DEATH"/>
						</death>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- XML-Kommentar anfügen -->
					<xsl:comment>no date of birth found</xsl:comment>
				</xsl:otherwise>
			</xsl:choose>
			<!-- XML-Kommentar anfügen -->
			<xsl:comment>
				<xsl:text>data import source: </xsl:text>
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
