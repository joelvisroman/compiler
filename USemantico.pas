unit USemantico;

interface

uses UToken, USemanticError;

type
    TSemantico = class
    public
        procedure executeAction(action : integer; const token : TToken); //raises ESemanticError
    end;

implementation

procedure TSemantico.executeAction(action : integer; const token : TToken);
begin

end;

end.
