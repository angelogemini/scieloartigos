<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink">

	<xsl:output method="xml" indent="yes" version="1.0" encoding="UTF-8" />

	<xsl:template match="/">
		<dublin_core schema="dc">
			<dcvalue element="type" qualifier="none">article</dcvalue>
			<dcvalue element="type" qualifier="category">original article</dcvalue>
			<xsl:for-each select="/article/front/article-meta/title-group/article-title">
				<dcvalue element="title" qualifier="none">
					<xsl:value-of select="."/>
				</dcvalue>
			</xsl:for-each>
			<xsl:for-each select="/article/front/article-meta/contrib-group/contrib/name">
				<dcvalue element="contributor" qualifier="author">
					<xsl:value-of select="surname" />,&#160;<xsl:value-of select="given-names" />
				</dcvalue>
			</xsl:for-each>
			<dcvalue element="identifier" qualifier="issn">
				<xsl:value-of select="/article/front/journal-meta/issn"/>
			</dcvalue>
			<dcvalue element="date" qualifier="issued">
				<xsl:value-of select="/article/front/article-meta/pub-date/year"/>
			</dcvalue>
			<dcvalue element="publisher" qualifier="none">
				<xsl:value-of select="/article/front/journal-meta/publisher/publisher-name"/>
			</dcvalue>
			<xsl:for-each select="/article/front/article-meta/article-id">
				<xsl:if test="@pub-id-type = 'doi'">			
					<dcvalue element="identifier" qualifier="doi">
						<xsl:value-of select="."/>
					</dcvalue>
				</xsl:if>
			</xsl:for-each>
			
			<dcvalue element="identifier" qualifier="citation"><xsl:value-of select="/article/front/journal-meta/abbrev-journal-title"/>,v.<xsl:value-of select="/article/front/article-meta/volume"/>,n.<xsl:value-of select="/article/front/article-meta/numero"/>,p.<xsl:value-of select="/article/front/article-meta/fpage"/>-<xsl:value-of select="/article/front/article-meta/lpage"/>,<xsl:value-of select="/article/front/article-meta/pub-date/year"/></dcvalue>

			<dcvalue element="description" qualifier="abstract">
				<xsl:value-of select="/article/front/article-meta/abstract" />
			</dcvalue>
			<xsl:for-each select="/article/front/article-meta/kwd-group/kwd">
				<dcvalue element="subject" qualifier="">
					<xsl:value-of select="." />
				</dcvalue>
			</xsl:for-each>
			<dcvalue element="rights" qualifier="none">openAccess</dcvalue>
			<dcvalue element="language" qualifier="iso"><xsl:value-of select="/article/front/article-meta/title-group/article-title/@xml:lang" /></dcvalue>
				<dcvalue element="description" qualifier="sponsorship"><![CDATA[TEXTOASERRETIRADO]]>
				
				</dcvalue>
			</dublin_core>
	</xsl:template>

</xsl:stylesheet>
