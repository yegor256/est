<?xml version="1.0"?>
<!--
 * Copyright (c) 2014-2025 Yegor Bugayenko
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the 'Software'), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
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
