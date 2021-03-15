<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns="http://www.tei-c.org/ns/1.0"
	xmlns:myns="http://my.namespace.org" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- 'identity transform' -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- xml-model entfernen -->
	<xsl:template match="processing-instruction()[name() = 'xml-model']"/>

	<!-- irgendetwas entfernen -->
	<xsl:template match="@myns:test"/>

	<!-- irgendetwas umbenennen -->
	<xsl:template match="myns:gut">
		<xsl:element name="p">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<!-- ggf. muss unter 'Optionen > Einstellungen'
		auf der Seite 'XML > XML Parser > RELAX NG'
		die Option 'Standard-Attributwerte hinzufügen'
		deaktiviert werden -->

</xsl:stylesheet>
