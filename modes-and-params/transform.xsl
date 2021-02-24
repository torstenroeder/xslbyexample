<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">

	<!-- XSLT by Example -->
	<!-- xsl:result-document -->
	<!-- xsl:param und xsl:with-param mit @tunnel -->
	<!-- xsl:template und xsl:apply-templates mit @mode -->

	<!-- Anwendungsfall: -->
	<!-- aus einem Quelldokument vier Derivate erzeugen -->
	<!-- dabei: Dateiformat mit @mode behandeln -->
	<!-- dabei: Editoria mit <param> steuern -->

	<!-- Wurzelknoten: Ausgabedokumente konfigurieren -->
	<xsl:template match="/">
		<!-- HTML 1 -->
		<xsl:result-document method="html" byte-order-mark="yes" omit-xml-declaration="no"
			href="output_1.html" encoding="utf-8">
			<xsl:apply-templates mode="html">
				<xsl:with-param name="KEEP_ORIG" select="true()" tunnel="yes"/>
				<xsl:with-param name="KEEP_LB" select="true()" tunnel="yes"/>
			</xsl:apply-templates>
		</xsl:result-document>
		<!-- HTML 2 -->
		<xsl:result-document method="html" byte-order-mark="yes" omit-xml-declaration="no"
			href="output_2.html" encoding="utf-8">
			<xsl:apply-templates mode="html">
				<xsl:with-param name="KEEP_ORIG" select="false()" tunnel="yes"/>
				<xsl:with-param name="KEEP_LB" select="false()" tunnel="yes"/>
			</xsl:apply-templates>
		</xsl:result-document>
		<!-- PLAIN 1 -->
		<xsl:result-document method="text" byte-order-mark="yes" omit-xml-declaration="yes"
			href="output_1.txt" encoding="utf-8">
			<xsl:apply-templates mode="plain">
				<xsl:with-param name="KEEP_ORIG" select="true()" tunnel="yes"/>
				<xsl:with-param name="KEEP_LB" select="true()" tunnel="yes"/>
			</xsl:apply-templates>
		</xsl:result-document>
		<!-- PLAIN 2 -->
		<xsl:result-document method="text" byte-order-mark="yes" omit-xml-declaration="yes"
			href="output_2.txt" encoding="utf-8">
			<xsl:apply-templates mode="plain">
				<xsl:with-param name="KEEP_ORIG" select="false()" tunnel="yes"/>
				<xsl:with-param name="KEEP_LB" select="false()" tunnel="yes"/>
			</xsl:apply-templates>
		</xsl:result-document>
	</xsl:template>

	<!-- mode #all (inklusiv) -->

	<!-- Originalform / Normalisierte Form -->
	<xsl:template match="choice[orig][reg]" mode="#all">
		<xsl:param name="KEEP_ORIG" tunnel="yes"/>
		<xsl:choose>
			<xsl:when test="$KEEP_ORIG">
				<xsl:apply-templates select="orig"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="reg"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Trennstrich am Zeilenende -->
	<xsl:template match="pc" mode="#all">
		<xsl:param name="KEEP_LB" tunnel="yes"/>
		<xsl:choose>
			<xsl:when test="$KEEP_LB">
				<xsl:apply-templates mode="#current"/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>

	<!-- Whitespace und Linebreaks rausfiltern -->
	<xsl:template match="text()" mode="#all">
		<xsl:analyze-string select="." regex="\n\s*">
			<xsl:matching-substring/>
			<xsl:non-matching-substring>
				<xsl:value-of select="."/>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
	</xsl:template>

	<!-- mode html -->

	<xsl:template match="TEI" mode="html">
		<!-- Dokumenttyp-Deklaration einfügen -->
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;&#xa;</xsl:text>
		<!-- HTML-Gerüst aufbauen -->
		<html>
			<head>
				<title>
					<!-- Titel aus dem TEI-Header holen -->
					<xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/>
				</title>
			</head>
			<body>
				<!-- hier nur Kindelemente von <body> auswerten -->
				<xsl:apply-templates select="text/body/*" mode="#current"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="head" mode="html">
		<h1>
			<xsl:apply-templates mode="#current"/>
		</h1>
	</xsl:template>

	<xsl:template match="p" mode="html">
		<p>
			<xsl:apply-templates mode="#current"/>
		</p>
	</xsl:template>

	<xsl:template match="hi" mode="html">
		<!-- Hervorhebungen wiedergeben -->
		<xsl:choose>
			<xsl:when test="@rend = '#b'">
				<!-- #b entspricht Format 'bold' -->
				<b>
					<xsl:apply-templates mode="#current"/>
				</b>
			</xsl:when>
			<xsl:when test="@rend = '#i'">
				<!-- #i entspricht Format 'italic' -->
				<i>
					<xsl:apply-templates mode="#current"/>
				</i>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="#current"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="lb[position() > 1]" mode="html">
		<xsl:param name="KEEP_LB" tunnel="yes"/>
		<xsl:choose>
			<!-- bei Zeilenausgabe Umbruch voranstellen -->
			<xsl:when test="$KEEP_LB">
				<br/>
			</xsl:when>
			<!-- sonst ggf. Leerzeichen einfügen -->
			<xsl:when test="not(@break = 'no')">
				<xsl:text> </xsl:text>
			</xsl:when>
			<!-- sonst nichts tun -->
			<xsl:otherwise/>
		</xsl:choose>
		<xsl:apply-templates mode="#current"/>
	</xsl:template>

	<!-- mode plaintext -->

	<xsl:template match="TEI" mode="plain">
		<!-- hier nur Kindelemente von <body> auswerten -->
		<xsl:apply-templates select="text/body/*" mode="#current"/>
	</xsl:template>

	<xsl:template match="head" mode="plain">
		<xsl:apply-templates mode="#current"/>
		<!-- zwei Zeilenumbrüche anhängen -->
		<xsl:text>&#xa;&#xa;</xsl:text>
	</xsl:template>

	<xsl:template match="p" mode="plain">
		<xsl:param name="KEEP_LB" tunnel="yes"/>
		<xsl:apply-templates mode="#current"/>
		<!-- am Absatzende einen Zeilenumbruch anhängen -->
		<xsl:text>&#xa;</xsl:text>
		<!-- bei Zeilenausgabe noch ein Umbruch hinzu -->
		<xsl:if test="$KEEP_LB">
			<xsl:text>&#xa;</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="hi" mode="plain">
		<!-- Hervorhebungen hier nicht berücksichtigen -->
		<xsl:apply-templates mode="#current"/>
	</xsl:template>

	<xsl:template match="lb[position() > 1]" mode="plain">
		<xsl:param name="KEEP_LB" tunnel="yes"/>
		<xsl:choose>
			<!-- bei Zeilenausgabe Umbruch voranstellen -->
			<xsl:when test="$KEEP_LB">
				<xsl:text>&#xa;</xsl:text>
			</xsl:when>
			<!-- sonst ggf. Leerzeichen einfügen -->
			<xsl:when test="not(@break = 'no')">
				<xsl:text> </xsl:text>
			</xsl:when>
			<!-- sonst nichts tun -->
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
