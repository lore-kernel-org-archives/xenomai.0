Message-ID: <1091.62.39.72.60.1203347858.squirrel@domain.hid>
Date: Mon, 18 Feb 2008 16:17:38 +0100 (CET)
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

Hello,

Thank you for your answers.

I ve got a new question about the Posix function
pthread_setschedparam(...) with Xenomai. I wrote a program to explain my
problem.

Program : I ve got a Main thread which creates T1 thread.
At the beginning, Main has the highest priority.
After the T1 creation, we decide to decrease the Main priority under the
T1 priority with pthread_setschedparam.
So T1 must preempt Main...


#include <sys/mman.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/time.h>
#include <string.h>
#include <stdio.h>

#define NB_ELEMENTS 50
int j;

char Commentaire [NB_ELEMENTS];


int func(volatile int* i)
{
	return (*i)++;
}

void AddConsole (char val)
{
     Commentaire[j] =3D val;
     j++;
}

void ReadTabConsole (void)
{
     int i;
     int NbConsole =3D j;

     for (i=3D0; i<NbConsole; i++)
     {
         printf("%d\n",Commentaire[i]);
         j--;
     }
}

void* thread1(void * context) {
	volatile int i =3D0;
	volatile int result;

	AddConsole(3);
        while (i < 50)
	{
              result =3D func(&i);
        }
    	AddConsole(4);

	return NULL;
}

void* thread_main(void *arg) {
    	pthread_attr_t attr;
    	pthread_t p;
    	pthread_t p1;
    	struct sched_param sch;
    	int result;

   	pthread_attr_init(&attr);
   	pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

    	sch.sched_priority =3D 25;
    	pthread_attr_setschedparam(&attr, &sch);

	AddConsole(1);
    	result=3Dpthread_create(&p1, &attr, thread1, NULL);
    	if (result !=3D 0)
	{
		AddConsole(0);
	}
	AddConsole(2);

    	pthread_attr_destroy(&attr);

    	p =3D pthread_self();

    	sch.sched_priority =3D 15;
    	pthread_setschedparam(p, SCHED_FIFO, &sch);

    	AddConsole(5);

    	while (1)
	{
        	sleep(5);
        	ReadTabConsole();
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
        	sleep(10);
    	}

    	return 0;
}


Result in Linux environment(Linux 2.6.20 kernel configurated preemptive) =
:
1	(Main : before pthread_create T1)
2	(Main : after pthread_create T1)
3	(T1 : start)
4	(T1 : finish)
5	(Main : finish)

Result in Xenomai environment(Xenomai 2.3.4 kernel) :
1	(Main : before pthread_create T1)
2	(Main : after pthread_create T1)
5	(Main : finish)
3	(T1 : start)
4	(T1 : finish)


As we can see, with Linux, just after the decrease of Main Priority, T1 r=
uns.
But with Xenomai, when we decrease the Main Priority, there is nothing. T=
1
runs when Main is waiting (sleep)...

Why we haven't got the same behaviour? With Xenomai, the recognition of
Posix function pthread_setschedparam isn't instantaneous?

I hope that you can help me. thanks a lot.


