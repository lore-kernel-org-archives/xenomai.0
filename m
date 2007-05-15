content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 May 2007 09:25:10 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C60322105D@FR0-MAILMB20.res.airbus.corp>
From: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Subject: [Xenomai-help] Time scale problem.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, rtnet-users@domain.hid

Hi Everyone

I'm programming a little client-server application to test network performa=
nces with xenomai 2.3.1 and rtnet 0.9.9.
The 2 programs are based on the rtnet frag-ip example.
The perdiodic scenario is :
- RSG program sends a datagram to the REMOTE program which was waiting.
- REMOTE sends a response to RSG.
- RSG simulates a CPU performing period using rt_timer_spin.
This cycle should take less than 2.5ms.

I observe strange time measurement :

For example when I want to run during 10 secs : 1000 cycles of 10 ms
The program calculates a time between 16 and 17 secs (using rt_timer_tsc)
But the effective elapsed time (i kept time with a chrono :-s ) is around 1=
0secs

When a cycle is supposed to be 5ms it is calculated to be 8.4ms

When I want a rt_timer_spin of 0.750ms, result is a 1.27ms burning period.

So a constant difference between effective and calculated time around +60%.

Maybe there something wrong in my program but I don't know what.
Also, I have read some threads that mentionned time problem and /proc/xenom=
ai/latency value.
I didn't understand everything.=20
Any suggestion ?


Thanks in advance.

Niry




RSG program

/**
 * \brief Prototype 01
 * Runs a task that : 	- sends amount of data via UDP/IP to a remote box
 * 			- waits for data message during a specific time
 * 			- simulates a CPU calcul performing
 * Time is expressed in nanoseconds
 * \file rt_rsg.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <arpa/inet.h>
#include <errno.h>
#include <native/task.h>
#include <native/timer.h>
#include <rtnet.h>

typedef unsigned long long uint64;
typedef unsigned long uint32;

/*                        --s--s--s */
/*                       s  m  u  n */
#define ONE_SEC          1000000000ULL
#define ONE_MILLI           1000000ULL
#define ONE_MICRO              1000ULL
#define CYCLE_RSG           2500000ULL      /* 2.5 ms */

#define ONE_KILO          1024


//#define CYCLE ONE_SEC

#define BUFF_SIZE   ONE_KILO + 512
#define PORT        37001

/** remote parameters */
char *dest_ip_s =3D "192.168.0.10";
struct sockaddr_in dest_addr;

/** communication parameters */
unsigned int data_size =3D BUFF_SIZE;
unsigned int nb_data =3D 1;
unsigned int add_rtskbs =3D 75;
unsigned int cpt, nb_cycles;=20

/** time parameters */
uint64 start_time =3D 0;
uint64 **time_grid;
uint64 period =3D 5 * ONE_MILLI;
uint64 delay =3D10 * ONE_SEC;
uint64 recv_timeout =3D 20 * ONE_MILLI;
uint64 burn_time =3D 750 * ONE_MICRO;

RT_TASK rt_rsg_task;

FILE * fd;


int sock;

char buffer_out[BUFF_SIZE];
char buffer_in[BUFF_SIZE];


compute_time(int nb_values, char *file_name  )
{
	int i;
	uint64 xr_time, tot_time, burn_time;
=09
	fd =3D fopen(file_name,"w+");
	if (fd =3D=3D NULL){
		perror("Impossible d'ouvrir le fichier");
		exit(2);
	}
=09
	fprintf(fd,"# Duree %llu\n# Repeat %d\n# StartTime %llu\n# \n",
			delay, nb_values, start_time);
	fprintf(fd,"# Cycle AbsoluteTime XmitRecvTime TaskTime CPUBurningTime\n");
=09
	/* Calcul des temps xmit - recv */
	for (i =3D 0; i < nb_values; i++) {
		xr_time =3D time_grid[i][1] - time_grid[i][0];
		tot_time =3D time_grid[i][2] - time_grid[i][0];
		burn_time =3D time_grid[i][2] - time_grid[i][1];
		fprintf(fd,"%d %llu %llu %llu %llu\n",i,
				time_grid[i][0], xr_time, tot_time, burn_time);
		//fprintf(fd,"%d %llu %llu %llu\n",i, time_grid[i][0], time_grid[i][1], t=
ime_grid[i][2]);
	}

	fclose(fd);
=09
=09
}

int burn_cpu(uint64 time)
{
	rt_timer_spin(time);
}

