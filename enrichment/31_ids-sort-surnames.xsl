<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">

	<!-- Quelldokument: 30_listPerson-normalized.xml -->

	<xsl:template match="/">
		<xsl:result-document indent="yes" method="xml" byte-order-mark="yes"
			href="32_listPerson-structured.xml" encoding="UTF-8">
			<xsl:apply-templates/>
		</xsl:result-document>
	</xsl:template>

	<xsl:template match="listPerson">
		<listPerson>
			<xsl:for-each select="person">
				<!-- Sortieren nach letztem Wort (mutmaßlich Nachname) -->
				<xsl:sort select="tokenize(persName[1], ' ')[last()]"/>
				<person>
					<!-- Attribute kopieren -->
					<xsl:apply-templates select="@*"/>
					<persName>
						<!-- Namensteile nach Leerzeichen trennen -->
						<xsl:variable name="nameParts" select="tokenize(persName[1], ' ')"/>
						<xsl:for-each select="$nameParts">
							<xsl:choose>
								<xsl:when test="position() = count($nameParts)">
									<!-- letztes Wort wird als Nachname getaggt -->
									<surname>
										<xsl:value-of select="."/>
									</surname>
								</xsl:when>
								<xsl:otherwise>
									<name>
										<xsl:value-of select="."/>
									</name>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</persName>
				</person>
			</xsl:for-each>
		</listPerson>
	</xsl:template>

	<!-- identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
