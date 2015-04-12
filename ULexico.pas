unit ULexico;

interface

uses UToken, ULexicalError, UConstants, SysUtils;

type
    TLexico = class
    public
        constructor create; overload;
        constructor create(input : string); overload;

        procedure setInput(input : string);
        procedure setPosition(pos : integer);
        procedure setEnd(endPos : integer);
        function nextToken : TToken; //raises ELexicalError

    private
        input : string;
        position : integer;
        endPos : integer;

        function nextState(c : char; state : integer) : integer;
        function tokenForState(state : integer) : integer;
        function lookupToken(base : integer; key : string) : integer;

        function hasInput : boolean;
        function nextChar : char;
    end;

implementation

constructor TLexico.create;
begin
    setInput('');
end;

constructor TLexico.create(input : string);
begin
    setInput(input);
end;

procedure TLexico.setInput(input : string);
begin
    self.input := input;
    setPosition(1);
    setEnd(Length(input));
end;

function TLexico.nextToken : TToken;
var
    start,
    oldState,
    state,
    endState,
    endPos,
    token : integer;
    lexeme : string;
begin
    if not hasInput then
        result := nil
    else
    begin
        start := position;

        state := 0;
        oldState := 0;
        endState := -1;
        endPos := -1;

        while hasInput do
        begin
            oldState := state;
            state := nextState(nextChar, state);

            if state < 0 then
                break

            else
            begin
                if tokenForState(state) >= 0 then
                begin
                    endState := state;
                    endPos := position;
                end;
            end;
        end;
        if (endState < 0) or ( (endState <> state) and (tokenForState(oldState) = -2) ) then
            raise ELexicalError.create(SCANNER_ERROR[oldState], start);

        position := endPos;

        token := tokenForState(endState);

        if token = 0 then
            result := nextToken
        else
        begin
            lexeme := Copy(input, start, endPos-start);
            token  := lookupToken(token, lexeme);
            result := TToken.create(token, lexeme, start);
        end;
    end;
end;

procedure TLexico.setPosition(pos : integer);
begin
    position := pos;
end;

procedure TLexico.setEnd(endPos : integer);
begin
    self.endPos := endPos;
end;

function TLexico.nextState(c : char; state : integer) : integer;
begin
    result := SCANNER_TABLE[state][c];
end;

function TLexico.tokenForState(state : integer) : integer;
begin
    if (state >= 0) and (state < STATES_COUNT) then
        result := TOKEN_STATE[state]
    else
        result := -1;
end;

function TLexico.lookupToken(base : integer; key : string) : integer;
var
    start, end_, half : integer;
    str : string;
begin
    result := base;

    start := SPECIAL_CASES_INDEXES[base];
    end_  := SPECIAL_CASES_INDEXES[base+1]-1;

    while start <= end_ do
    begin
        half := (start+end_) div 2;
        str := SPECIAL_CASES_KEYS[half];

        if str = key then
        begin
            result := SPECIAL_CASES_VALUES[half];
            break;
        end
        else if str < key then
            start := half+1
        else  //str > key
            end_ := half-1;
    end;
end;

function TLexico.hasInput : boolean;
begin
    result := position <= endPos;
end;

function TLexico.nextChar : char;
begin
    if hasInput then
    begin
        result := input[position];
        position := position + 1;
    end
    else
        result := char(0);
end;

end.
