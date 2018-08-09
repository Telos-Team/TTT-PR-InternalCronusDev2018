codeunit 50008 TTTPRAzureFunctionsSimple
{
    Description = 'TTTPR';
    Subtype = Normal;

    // https://tttpr-functionapp.azurewebsites.net 

    trigger OnRun();
    begin
        TestSimpleHelloWorld()
    end;
    
    var
    local procedure TestSimpleHelloWorld();
    var
        loclblUrl : label 'https://tttpr-functionapp.azurewebsites.net/api/HelloWorld';
        lochttpContent : HttpContent;
        lochttpClient : HttpClient;
        lochttpResponse : HttpResponseMessage;
        lochttpHeaders : HttpHeaders;
        locjsonObject : JsonObject;
        locjsonToken : JsonToken;
        locbooPostResult : Boolean;
        locbooReadResult : Boolean;
        loctxtReturnValue : Text;
    begin
        locjsonObject.Add('hello', 'WORLD!');
        locjsonToken := locjsonObject.AsToken();
        //lochttpContent.WriteFrom(locjsonToken);
        lochttpContent.WriteFrom('{"helo":"WORLD!"}');
        lochttpContent.GetHeaders(lochttpHeaders);
        lochttpHeaders.Remove('content-type');
        lochttpHeaders.Add('content-type', 'application/json');
        locbooPostResult := lochttpClient.Post(loclblUrl, lochttpContent, lochttpResponse);
        lochttpContent := lochttpResponse.Content();
        locbooReadResult := lochttpContent.ReadAs(loctxtReturnValue);
        locbooPostResult :=not  locbooPostResult;
        message('Post: %1\Read: %2\Value: %3', locbooPostResult, locbooReadResult, loctxtReturnValue);
    end;
}