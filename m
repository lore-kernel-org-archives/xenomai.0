Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Jul 2006 13:47:42 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A66846@domain.hid>
In-Reply-To: <200607111736.k6BHaCme029123@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
Subject: [Xenomai-help] kernel oops using mq_open after fork
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

I'm using xenomai 2.2 rc3 on a MPC8247, on linux 2.6.14.
=20
I have a problem using mq_open. Please see the attached code.
If I fork before the mq_open the kernel, I get a kernel oops.

Why this behaviour?

//***************************************************************
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
#include <sys/wait.h>

#include <sys/time.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/socketvar.h>
#include <sys/mount.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <pthread.h>
#include <unistd.h>
#include <mqueue.h>
#include <sys/mman.h>
pthread_t Main_Exec_thread_id;


#define MAIN_TASK_PRI 20
#define MAIN_STACK_SIZE 8192

pthread_attr_t Main_Exec_attr;
struct sched_param Main_Exec_parm;

int Main_PID =3D 0;
int Mains_Parent =3D 0;
int Child_PID =3D 0;

void split (void);

void *MainExecThread (void *dummy)
{

  	struct mq_attr buf;
	int perms =3D 0666;
	buf.mq_msgsize =3D 4;
	buf.mq_maxmsg =3D 20;
	printf ("mq_open\n");
	sleep (2);
	mq_open ("/con_to_R01", O_CREAT | O_RDWR , perms, &buf);

	pause ();

	return 0;

}

int child (void)
{

	Main_PID =3D getpid ();

	printf ("main pid =3D %08x\n", Main_PID) ;
	printf ("main parent =3D %08x\n", Mains_Parent);


	mlockall (MCL_CURRENT | MCL_FUTURE);

	pthread_attr_init (&Main_Exec_attr);

	pthread_attr_setinheritsched(&Main_Exec_attr, 1);
 	pthread_attr_setschedpolicy(&Main_Exec_attr, SCHED_FIFO);
	pthread_attr_setstacksize(&Main_Exec_attr, MAIN_STACK_SIZE);
 	Main_Exec_parm.sched_priority =3D MAIN_TASK_PRI;
  	pthread_attr_setschedparam(&Main_Exec_attr, &Main_Exec_parm);

	pthread_create (&Main_Exec_thread_id, &Main_Exec_attr, (void*(*)(void*))=
MainExecThread, 0);=20

	while (true)
		pause ();

	printf ("MAIN PAUSE RETURNED\n") ;
=09
}

void parent (void)
{
	while (true)
		pause ();
}

void split (void)
{
	int pid =3D fork ();

	if (pid =3D=3D 0) // child
	{
		child ();
	}
	else // parent
	{

		Child_PID =3D pid;
		parent ();
	}
}
	=09

int main (int argc, char *argv[])
{

	Mains_Parent =3D getpid ();
=09
#if 1
	split ();
#endif

#if 0
	child ();
#endif

}
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

