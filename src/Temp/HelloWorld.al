// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

// pageextension 50100 CustomerListExt extends "Customer Card" 
// {
//     addfirst(Processing)
//     {
//         action("ObjectRunner2")
//         {
//             Caption = 'Object Runner2';
//             ToolTip = 'Show the Object Runner list2';
//             ApplicationArea = All;
//             Image = "Table";
//             RunObject = page "Customer Card";
//         }
//     }
// }