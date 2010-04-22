<?xml version="1.0" encoding="UTF-8"?>
<!--
        Copyright  1990-2008 Sun Microsystems, Inc. All Rights Reserved.
        DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
        
        This program is free software; you can redistribute it and/or
        modify it under the terms of the GNU General Public License version
        2 only, as published by the Free Software Foundation.
        
        This program is distributed in the hope that it will be useful, but
        WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
        General Public License version 2 for more details (a copy is
        included at /legal/license.txt).
        
        You should have received a copy of the GNU General Public License
        version 2 along with this work; if not, write to the Free Software
        Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
        02110-1301 USA
        
        Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa
        Clara, CA 95054 or visit www.sun.com if you need additional
        information or have any questions.
-->
<!--
    This stylesheet outputs C source file with arrays to be used
    for property initialization.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>
<!-- stylesheet parameter: properties scope -->
<xsl:param name="arrayNamePrefix">error</xsl:param>

<xsl:template match="/">
<xsl:variable name="properties" select="/configuration/properties"/>
<xsl:call-template name="outputProperties">
<xsl:with-param name="properties" select="$properties"/>
</xsl:call-template> 
</xsl:template>

<xsl:template name="outputProperties">
<xsl:param name="properties"/>
<!-- all properties with internal scope -->
<xsl:variable name="internalProps"
    select="$properties/property[@Scope = 'internal']"/>
<!-- all properties with system scope -->
<xsl:variable name="systemProps"
    select="$properties/property[@Scope = 'system' and not(@Callout)]"/>
<xsl:text>/*
 * Copyright  1990-2008 Sun Microsystems, Inc. All Rights Reserved.
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License version
 * 2 only, as published by the Free Software Foundation.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License version 2 for more details (a copy is
 * included at /legal/license.txt).
 * 
 * You should have received a copy of the GNU General Public License
 * version 2 along with this work; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA
 * 
 * Please contact Sun Microsystems, Inc., 4150 Network Circle, Santa
 * Clara, CA 95054 or visit www.sun.com if you need additional
 * information or have any questions.
 *
 */

/*
 * This file is auto generated by Configurator.
 */

#ifndef NULL
#define NULL (void*)0
#endif

char* </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_static_properties_sections[] = {
    "application",
    "internal",
    NULL
};

char* </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_internalKey[] = {
</xsl:text>
<!-- output array of properties with internal scope keys -->
<xsl:call-template name="outputKeys">
<xsl:with-param name="nodes" select="$internalProps"/>
</xsl:call-template>
<xsl:text>    NULL
};

char* </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_internalValue[] = {
</xsl:text>
<!-- output array of properties with internal scope values -->
<xsl:call-template name="outputValues">
<xsl:with-param name="nodes" select="$internalProps"/>
</xsl:call-template>
<xsl:text>    NULL
};

char* </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_systemKey[] = {
</xsl:text>
<!-- output array of properties with system scope keys -->
<xsl:call-template name="outputKeys">
<xsl:with-param name="nodes" select="$systemProps"/>
</xsl:call-template>
<xsl:text>    NULL
};

char* </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_systemValue[] = {
</xsl:text>
<!-- output array of properties with system scope values -->
<xsl:call-template name="outputValues">
<xsl:with-param name="nodes" select="$systemProps"/>
</xsl:call-template>
<xsl:text>    NULL
};

char** </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_static_properties_keys[] = {
    </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_systemKey,
    </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_systemValue,
    NULL
};

char** </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_static_properties_values[] = {
    </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_internalKey,
    </xsl:text>
<xsl:value-of select="$arrayNamePrefix"/>
<xsl:text>_internalValue,
    NULL
};
</xsl:text>
</xsl:template>

<!-- output properties keys, one key per line, separated by comma -->
<xsl:template name="outputKeys">
<xsl:param name="nodes"/>
<xsl:for-each select="$nodes[@Key]">
<xsl:sort select="@Key"/>
<xsl:text>    </xsl:text>
<xsl:text>"</xsl:text><xsl:value-of select="@Key"/><xsl:text>"</xsl:text>
<xsl:text>,
</xsl:text>
</xsl:for-each>
</xsl:template>

<!-- output properties values, one value per line, separated by comma -->
<xsl:template name="outputValues">
<xsl:param name="nodes"/>
<xsl:for-each select="$nodes[@Key]">
<xsl:sort select="@Key"/>
<xsl:text>    </xsl:text>
<xsl:choose>
    <xsl:when test="@Value = ''">NULL</xsl:when>
    <xsl:otherwise>
        <xsl:text>"</xsl:text><xsl:value-of select="@Value"/><xsl:text>"</xsl:text>
    </xsl:otherwise>
</xsl:choose>
<xsl:text>,
</xsl:text>
</xsl:for-each>
</xsl:template>


</xsl:stylesheet>
