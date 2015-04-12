unit USyntaticError;

interface

uses UAnalysisError;

type
    ESyntaticError = class(EAnalysisError)
    public
        constructor create(message:string; position:integer); overload;
        constructor create(message:string); overload;
    end;

implementation

constructor ESyntaticError.create(message:string; position:integer);
begin
    inherited create(message, position);
end;

constructor ESyntaticError.Create(message:string);
begin
    inherited create(message);
end;

end.