int xmit_data()
{
	int ret, i;
	struct msghdr msg;
	struct iovec iov[3];
	unsigned short msgsize =3D data_size;
	unsigned short nbmsg =3D nb_data;
=09
	for (i=3D0;i<nb_data;i++) {
		iov[0].iov_base =3D &msgsize;
		iov[0].iov_len  =3D sizeof(msgsize);
		iov[1].iov_base =3D buffer_out;
		iov[1].iov_len  =3D data_size;
		iov[2].iov_base =3D &nbmsg;
		iov[2].iov_len =3D sizeof(nbmsg);
=09=09
		memset(&msg, 0, sizeof(msg));
		msg.msg_name    =3D &dest_addr; // ptr addresse socket
		msg.msg_namelen =3D sizeof(dest_addr); // longueur addresse socket
		msg.msg_iov     =3D iov; // tampon memoire vectoriel
		msg.msg_iovlen  =3D 3; // nb elements de msg_iov

		// printf("Sending message of %d+2 bytes\n", size);
		ret =3D rt_dev_sendmsg(sock, &msg, 0);
		if (ret =3D=3D -EBADF)
			return ret;
		else if (ret !=3D (int)(sizeof(nbmsg) + sizeof(msgsize) + data_size)) {
			printf("*** Error *** rt_dev_sendmsg() =3D %d : %s\n", ret, strerror(-re=
t));
			return ret;
		} /*else {
			printf("emit data OK\n");
		}*/
	}
	return 0;
}



int recv_data()
{
	int ret;
	struct msghdr msg;
	struct iovec iov[3];
	unsigned short msgsize =3D data_size;
	unsigned short nbmsg =3D nb_data;
	struct sockaddr_in addr;


	iov[0].iov_base =3D &msgsize;
	iov[0].iov_len  =3D sizeof(msgsize);
	iov[1].iov_base =3D buffer_in;
	iov[1].iov_len =3D data_size;
	iov[2].iov_base =3D &nbmsg;
	iov[2].iov_len  =3D sizeof(nbmsg);

	memset(&msg, 0, sizeof(msg));
	msg.msg_name    =3D &addr;
	msg.msg_namelen =3D sizeof(addr);
	msg.msg_iov     =3D iov;
	msg.msg_iovlen  =3D 2;

	ret =3D rt_dev_recvmsg(sock, &msg, 0);
	if (ret <=3D 0) {
		printf("Error rt_dev_recvmsg() =3D %d : %s\n", ret, strerror(-ret));
		return ret;
	} /*else {
		unsigned long ip =3D ntohl(addr.sin_addr.s_addr);
		printf("received data OK\n");
// 		printf("received packet from %lu.%lu.%lu.%lu, length: %zd+2, "
// 				"encoded length: %d,\n flags: %X, content %s\n", ip >> 24,
// 		(ip >> 16) & 0xFF, (ip >> 8) & 0xFF, ip & 0xFF,
// 		ret-sizeof(msgsize), msgsize, msg.msg_flags,
// 		(memcmp(buffer_in, buffer_out, ret-sizeof(msgsize)) =3D=3D 0) ?
// 				"ok" : "corrupted");
}*/
	return 0;
}



void catch_signal(int sig)
{
}

void perform_rsg(void *arg)
{
	int ret;
=09
	if((ret =3D rt_task_set_periodic (NULL, TM_NOW, period))) {
		printf("ERROR : rt_task_set_periodic : %d\n", ret);
		return;
	}
	start_time =3D rt_timer_ticks2ns(rt_timer_tsc());
	while(1) {
		if(cpt<nb_cycles) {
			time_grid[cpt][0] =3D rt_timer_ticks2ns(rt_timer_tsc());
			if(!xmit_data()) {
				if(!recv_data()) {
					time_grid[cpt][1] =3D rt_timer_ticks2ns(rt_timer_tsc());
					burn_cpu(burn_time);
				}
			}
			time_grid[cpt][2] =3D rt_timer_ticks2ns(rt_timer_tsc());
			cpt++;
		}
		if(cpt=3D=3Dnb_cycles) {
			printf("No cycles remaining. Press ctl-c to quit.\n");
			cpt++;
		}
		rt_task_wait_period(NULL);
	}
}

