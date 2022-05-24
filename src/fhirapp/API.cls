Class fhirapp.API Extends %CSP.REST
{

Parameter CONTENTTYPE = "application/json";

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
  <Route Url="/" Method="GET" Call="GetStatus"/>
  <Route Url="/import" Method="GET" Call="Import"/>
</Routes>
}

ClassMethod GetStatus() As %Status
{
  Set json = {
    "status": "OK"
  }
  Do json.%ToJSON()
  Quit $$$OK
}

ClassMethod Import() As %Status
{
  Set %response.ContentType = "text/plain"
  New $Namespace 
  Set $Namespace = "FHIRSERVER"
  Try {
    Set logGN = $Name(^IRIS.Temp.FHIRSubmitLog($Job))
    Set tSC = ##class(HS.FHIRServer.Tools.DataLoader).SubmitResourceFiles("/home/irisowner/fhirdata/", "FHIRServer", "/fhir/r4", 1, logGN)
  } Catch (e) {
    Set tSC=e.AsStatus()
  }
  Quit tSC
}

}
