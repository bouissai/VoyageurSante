<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : patient.xsl
    Created on : 17 novembre 2021, 09:39
    Author     : ilyassbouissa
    Description: Les visites d'un patient : 
    Transforme patient_NOMPATIENT.xml en une page html fiche_patient.html lui présentant les renseignements voulus.
        Purpose of transformation follows.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title>patient.xsl</title>
                <link rel="stylesheet" href="css/patient.css"/>
            </head>
            <body>
                <table border="1">
                    <ul>
                        <li>Nom : <xsl:value-of select="/patient/nom"/></li>
                        <li>Prénom : <xsl:value-of select="/patient/prénom"/></li>
                        <li>Sexe : <xsl:value-of select="/patient/sexe"/></li>
                        <li>Naissance : <xsl:value-of select="/patient/naissance"/></li>
                        <li>N°securite sociale : <xsl:value-of select="/patient/numéroSS"/></li>
                        <li>Adresse : <xsl:value-of select="/patient/adresse/rue"/>, <xsl:value-of select="/patient/adresse/codePostal"/> (<xsl:value-of select="/patient/adresse/ville"/>)</li>
                        <h3>Visite</h3>
                        <table border="1">
                            <tr>
                                <th>Date</th>
                                <th>Soins à éffectuer</th>
                                <th>Intervenant</th>
                            </tr>
                            <xsl:apply-templates select="//visite"></xsl:apply-templates>
                        </table>
                    </ul>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="visite">
        <td><xsl:value-of select="./@date"/></td>
        <td><xsl:value-of select="./acte"/></td>
        <td><xsl:value-of select="./intervenant/nom"/></td>
    </xsl:template>

</xsl:stylesheet>
