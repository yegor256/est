<?xml version="1.0" encoding="UTF-8"?>
<!--
 * SPDX-FileCopyrightText: Copyright (c) 2014-2026 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="text" omit-xml-declaration="yes"/>
  <xsl:template match="/estimate">
    <xsl:text>Total: </xsl:text>
    <xsl:value-of select="total"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="ests/est"/>
  </xsl:template>
  <xsl:template match="ests/est">
    <xsl:value-of select="date"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="total"/>
    <xsl:text> hours by </xsl:text>
    <xsl:value-of select="author"/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>
</xsl:stylesheet>
