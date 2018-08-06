table 50001 TTTPRTableFilterExample1
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;LineNo;Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(2;ObjectID;Integer)
        {
            Caption = 'Object ID';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(3;ObjectName;Text[30])
        {
            Caption = 'Object Name';
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Name" where ("Object ID" = field(ObjectID)));
            Editable = false;
        }
        field(4;FilterString;TableFilter)
        {
            Caption = 'Table Filter';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK;LineNo)
        {
            Clustered = true;
        }
    }
    
    var
        myInt : Integer;

    trigger OnInsert();
    begin
    end;

    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

}