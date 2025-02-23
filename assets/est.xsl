<?xml version="1.0" encoding="UTF-8"?>
<!--
 * SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:template match="/estimate">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta name="description" content="Estimate"/>
        <meta name="keywords" content="automated estimate"/>
        <meta name="author" content="teamed.io"/>
        <title><xsl:text>Estimate</xsl:text></title>
        <style type="text/css">
          body {
          background-color: #e6e1ce;
          font-family: Arial, sans-serif;
          margin: 2em;
          font-size: 22px;
          }
          table {
          border-spacing: 0px;
          border-collapse: collapse;
          }
          th, td {
          vertical-align: top;
          padding: 1em;
          border: 1px solid gray;
          }
          th {
          text-align: left;
          }
        </style>
      </head>
      <body>
        <div>
          <h1>Estimate</h1>
          <p>
            <xsl:text>Total: </xsl:text>
            <xsl:value-of select="total"/>
          </p>
          <xsl:apply-templates select="ests/est"/>
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="ests/est">
    <xsl:value-of select="date"/>
    <xsl:text>: </xsl:text>
    <strong><xsl:value-of select="total"/></strong>
    <xsl:text> hours by </xsl:text>
    <xsl:value-of select="author"/>
  </xsl:template>
</xsl:stylesheet>
