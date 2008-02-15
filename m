Message-ID: <7470.62.39.72.60.1203063044.squirrel@domain.hid>
Date: Fri, 15 Feb 2008 09:10:44 +0100 (CET)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Problem of thread creation with Xenomai Posix 2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

OK, thank you.

I wrote a new program in which there is no call to my function Console.
There is just calls to printf at the end of the program. Thus, we can be
sure that the problem comes from the pthread_create call.

New program :

#include <sys/mman.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/time.h>
#include <string.h>
#include <stdio.h>

#define NB_ELEMENTS 50

int j;
char Text [NB_ELEMENTS];

int func(volatile int* i)
{
	return (*i)++;
}

void AddConsole (char val)
{
 	Text[j] =3D val;
     	j++;
}

void ReadTabConsole (void)
{
     	int i;
     	int NbConsole =3D j;

     	for (i=3D0; i<NbConsole; i++)
     	{
     		printf("%d\n",Text[i]);
         	j--;
     	}
}

void* thread1(void * context) {
     	volatile int i;
	volatile int result;

	AddConsole(5);
        while (i < 1000) {
              result =3D func(&i);
        }
    	AddConsole(6);

	return NULL;
}

void* thread2(void * context) {
        volatile int i;
	volatile int result;

	AddConsole(7);
        while (i < 1000) {
              result =3D func(&i);
        }
	AddConsole(8);

	// Lecture du tableau de console
    	ReadTabConsole();

	return NULL;
}

void* thread_main(void *arg) {
    	pthread_attr_t attr;
    	pthread_t p1;
    	pthread_t p2;
    	struct sched_param sch;
    	struct sched_param sch1;
    	int result;

        pthread_attr_init(&attr);
        pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

        sch.sched_priority =3D 25;
        pthread_attr_setschedparam(&attr, &sch);


	AddConsole(1);
        pthread_create(&p1, &attr, thread1, NULL);
	AddConsole(2);

        sch.sched_priority =3D 20;
        pthread_attr_setschedparam(&attr, &sch);

	AddConsole(3);
        result =3D pthread_create(&p2, &attr, thread2, NULL);
	if (result !=3D 0)
	{
		AjoutConsole(0);
	}
	AddConsole(4);

        pthread_attr_destroy(&attr);

        while (1) {
                sleep(500);
        }
	return NULL;
}

int main(int argc, char** argv) {

    	j =3D 0;
    	pthread_attr_t attr;
        pthread_t p;
    	struct sched_param sch;

       	mlockall(MCL_CURRENT|MCL_FUTURE);

        pthread_attr_init(&attr);
	    pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
        pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

        sch.sched_priority =3D 30;
        pthread_attr_setschedparam(&attr, &sch);
        pthread_create(&p, &attr, thread_main, NULL);
        pthread_attr_destroy(&attr);

        while (1) {
                sleep(500);
        }

        return 0;
}

Result in Linux environment(Linux 2.6.20 kernel configurated preemptive) =
:
1
2
3
4
5
6
7
8

Result in Xenomai environment(Xenomai 2.3.4 kernel) :
1
2
3
5
6
4
7
8

OK, we can see that there is the same problem. T1 thread prempts Main
Thread during the pthread_create of T2 with Xenomai and not with Linux
standard. I would like to know why.

I don't that there is a difference beetween the posix Linux pthread_creat=
e
and the posix Xenomai pthread_create ?

If pthread_create suspends a short time its caller, why we don t have the
same behaviour in the two cases ?

In my opinion, there is a problem with Xenomai, no ?

I hope that you could help me. thank you


