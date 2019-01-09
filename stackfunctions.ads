--Assignment 1: software for legacy systems with Michael Wirth
--Author: Kent Spence, mail: kspenc05@mail.uoguelph.ca, student number: 0872780
--Date: 04/03/2016

--This package is designed to deal with unbounded Integers using a stackfunctions.
--The type is a simple record that has an array of ints and a int to store the size.


package stackfunctions is


    type item is array (Integer range 1 .. 40) of Integer; 
    type Stack is                                          
        record
            items : item;
            size : Integer;
    end record;               --Stack type
    
    
    
    --PURPOSE: creates a stack using the string of user input
    --ARGUMENTS: input string, and the length of that line 
    --returns the newly created Stack
    
    function createStack (input: in String; len: in Integer) return Stack;
    


    --PURPOSE: adds, multiples or subtracts two stacks based on value of Operator
    --if Operator is '+' performs addition, '-' performs subtratction,
    --or if it is '*' performs multiplication on both stacks.
    --Arguments: Stack1, Stack2
    --the result of the performed operation is stored in another stack,
    --which is then returned
    
    function Operation (Stack1: Stack; Stack2: Stack; Operator: Character) return Stack;
    
    
    
    --PURPOSE: determines size of Stack
    --ARGUMENTS: the stack in question
    --returns the Integer size of that Stack
    
    function Size (Stack1: Stack) return Integer;
    
    
    
    --PURPOSE: copies each element to the next position, 1 will be copied to 2, 
    --so that you can store the next element at 1
    --ARGUENTS: the Stack you wish to push an element on to
    --returns the Stack with the newly 
    
    function Push (Stack1: Stack) return Stack;
    
    
    
    --PURPOSE: determines the factorial of a given stack
    --ARGUMENTS: the given stack
    --NOTE: is still currently a stub, did not get around to implementing this 
    --properly, so it just returns the stack you give it.
    
    function factorial(Stack1: Stack) return Stack;
    
    
    
end stackfunctions;

--IMPORTANT NOTE: I did not create a pop function, this is because stacks are 
--continually re-initialized during the program's run, and 
--since it is a sequential stack, there is no issue of freeing dynamically
--allocated memory.

--Although "Pop" is an important function for a Stack to have, for this program
--I felt it was not that necessary to include