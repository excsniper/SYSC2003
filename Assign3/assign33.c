
char displaySystemStatus(char speed, char temperature, unsigned int proximity, unsigned int *keysPressed)
{
 	 printf("Speed: 0x%x\n", speed);				//print speed
	 printf("Temperature: 0x%x\n", temperature);	//print temperature
	 printf("Proximity: ", proximity);				//print proximity
	 
	 if(proximity & 0x0080)							//print heading
	 	printf("Forward, ");
     else
	 	printf("Backward, ");
	 
	 switch(proximity & 0x0007)						//ANDing proximity to ignore all but 3 LSB
	 {												//print direction according to 3 LSB
	  		case 0:
				 printf("N");
				 break;
	  		case 1:
				 printf("S");
				 break;
	  		case 2:
				 printf("E");
				 break;
	  		case 3:
				 printf("W");
				 break;
	  		case 4:
				 printf("NE");
				 break;
	  		case 5:
				 printf("NW");
				 break;
	  		case 6:
				 printf("SE");
				 break;
	  		case 7:
				 printf("SW");
				 break;				 				 				 				 				 				 
	 }
	 
	 if(proximity & 0x8000)						//ANDing proximity to check if there's an obstacle
	 	 printf(" ** Obstacles Nearby! **");	//if so print the message
		
	 printf("\n");								
	 printf("Keys Pressed: 0x%x\n", *keysPressed);	//print the keys pressed
	 return 1;	//always return 1
}

void main()
{
 	 /*
 	 Speed: 10110001b (0xB1)
	 Temperature: 10101011b (0xAB)
	 Proximity: 1111111100001100b (0xFF0C)
	 Keys Pressed: 100100100101010b (0x492A)
	 */

 	 unsigned int keys = 0x492A;
 	 displaySystemStatus(0xB1, 0xAB, 0xFF0C, &keys);
	 
	 asm("SWI");	//inline asm to pause the chip
}
