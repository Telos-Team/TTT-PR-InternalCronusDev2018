page 50001 "TTTPRObjectRunner"
{
    Caption = 'Object Runner';
    PageType = List;
    SourceTable = TTTPRObjectRunner;
    SourceTableTemporary = true;
    Editable = false;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ObjectTypeName;ObjectTypeName)
                {
                    ApplicationArea = All;
                }
                field(ObjectID;ObjectID)
                {
                    ApplicationArea = All;
                }
                field(ObjectName;ObjectName)
                {
                    ApplicationArea = All;
                }
                field(ObjectCaption;ObjectCaption)
                {
                    ApplicationArea = All;
                }
                field(ObjectSubType;ObjectSubType)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action(RunObject)
            {
                Caption = 'Run Object';
                ToolTip = 'Run the selected object';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction();
                begin
                    RunObject();
                end;
            }
            action(ShowFieldList)
            {
                Caption = 'Show Field List';
                ToolTip = 'Show the Field List for selected table';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction();
                begin
                    ShowFieldList();
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        FillTable(rec);
    end;
}