#include <wiringPi.h> 
#include <wiringSerial.h> 
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int getValue();

int main(int argc,char** argv){
	int fd;
	int value;
	int triesLeft;
	char waveMeterValueFileName[] ="/home/pi/.wavelength";
	FILE *waveMeterValueFile;
	int	baud=9600;
	wiringPiSetup();


	waveMeterValueFile=fopen(waveMeterValueFileName,"w");

	fd=serialOpen("/dev/ttyAMA0",baud);
	delay(50);

	//printf("Data available: %d\n",serialDataAvail(fd));
	value = 0;
	triesLeft=5;
	while(value < 700 && triesLeft > 0){
		//printf("Running the loop\n");
		value=getValue(fd);
		triesLeft--;
	}

	if(value==-8){
		printf("Error: no data available\n");
	}


	//printf("Writing wavemeter value to file.\n");
	fprintf(waveMeterValueFile,"%d\n",value);
	//printf("Wavemeter value written.\n");

	//printf("Closing wavemeter file.\n");
	fclose(waveMeterValueFile);
	//printf("Wavemeter file closed.\n");

	//printf("Closing serial port.\n");
	serialClose(fd);
	//printf("Serial port closed .\n");

	delay(100);

    return 0;
}

int getValue(int fd){
	//printf("Entered getValue()\n");
	int a,i;
	char buffer[1024];
	char outputChar[1024];
    char* temp;

	a=0;
	i=0;
	if(serialDataAvail(fd) != 0){
		while(a!=13 && a!=-1){
			a=serialGetchar(fd);
			buffer[i]=a;
			i++;
			if (a==13)
			{
				buffer[i-1]='\0';
				strcpy(outputChar,buffer);
				//printf(outputChar);

				/** This final sequence of commands removes
				 * the decimal point from the reported value.
				 * This ensures that rounding errors won't 
				 * occur when the value is saved.
				 */
				for(temp= outputChar+3; *temp != '\0'; temp++)
					*temp = *(temp+1);
				*temp='\0';
			}
		}
	} else{
		//printf("Error, no data available.\n");
		strcpy(outputChar,"-8");
	}

	//printf("String: %s\n",outputChar);
	return atof(outputChar);
}
