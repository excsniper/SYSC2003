
char collision_detection(char *speed, unsigned int *proximity)
{
		
 	 if ( !(*proximity & 0x8000) )	//ANDing proximity to check for collision
	 {
	  	*speed = *speed << 1;		//if none, speed *= 2
		return 0;				
	 }
	 else	//if so
	 {
	 
		if( !(*proximity & 0x0003) ) //check for N, NE
		 	*proximity = (*proximity | 0x0200) & 0xFEFF;	//robot -> left
		else if( !(*proximity & 0x0007) || !((*proximity & 0x0007)-1) )	//check for S, SW
			*proximity = (*proximity | 0x0100) & 0xFDFF;	//robot -> right
		else	//any other directions
			*speed = *speed >> 3;	//speed /= 8

			return 1;
	 }
}

void main()
{
 	 //Speed: 01101011b (0x6B)
	 
	 char speed = 0x6B;
 	 unsigned int proxomity = 0x02C5; //Proxomity: 0000001011000101b (0x02C5)
	 printf("  Proximity: 0x%x Speed: 0x%x\n", proxomity, speed);
	 collision_detection(&speed, &proxomity);
	 printf("> Proximity: 0x%x Speed: 0x%x\n\n", proxomity, speed);
	 
	 speed = 0x6B;
	 proxomity = 0x81C4; //Proxomity: 1000000111000100b (0x81C4)
	 printf("  Proximity: 0x%x Speed: 0x%x\n", proxomity, speed);
	 collision_detection(&speed, &proxomity);
	 printf("> Proximity: 0x%x Speed: 0x%x\n\n", proxomity, speed);

	 speed = 0x6B;
	 proxomity = 0x82C1; //Proxomity: 1000001011000001b (0x82C1)
	 printf("  Proximity: 0x%x Speed: 0x%x\n", proxomity, speed);
	 collision_detection(&speed, &proxomity);
	 printf("> Proximity: 0x%x Speed: 0x%x\n\n", proxomity, speed);

	 speed = 0x6B;	 
	 proxomity = 0x80C5; //Proxomity: 1000000011000101b (0x80C5)
	 printf("  Proximity: 0x%x Speed: 0x%x\n", proxomity, speed);
	 collision_detection(&speed, &proxomity);
	 printf("> Proximity: 0x%x Speed: 0x%x\n\n", proxomity, speed);
	 
	 asm("SWI"); 
}