int main(int argc, char *argv[])
{
	int ret;
	unsigned int i;
	char *res_file_name =3D "res_tmp.txt";
	struct sockaddr_in local_addr;
	struct in_addr dest_ip;
	uint64 chrono[2];
=09
	while (1) {
		switch (getopt(argc, argv, "d:f:")) {
		case 'd':
			dest_ip_s =3D optarg;
			break;
=09=09
		case 'f':
			res_file_name =3D optarg;
			break;
=09=09=09
		case -1:
			goto end_of_opt;

		default:
			printf("usage: %s [-d <dest_ip>]\n", argv[0]);
			return 0;
		}
	}
end_of_opt:

	inet_aton(dest_ip_s, &dest_ip);

	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);
	signal(SIGHUP, catch_signal);
	mlockall(MCL_CURRENT|MCL_FUTURE);

	printf("*** Infos *** destination ip address %s=3D%08x\n", dest_ip_s, dest=
_ip.s_addr);
	printf("*** Debug *** size %d\n", data_size);

	/* fill output buffer with test pattern */
	for (i =3D 0; i < sizeof(buffer_out); i++)
		buffer_out[i] =3D i & 0xFF;

	printf("*** Debug *** CPU burning time : %llu\n",burn_time);
=09
	cpt =3D 0;
	printf("*** Debug *** Total Duration : %llu\n",delay);
	printf("*** Debug *** Cycle Duration : %llu\n",period);
	nb_cycles =3D delay / period;
	printf("*** Debug *** Number of cycles : %lu\n",nb_cycles);
	time_grid =3D (uint64 **) malloc(sizeof(uint64 *) * nb_cycles);
	for(i =3D 0; i < nb_cycles; i++)
		time_grid[i] =3D (uint64 *) calloc(3, sizeof(uint64));
=09
	/* create rt-socket */
	sock =3D rt_dev_socket(AF_INET,SOCK_DGRAM,0);
	if (sock < 0) {
		printf("*** Error *** rt_dev_socket() =3D %d!\n", sock);
		return sock;
	} else {
		printf("*** Debug *** Creating socket OK\n");
	}
=09
	/* extend the socket pool */
	ret =3D rt_dev_ioctl(sock, RTNET_RTIOC_EXTPOOL, &add_rtskbs);
	if (ret !=3D (int)add_rtskbs) {
		printf("*** Error *** rt_dev_ioctl(RT_IOC_SO_EXTPOOL) =3D %d\n", ret);
		rt_dev_close(sock);
		return -1;
	} else {
		printf("*** Debug *** Extending socket pool OK\n");
	}
=09
	/* reception acquitement bloquant + timeout */
	ret =3D rt_dev_ioctl(sock, RTNET_RTIOC_TIMEOUT, &recv_timeout);
	if (ret !=3D 0) {
		printf("*** Error *** rt_dev_ioctl(RT_IOC_TIME_OUT) =3D %d\n", ret);
		rt_dev_close(sock);
		return -1;
	} else {
		printf("*** Debug *** Setting receive timeout OK\n");
	}

	/* bind the rt-socket to a port */
	memset(&local_addr, 0, sizeof(struct sockaddr_in));
	local_addr.sin_family =3D AF_INET;
	local_addr.sin_port =3D htons(PORT);
	local_addr.sin_addr.s_addr =3D INADDR_ANY;
	ret =3D rt_dev_bind(sock, (struct sockaddr *)&local_addr,
			  sizeof(struct sockaddr_in));
	if (ret < 0) {
		printf("*** Error ***  rt_dev_bind() =3D %d!\n", ret);
		rt_dev_close(sock);
		return ret;
	} else {
		printf("*** Debug *** Binding socket OK\n");
	}

	/* set destination address */
	memset(&dest_addr, 0, sizeof(struct sockaddr_in));
	dest_addr.sin_family =3D AF_INET;
	dest_addr.sin_port =3D htons(PORT);
	dest_addr.sin_addr =3D dest_ip;

	ret =3D rt_task_create(&rt_rsg_task, "RSG", 0, 10, 0);
	if (ret !=3D 0) {
		printf("*** Error ***  rt_task_create(recv) =3D %d!\n", ret);
		rt_dev_close(sock);
		return ret;
	}

	rt_task_start(&rt_rsg_task, perform_rsg, NULL);

	pause();
=09=09
	/* Note: The following loop and the strict ordering "close before task
	 * termination" is no longer required since Xenomai 2.4. */
	while (rt_dev_close(sock) =3D=3D -EAGAIN) {
		printf("*** Debug *** Socket busy - waiting...\n");
		sleep(1);
	}

	if(ret =3D rt_task_delete(&rt_rsg_task)) {
		printf("*** Error ***  rt_task_delete() =3D %d!\n", ret);
	} else {
		printf("*** Debug *** Deleting task OK\n");
	}
