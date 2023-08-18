program q3;
var i : Integer;
    commands : array [1..5] of char;
    actions : array [1..5] of
        record
            case command : char of
                'P' : (a, b, c : integer);
                'C' : (ch: char; d: Integer);
                'G' : (hw , final : Integer);
        end;

function isPythagorean (a,b,c : Integer) : Boolean;
begin
    isPythagorean := (a * a) + (b * b) = (c * c)
end;

function caesarCipher (ch : char ; d : Integer) : Char;
begin
    caesarCipher := chr(ord(ch) + d)
end;

function gradeCalc (hw, final : Integer) : Integer;
begin
    if final < 55 then
        gradeCalc := final
    else
        gradeCalc := Round((0.8 * final) + (0.2 * hw))
end;


begin
    for i := 1 to 5 do
        ReadLn(commands[i]);

    for i := 1 to 5 do
        begin
            actions[i].command := commands[i];
            case commands[i] of
                'P' : begin
                        ReadLn(actions[i].a);
                        ReadLn(actions[i].b);
                        ReadLn(actions[i].c)
                    end;
                'C' : begin
                        ReadLn(actions[i].ch);
                        ReadLn(actions[i].d)
                end;    
                'G' : begin
                        ReadLn(actions[i].hw);
                        ReadLn(actions[i].final)
                end;    
            end;
        end;

    for i := 5 downto 1 do
        begin
            case actions[i].command of
                'P' : WriteLn(isPythagorean(actions[i].a, actions[i].b, actions[i].c));
                'C' : WriteLn(caesarCipher(actions[i].ch, actions[i].d));
                'G' : WriteLn(gradeCalc(actions[i].hw, actions[i].final));
            end;
        end     
end.