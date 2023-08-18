program PascalTriangle;
type Arr = array [1..16] of integer;

var n: integer;
var i: integer;
var line: array [1..16] of integer;

procedure next(var line: Arr; j: integer);
var temp: integer;
var sum: integer;
var i: integer;
begin
write(1, ' ');
temp := line[1];
for i := 2 to j-1 do
    begin
    sum := temp + line[i];
    write(sum, ' ');
    temp := line[i];
    line[i] := sum;
    end;
line[j] := 1;
write(1)
end;

begin
line[1] := 1;
ReadLn(n);
writeLn(1);
for i := 2 to n do
    begin
    next(line, i);
    writeLn('')
    end;
end.