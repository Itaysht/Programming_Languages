program safePassword;
var hist: array ['a'..'z'] of integer;
var firstWord: string;
var secondWord: string;
var i: integer;
var isSafe: boolean;
var c: char;

begin
    
    isSafe := true;
    
    for c:='a' to 'z' do
    begin
        hist[c] := 0;
    end;

    ReadLn(firstWord);
    ReadLn(secondWord);
    for i:=1 to Length(firstWord) do 
    begin
        hist[firstWord[i]] := hist[firstWord[i]] + 1;
    end;
    
    for i:=1 to Length(secondWord) do 
    begin
        if hist[secondWord[i]] > 0 then isSafe := false;
    end;
    
    if isSafe then WriteLn('TRUE') else WriteLn('FALSE');
    
    for i:=1 to Length(secondWord) do 
    begin
        hist[secondWord[i]] := hist[secondWord[i]] + 1;
    end;
    
    for c:='a' to 'z' do
    begin
        if hist[c] > 0 then WriteLn(c, ' ', hist[c]);
    end;
    
end.

