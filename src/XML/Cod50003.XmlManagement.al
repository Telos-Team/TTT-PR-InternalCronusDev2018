codeunit 50003 TTTPRXmlManagement
{
    trigger OnRun();
    begin
        TestorLoadClientXml();
        TestorCreateXml();
    end;
    
    var
    
    local procedure TestorLoadClientXml();
    var
        locxmlDoc : XmlDocument;
        locbooOK : Boolean;
    begin
        locbooOK := LoadClientXml(locxmlDoc);
        // Message('%1', format(xmlDoc));
        Message('LoadXml:\%1, %2', locbooOK, locxmlDoc.GetChildNodes.Count);
    end;

    local procedure LoadClientXml(var parvarxmlDoc : XmlDocument) : Boolean;
    var
        loctxtClientFilename : Text;
        locstrmXml : InStream;
    begin
        loctxtClientFilename := '';
        if not UploadIntoStream('Select file', '', '', loctxtClientFilename, locstrmXml) then
            exit;
        if not XmlDocument.ReadFrom(locstrmXml, parvarxmlDoc) then
            exit;
        exit(true);
    end;


    local procedure TestorCreateXml();
    var
        locxmlDoc : XmlDocument;
        locbooOK : Boolean;
        loctxtXml : Text;
    begin
        locbooOK := CreateXml(locxmlDoc);
        Message('CreateXml:\%1, %2', locbooOK, locxmlDoc.GetChildNodes.Count);
        if locxmlDoc.WriteTo(loctxtXml) then
            message('%1', loctxtXml);
    end;
    local procedure CreateXml(var parvarxmlDoc : XmlDocument) : Boolean;
    var
        locxmlDecl : XmlDeclaration;
        locxmlRoot : XmlElement;
        locxmlElem : XmlElement;
    begin
        parvarxmlDoc.RemoveNodes();
        locxmlDecl := XmlDeclaration.Create('1.0', 'utf-8', '');
        if not parvarxmlDoc.SetDeclaration(locxmlDecl) then
            exit(false);
        locxmlRoot := XmlElement.Create('RootNode');
        if not parvarxmlDoc.Add(locxmlRoot) then
            exit(false);
        locxmlElem := XmlElement.Create('FirstNode', '', 'Value');
        locxmlRoot.Add(locxmlElem);
        exit(true);
    end;
}