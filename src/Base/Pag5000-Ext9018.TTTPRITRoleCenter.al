pageextension 50000 "TTTPR IT Role Center" extends "Administrator Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Embedding)
        {
            action("TTTPRObjectRunnerEmbedding")
            {
                ApplicationArea = All;
                Caption = 'Show Object Runner';
                ToolTip = 'Show the Object Runner List';
                RunObject = Page "TTTPRObjectRunner";
            }
        }

        addfirst(Processing)
        {
            group(TTTPRMainGroupProcessing)
            {
                Caption = 'TTTPR';
                ToolTip = 'TTTPR functionality';

                group(TTTPRGroupProcessing)
                {
                    Caption = 'TTTPR';
                    ToolTip = 'TTTPR functionality';
                    Image = WorkCenter;

                    group(Objects)
                    {
                        Caption = 'Objects';
                        ToolTip = 'Object functionality';
                        Image = SuggestTables;

                        action("ObjectRunnerProcessing")
                        {
                            Caption = 'Show Object Runner';
                            ToolTip = 'Show the Object Runner List';
                            ApplicationArea = All;
                            Image = "Table";
                            RunObject = page "TTTPRObjectRunner";
                        }
                    }
                }
            }
        }
        
        addfirst(Sections)
        {
            group(TTTPRGroupSections)
            {
                Caption = 'TTTPR';
                ToolTip = 'TTTPR Elements';
                Image = Dimensions;
                action("ObjectRunnerSections")
                {
                    Caption = 'Show Object Runner';
                    ToolTip = 'Show the Object Runner List';
                    ApplicationArea = All;
                    Image = "Table";
                    RunObject = page "TTTPRObjectRunner";
                }
            }
        }
    }
    
    var
        myInt : Integer;
}