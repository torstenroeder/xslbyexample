<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="xs" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0">

	<!-- Ausgabe als HTML -->
	<xsl:output method="html"/>

	<!-- Wurzelbehandlung -->
	<xsl:template match="/">
		<!-- Ergebnis in eine Datei schreiben -->
		<xsl:result-document href="apparatus_C.html">
			<html>
				<body>
					<!-- HTML Abschnitt -->
					<div>
						<!-- HTML Überschrift -->
						<h1>Text</h1>
						<!-- Templates aufrufen mit Modus "text" -->
						<xsl:apply-templates mode="text"/>
					</div>
					<!-- HTML Abschnitt -->
					<div>
						<!-- HTML Überschrift -->
						<h1>Apparatus (<xsl:value-of
								select="/TEI/teiHeader/encodingDesc/variantEncoding/@method"/>)</h1>
						<!-- Templates aufrufen mit Modus "app" -->
						<xsl:apply-templates mode="app"/>
					</div>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>

	<!-- TEI-Header komplett ignorieren -->
	<xsl:template match="teiHeader" mode="#all"/>

	<!-- im Modus "text": Apparateinträge mitten im Fließtext ausgeben -->
	<xsl:template match="app" mode="text">
		<!-- HTML Unterstreichung -->
		<u>
			<!-- Reading-Template aufrufen -->
			<!-- aber einschränken auf Witness D1! -->
			<xsl:apply-templates mode="text" select="rdg[@wit = '#D1']"/>
		</u>
		<xsl:text>[</xsl:text>
		<!-- Zählung des Eintrags ausgeben -->
		<xsl:number count="app"/>
		<xsl:text>]</xsl:text>
	</xsl:template>

	<!-- im Modus "text": Absatz -->
	<xsl:template match="p" mode="text">
		<!-- HTML Absatz -->
		<p>
			<!-- alle Templates im Modus "text" aufrufen -->
			<xsl:apply-templates mode="text"/>
		</p>
	</xsl:template>

	<!-- im Modus "text": Reading -->
	<xsl:template match="rdg" mode="text">
		<!-- Reading-Text ausgeben -->
		<xsl:value-of select="."/>
	</xsl:template>

	<!-- im Modus "app": Apparateintrag -->
	<xsl:template match="app" mode="app">
		<!-- HTML Absatz -->
		<p>
			<!-- HTML fett -->
			<b>
				<!-- Zählung des Eintrags ausgeben -->
				<xsl:number count="app"/>
			</b>
			<xsl:text> </xsl:text>
			<!-- Reading-Template aufrufen -->
			<xsl:apply-templates mode="app" select="rdg"/>
		</p>
	</xsl:template>

	<!-- im Modus "app": Reading -->
	<xsl:template match="rdg" mode="app">
		<xsl:text> </xsl:text>
		<!-- Reading-Text ausgeben -->
		<xsl:value-of select="."/>
		<xsl:text> </xsl:text>
		<!-- Witness-Template aufrufen -->
		<xsl:apply-templates mode="app" select="@wit"/>
	</xsl:template>

	<!-- im Modus "app": Reading ohne Inhalt -->
	<xsl:template match="rdg[. = '']" mode="app">
		<!-- Geviertstrich setzen -->
		<xsl:text> – </xsl:text>
		<!-- Witness-Template aufrufen -->
		<xsl:apply-templates mode="app" select="@wit"/>
	</xsl:template>

	<!-- im Modus "app": Reading-Witness -->
	<xsl:template match="rdg/@wit" mode="app">
		<!-- HTML kursiv -->
		<i>
			<!-- Sigle ausgeben -->
			<!-- dabei das Hash (#) überspringen -->
			<xsl:value-of select="substring(., 2)"/>
		</i>
	</xsl:template>

	<!-- im Modus "app": Textknoten ignorieren (wegen Whitespace) -->
	<xsl:template match="text()" mode="app"/>

</xsl:stylesheet>
