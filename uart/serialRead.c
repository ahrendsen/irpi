#include <wiringPi.h> 
#include <wiringSerial.h> 
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc,char** argv){
	int a,fd,i;
//,numChar;
	float f;
	char buffer[1024];
	char outputChar[1024];
	char waveMeterValueFileName[] ="/home/pi/.wavelength";
	FILE *waveMeterValueFile;
	int	baud=9600;
	wiringPiSetup();

	waveMeterValueFile=fopen(waveMeterValueFileName,"w");

	fd=serialOpen("/dev/ttyAMA0",baud);

	delay(100);
	i=0;
	a=0;

	while(a!=13 && a!=-1){
		a=serialGetchar(fd);
		buffer[i]=a;
		//printf("Data Available:%d\tCurrent Char:%d\n",numChar,a);
		i++;
		if (a==13)
		{
			buffer[i-1]='\0';
			strcpy(outputChar,buffer);
		}
	}
	f=atof(outputChar);
	printf("String: %s AtoF: %f\n",outputChar,f);
	fprintf(waveMeterValueFile,"%f\n",f);
	fclose(waveMeterValueFile);
	serialClose(fd);
return 0;
}
