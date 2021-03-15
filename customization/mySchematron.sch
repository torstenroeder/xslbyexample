<?xml version="1.0" encoding="UTF-8"?>
<sch:schema queryBinding="xslt2" xmlns="http://www.tei-c.org/ns/1.0"
	xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:sqf="http://www.schematron-quickfix.com/validator/process">

	<!-- TEI-Namespace deklarieren -->
	<sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>

	<!-- Prüf-Schema -->
	<sch:pattern>
		<!-- XPath festlegen, der zu prüfen ist -->
		<sch:rule context="tei:titleStmt">
			<!-- Test: ist ein Element 'author' vorhanden? -->
			<!-- und als Fix festlegen: 'insert_author' (s.u.) -->
			<sch:assert sqf:fix="insert_author" test="tei:author">Da fehlt das Element
				'author'!</sch:assert>
		</sch:rule>
	</sch:pattern>

	<!-- Reparatur-Schemata -->
	<sqf:fixes>
		<!-- Repearatur-Schema für fehlendes Element 'author'-->
		<sqf:fix id="insert_author">
			<!-- Befehl für Seitenleiste -->
			<sqf:description>
				<sqf:title>Element 'author' einfügen</sqf:title>
			</sqf:description>
			<!-- nach dem Element 'title' das Element 'author' einfügen -->
			<sqf:add match="tei:title" position="after">
				<author>#wsde2020</author>
			</sqf:add>
		</sqf:fix>
	</sqf:fixes>

</sch:schema>
