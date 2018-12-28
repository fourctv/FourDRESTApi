<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output 
        method="html" 
        encoding="UTF-8"
        version="1.0"
        doctype-public="-//W3C//DTD HTML 4.01//EN"
        doctype-system="http://www.w3.org/TR/html4/strict.dtd"
        indent="yes"
        standalone="yes"
    />

    <xsl:template match="verifylog">
        <html>
            <head>
                <title>4D Maintenance and Security Center Log</title>
                <style type="text/css">
                    html
                    {
                        text-align: center;
                    }
                    body  
                    { 
                        background: #fff; 
                        color: #333;
                        text-align: left;
                        font-size: 11pt;
                        font-family: Verdana, Helvetica, sans-serif; 
                        margin: 0px; 
                        padding: 0px; 
                    }
                    a, a:visited 
                    {
                        color: #036;
                    }
                    h1 
                    {
                        color: #036;
                        margin: 5px auto;
                    }
                    h2
                    {
                        font-size: small;
                        font-weight: bold;
                        color: #036;
                        padding: 2px 10px;
                        border: 1px solid #036;
                        background-color: #eee;
                    }
                    h3
                    {
                        display: list-item;
                        list-style-type: square;
                        list-style-position: inside;
                        margin: 0;
                        padding-bottom: 3px;
                        font-size: small;
                        font-weight: normal;
                    }
                    table
                    {
                        text-align: left;
                        border: 1px solid #036;
                        width: 100%;
                    }
                    td, th
                    {
                        padding: 2px 10px;
                        font-size: x-small;
                    }
                    #header
                    {
                        margin: 0 10px;
                        text-align: center;
                    }
                    #header ul#menu
                    {
                        font-size: x-small;
                        list-style-type: none;
                    }
                    #header ul#menu li
                    {
                        display: inline;
                        padding: 5px 10px;
                    }
                    #contents
                    {
                        margin: 0 10px;
                    }
                    table#summary, table.move
                    {
                        color: #036;
                    }
                    table#summary tr td, table.move tr td
                    {
                        background-color: #eee;
                    }
                    table#summary tr td:first-child, table.move tr td:first-child 
                    {
                        font-weight: bold;
                        width: 200px;
                        background-color: #036;
                        color: #fff;
                        text-align: right;
                    }
					b.canceled
					{
						font-weight: bold;
						color: forestgreen;
					}
                    .operations
                    {
                        display: block;
                        margin: 0;
                        padding: 0;
                    }
                    .hidden
                    {
                        display: none;
                    }
                    .operation
                    {
                        display: block;
                        margin: 0;
                        margin-left: 20px;
                    }
                    a.ok, a.ok:visited, .ok
                    {
                        color: forestgreen;
                    }
                    a.error, a.error:visited 
                    {
                        color: #f00;
                    }
                    a.warning, a.warning:visited
                    {
                        color: #f4ae36; 
                    }
                    h3 b.ok
                    {
                        font-weight: normal;
                    }
                    ul.errorsAndWarnings
                    {
                        list-style-type: none;
                        border: 1px dotted #036;
                        margin: 0;
                        padding: 2px 10px;
                        font-size: x-small;
                    }
                    li.error
                    {
                        margin: 2px 0;
                        border-left: 5px solid #f00;
                        padding-left: 5px;
                    }
                    li.warning
                    {
                        margin: 2px 0;
                        padding-left: 5px;
                        border-left: 5px solid #f4ae36;
                    }
                </style>
            
                <script type="text/javascript">
                    <xsl:comment>
                        <![CDATA[
                            function display(calque)
                            { 
                                if(document.getElementById(calque).className == "operations hidden")
                                    document.getElementById(calque).className = "operations";
                                else 
                                    document.getElementById(calque).style.display = document.getElementById(calque).style.display == "none" ? "block" : "none";
                            }
                            
                            function showAll()
                            {
                                var x = document.getElementsByTagName('div');
                                for (i = 0 ; i < x.length ; i++)
                                {
                                    if(x[i].className == "operations hidden")
                                       x[i].className = "operations";
                                       
                                    else if(x[i].className == "operation hidden")
                                       x[i].className = "operation"; 
                                    
                                    if(x[i].className == "operations" || x[i].className == "operations" )
                                        x[i].style.display = "block"; 
                                }
                                showErrorsOrWarnings('error');
                                showErrorsOrWarnings('warning');
                            }
                            
                            function hideAll()
                            {
                                var x = document.getElementsByTagName('div');
                                for (i = 0 ; i < x.length ; i++)
                                    if(x[i].className == "operations" || x[i].className == "operations")
                                        x[i].style.display = "none"; 
                                hideErrorsOrWarnings('error');
                                hideErrorsOrWarnings('warning');
                            }
                            
                            function showErrorsOrWarnings(errorsOrWarnings)
                            {
                                var x = document.getElementsByTagName('li');
                                var y = '';
                                for (i = 0 ; i < x.length ; i++)
                                    if(x[i].className == errorsOrWarnings)
                                    {
                                        y = x[i].parentNode;
                                        while(y.className == "errorsAndWarnings" || y.className == "operation" || y.className == "operations")
                                        {
                                            y.style.display = "block";
                                            y = y.parentNode;
                                        }
                                    }
                            }
                            
                            function hideErrorsOrWarnings(errorsOrWarnings)
                            {
                                var x = document.getElementsByTagName('li');
                                for (i = 0 ; i < x.length ; i++)
                                {
                                    if(x[i].className == errorsOrWarnings)
                                    {
                                        x[i].parentNode.style.display = "none"; 
                                    }
                                }
                            }
                        ]]> 
                    </xsl:comment>
                </script>
            </head>
            
            <body>
                <div id="header">
                    <h1><xsl:value-of select="@name"/></h1>
                    <table id="summary">
                        <tr>
                            <td><xsl:text>Operation:</xsl:text></td>
                            <td><xsl:value-of select="@operation" /></td>
                        </tr>
                        <tr>
                            <td><xsl:text>Structure file:</xsl:text></td>
                            <td><xsl:value-of select="@structure" /></td>
                        </tr>
                        <tr>
                            <td><xsl:text>Data file:</xsl:text></td>
                            <td><xsl:value-of select="@data" /></td>
                        </tr>
                        <tr>
                            <td><xsl:text>OS: </xsl:text></td>
                            <td><xsl:value-of select="@os" /></td>
                        </tr>
                    
                        <xsl:for-each select="start_timer">
                        <tr>
                            <td><xsl:text>Started on: </xsl:text></td>
                            <td><xsl:value-of select="@time" /></td>
                        </tr>
                        </xsl:for-each>
                    
                        <xsl:for-each select="stop_timer">
						<tr>
							<td><xsl:text>Ended on: </xsl:text></td>
							<td><xsl:value-of select="@time" />
							<xsl:if test="@user_canceled = 'true'">
								<xsl:text>, </xsl:text>
								<b class="canceled"><xsl:text>canceled by user</xsl:text></b>
								</xsl:if>
							</td>
                     	</tr>
                        </xsl:for-each>
                    </table>
                    <ul id="menu">
                        <li>
                            <a href="#" onclick="showAll();"><xsl:text>Show all</xsl:text></a><xsl:text> / </xsl:text><a href="#" onclick="hideAll();"><xsl:text>Hide all</xsl:text></a>
                        </li>
                        <li>
                            <a href="#" onclick="showErrorsOrWarnings('error');"><xsl:text>Show errors</xsl:text></a><xsl:text> / </xsl:text><a href="#" onclick="hideErrorsOrWarnings('error');"><xsl:text>Hide errors</xsl:text></a>
                        </li>
                        <li>
                            <a href="#" onclick="showErrorsOrWarnings('warning');"><xsl:text>Show warnings</xsl:text></a><xsl:text> / </xsl:text><a href="#" onclick="hideErrorsOrWarnings('warning');"><xsl:text>Hide warnings</xsl:text></a>
                        </li>
                    </ul>
                </div>
                
                <div id="contents">
                    <xsl:for-each select="step"><xsl:comment>Verify</xsl:comment>
                        <xsl:call-template name="displayMainStep">
                            <xsl:with-param name="toto" select="''"/>
                        </xsl:call-template>    
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="displayMainStep">
    
        <xsl:variable name="nbSteps"><xsl:value-of select="count(step)"/></xsl:variable>
        <xsl:variable name="operationsID"><xsl:value-of select="generate-id()"/></xsl:variable>
        <xsl:variable name="DivNumber"><xsl:value-of select="generate-id()"/></xsl:variable>
        <xsl:variable name="nbErrors"><xsl:value-of select="count(descendant::error)"/></xsl:variable>		
        <xsl:variable name="nbWarnings"><xsl:value-of select="count(descendant::warning)"/></xsl:variable>
        
        <xsl:if test="$nbErrors &gt; 0 or $nbWarnings &gt; 0">
        <h2>
            <xsl:number value="position()"/><xsl:text>. </xsl:text><xsl:value-of select="@title" />
            <xsl:if test="$nbErrors &gt; 0">
                <xsl:text> [</xsl:text>
                <a class="error" href="#{$DivNumber}" onclick="display('{$DivNumber}');">
                    <xsl:value-of select="$nbErrors"/>
                    <xsl:choose>
                        <xsl:when test="$nbErrors=1">
                            <xsl:text> error</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> errors</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </a>
                <xsl:text>] </xsl:text>
            </xsl:if>
            <xsl:if test="$nbWarnings &gt; 0">
                <xsl:text> [</xsl:text>
                <a class="warning" href="#{$DivNumber}" onclick="display('{$DivNumber}');">
                    <xsl:value-of select="$nbWarnings"/>
                    <xsl:choose>
                        <xsl:when test="$nbWarnings=1">
                            <xsl:text> warning</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> warnings</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </a>
                <xsl:text>] </xsl:text>
            </xsl:if>
        </h2>	 
        </xsl:if>
        
        <xsl:if test="$nbErrors=0 and $nbWarnings = 0">
        <h2>
            <xsl:number value="position()"/><xsl:text>. </xsl:text><xsl:value-of select="@title"/>
            <xsl:choose>
                <xsl:when test="$nbSteps=0">    
                    <xsl:text> [</xsl:text><b class="ok"><xsl:text>OK</xsl:text></b><xsl:text>]</xsl:text>
                </xsl:when>
                <xsl:otherwise>    
                    <xsl:text> [</xsl:text><a href="#{$operationsID}" onclick="display('{$operationsID}');" class="ok"><xsl:text>OK</xsl:text></a><xsl:text>]</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </h2>
        </xsl:if>
            
        <xsl:if test="$nbSteps &gt; 0 or $nbErrors &gt; 0 or $nbWarnings &gt; 0">
            <xsl:choose>
                <xsl:when test="$nbErrors=0 and $nbWarnings=0">
                    <div id="{$operationsID}" class="operations hidden">  
                        <xsl:for-each select="step">
                            <xsl:call-template name="displayStep">
                                <xsl:with-param name="toto" select="''"/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <div id="{$operationsID}" class="operations">
                        <xsl:call-template name="ManageErrors">
                            <xsl:with-param name="toto" select="''"/>
                        </xsl:call-template>
                        <xsl:for-each select="step">
                            <xsl:call-template name="displayStep">
                                <xsl:with-param name="toto" select="''"/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        
        <xsl:for-each select="move">
            <div class="SubTitle">
                <table class="Error">
                    <tr>
                        <td><b><xsl:text>Source : </xsl:text></b></td>
                        <td><xsl:value-of select="@from" /></td>
                    </tr>
                    <tr>
                        <td><b><xsl:text>Destination : </xsl:text></b></td>
                        <td><xsl:value-of select="@to" /></td>
                    </tr>
                </table>		
            </div>
        </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template name="displayStep">
    
        <xsl:variable name="nbSteps"><xsl:value-of select="count(step)"/></xsl:variable>
        <xsl:variable name="operationsID"><xsl:value-of select="generate-id()"/></xsl:variable>
        <xsl:variable name="DivNumber"><xsl:value-of select="generate-id()"/></xsl:variable>
        <xsl:variable name="nbErrors"><xsl:value-of select="count(child::error)"/></xsl:variable>		
        <xsl:variable name="nbWarnings"><xsl:value-of select="count(child::warning)"/></xsl:variable>
        <xsl:variable name="totalNbErrors"><xsl:value-of select="count(descendant::error)"/></xsl:variable>		
        <xsl:variable name="totalNbWarnings"><xsl:value-of select="count(descendant::warning)"/></xsl:variable>
        
        <div class="operation">
        
            <xsl:if test="$nbErrors &gt; 0 or $nbWarnings &gt; 0">
                <h3>
                    <xsl:value-of select="@title" />
                    <xsl:if test="$nbErrors &gt; 0">
                        <xsl:text> [</xsl:text>
                        <a class="error" href="#{$DivNumber}" onclick="display('{$DivNumber}');">
                            <xsl:value-of select="$nbErrors"/>
                            <xsl:choose>
                                <xsl:when test="$nbErrors=1">
                                    <xsl:text> error</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text> errors</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                        <xsl:text>] </xsl:text>
                    </xsl:if>
                    <xsl:if test="$nbWarnings &gt; 0">
                        <xsl:text> [</xsl:text>
                        <a class="warning" href="#{$DivNumber}" onclick="display('{$DivNumber}');">
                            <xsl:value-of select="$nbWarnings"/>
                            <xsl:choose>
                                <xsl:when test="$nbWarnings=1">
                                    <xsl:text> warning</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text> warnings</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                        <xsl:text>] </xsl:text>
                    </xsl:if>
                </h3>	 
            </xsl:if>
            
            <xsl:if test="$nbErrors=0 and $nbWarnings = 0">
                <h3>
                    <xsl:value-of select="@title"/>
                    <xsl:choose>
                        <xsl:when test="$nbSteps=0">    
                            <xsl:text> [</xsl:text><b class="ok"><xsl:text>OK</xsl:text></b><xsl:text>]</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>    
                            <xsl:text> [</xsl:text><a href="#{$operationsID}" onclick="display('{$operationsID}');" class="ok"><xsl:text>OK</xsl:text></a><xsl:text>]</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </h3>
            </xsl:if>
                                    
            <xsl:if test="$nbErrors &gt; 0 or $nbWarnings &gt; 0">
                <div id="{$DivNumber}" class="operations"><xsl:comment>Error list</xsl:comment>
                    <xsl:call-template name="ManageErrors">
                        <xsl:with-param name="toto" select="''"/>
                    </xsl:call-template>
                </div>									
            </xsl:if>
        
            <xsl:if test="$nbSteps &gt; 0">
                <xsl:choose>
                    <xsl:when test="$totalNbErrors=0 and $totalNbWarnings=0">
                        <div id="{$operationsID}" class="operations hidden">    
                            <xsl:for-each select="step">
                                <xsl:call-template name="displayStep">
                                    <xsl:with-param name="toto" select="''"/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div id="{$operationsID}" class="operations">    
                            <xsl:for-each select="step">
                                <xsl:call-template name="displayStep">
                                    <xsl:with-param name="toto" select="''"/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        
            <xsl:for-each select="move">
                <table class="move">
                    <tr>
                        <td><xsl:text>Source:</xsl:text></td>
                        <td><xsl:value-of select="@from" /></td>
                    </tr>
                    <tr>
                        <td><xsl:text>Destination:</xsl:text></td>
                        <td><xsl:value-of select="@to" /></td>
                    </tr>
                </table>		
            </xsl:for-each>
    
        </div>
        
    </xsl:template>
    
    <xsl:template name="ManageErrors">
    
        <xsl:if test="count(error) &gt; 0 or count(warning) &gt; 0">
            <ul class="errorsAndWarnings">
                <xsl:for-each select="error">
                <li class="error">
                    <xsl:value-of select="text()"/>
					<xsl:if test="@error_type!=0 or @error_num!=0">
						<xsl:text> (</xsl:text><xsl:value-of select="@error_type"/><xsl:text>;</xsl:text><xsl:value-of select="@error_num"/><xsl:text>)</xsl:text>
					</xsl:if>
				</li>
                </xsl:for-each>
                    
                <xsl:for-each select="warning">
                <li class="warning">
                    <xsl:value-of select="text()"/>
					<xsl:if test="@warning_type!=0 or @warning_num!=0">
						<xsl:text> (</xsl:text><xsl:value-of select="@warning_type"/><xsl:text>;</xsl:text><xsl:value-of select="@warning_num"/><xsl:text>)</xsl:text>
					</xsl:if>
				</li>
                </xsl:for-each>	
            </ul>
        </xsl:if>
        
    </xsl:template>

</xsl:stylesheet>