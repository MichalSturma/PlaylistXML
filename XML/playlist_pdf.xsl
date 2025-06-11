<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:pl="http://playlistyprovsechny.cz/evidence"
    exclude-result-prefixes="pl" version="2.0">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="default" page-width="210mm" page-height="297mm"
                    margin="20mm">
                    <fo:region-body margin-top="15mm" margin-bottom="15mm"/>
                    <fo:region-before extent="15mm"/>
                    <fo:region-after extent="15mm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="default">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center" font-size="10pt" font-family="Calibri"
                        color="gray"> stum08 </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center" font-size="10pt" font-family="Calibri"
                        color="gray">
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-family="Calibri" font-size="24pt" text-align="center"
                        font-weight="bold" margin-top="10cm"> Evidence playlistů </fo:block>
                    <fo:block font-family="Calibri" font-size="14pt" text-align="center"
                        color="gray" margin-top="1cm"> Semestrální práce na předmět 4iz238
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="default">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center" font-size="10pt" font-family="Calibri"
                        color="gray"> stum08 </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center" font-size="10pt" font-family="Calibri"
                        color="gray">
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-family="Calibri" font-size="24pt" font-weight="bold"
                        margin-bottom="10pt"> Obsah </fo:block>
                    <xsl:for-each select="/pl:playlistEvidence/pl:playlist">
                        <fo:block font-family="Calibri" font-size="12pt" text-align-last="justify">
                            <fo:basic-link internal-destination="playlist-{position()}">
                                <xsl:value-of select="pl:metadata/pl:nazevPlaylistu"/>
                            </fo:basic-link>
                            <fo:leader leader-pattern="dots"/>
                            <fo:page-number-citation ref-id="playlist-{position()}"/>
                        </fo:block>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
            <xsl:for-each select="/pl:playlistEvidence/pl:playlist">
                <xsl:variable name="playlist-id" select="position()"/>
                <fo:page-sequence master-reference="default">
                    <fo:static-content flow-name="xsl-region-before">
                        <fo:block text-align="center" font-size="10pt" font-family="Calibri"
                            color="gray"> stum08 </fo:block>
                    </fo:static-content>
                    <fo:static-content flow-name="xsl-region-after">
                        <fo:block text-align="center" font-size="10pt" font-family="Calibri"
                            color="gray">
                            <fo:page-number/>
                        </fo:block>
                    </fo:static-content>
                    <fo:flow flow-name="xsl-region-body">
                        <fo:block id="playlist-{$playlist-id}" font-size="16pt" font-weight="bold"
                            margin-bottom="10mm" text-align="center" font-family="Calibri"
                            color="#333333"> Informace o playlistu </fo:block>
                        <fo:block font-size="12pt" font-weight="bold" margin-bottom="5mm"
                            font-family="Calibri">Jméno playlistu:</fo:block>
                        <fo:block font-size="12pt" margin-bottom="5mm" font-family="Calibri">
                            <xsl:value-of select="pl:metadata/pl:nazevPlaylistu"/>
                        </fo:block>
                        <fo:block font-size="12pt" font-weight="bold" margin-bottom="5mm"
                            font-family="Calibri">Popis:</fo:block>
                        <fo:block font-size="12pt" margin-bottom="5mm" font-family="Calibri">
                            <xsl:value-of select="pl:metadata/pl:popis"/>
                        </fo:block>
                        <fo:block font-size="12pt" font-weight="bold" margin-bottom="5mm"
                            font-family="Calibri">Datum vytvoření:</fo:block>
                        <fo:block font-size="12pt" margin-bottom="5mm" font-family="Calibri">
                            <xsl:value-of select="pl:metadata/pl:datumVytvoreni"/>
                        </fo:block>
                        <fo:block font-size="12pt" font-weight="bold" margin-bottom="5mm"
                            font-family="Calibri">Autor:</fo:block>
                        <fo:block font-size="12pt" margin-bottom="5mm" font-family="Calibri">
                            <xsl:value-of
                                select="/pl:playlistEvidence/pl:autori/pl:autor[@id = current()/pl:metadata/pl:autorId]/pl:jmeno"/>
                        </fo:block>
                        <fo:block font-size="12pt" font-weight="bold" margin-bottom="5mm"
                            font-family="Calibri">Počet skladeb:</fo:block>
                        <fo:block font-size="12pt" margin-bottom="5mm" font-family="Calibri">
                            <xsl:value-of select="pl:metadata/pl:pocetPisnicek"/>
                        </fo:block>
                        <fo:block font-size="12pt" font-weight="bold" margin-bottom="5mm"
                            font-family="Calibri"> Hodnocení: </fo:block>
                        <fo:block font-size="12pt" font-family="Calibri" margin-bottom="5mm">
                            <xsl:value-of select="pl:metadata/pl:hodnoceni"/> / 5 </fo:block>

                        <fo:block font-size="12pt" font-weight="bold" margin-bottom="5mm"
                            font-family="Calibri">Měsíční počet posluchačů:</fo:block>
                        <fo:block font-size="12pt" margin-bottom="5mm" font-family="Calibri">
                            <xsl:value-of select="pl:metadata/pl:pocetPosluchacu"/>
                        </fo:block>
                        <fo:block font-size="12pt" font-weight="bold" margin-bottom="5mm"
                            font-family="Calibri">Počet uložení:</fo:block>
                        <fo:block font-size="12pt" margin-bottom="5mm" font-family="Calibri">
                            <xsl:value-of select="pl:metadata/pl:pocetUlozeni"/>
                        </fo:block>
                        <fo:block margin-top="12mm" margin-bottom="12mm" text-align="left"
                            font-family="Calibri">
                            <fo:external-graphic src="url({pl:metadata/pl:obalPlaylistu})"
                                content-width="scale-to-fit" content-height="scale-to-fit"
                                width="60mm" height="60mm"/>
                        </fo:block>
                        <fo:table table-layout="fixed" width="100%" border-collapse="separate"
                            border-spacing="0">
                            <fo:table-header>
                                <fo:table-row background-color="#f0f0f0"
                                    border-bottom="2pt solid #000000">
                                    <fo:table-cell padding="6pt">
                                        <fo:block font-weight="bold" font-family="Calibri"
                                            font-size="12pt">Název skladby</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="6pt">
                                        <fo:block font-weight="bold" font-family="Calibri"
                                            font-size="12pt">Interpret</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="6pt">
                                        <fo:block font-weight="bold" font-family="Calibri"
                                            font-size="12pt">Album</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="6pt">
                                        <fo:block font-weight="bold" font-family="Calibri"
                                            font-size="12pt">Délka</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="6pt">
                                        <fo:block font-weight="bold" font-family="Calibri"
                                            font-size="12pt">Žánr</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <xsl:for-each select="pl:skladby/pl:skladba">
                                    <fo:table-row>
                                        <fo:table-cell padding="6pt"
                                            border-bottom="1pt solid #d0d0d0">
                                            <fo:block font-family="Calibri" font-size="10pt">
                                                <xsl:value-of select="pl:nazev"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="6pt"
                                            border-bottom="1pt solid #d0d0d0">
                                            <fo:block font-family="Calibri" font-size="10pt">
                                                <xsl:value-of select="pl:interpret"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="6pt"
                                            border-bottom="1pt solid #d0d0d0">
                                            <fo:block font-family="Calibri" font-size="10pt">
                                                <xsl:value-of select="pl:album"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="6pt"
                                            border-bottom="1pt solid #d0d0d0">
                                            <fo:block font-family="Calibri" font-size="10pt">
                                                <xsl:value-of select="pl:delka"/>
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="6pt"
                                            border-bottom="1pt solid #d0d0d0">
                                            <fo:block font-family="Calibri" font-size="10pt">
                                                <xsl:value-of select="pl:zanr"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:for-each>
                            </fo:table-body>
                        </fo:table>
                    </fo:flow>
                </fo:page-sequence>
            </xsl:for-each>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>
