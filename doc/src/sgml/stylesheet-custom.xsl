<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

<xsl:param name="html.original" select="0"/>

<xsl:template name="user.head.content">
  <meta name="viewport" content="width=device-width,initial-scale=1.0" />
</xsl:template>


<xsl:template match="comment()">
  <xsl:choose>
    <xsl:when test="$html.original = 1">
      <span class="original" >
        <xsl:value-of select="." />
      </span>
    </xsl:when>
    <xsl:otherwise>
      <xsl:comment><xsl:value-of select="." /></xsl:comment>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="header.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:param name="nav.context"/>

  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:variable name="row1" select="count($prev) &gt; 0
                                    or count($up) &gt; 0
                                    or count($next) &gt; 0"/>

  <xsl:variable name="row2" select="count($prev) &gt; 0
                                    or count($up) &gt; 0
                                    or count($next) &gt; 0"/>

  <xsl:variable name="row3" select="($prev and $navig.showtitles != 0)
                                    or (generate-id($home) != generate-id(.)
                                        or $nav.context = 'toc')
                                    or ($chunk.tocs.and.lots != 0
                                        and $nav.context != 'toc')
                                    or ($next and $navig.showtitles != 0)"/>

  <xsl:if test="$suppress.navigation = '0' and $suppress.header.navigation = '0'">
    <div class="navheader">
      <xsl:if test="$row1 or $row2 or $row3">
        <table width="100%" summary="Navigation header">
          <xsl:if test="$row1">
            <tr>
              <th colspan="4" align="center">
                <a accesskey="h">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$home"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:apply-templates select="$home" mode="object.title.markup"/>
                </a>
              </th>
            </tr>
          </xsl:if>

          <xsl:if test="$row2">
            <tr>
              <td width="10%" align="{$direction.align.start}">
              </td>
              <td width="10%" align="{$direction.align.start}">
              </td>
              <td width="60%" align="center">
                <xsl:choose>
                <xsl:when test="generate-id($up) != generate-id($home)">
                  <a>
                    <xsl:attribute name="href">
                      <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$up"/>
                      </xsl:call-template>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                      <xsl:apply-templates select="$up" mode="object.title.markup"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="$up" mode="object.title.markup"/>
                  </a>
                </xsl:when>
                <xsl:otherwise>&#160;</xsl:otherwise>
              </xsl:choose>
              </td>
              <td width="20%" align="{$direction.align.end}">
                <xsl:choose>
                <xsl:when test="$html.original = 1">
                  <div class="actions">
                    <a class="issue" title="github">
                      <xsl:attribute name="href">https://github.com/pgsql-jp/jpug-doc/issues/new?template=bug_report.yml&amp;what-happened=version&#160;<xsl:value-of select="$pg.version"/> &#058; <xsl:call-template name="href.target"><xsl:with-param name="object" select="."/></xsl:call-template></xsl:attribute>誤訳等の報告
                    </a>
                  </div>
                </xsl:when>
                </xsl:choose>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test="$row3">
            <tr>
              <td width="10%" align="{$direction.align.start}">
                <xsl:if test="count($prev)>0">
                  <a accesskey="p">
                    <xsl:attribute name="href">
                      <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$prev"/>
                      </xsl:call-template>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                      <xsl:apply-templates select="$prev" mode="object.title.markup"/>
                    </xsl:attribute>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'prev'"/>
                    </xsl:call-template>
                  </a>
                </xsl:if>
                <xsl:text>&#160;</xsl:text>
              </td>
              <td width="10%" align="{$direction.align.start}">
                <xsl:choose>
                  <xsl:when test="count($up)&gt;0
                                  and generate-id($up) != generate-id($home)">
                    <a accesskey="u">
                      <xsl:attribute name="href">
                        <xsl:call-template name="href.target">
                          <xsl:with-param name="object" select="$up"/>
                        </xsl:call-template>
                      </xsl:attribute>
                      <xsl:attribute name="title">
                        <xsl:apply-templates select="$up" mode="object.title.markup"/>
                      </xsl:attribute>
                      <xsl:call-template name="navig.content">
                        <xsl:with-param name="direction" select="'up'"/>
                      </xsl:call-template>
                    </a>
                  </xsl:when>
                  <xsl:otherwise>&#160;</xsl:otherwise>
                </xsl:choose>
              </td>
              <td width="60%" align="center">
                <xsl:choose>
                  <xsl:when test="count($up) > 0
                                  and generate-id($up) != generate-id($home)
                                  and $navig.showtitles != 0">
                    <xsl:apply-templates select="." mode="object.title.markup"/>
                  </xsl:when>
                </xsl:choose>
              </td>
              <td width="20%" align="{$direction.align.end}">
                <xsl:text>&#160;</xsl:text>
                <xsl:if test="count($next)>0">
                  <a accesskey="n">
                    <xsl:attribute name="href">
                      <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$next"/>
                      </xsl:call-template>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                      <xsl:apply-templates select="$next" mode="object.title.markup"/>
                    </xsl:attribute>
                    <xsl:call-template name="navig.content">
                      <xsl:with-param name="direction" select="'next'"/>
                    </xsl:call-template>
                  </a>
                </xsl:if>
              </td>
            </tr>
          </xsl:if>

        </table>
      </xsl:if>

      <xsl:if test="$header.rule != 0">
        <hr/>
      </xsl:if>

    </div>
  </xsl:if>

</xsl:template>

<xsl:template name="section.toc">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="toc.title.p" select="true()"/>

  <xsl:call-template name="make.toc">
    <xsl:with-param name="toc-context" select="$toc-context"/>
    <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
    <xsl:with-param name="nodes"
                    select="refentry
                           |bridgehead[$bridgehead.in.toc != 0]"/>

  </xsl:call-template>
</xsl:template>

<xsl:template match="sect1" mode="toc">
  <xsl:param name="toc-context" select="."/>
  <xsl:call-template name="subtoc">
    <xsl:with-param name="toc-context" select="$toc-context"/>
    <xsl:with-param name="nodes" select="sect2|refentry                                 |bridgehead[$bridgehead.in.toc != 0]"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
