<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pl="http://playlistyprovsechny.cz/evidence" exclude-result-prefixes="pl" version="2.0">
    
    <xsl:output method="html" version="5" indent="yes" encoding="UTF-8"/>
    
    <xsl:param name="titlePrefix" select="'Music Playlists - '"/>
    
    <xsl:template match="/">
        
        <xsl:result-document method="html" version="5" indent="yes" encoding="UTF-8" href="menu.html">
            <html lang="en">
                <head>
                    <meta charset="UTF-8"/>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <title><xsl:value-of select="$titlePrefix"/>Main Menu</title>
                    <link rel="stylesheet" href="styles.css"/>
                </head>
                <body>
                    <header>
                        <h1>Hudební playlisty</h1>
                    </header>
                    <nav>
                        <h2>Dostupné playlisty</h2>
                        <ul>
                            <xsl:for-each select="/pl:playlistEvidence/pl:playlist">
                                <li>
                                    <p><xsl:value-of select="pl:metadata/pl:popis"/></p>
                                    <a href="{concat(translate(pl:metadata/pl:nazevPlaylistu, ' ', '_'), '.html')}">
                                        <xsl:value-of select="pl:metadata/pl:nazevPlaylistu"/>
                                    </a>
                                </li>
                            </xsl:for-each>
                            <li>
                                <p>Informace o autorech</p>
                                <a href="authors.html">Seznam autorů</a>
                            </li>
                        </ul>
                    </nav>
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:apply-templates select="/pl:playlistEvidence/pl:autori"/>
        
        <xsl:apply-templates select="/pl:playlistEvidence/pl:playlist"/>
    </xsl:template>
    
    <xsl:template match="pl:autori">
        <xsl:result-document method="html" version="5" indent="yes" encoding="UTF-8" href="authors.html">
            <html lang="en">
                <head>
                    <meta charset="UTF-8"/>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <title><xsl:value-of select="$titlePrefix"/>Seznam autorů</title>
                    <link rel="stylesheet" href="styles.css"/>
                </head>
                <body>
                    <header>
                        <h1><a href="menu.html">Hudební playlisty</a></h1>
                        <h2>Seznam autorů</h2>
                    </header>
                    <main>
                        <h3>Autoři</h3>
                        <ul>
                            <xsl:for-each select="pl:autor">
                                <li>
                                    <strong><xsl:value-of select="pl:jmeno"/></strong>
                                    <p>Oblíbené žánry: 
                                        <xsl:for-each select="pl:oblibeneZanry">
                                            <span><xsl:value-of select="."/></span><xsl:if test="position() != last()">, </xsl:if>
                                        </xsl:for-each>
                                    </p>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </main>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="pl:playlist">
        <xsl:variable name="playlistName" select="translate(pl:metadata/pl:nazevPlaylistu, ' ', '_')"/>
        <xsl:result-document method="html" version="5" indent="yes" encoding="UTF-8" href="{$playlistName}.html">
            <html lang="en">
                <head>
                    <meta charset="UTF-8"/>
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                    <title><xsl:value-of select="$titlePrefix"/><xsl:value-of select="pl:metadata/pl:nazevPlaylistu"/></title>
                    <link rel="stylesheet" href="styles.css"/>
                </head>
                <body>
                    <header>
                        <h1><a href="menu.html">Hudební playlisty</a></h1>
                        <h2><xsl:value-of select="pl:metadata/pl:nazevPlaylistu"/></h2>
                    </header>
                    <main>
                        <h3>Detaily playlistu</h3>
                        <img src="{pl:metadata/pl:obalPlaylistu}" alt="Playlist Cover" width="200"/>
                        <p><strong>Autor: </strong> <xsl:value-of select="/pl:playlistEvidence/pl:autori/pl:autor[@id = current()/pl:metadata/pl:autorId]/pl:jmeno"/></p>
                        <p><strong>Datum vytvoření: </strong> <xsl:value-of select="pl:metadata/pl:datumVytvoreni"/></p>
                        <p><strong>Počet skladeb: </strong> <xsl:value-of select="pl:metadata/pl:pocetPisnicek"/></p>
                        <p><strong>Hodnocení: </strong> <xsl:value-of select="pl:metadata/pl:hodnoceni"/>/5</p>
                        <p><strong>Počet uložení: </strong> <xsl:value-of select="pl:metadata/pl:pocetUlozeni"/></p>
                        <p><strong>Počet měsíčních posluchačů: </strong> <xsl:value-of select="pl:metadata/pl:pocetPosluchacu"/></p>
                        <p><strong>Tagy playlistu: </strong> 
                            <xsl:for-each select="pl:metadata/pl:tagy/pl:tag">
                                <span><xsl:value-of select="."/></span><xsl:if test="position() != last()">, </xsl:if>
                            </xsl:for-each>
                        </p>
                        <p><strong>Typ: </strong> <xsl:value-of select="pl:metadata/pl:typPlaylistu"/></p>
                        
                        <h3>Seznam skladeb:</h3>
                        <table class="custom-table">
                            
                            <thead>
                                <tr>
                                    <th>Pozice</th>
                                    <th>Název</th>
                                    <th>Interpret</th>
                                    <th>Délka</th>
                                    <th>Album</th>
                                    <th>Žánr</th>
                                    <th>Datum vydání</th>
                                    <th>Datum přidání</th>
                                    <th>Text</th>
                                    <th>Vydavatel</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="pl:skladby/pl:skladba">
                                    <xsl:sort select="@pozice" data-type="number" order="ascending"/>
                                    <tr>
                                        <xsl:if test="@pozice">
                                            <td><xsl:value-of select="@pozice"/></td>
                                        </xsl:if>
                                        <xsl:if test="not(@pozice)">
                                            <td>N/A</td>
                                        </xsl:if>
                                        <td><xsl:value-of select="pl:nazev"/></td>
                                        <td><xsl:value-of select="pl:interpret"/></td>
                                        <td><xsl:value-of select="pl:delka"/></td>
                                        <td><xsl:value-of select="pl:album"/></td>
                                        <td><xsl:value-of select="pl:zanr"/></td>
                                        <td><xsl:value-of select="pl:datumVydani"/></td>
                                        <td><xsl:value-of select="pl:datumPridani"/></td>
                                        <xsl:if test="pl:textDostupny and string(pl:textDostupny) != ''">
                                            <td><xsl:value-of select="pl:textDostupny"/></td>
                                        </xsl:if>
                                        <xsl:if test="not(pl:textDostupny) or string(pl:textDostupny) = ''">
                                            <td>N/A</td>
                                        </xsl:if>
                                        <td><xsl:value-of select="pl:nahravaciSpolecnost"/></td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </main>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
