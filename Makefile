all:
	gnatmake unboundedints.adb stackfunctions.adb stackfunctions.ads -Wall 
    
clean:
	rm unboundedints *.ali *.o