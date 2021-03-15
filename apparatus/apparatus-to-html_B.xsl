<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0">

	<!-- Ausgabe als HTML -->
	<xsl:output method="html"/>

	<!-- Wurzelbehandlung -->
	<xsl:template match="/">
		<!-- Ergebnis in eine Datei schreiben -->
		<xsl:result-document href="apparatus_B.html">
			<html>
				<body>
					<!-- Templates aufrufen, aber nur für <body> -->
					<xsl:apply-templates select="/TEI/text/body"/>
					<!-- Templates aufrufen, aber nur für <back> -->
					<xsl:apply-templates select="/TEI/text/back"/>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>

	<!-- TEI-Header komplett ignorieren -->
	<xsl:template match="teiHeader"/>

	<!-- Text-Bereich -->
	<xsl:template match="body">
		<!-- HTML Abschnitt -->
		<div>
			<!-- HTML Überschrift -->
			<h1>Text</h1>
			<!-- alle Templates aufrufen -->
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- Seitenanfang -->
	<xsl:template match="pb">
		<!-- HTML neue Zeile -->
		<br/>
		<!-- HTML fett -->
		<b>
			<xsl:text>[</xsl:text>
			<!-- Seitennummer ausgeben -->
			<xsl:value-of select="@n"/>
			<xsl:text>]</xsl:text>
		</b>
	</xsl:template>

	<!-- Zeilenanfang -->
	<xsl:template match="lb">
		<!-- HTML neue Zeile -->
		<br/>
		<!-- Zeilennummer ausgeben -->
		<xsl:value-of select="@n"/>
		<xsl:text> </xsl:text>
	</xsl:template>

	<!-- Apparatus-Bereich -->
	<xsl:template match="back">
		<!-- HTML Abschnitt -->
		<div>
			<!-- HTML Überschrift -->
			<h1>Apparatus (<xsl:value-of
					select="/TEI/teiHeader/encodingDesc/variantEncoding/@method"/>)</h1>
			<!-- alle Templates aufrufen -->
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- Apparat-Eintrag -->
	<xsl:template match="app">
		<!-- HTML Absatz -->
		<p>
			<!-- Anker im Text identifizieren -->
			<xsl:variable name="a1" select="substring(@from, 2)"/>
			<xsl:variable name="a2" select="substring(@to, 2)"/>
			<!-- Position ausgeben: Template für ersten Anker aufrufen -->
			<xsl:apply-templates mode="app" select="id($a1)"/>
			<xsl:text> </xsl:text>
			<!-- jetzt den Text zwischen beiden Ankern ausgeben -->
			<xsl:value-of
				select="//text()[preceding::anchor[@xml:id = $a1] and following::anchor[@xml:id = $a2]]"/>
			<xsl:text>]</xsl:text>
			<!-- Reading-Template aufrufen -->
			<xsl:apply-templates select="rdg"/>
		</p>
	</xsl:template>

	<!-- im Modus "app": Position des Ankers ausgeben -->
	<xsl:template match="anchor" mode="app">
		<!-- HTML fett -->
		<b>
			<!-- Angabe von Seite und Zeile -->
			<!-- Nummer des vorhergehenden <pb> ermitteln -->
			<xsl:value-of select="preceding::pb[1]/@n"/>
			<xsl:text>.</xsl:text>
			<!-- Nummer des vorhergehenden <lb> ermitteln -->
			<xsl:value-of select="preceding::lb[1]/@n"/>
		</b>
	</xsl:template>

	<!-- Reading -->
	<xsl:template match="rdg">
		<xsl:text> </xsl:text>
		<!-- Reading-Text ausgeben -->
		<xsl:value-of select="."/>
		<xsl:text> </xsl:text>
		<!-- Witness-Template aufrufen -->
		<xsl:apply-templates select="@wit"/>
	</xsl:template>

	<!-- Reading ohne Text -->
	<xsl:template match="rdg[. = '']">
		<!-- Geviertstrich setzen -->
		<xsl:text> – </xsl:text>
		<!-- Witness-Template aufrufen -->
		<xsl:apply-templates select="@wit"/>
	</xsl:template>

	<!-- Reading-Witness -->
	<xsl:template match="rdg/@wit">
		<!-- HTML kursiv -->
		<i>
			<!-- Sigle ausgeben -->
			<!-- dabei das Hash (#) überspringen -->
			<xsl:value-of select="substring(., 2)"/>
		</i>
	</xsl:template>

</xsl:stylesheet>
