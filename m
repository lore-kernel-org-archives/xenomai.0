Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 Dec 2009 13:07:19 +0100
Message-ID: <EA8B423DB69FD24FA233008019A052AE015C06A9@domain.hid>
From: "Soboljew, Patrick" <Patrick.Soboljew@domain.hid>
Subject: [Xenomai-help] Problem with pthread_cond_wait
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

Hello all,

I have a strange problem concerning the posix skin of xenomai (Ver.
2.4.9.1). Whenever two or more threads call 'pthread_cond_wait' and I
want to interrupt the program with SIGINT (CTRL-c) only the main thread
and the first thread that called 'pthread_cond_wait' get the signal. The
remaining threads are not interrupted so I have created some zombies
here. I discovered this problem when I tried to debug some code with the
ACE/TAO Framework which calls these functions in a similar way. The
debugger also has problems to interrupt these threads.

The small code example illustrates what I did.

Has anyone an idea what exactly causes this problem?

Thanks for any help
Patrick Soboljew

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Code Begin
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
#include <pthread.h>
#include <sys/mman.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


const int NUM_THREADS=3D2;
pthread_mutex_t Mutex;
pthread_cond_t  Condition;


void SetupRtThread()
{
#ifdef __XENO__
    int RetVal =3D 0;
    struct sched_param SParam;
    SParam.sched_priority =3D 1;
    int Policy =3D SCHED_FIFO;
    if ((RetVal =3D pthread_setschedparam(pthread_self(), Policy,
&SParam)) !=3D 0)
    {
        printf("pthread_setschedparam: %s", strerror(RetVal));
        exit(RetVal);
    }
#endif
}


void *ThreadFunc(void *pData)
{
    SetupRtThread();
    int MyId =3D (int)pData;

    printf("Starting thread %d\n", MyId);

    pthread_mutex_lock(&Mutex);
    pthread_cond_wait(&Condition, &Mutex);
    pthread_mutex_unlock(&Mutex);

    pthread_exit(NULL);
}


int main (int /*argc*/, char** /*argv[]*/)
{
    mlockall(MCL_CURRENT | MCL_FUTURE);
    SetupRtThread();


    pthread_t threads[NUM_THREADS];


    // Initialize mutex and condition variable objects
    pthread_mutex_init(&Mutex, NULL);
    pthread_cond_init (&Condition, NULL);


    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

    for (int i=3D0; i<NUM_THREADS; ++i)
    {
        pthread_create(&threads[i], &attr, ThreadFunc, (void *)i);
    }

    /* Wait for all threads to complete */
    for (int i=3D0; i<NUM_THREADS; i++)
    {
        pthread_join(threads[i], NULL);
    }
    printf ("Main(): Waited on %d  threads. Done.\n", NUM_THREADS);

    /* Clean up and exit */
    pthread_attr_destroy(&attr);
    pthread_mutex_destroy(&Mutex);
    pthread_cond_destroy(&Condition);
    pthread_exit(NULL);

}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Code End
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20

