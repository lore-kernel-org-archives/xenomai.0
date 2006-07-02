Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] pthread_mutex_destroy in 2.2 rc2
Date: Sun, 2 Jul 2006 16:43:19 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A66770@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

As you suggested, I've upgraded to xenomai 2.2 rc3.
I still see the same phenomenon.
I'm attaching code that will reproduce the error.
(When you ^c out of the main loop, the pthread_cleanup_pop is called, and=
 the call to pthread_mutex_destroy returns 0x10.)

//********************************************************************
#include <termios.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/signal.h>
#include <sys/types.h>
#include <sys/select.h>
#include <error.h>
#include <errno.h>

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>

#include <sys/time.h>
#include <sys/ioctl.h>
#include <netdb.h>
#include <pthread.h>
#include <unistd.h>
#include <mqueue.h>
#include <sys/mman.h>
pthread_t Main_Exec_thread_id;

#define DPRINT(arg) printf arg

pthread_mutex_t testmutex;


#define MAIN_TASK_PRI 1
#define MAIN_STACK_SIZE 8192


pthread_attr_t Main_Exec_attr;
struct sched_param Main_Exec_parm;

int Main_PID;

void shut_down (void *par)
{
	printf ("shutting down, pid =3D %08x\n", getpid()) ;

	int res =3D pthread_mutex_destroy (&testmutex);

	printf ("pthread_mutex_destroy returned %08x\n", res) ;

	printf ("MAIN EXEC THREAD EXITING!\n") ;



}


void error_exit (int sval)
{
  void *val;
  DPRINT( ("error_exit, pid =3D %08x, signal =3D %08x\n", getpid (), sval=
));
  if (getpid () =3D=3D Main_PID)
  {
	printf ("cancelling main thread\n");
	pthread_cancel (Main_Exec_thread_id);=20
	printf ("waiting for main thread to exit\n");
	pthread_join (Main_Exec_thread_id, &val);
	printf ("exiting\n") ;
  }
}


void *MainExecThread (void *dummy)
{

	printf ("Main Exec Thread starting, pid =3D %08x\n", getpid()) ;

	pthread_cleanup_push ((void(*)(void*))shut_down, NULL);

	pthread_mutexattr_t attrib;
	int status =3D pthread_mutexattr_init (&attrib);
	if (status !=3D 0)
		DPRINT( ("pthread_mutexattr_init error\n"));
	status =3D pthread_mutex_init (&testmutex, &attrib);
	if (status !=3D 0)
		DPRINT( ("pthread_mutex_init error\n") );

=09
	pause ();

	DPRINT( ("MAIN EXEC PAUSE RETURNED\n") );
	pthread_cleanup_pop (true);
	return 0;
}

int main (int argc, char *argv[])
{

	Main_PID =3D getpid ();
	printf ("main pid =3D %08x\n", Main_PID) ;

	signal (SIGINT, error_exit);
	signal (SIGQUIT, error_exit);
	signal (SIGHUP, error_exit);
	signal (SIGTERM, error_exit);

	mlockall (MCL_CURRENT | MCL_FUTURE);

	pthread_attr_init (&Main_Exec_attr);

	pthread_attr_setinheritsched(&Main_Exec_attr, 1);
 	pthread_attr_setschedpolicy(&Main_Exec_attr, SCHED_FIFO);
	pthread_attr_setstacksize(&Main_Exec_attr, MAIN_STACK_SIZE);
 	Main_Exec_parm.sched_priority =3D MAIN_TASK_PRI;
  	pthread_attr_setschedparam(&Main_Exec_attr, &Main_Exec_parm);

	pthread_create (&Main_Exec_thread_id, &Main_Exec_attr, (void*(*)(void*))=
MainExecThread, 0);=20

	pause ();

	DPRINT( ("MAIN PAUSE RETURNED\n") );

	exit (0);
=09
-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thursday, June 29, 2006 7:17 PM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] pthread_mutex_destroy in 2.2 rc2


Landau, Bracha wrote:
 > I'm using Xenomai 2.2 rc2 on an MPC8247 board.

You should be using 2.2 rc3, it implements per-process cleanup, so even
if pthread_mutex_destroy fails, if the mutex is not shared between
several processes, it will automatically be destroyed when the
application terminates.

 > When I try to destroy a mutex I get error x10 (EBUSY).
 > The mutex is not locked.=20

EBUSY is also returned if the mutex is currently "bound" to a condition
variable, that is, if some thread is currently blocked in a call to
pthread_cond_wait using the mutex as second argument. In this case, the
application is expected to cancel the thread blocked in the call to
pthread_cond_wait, the said thread is expected to have
pthread_cleanup_pushed a cleanup function unlocking the mutex. Only then
the application can destroy the mutex with pthread_mutex_destroy.

When I run the same code with the regular pthreads library the function d=
oes not return an error.
 > Is this a Xenomai bug?

Maybe, maybe not. Could you provide a small program showing the bug ?

--=20


					    Gilles Chanteperdrix.
*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

