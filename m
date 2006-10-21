From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 21 Oct 2006 16:28:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610211628.21249.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Cleanup after using the vxWorks skin?
Reply-To: niklaus.giger@domain.hid
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

Hi

I run a program using the vxworks skin from user space. As did hang, I=20
typed =A0"Ctrl-C" to end the program.

Looking at /proc/xenomai/registry/vxworks/semaphores/ I remarked however, t=
hat=20
there were still vxworks semaphores open, which had not been deleted.

Is it up to the programmer to clean up at exit? Or is this a bug in the=20
current Xenomai implementation?

My test program looks like this:
#include <sys/mman.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "vxworks/vxworks.h"
extern "C" int root_thread_init();
extern "C" void root_thread_exit(void);

int main (int argc, char *argv[])
{
=A0 int tid;
=A0 mlockall(MCL_CURRENT|MCL_FUTURE);
=A0 atexit(&root_thread_exit);
=A0 tid =3D taskSpawn("root", 10, 0, 32*1024, (FUNCPTR) root_thread_init,=20
1,2,3,4,5,6,7,8,9,10);
=A0 if (tid > 0) =A0pause();
=A0 return 1;
}
=A0 extern "C" void root_thread_exit(void)
=A0 {
=A0 =A0 printf("%s: task %d\n", __FUNCTION__, taskIdSelf());
=A0 }
=A0 extern "C" int root_thread_init()
=A0 { const char* arg=3D"";
=A0 =A0 const char* argv[2];
=A0 =A0 argv[0] =A0=3D "undefined";
=A0 =A0 argv[1] =A0=3D arg;
=A0 =A0 int argc =3D sizeof(argv) / sizeof(char*);
=A0 =A0 int semId1 =3D semCCreate(SEM_Q_PRIORITY, 3);
=A0 =A0 int semId3 =3D semMCreate(SEM_Q_PRIORITY | SEM_INVERSION_SAFE );
=A0 =A0 printf("proc %s: task %d %s \n", __FUNCTION__, taskIdSelf(),=20
taskName(taskIdSelf()));
=A0 =A0 taskDelay(sysClkRateGet());
=A0 =A0 printf("proc %s: task %d shutting down\n", __FUNCTION__, taskIdSelf=
());
// =A0 =A0 return 0;
=A0 =A0exit(0);
}

Best regards

=2D-=20
Niklaus Giger

