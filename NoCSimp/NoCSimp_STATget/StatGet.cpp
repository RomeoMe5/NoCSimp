#include <iostream>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <time.h>

using namespace std;
#define N 9
#define M 1000

struct Node
{
	int sendp;
	int sendf;
	int rcvp;
	int rcvf;
	int sw_send;
	int sw_rcv;
};
struct Packet
{
	int prod;
	int rec;
	int gent;
	int rect;
	int len;
};

void ReadStat(char name [])
{
	string str;
	string buf;
	int totsendp=0;
	int totsendf=0;
	int totrcvp=0;
	int totrcvf=0;
	int i;
	int pos;
	
	Packet * Pkets = new Packet [M];

	ifstream fin;
	fin.open(name);
	if(!fin.is_open()) cerr<<"Error opening file: "<<name;
	Node * Nods = new Node [N];
	for (i=0;i<N;i++)
	{
		Nods[i].rcvf=0;
		Nods[i].rcvp=0;
		Nods[i].sendf=0;
		Nods[i].sendp=0;
		Nods[i].sw_send=0;
		Nods[i].sw_rcv=0;
	}
	while( !fin.eof())
	{
		getline(fin,str);
		//fin.getline(str);
		if (str.find("# Start simulation")&&
			(str.find("# Otput starts"))&&
			(str.find("# Input starts"))&&
			(str.find("# IP block position")&&
			(str.find("run"))))
			{
				if (!str.find("# Stgen"))
				{
					
					buf = str.substr(str.find("dest:")-3, 2);
					pos=atoi(buf.c_str());
					Nods[pos].sendp++;
					buf = str.substr(str.find("time:")-3, 2);
					Nods[pos].sendf+=atoi(buf.c_str());
					
					Pkets[totsendp].prod=pos;
					Pkets[totsendp].len=atoi(buf.c_str());
					buf=str.substr(str.find("time:")+6);
					//cout<<endl<<buf;
					Pkets[totsendp].gent=atoi(buf.c_str());
					buf = str.substr(str.find("dest:")+6, 3);
					Pkets[totsendp].rec=atoi(buf.c_str());
					Pkets[totsendp].rect=0;
					totsendp++;
					//cout<<atoi(buf.c_str())<<"  ";
				}
				else if (!str.find("# Recv"))
					{
						buf = str.substr(str.find("len:")-3, 2);
						pos = atoi(buf.c_str());
						Nods[pos].rcvp++;
						buf = str.substr(str.find("time:")-3, 2);
						Nods[pos].rcvf+=atoi(buf.c_str());

						for (i=0;i<totsendp;i++)
						{
							if ((Pkets[i].rec == pos)&&(Pkets[i].len==atoi(buf.c_str()))&&(Pkets[i].rect==0))
							{
								buf=str.substr(str.find("time:")+6);
								Pkets[i].rect=atoi(buf.c_str());
								Pkets[i].rec=pos;
								break;
							}
						}
						totrcvp++;
					}
				else if (!str.find("# SW"))
					{
					if (str.find("Send")!=string::npos) //
						{
							//cout<<str<<endl;
							buf = str.substr(str.find(": Send")-2, 2);
							pos = atoi(buf.c_str());
							Nods[pos].sw_send++;
						}
						else if (str.find(": Received")!=string::npos)
							{
								buf = str.substr(str.find(": Received")-2, 2);
								pos = atoi(buf.c_str());
								Nods[pos].sw_rcv++;
							}
						
					}	
				//cout<<str<<endl;
				buf=str;
			}
	}
	fin.close();

	ofstream fout;

	time_t lt = time(NULL);
	char * fname=ctime(&lt);
	fname[3]='_';
	fname[7]='_';
	fname[10]='_';
	fname[13]='_';
	fname[16]='_';
	fname[19]='\0';
	char rname [40];
	sprintf(rname, "%s%s%s", "50_8ip_psd_statistics_", fname, ".txt");
	fout.open(rname);
	
	for (i=0;i<N;i++) totsendf+=Nods[i].sendf;
	for (i=0;i<N;i++) totrcvf+=Nods[i].rcvf;
	
	cout<<"Packets send: "<<totsendp<<"  Recv: "<<totrcvp;
	cout<<"\nFlits send: "<<totsendf<<"  Recv: "<<totrcvf;
	fout<<"Packets send: "<<totsendp<<"  Recv: "<<totrcvp;
	fout<<"\nFlits send: "<<totsendf<<"  Recv: "<<totrcvf;
	
	buf=buf.substr(buf.find("time:")+5);
	int tottime=(atoi(buf.c_str())-21)/2;
	
	cout<<"\nTotal time: "<<tottime<<"\nFlits ingection rate:   "<<float(totsendf)*2/tottime/N<<"\nFlits consumption rate: "<<float(totrcvf)*2/tottime/N;
	fout<<"\nTotal time: "<<tottime<<"\nFlits ingection rate:   "<<float(totsendf)*2/tottime/N<<"\nFlits consumption rate: "<<float(totrcvf)*2/tottime/N;
	
	int pdelivery=0;
	for (i=0;i<totsendp;i++)
	{
		if(Pkets[i].rect!=0) pdelivery+=(Pkets[i].rect-Pkets[i].gent);
	}
	cout<<"\nAvg. packets delivery time: "<<(float)pdelivery/2/totrcvp;
	fout<<"\nAvg. packets delivery time: "<<(float)pdelivery/2/totrcvp;
	cout<<endl;
	fout<<endl;
	
	for (i=0;i<N;i++) 
	{
		cout<<"Nods["<<i<<"].sendp= "<<Nods[i].sendp;
		cout<<"  Nods["<<i<<"].sendf= "<<Nods[i].sendf;
		cout<<"  Nods["<<i<<"].rcvp= "<<Nods[i].rcvp;
		cout<<"  Nods["<<i<<"].rcvf= "<<Nods[i].rcvf;
		cout<<endl;
		fout<<"Nods["<<i<<"].sendp= "<<Nods[i].sendp;
		fout<<"  Nods["<<i<<"].sendf= "<<Nods[i].sendf;
		fout<<"  Nods["<<i<<"].rcvp= "<<Nods[i].rcvp;
		fout<<"  Nods["<<i<<"].rcvf= "<<Nods[i].rcvf;
		fout<<endl;
		//cout<<"  Nods["<<i<<"].sw_send= "<<Nods[i].sw_send;
		//cout<<"  Nods["<<i<<"].sw_rcv= "<<Nods[i].sw_rcv;
	}
	
	
	cout<<endl;
	fout<<endl;
	delete [] Nods;


	for (i=0;i<totsendp;i++)
	{
		cout<<endl<<"Prod: "<<Pkets[i].prod<<" Ptime: "<<Pkets[i].gent<<" Rec: "<<Pkets[i].rec<<" RTime: "<<Pkets[i].rect<<" Len: "<<Pkets[i].len;
		fout<<endl<<"Prod: "<<Pkets[i].prod<<" Ptime: "<<Pkets[i].gent<<" Rec: "<<Pkets[i].rec<<" RTime: "<<Pkets[i].rect<<" Len: "<<Pkets[i].len;
		if(Pkets[i].rect!=0) 
		{
			cout<<" TDelivery: "<<(float)(Pkets[i].rect-Pkets[i].gent)/2;
			fout<<" TDelivery: "<<(float)(Pkets[i].rect-Pkets[i].gent)/2;
		}
	}
	cout<<"\n"<<float(totsendf)*2/tottime/N<<"\n"<<float(totrcvf)*2/tottime/N<<endl<<(float)pdelivery/2/totrcvp;
	fout<<"\n"<<float(totsendf)*2/tottime/N<<"\n"<<float(totrcvf)*2/tottime/N<<endl<<(float)pdelivery/2/totrcvp;
	fout.close();
	delete [] Pkets;
	system("pause");
}

void main()
{
	ReadStat("modelsim_log.txt");

	//ReadStat("Stat1.txt");

}
