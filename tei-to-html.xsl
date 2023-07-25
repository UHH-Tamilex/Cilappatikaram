<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:x="http://www.tei-c.org/ns/1.0"
                xmlns:tst="https://github.com/tst-project"
                exclude-result-prefixes="x tst">
<xsl:import href="./lib/xslt/tei-to-html.xsl"/>

<xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes"/>

<xsl:variable name="root">./lib/</xsl:variable>

<xsl:template match="x:TEI">
    <xsl:call-template name="TEI"/>
</xsl:template>

<xsl:template match="x:div1 | x:div2 | x:div3 | x:div4">
    <div>
        <xsl:apply-templates/>
    </div>
</xsl:template>

<xsl:template match="x:footnote">
    <xsl:variable name="anchor" select="./x:c[@type='anchor']"/>
    <xsl:element name="span">
        <xsl:attribute name="data-anno"/>
        <xsl:attribute name="class">footnote</xsl:attribute>
        <xsl:choose>
            <xsl:when test="$anchor"><xsl:value-of select="$anchor"/></xsl:when>
            <xsl:otherwise><xsl:text>†</xsl:text></xsl:otherwise>
        </xsl:choose>
        <xsl:element name="span">
            <xsl:attribute name="class">anno-inline</xsl:attribute>
            <xsl:call-template name="lang"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:element>
</xsl:template>

<xsl:template match="x:q1">
    <q class="single"><xsl:apply-templates/></q>
</xsl:template>

<xsl:template match="x:q2">
    <q class="double"><xsl:apply-templates/></q>
</xsl:template>
<xsl:template match="x:l">
    <xsl:element name="div">
        <xsl:call-template name="lang"/>
        <xsl:attribute name="class">l</xsl:attribute>
        <xsl:if test="@n">
            <span class="lb">
                <xsl:attribute name="data-anno">line <xsl:value-of select="@n"/></xsl:attribute>
                <xsl:attribute name="data-n"><xsl:value-of select="@n"/></xsl:attribute>
            </span>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="x:p">
    <xsl:element name="p">
        <span class="lb unnumbered"></span>
        <xsl:if test="@corresp">
            <xsl:attribute name="data-corresp"><xsl:value-of select="@corresp"/></xsl:attribute>
            <h4 style="display:inline;margin-right: 1rem"><xsl:value-of select="@corresp"/></h4>
        </xsl:if>
        <xsl:call-template name="lang"/>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
