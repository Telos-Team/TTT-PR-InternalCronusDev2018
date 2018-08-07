codeunit 50007 TTTPRObjectManagement
{
    trigger OnRun();
    begin
    end;
    
    var

    procedure OpenRecordRef(parintTableNo : Integer; parbooTemporary : Boolean; var parvarrrTable : RecordRef) : Boolean
    var
        locvarTable : Variant;
    begin
        if parintTableNo < 2000000000 then begin
            parvarrrTable.Open(parintTableNo);
            exit(true);
        end;
        if not GetSystemVirtualTableVariant(parintTableNo, parbooTemporary, locvarTable) then
            exit(false);
        parvarrrTable.Open(locvarTable);
        exit(true);
    end;

    procedure GetSystemVirtualTableVariant(parintTableNo : Integer; parbooTemporay : Boolean; var parvarvarTable : Variant) : Boolean;
    var
        locrecPermissionSet : Record "Permission Set";
        loctmprecPermissionSet : Record "Permission Set" temporary;
        locrecPermission : Record "Permission";
        loctmprecPermission : Record "Permission" temporary;
    begin
        case parintTableNo of
            database::Object :
                exit(false);
            database::"Permission Set" :
                if parbooTemporay then 
                    parvarvarTable := loctmprecPermissionSet
                else
                    parvarvarTable := locrecPermissionSet;
            database::"Permission" :
                if parbooTemporay then 
                    parvarvarTable := loctmprecPermission
                else
                    parvarvarTable := locrecPermission;
        end;
    end;

    procedure ConstructGetSystemVirtualTableVariantAL();
    var
        locrecAllObjWithCaption : Record AllObjWithCaption;
        loctbResult : TextBuilder;
        locrecTempBlob : Record TempBlob temporary;
        locstrmIn : InStream;
        locstrmOut : OutStream;
        loctxtClientFilename : Text;
    begin
        locrecAllObjWithCaption.SetRange("Object Type", locrecAllObjWithCaption."Object Type"::Table);
        // locrecAllObjWithCaption.FilterGroup(250);
        // locrecAllObjWithCaption.SetFilter("Object ID", '..%1', database::Session);
        locrecAllObjWithCaption.FilterGroup(0);
        locrecAllObjWithCaption.SetFilter("Object ID", '%1..', 2000000000);

        loctbResult.AppendLine(
            '    procedure GetSystemVirtualTableVariant(parintTableNo : Integer; parbooTemporay : Boolean; var parvarvarTable : Variant) : Boolean;');
        loctbResult.AppendLine(
            '    var');

        locrecAllObjWithCaption.FindSet;
        repeat
            loctbResult.AppendLine(
                strsubstno('        locrec%1 : Record "%2";', DelChr(locrecAllObjWithCaption."Object Name", '=', ' -.'), locrecAllObjWithCaption."Object Name"));
            loctbResult.AppendLine(
                strsubstno('        loctmprec%1 : Record "%2" temporary;', DelChr(locrecAllObjWithCaption."Object Name", '=', ' -.'), locrecAllObjWithCaption."Object Name"));
        until locrecAllObjWithCaption.next = 0;

        loctbResult.AppendLine('    begin');
        loctbResult.AppendLine('        case parintTableNo of');
        loctbResult.AppendLine('            database::Object :');
        loctbResult.AppendLine('                exit(false);');

        locrecAllObjWithCaption.FindSet;
        repeat

        loctbResult.AppendLine(
            StrSubstNo('            database::"%1" :', locrecAllObjWithCaption."Object Name"));
        loctbResult.AppendLine(
            StrSubstNo('                if parbooTemporay then'));
        loctbResult.AppendLine(
            StrSubstNo('                    parvarvarTable := loctmprec%1', DelChr(locrecAllObjWithCaption."Object Name", '=', ' -.')));
        loctbResult.AppendLine(
            StrSubstNo('                else'));
        loctbResult.AppendLine(
            StrSubstNo('                    parvarvarTable := locrec%1;', DelChr(locrecAllObjWithCaption."Object Name", '=', ' -.')));

        until locrecAllObjWithCaption.next = 0;

        loctbResult.AppendLine('        end;');
        loctbResult.AppendLine('    end;');

        Message('%1', loctbResult.ToText());
        
        locrecTempBlob.Blob.CreateOutStream(locstrmOut);
        locstrmOut.Write(loctbResult.ToText());
        locrecTempBlob.Blob.CreateInStream(locstrmIn);
        DownloadFromStream(locstrmIn, 'Select a file', '', '', loctxtClientFilename);
    end;

}
