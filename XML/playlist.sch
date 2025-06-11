<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    
    <sch:ns uri="http://playlistyprovsechny.cz/evidence" prefix="pl"/>
    
    <sch:pattern id="playlist-validation">
        
        <sch:rule context="pl:playlistEvidence/pl:playlist/pl:skladby/pl:skladba/pl:datumVydani">
            <sch:assert test=". &lt;= current-date()">
                datumVydani musí být v minulosti nebo dnešní. Hodnota: <sch:value-of select="."/>.
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="pl:playlistEvidence/pl:playlist/pl:skladby/pl:skladba/pl:datumPridani">
            <sch:assert test=". &lt;= current-date()">
                datumPridani musí být v minulosti nebo dnešní. Hodnota: <sch:value-of select="."/>.
            </sch:assert>
            <sch:assert test=". &gt; ../pl:datumVydani">
                datumPridani musí být novější než datumVydani. datumPridani: <sch:value-of select="."/>, datumVydani: <sch:value-of select="../pl:datumVydani"/>.
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="pl:playlistEvidence/pl:playlist/pl:metadata/pl:datumVytvoreni">
            <sch:assert test=". &lt;= current-date()">
                datumVytvoreni musí být v minulosti nebo dnešní. Hodnota: <sch:value-of select="."/>.
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="pl:playlistEvidence/pl:playlist/pl:metadata/pl:datumVytvoreni">
            <sch:assert test=". &gt; ../pl:datumPridani">
                datumVytvoreni musí být novější než datumPridani. datumVytvoreni: <sch:value-of select="."/>, datumPridani: <sch:value-of select="../pl:datumPridani"/>.
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="pl:playlistEvidence/pl:playlist/pl:skladby/pl:skladba/pl:datumVydani">
            <sch:assert test=". &lt; ../pl:datumPridani">
                datumVydani musí být starší než datumPridani. datumVydani: <sch:value-of select="."/>, datumPridani: <sch:value-of select="../pl:datumPridani"/>.
            </sch:assert>
        </sch:rule>
       
        
    </sch:pattern>
    
    <sch:pattern id="unique-tags">
        <sch:rule context="pl:tagy">
            <sch:assert test="count(pl:tag) = count(distinct-values(pl:tag))">
                Hodnoty v elementech &lt;tag&gt; musí být unikátní.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern id="check-song-count">
        <sch:rule context="pl:playlist">
            <sch:assert test="count(pl:skladby/pl:skladba) = pl:metadata/pl:pocetPisnicek">
                Počet skladeb v playlistu musí odpovídat hodnotě uvedené v &lt;pocetPisnicek&gt;.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
