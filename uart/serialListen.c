#include <wiringPi.h> 
#include <wiringSerial.h> 
#include <stdio.h>
#include <string.h>

int main(int argc,char** argv){
	int a,fd,numChar,i;
	int numitts;
	char buffer[128];
	char outputChar[512];
//	char waveMeterValueFileName[]="/home/pi/.wavelength";
//	FILE *waveMeterValueFile;

	int	baud=9600;
	wiringPiSetup();

//	waveMeterValueFile=fopen(waveMeterValueFileName,"w");

	fd=serialOpen("/dev/ttyAMA0",baud);

		delay(100);
		i=0;
		numitts=0;
//loop forever and ever. and ever. and ever. 
//while (1==1){
while (numitts<100000){
		i=0;
		a=0;
		while (a!=13){
		while(numChar=serialDataAvail(fd)){
			a=serialGetchar(fd);
			buffer[i]=a;
printf("%d  ",a);//  decode print individual ASCII decimal			
			i++;
		}
		if (a==13)
			{
			buffer[i+1]='\0';
			strcpy(outputChar,buffer);
			}
		}

numitts++;
printf("Itt: %d  Recieved: %s\n",numitts,outputChar);


}
		//printf("String: %s\n",buffer);
		//fprintf(waveMeterValueFile,"%f\n",atof(buffer));
		//fclose(waveMeterValueFile);
}
