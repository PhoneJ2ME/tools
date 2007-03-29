<?xml version="1.0" encoding="UTF-8"?>
<!--
          

        Copyright 1990-2006 Sun Microsystems, Inc. All Rights Reserved.
        DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
-->
<!--
    This stylesheet outputs Java initializer class for an optional JSR.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
    Stylesheet parameter: name of Java package where initializer
    belongs to.
-->
<xsl:param name="packageName"></xsl:param>
<!--
    Stylesheet parameter: list of native library names to load.
-->
<xsl:param name="nativeLibs"></xsl:param>
<xsl:output method="text"/>

<xsl:template match="/">
<xsl:text>/*
 *
 *
 * Copyright  1990-2006 Sun Microsystems, Inc. All Rights Reserved.  
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER  
 *
 */

/*
 * This file is auto generated by Configurator. Do not edit.
 */

package </xsl:text>
    <xsl:value-of select="$packageName"/>
<xsl:text>;

import java.security.AccessController;
import java.security.PrivilegedAction;
import com.sun.cdc.config.DynamicProperties;
import com.sun.j2me.main.Configuration;

public class Initializer {
    static {
</xsl:text>
<xsl:text>        AccessController.doPrivileged(
            new PrivilegedAction() {
                public Object run() {
</xsl:text>
    <!-- add loadLibrary() calls if nativeLibs parameter is not empty -->
    <xsl:if test="boolean($nativeLibs)">
        <xsl:call-template name="addLibs">
            <xsl:with-param name="libsList" select="$nativeLibs"/>
        </xsl:call-template>
    </xsl:if>
    <!-- set system static properties -->
    <xsl:for-each select="/configuration/properties">
            <xsl:for-each select="property[@Scope = 'system' and not(@Callout)]">
                <xsl:sort select="@Key"/>
                <xsl:text>                    System.setProperty("</xsl:text>
                <xsl:value-of select="@Key"/>
                <xsl:text>", "</xsl:text>
                <xsl:value-of select="@Value"/>
<xsl:text>");
</xsl:text>
            </xsl:for-each>
    </xsl:for-each>
<xsl:text>                    return null;
                }
            }
        );
</xsl:text>
    <xsl:for-each select="/configuration/properties">
        <!-- set system dynamic properties -->
        <xsl:for-each select="property[@Scope = 'system' and @Callout]">
            <xsl:sort select="@Key"/>
            <xsl:text>        DynamicProperties.put("</xsl:text>
            <xsl:value-of select="@Key"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@Callout"/>
<xsl:text>.getInstance());
</xsl:text>
        <!-- set internal properties -->
        </xsl:for-each>
        <xsl:for-each select="property[@Scope = 'internal']">
            <xsl:sort select="@Key"/>
            <xsl:text>        Configuration.setProperty("</xsl:text>
            <xsl:value-of select="@Key"/>
            <xsl:text>", "</xsl:text>
            <xsl:value-of select="@Value"/>
<xsl:text>");
</xsl:text>
        </xsl:for-each>

    </xsl:for-each>
<xsl:text>    }
}
</xsl:text>
</xsl:template>

<!-- calls to System.loadLibrary() -->
<xsl:template name="addLibs">
<!-- template parameter: space separated list of libraries -->
<xsl:param name="libsList"/>
<!-- add first loadLibrary() -->
<xsl:text>                    System.loadLibrary("</xsl:text>
    <xsl:choose>
        <!-- when there is more than one element in the list -->
        <xsl:when test="contains($libsList,' ')">
            <xsl:value-of select="substring-before($libsList,' ')"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$libsList"/>
        </xsl:otherwise>
    </xsl:choose>
<xsl:text>");
</xsl:text>
<!-- and call this template recursively to process the rest of libraries -->
    <xsl:if test="contains($libsList,' ')">
        <xsl:call-template name="addLibs">
            <xsl:with-param name="libsList" select="substring-after($libsList,' ')"/>
        </xsl:call-template>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