=09
	compute_time(nb_cycles, res_file_name);
=09
	return 0;
}




REMOTE program

/**
 * \brief Prototype 01
 * Runs a task that : 	- waits for amount of data via UDP/IP from a remote =
box
 * 				- sends data message
 * Time is expressed in nanoseconds
 * \file rt_remote.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <arpa/inet.h>
#include <errno.h>
#include <native/task.h>
#include <native/timer.h>
#include <rtnet.h>

typedef unsigned long long uint64;
typedef unsigned long uint32;

/*                        --s--s--s */
/*                       s  m  u  n */
#define ONE_SEC          1000000000ull
#define ONE_MILLI           1000000ull
#define ONE_MICRO              1000ull


#define ONE_KILO          1024

//#define CYCLE           2.5 * ONE_MILLI  /* 2.5 ms */
#define CYCLE           ONE_SEC

#define BUFF_SIZE   ONE_KILO + 512
#define PORT        37001

/** remote parameters */
char *dest_ip_s =3D "192.168.0.1";
struct sockaddr_in dest_addr;

/** communication parameters */
unsigned int data_size =3D BUFF_SIZE;
unsigned int nb_data =3D 1;
unsigned int add_rtskbs =3D 75;

/** time parameters */
uint64 start_time;
uint64 *time_grid;
uint64 recv_timeout =3D CYCLE;

RT_TASK rt_rsg_task;




int sock;

char buffer_out[BUFF_SIZE];
char buffer_in[BUFF_SIZE];

int xmit_data()
{
	int ret, i;
	struct msghdr msg;
	struct iovec iov[3];
	unsigned short msgsize =3D data_size;
	unsigned short nbmsg =3D nb_data;
=09

	iov[0].iov_base =3D &msgsize;
	iov[0].iov_len  =3D sizeof(msgsize);
	iov[1].iov_base =3D buffer_out;
	iov[1].iov_len  =3D data_size;
	iov[2].iov_base =3D &nbmsg;
	iov[2].iov_len =3D sizeof(nbmsg);
=09
	memset(&msg, 0, sizeof(msg));
	msg.msg_name    =3D &dest_addr; // ptr addresse socket
	msg.msg_namelen =3D sizeof(dest_addr); // longueur addresse socket
	msg.msg_iov     =3D iov; // tampon memoire vectoriel
	msg.msg_iovlen  =3D 3; // nb elements de msg_iov

	// printf("Sending message of %d+2 bytes\n", size);
	ret =3D rt_dev_sendmsg(sock, &msg, 0);
	if (ret =3D=3D -EBADF)
		return ret;
	else if (ret !=3D (int)(sizeof(nbmsg) + sizeof(msgsize) + data_size)) {
		printf("*** Error *** rt_dev_sendmsg() =3D %d : %s\n",=20
				ret, strerror(-ret));
		return ret;
	}/* else {
		printf("*** Debug ***data emit ok\n");
	}*/
	return 0;
}



int recv_data()
{
	int ret,i;
	struct msghdr msg;
	struct iovec iov[3];
	unsigned short msgsize =3D data_size;
	unsigned short nbmsg =3D nb_data;
	struct sockaddr_in addr;

	for (i=3D0;i<nb_data;i++) {
		iov[0].iov_base =3D &msgsize;
		iov[0].iov_len  =3D sizeof(msgsize);
		iov[1].iov_base =3D buffer_in;
		iov[1].iov_len =3D data_size;
		iov[2].iov_base =3D &nbmsg;
		iov[2].iov_len  =3D sizeof(nbmsg);

		memset(&msg, 0, sizeof(msg));
		msg.msg_name    =3D &addr;
		msg.msg_namelen =3D sizeof(addr);
		msg.msg_iov     =3D iov;
		msg.msg_iovlen  =3D 3;

		ret =3D rt_dev_recvmsg(sock, &msg, 0);
		if (ret <=3D 0) {
			printf("*** Error *** rt_dev_recvmsg() =3D %d : %s\n",
					 ret, strerror(-ret));
			return ret;
		} /*else {
			unsigned long ip =3D ntohl(addr.sin_addr.s_addr);
			printf("receive data OK\n");
// 		printf("received packet from %lu.%lu.%lu.%lu, length: %zd+2, "
// 				"encoded length: %d,\n flags: %X, content %s\n", ip >> 24,
// 		(ip >> 16) & 0xFF, (ip >> 8) & 0xFF, ip & 0xFF,
// 		ret-sizeof(msgsize), msgsize, msg.msg_flags,
// 		(memcmp(buffer_in, buffer_out, ret-sizeof(msgsize)) =3D=3D 0) ?
// 				"ok" : "corrupted");
		}*/
	}
	return 0;
}



