<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : patient.xsl
    Created on : 16 novembre 2021, 18:15
    Author     : ilyassbouissa
    Description: Les visites d'un patient : 
    transformer cabinet.xml en un nouveau fichier 
    xml nommé cabinetInfirmier_NomPatient.xml 
    (ou NomPatient du patient le parametre "destinedName".
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical"
    xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="xml"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <!-- parametre qui donne nom du patients-->
    <xsl:param name="destinedName" select="'Pien'"/> 
    <xsl:template match="/">

        <patient>
            <!-- On applique la template sur le patient qui a le même nom que celui en parametre puis on affiche tout ses informations dans la templates -->
            <xsl:apply-templates select="//med:patient[./med:nom=$destinedName]"/>
        </patient>
    </xsl:template>
    <xsl:template match="med:patient">
        <nom><xsl:value-of select="./med:nom"/></nom>
        <prénom><xsl:value-of select="./med:prénom"/></prénom>
        <sexe><xsl:value-of select="./med:sexe"/></sexe>
        <naissance><xsl:value-of select="./med:naissance"/></naissance>
        <numéroSS><xsl:value-of select="./med:numéro"/></numéroSS>
        <adresse>
            <rue><xsl:value-of select="./med:adresse/med:rue"/></rue>
            <codePostal><xsl:value-of select="./med:adresse/med:codePostal"/></codePostal>
            <ville><xsl:value-of select="./med:adresse/med:ville"/></ville>
        </adresse>
        <xsl:apply-templates select="./med:visite"/>

    </xsl:template>
    
    <xsl:template match="med:visite">
                <visite> 
                    <xsl:attribute name="date"><xsl:value-of select="./@date"/></xsl:attribute>
                    <intervenant>
                        <!-- On stocke l'id de l'infirmiere dans une variable-->
                        <xsl:variable name="destinedId" select="./@intervenant"/> 
                        <nom><xsl:value-of select="//med:infirmier[@id=$destinedId]/med:nom"/></nom>
                        <prénom><xsl:value-of select="//med:infirmier[@id=$destinedId]/med:prénom"/></prénom>
                    </intervenant>
                    <!-- Pour chaque acte on affiche sa descripiton-->
                    <xsl:apply-templates select="./med:acte"/>
                </visite>
    </xsl:template>
    
    <xsl:template match="med:acte">
        <!-- Pour chaque acte du patient -->
        <xsl:variable name="idActe" select="@id"/> 
        <!-- Pour chaque id du patient on regarde dans l'arborescence
        du fichiers actes.xml lorsque l'acte est égale à l'id du patient-->
        <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap/act:actes/act:acte[@id=$idActe]"/>
        <!-- Puis on affiche la description pour chauqe acte-->
        <acte><xsl:value-of select="$actes"/></acte>
    </xsl:template>

</xsl:stylesheet>
