program Lab4;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

const MaxIterations = 1024;

var Eps : double = 1e-5;

function GetFunctionRes(x : double) : double;
begin
      GetFunctionRes := 3 * x - 4 * Ln(x) - 5;
end;

function GetFunctionDerivative(x : double) : double;
begin
  const d = Eps / 1000.0;
  GetFunctionDerivative := (GetFunctionRes(x + d) - GetFunctionRes(x)) / d;
end;

function GetFunctionDerivative2(x : double) : double;
begin
  const d = Eps / 1000.0;
  GetFunctionDerivative2 := (GetFunctionDerivative(x + d) - GetFunctionDerivative(x)) / d;
end;

begin
  var a := 0.0;
  var b := 0.0;

  while True do
  begin
    Writeln('Enter interval: ');
    Readln(a, b);

    Writeln('Enter result tolerance: ');
    Readln(Eps);


    var x := a;

    if GetFunctionRes(x) * GetFunctionDerivative2(x) < 0.0 then
    begin
      x := b;

      if GetFunctionRes(x) * GetFunctionDerivative2(x) < 0.0 then
        Writeln('For the specified interval result is not guaranteed!');
    end;


    var iterations := 0;

    while True do
    begin
      if iterations > MaxIterations then
        break;

      var d := GetFunctionRes(x) / GetFunctionDerivative(x);
      x := x - d;

      if Abs(d) <= Eps then
        break;

      iterations := iterations + 1;
    end;

    Writeln('Approximate root is: ', x, ' found in ', iterations, ' iterations', #13#10);
  end;

end.