void catch_signal(int sig)
{
	//rt_task_suspend(&rt_rsg_task);
}

void perform_remote(void *arg)
{
	unsigned int i =3D 0;
	while(1) {
		//printf("\nPass %d",i++);
		if(recv_data()) continue;
		if(xmit_data()) continue;
	}
}

int main(int argc, char *argv[])
{
	int ret;
	unsigned int i;
	struct sockaddr_in local_addr;
	struct in_addr dest_ip;


	while (1) {
		switch (getopt(argc, argv, "d:")) {
		case 'd':
			dest_ip_s =3D optarg;
			break;

		case -1:
			goto end_of_opt;

		default:
			printf("usage: %s [-d <dest_ip>]\n", argv[0]);
			return 0;
		}
	}
end_of_opt:

	inet_aton(dest_ip_s, &dest_ip);

	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);
	signal(SIGHUP, catch_signal);
	mlockall(MCL_CURRENT|MCL_FUTURE);

	printf("destination ip address %s=3D%08x\n", dest_ip_s, dest_ip.s_addr);
	printf("size %d\n", data_size);

	/* fill output buffer with test pattern */
	for (i =3D 0; i < sizeof(buffer_out); i++)
		buffer_out[i] =3D i & 0xFF;

	/* create rt-socket */
	sock =3D rt_dev_socket(AF_INET,SOCK_DGRAM,0);
	if (sock < 0) {
		printf("*** Error *** rt_dev_socket() =3D %d!\n", sock);
		return sock;
	}

	/* extend the socket pool */
	ret =3D rt_dev_ioctl(sock, RTNET_RTIOC_EXTPOOL, &add_rtskbs);
	if (ret !=3D (int)add_rtskbs) {
		printf("*** Error *** rt_dev_ioctl(RT_IOC_SO_EXTPOOL) =3D %d\n", ret);
		rt_dev_close(sock);
		return -1;
	}
=09
// 	/* reception acquitement bloquant + timeout */
// 	ret =3D rt_dev_ioctl(sock, RTNET_RTIOC_TIMEOUT, &recv_timeout);
// 	if (ret !=3D 0) {
// 		printf("Error rt_dev_ioctl(RT_IOC_TIME_OUT) =3D %d\n", ret);
// 		rt_dev_close(sock);
// 		return -1;
// 	}

	/* bind the rt-socket to a port */
	memset(&local_addr, 0, sizeof(struct sockaddr_in));
	local_addr.sin_family =3D AF_INET;
	local_addr.sin_port =3D htons(PORT);
	local_addr.sin_addr.s_addr =3D INADDR_ANY;
	ret =3D rt_dev_bind(sock, (struct sockaddr *)&local_addr,
			  sizeof(struct sockaddr_in));
	if (ret < 0) {
		printf("*** Error *** rt_dev_bind() =3D %d!\n", ret);
		rt_dev_close(sock);
		return ret;
	}

	/* set destination address */
	memset(&dest_addr, 0, sizeof(struct sockaddr_in));
	dest_addr.sin_family =3D AF_INET;
	dest_addr.sin_port =3D htons(PORT);
	dest_addr.sin_addr =3D dest_ip;

	ret =3D rt_task_create(&rt_rsg_task, "REMOTE", 0, 10, 0);
	if (ret !=3D 0) {
		printf(" rt_task_create(recv) =3D %d!\n", ret);
		rt_dev_close(sock);
		return ret;
	}

	rt_task_start(&rt_rsg_task, perform_remote, NULL);

	pause();


	/* Note: The following loop and the strict ordering "close before task
	 * termination" is no longer required since Xenomai 2.4. */
	while (rt_dev_close(sock) =3D=3D -EAGAIN) {
		printf("Socket busy - waiting...\n");
		sleep(1);
	}

	rt_task_delete(&rt_rsg_task);

	return 0;
}









This e-mail is intended only for the above addressee. It may contain privil=
eged information.
If you are not the addressee you must not copy, distribute, disclose or use=
 any of the information in it.=20
If you have received it in error please delete it and immediately notify th=
e sender.
Security Notice: all e-mail, sent to or from this address, may be accessed =
by someone other than the recipient, for system management and security rea=
sons. This access is controlled under Regulation of security reasons.
This access is controlled under Regulation of Investigatory Powers Act 2000=
, Lawful Business Practises.



