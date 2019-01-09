--Assignment 1: software for legacy systems with Michael Wirth
--Author: Kent Spence, mail: kspenc05@mail.uoguelph.ca, student number: 0872780
--Date: 04/03/2016

--PURPOSE: uses stackFunctions the I have made to handle unbounded integer operations
--fair warning: the operations still do not always work correctly... unfortunately

with Ada.TEXT_IO, stackFunctions;
use stackfunctions;

procedure unBoundedInts is

    use Ada.TEXT_IO;
    
    input1, input2, input3, quit: String (1 .. 80);
    correct : Boolean;
    --"correct" is used to show if operator is valid or not
    len1, len2, len3, num: Integer; 
    Stack1: Stack;

    --PURPOSE: display warnings depending on the operator given
    --informs user how subtraction works, and what operand is used for the factorial
    procedure displayWarnings (operator: character) is
    
    begin
        if operator = '-' then
            put("NOTE: Subtraction is performed: ");
            put("(operand1 - operand2) on this system"); new_line;
        end if;
        
        if operator = '!'  then
            put("NOTE: will determine the factorial of operand1");
            put("operand2 WILL NOT be used"); new_line;
        end if;
    
    end displayWarnings;


    --PURPOSE: prints the result stored in the stack of previous operation
    --NOTE: defensively speaking, it 
    -- is only called if a valid operation has been performed, and
    --that operation is greater than 0 characters.
    procedure printResult (Stack1 : Stack) is
    
    begin
        put_line("Result:");
        for i in Integer Range 1 .. size(Stack1) loop
            put(Integer'Image(Stack1.items(i)));
        end loop; 
        
        new_line; --so the numbers are printed on one line
    end printResult;
        
 
begin

    quit(1 .. 1) := " ";
    
    while quit(1 .. 1) /= "y" and quit(1 .. 1) /= "Y" loop
        
        correct := true;
        put_line("> Enter an Operation: + , - , * , !");
        get_line(input1, len1);
        
        displayWarnings(input1(1));
    
        put_line("> Enter first operand (any whole number):"); 
        get_line(input2, len2);
        
        put_line("> Enter second operand (any whole number):"); 
        get_line(input3, len3);
    
        case input1(1) is
            when '+' =>
                Stack1 := Operation(createStack(input2, len2), createStack(input3, len3), '+');
                --creates two stacks then adds them together
                
            when '-' =>
                Stack1 := Operation(createStack(input2, len2), createStack(input3, len3), '-');
                --same except with subtraction
                
            when '*' =>
                Stack1 := Operation(createStack(input2, len2), createStack(input3, len3), '*');
                
            when '!' =>
                Stack1 := factorial(createStack(input2, len2));
                --only operation not handled by Operation() is factorials
                
            when others =>
                correct := false;
                
                put_line("error (not-fatal):");
                put("Invalid operation, ");
                put("should be '+', '-', '*', or '!'"); new_line;
                new_line;
                
        end case;
        
        if(correct /= false and len1 > 0) then
            printResult(Stack1);
        end if;
        
        put_line("Would you like to quit? ('y' or 'n' / yes or no)");
        get_line(quit, num);
    end loop;
    
end unBoundedInts;