--Assignment 1: software for legacy systems with Michael Wirth
--Author: Kent Spence, mail: kspenc05@mail.uoguelph.ca, student number: 0872780
--Date: 04/03/2016

--All information about each function header comments will be found in 
--stackfunctions.ads, which give a summary of what each function does

package body stackfunctions is


    function createStack (input: in String; len: Integer) return Stack is

        Top: Stack;
    begin 
    
        for i in Integer range 1 .. len loop --then set a value to it
            Top.items(i) := Integer'value(input(i .. i)); --convert each char to int
        end loop; 
    
        Top.size := len; --size of the stack, is determined by length of string
        if(len = 0) then
            Top.size := 1;
        end if;
        
        for i in Integer range Top.size + 1 .. 40 loop 
            Top.items(i) := 0;     --initalizes every element to 0
        end loop;
        
        return Top;
    end createStack;
    
    --WHY: enforces the interface of the type, by returning Stack1.size,
    --discourages mucking around with the size variable, and is more readable.
    function Size (Stack1: Stack) return Integer is
        
    begin
        return Stack1.size; 
    end size;   
   

    function Push (Stack1: Stack) return Stack is
    
        Stack2: Stack;
        temp : Integer;
    begin
    
        Stack2 := Stack1;
        
        for i in Integer Range 1 .. Stack1.size loop
    
            Stack2.items(i) := Stack1.items(i);
        end loop;
        
        Stack2.size :=  Stack1.size;
        
        for i in Integer Range 1 .. Stack2.size-1 loop
        
            Stack2.items(i+1) := Stack2.items(i);
            temp := Stack2.items(i);
            Stack2.items(i+1) := temp;
            
        end loop;
        
        return Stack2;
    end Push;
    
    function Operation (Stack1: Stack; Stack2: Stack; Operator: Character) return Stack is
    
        i, j, overflow, modulus, counter: Integer;
        Stack3 : Stack;
        
    begin
        overflow := 0;
        modulus := 0;
        counter:= 1;
        
        i := size(Stack1);
        j := size(Stack2);
        
        if( j > 1) then  --determines which size is bigger to give to Stack3.size
            Stack3.size := j;
            
        elsif ( i >= j) then
            Stack3.size := i;
            
        end if;

        for i in Integer Range 1 .. 40 loop
            Stack3.items(i) := 0;
        end loop;
        
        while i >= 1 or j >= 1 loop
            if(i >= 1 and j >= 1) then
                Stack3 := Push(Stack3); --make room on the stack before adding value to (1)

                case Operator is --determines which operator to use for digit overflow
                    when '+' =>
                        Stack3.items(1) := Stack1.items(i) + Stack2.items(j) + modulus;
                        
                    when '-' =>
                        Stack3.items(1) := Stack1.items(i) - Stack2.items(j) + modulus;
                        if Stack1.items(i+1) < Stack2.items(j+1) and size(Stack1) > 1 then
                        
                            Stack3.items(1) := Stack3.items(1) - 1;
                            Stack3.items(2) :=  Stack3.items(2) + 10;
                        end if;
                            
                    when '*' =>
                        Stack3.items(1) := Stack1.items(i) * Stack2.items(j) + modulus;
                        Stack3.items(1) := Stack1.items(i) * Stack2.items(j+1) + modulus;
                    
                    when others =>
                        Stack3.items(1) := 0;
                end case;
                
            --in the event one stack is bigger than another, determines which value to use
            elsif(i < 1) then
                Stack3 := Push(Stack3);
                Stack3.items(1) := Stack2.items(j) + modulus;
                
            elsif(j < 1) then
                Stack3 := Push(Stack3);
                Stack3.items(1) := Stack1.items(i) + modulus;
            end if;
            
            i := i - 1;
            j := j - 1;
            counter := counter + 1;
        end loop;
        
        for i in Integer range 1 .. size(Stack3) loop
        
            if(Stack3.items(i) > 9 and i > 1) then
            
                modulus := Stack3.items(i) mod 10; 
                
                case operator is
                    when '*' => --if it it's mulitiplication needs to be divided
                        Stack3.items(i) := 
                        Stack3.items(i) / 10; 
                        --if multiplying, divides it by 10
                      
                    when others =>
                        Stack3.items(i) := 
                        Stack3.items(i) - 10;
                        
                end case;
                
                if(operator = '+') then
                    Stack3.items(i-1) := Stack3.items(i-1) + 1;
                    
                elsif(operator = '*') then
                    Stack3.items(i-1) := Stack3.items(i-1) * modulus;
                    
                end if;
                
                if(Stack3.items(1) = 1) then
                    overflow := overflow + 1;
                end if;
                
                Stack3.size := overflow + Stack3.size; 
            
                if(operator = '*') then
                    Stack3.size := Stack1.size * Stack2.size;
                end if;
            end if;
        end loop;
        --put_line("result:"); -- *TESTING*: some code to test if result is correct
        --for i in Integer range 1 .. Stack3.size loop
         
            --put_line(Integer'Image(Stack3.items(i)));
        --end loop;
        --new_line;
        return Stack3;
    end Operation;
    
    function factorial(Stack1: Stack) return Stack is 
    
    begin
        return Stack1;
    end factorial;
        
end stackfunctions;