<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : cabinetInfirmier.xsl
    Created on : 9 novembre 2021, 16:14
    Author     : ilyassbouissa
    Description: La page de l'infirmière
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical"
    xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="html"></xsl:output>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title>cabinetInfirmier.xsl</title>
                <link rel="stylesheet" href="css/cabinet.css"></link>
                <script type="text/javascript">
                    function openFacture(prenom, nom, actes) {
                        var width  = 500;
                        var height = 300;
                        if(window.innerWidth) {
                            var left = (window.innerWidth-width)/2;
                            var top = (window.innerHeight-height)/2;
                        }
                        else {
                            var left = (document.body.clientWidth-width)/2;
                            var top = (document.body.clientHeight-height)/2;
                        }
                        var factureWindow = window.open('','facture','menubar=yes, scrollbars=yes, top='+top+', left='+left+', width='+width+', height='+height+'');
                        factureText = "Facture pour : " + prenom +  " " + nom  ;
                        factureWindow.document.write(factureText);
                    }
                </script>
            </head>
            <xsl:param name="destinedId" select="001"/> 
            <body>
                <!-- La variable visitesDuJour contient l'ensemble des noeuds visite correspondant à l'infirmière.  -->
                <xsl:variable name="visitesDuJour" select="//med:patient[./med:visite/@intervenant = $destinedId]"/> 
                Bonjour <xsl:value-of select="/med:cabinet/med:infirmiers/med:infirmier[@id=$destinedId]/med:prénom"/>,<br></br> <!-- On veut le prenom de l'infirmiere.  -->
                Aujourd'hui, vous avez  <xsl:value-of select="count($visitesDuJour)"/> patient(s) <br></br>
                <ul>
                <xsl:apply-templates select="//med:patient[./med:visite/@intervenant = $destinedId]"/>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="med:patient">
        <br></br>
        <li>Nom : <xsl:value-of select="./med:nom"/></li>
        <li>Adresse : <xsl:value-of select="./med:adresse"/></li>
        <li>Soins : 
            <ul> 
                <xsl:apply-templates select="./med:visite/med:acte"/> 
            </ul>
        </li>
        <br></br>
            <button>
                <xsl:attribute name="onclick">
                openFacture('<xsl:value-of select="./med:prénom"/>','<xsl:value-of select="./med:nom"/>','<xsl:value-of select="med:actes"/>')
                </xsl:attribute> 
                facture
            </button> 
        <br></br>
    </xsl:template>

    <xsl:template match="med:acte">
        <!-- Pour chaque acte du patient -->
        <xsl:variable name="idActe" select="@id"/> 
        <!-- Pour chaque id du patient on regarde dans l'arborescence
        du fichiers actes.xml lorsque l'acte est égale à l'id du patient-->
        <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap/act:actes/act:acte[@id=$idActe]"/>
        <!-- Puis on affiche la description pour chauqe acte-->
        <li><xsl:value-of select="$actes"/></li>
    </xsl:template>

</xsl:stylesheet>
