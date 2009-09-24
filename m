Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2009 14:25:57 -0500
Message-ID: <181804936ABC2349BE503168465576460C3AE7CB@exchserver.basler.com>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Printf stops working after receiving signal.
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

I have a simple little test program, attached below.  When I hit CTL-C
to break the program, not all of the "finished" lines will print.  If I
remove either the rt_task_shadow call or the sigwait at the end, it will
then print all of them.  Adding a fflush(stdout) to the end does nothing
to help it.

I'm not sure if there's some interaction with the Xenomai domain I am
just missing which is causing the print statements to be dropped.

This is running on a PowerPC kernel 2.6.24 with Xenoami 2.4.9.

-----------------------------------------------------=20
#include <signal.h>
#include <stdio.h>
#include <native/task.h>

static volatile int signaled =3D 0;

static void catch(int x)
{
   signaled =3D 1;
}

static RT_TASK rt_main;

int main(int argc, char **argv)
{
   int sig;
   struct sigaction act;
   sigset_t set;
   rt_task_shadow(&rt_main, NULL, 99, 0);

   act.sa_flags =3D 0;
   act.sa_handler =3D catch;
   sigemptyset(&act.sa_mask);
   sigaction(SIGINT,&act,NULL);

   printf("starting 1\n");
   printf("starting 2\n");
   printf("starting 3\n");
   printf("starting 4\n");
   printf("starting 5\n");

   while(!signaled)
   {
      sleep(1);
      printf(".");
      fflush(stdout);
   }

   printf("\nfinished 1\n");
   printf("finished 2\n");
   printf("finished 3\n");
   printf("finished 4\n");
   printf("finished 5\n");

   sigfillset(&set);
   sigwait(&set,&sig);

   return 0;
}

