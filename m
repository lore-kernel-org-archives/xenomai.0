Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 6 Jul 2010 13:36:05 -0500
Message-ID: <181804936ABC2349BE503168465576460F3847C2@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Mixing skin calls (cancellation points)
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

Is it in general valid to mix calls from different skins?  In
particular, can I expect the native skin calls to work as POSIX
cancellation points?  For example, if I have a POSIX thread with a
pthread_t identifier which I know calls rt_cond_wait somewhere, will it
work as a cancellation point when I call pthread_cancel?

The example program attached will not cancel if I have CANCEL_DEFERRED
defined as 1 at the top, which sets the cancel type to deferred.  This
is on a PowerPC with Xenomai 2.5.3.  I think this worked with Xenomai
2.4.10.


--------


#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <native/task.h>
#include <native/cond.h>

#define CANCEL_DEFERRED 1

RT_MUTEX mutex;
RT_COND cond;
pthread_t thread;

void *entry(void *cookie)
{
   fprintf(stderr, "Starting thread\n");

#if CANCEL_DEFERRED
   pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
#else
   pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
#endif

   rt_mutex_acquire(&mutex, TM_INFINITE);
   rt_cond_wait(&cond, &mutex, TM_INFINITE);
   rt_mutex_release(&mutex);

   return NULL;
}

int main(int argc, char **argv)
{
   int ret;
   pthread_attr_t attr;

   if((ret =3D rt_mutex_create(&mutex, NULL)))
   {
      errno =3D -ret;
      perror("rt_mutex_create");
      exit(EXIT_FAILURE);
   }

   if((ret =3D rt_cond_create(&cond, NULL)))
   {
      errno =3D -ret;
      perror("rt_cond_create");
      exit(EXIT_FAILURE);
   }

   pthread_attr_init(&attr);
   pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

   if(pthread_create(&thread, &attr, entry, NULL))
   {
      perror("pthread_create");
      exit(EXIT_FAILURE);
   }

   fprintf(stderr, "Sleeping 5 seconds\n");
   sleep(5);
   fprintf(stderr, "Woke up, cancelling thread\n");

   pthread_cancel(thread);
   pthread_join(thread, NULL);

   return 0;
}

