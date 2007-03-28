Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 28 Mar 2007 22:31:15 +0200
From: "Jack Whorn" <jackwhorn@domain.hid>
Message-ID: <20070328203115.190280@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Preemptive scheduling 
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

Hi,

I`m new to Xenomai and I`m experiencing some issues.

Why does a Xenomai thread (native skin) with an infinite loop hang the syst=
em, though there are higher-priority RT-threads present, and
rt_task_set_mode periodically clears T_LOCK and T_SHIELD and sets T_RRB?

Isn`t the scheduler preemptive, first considering the thread`s priority and=
 subsequently the thread`s position in its priority`s ready queue?

I have attached some sample code.

Thanks for any hint,

Jack


#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
#include <sys/time.h>
#include <sys/io.h>
#include <sys/mman.h>
#include <sys/types.h>

#include <native/task.h>
#include <native/queue.h>
#include <native/intr.h>
#include <native/timer.h>


#define STACK_SIZE 8192
#define PRIO 10


static RT_TASK timer_task_desc;

//		              ..s.ms.=B5s.ns
static RTIME task_period_ns =3D   0100000000llu;

static unsigned long overruns =3D 0;

static void clean_exit(int dummy) {

  rt_task_delete(&timer_task_desc);

}

static void thread(void *cookie) {

  int ret;
  int i;
  int c;


  ret =3D rt_task_set_mode(T_LOCK, T_RRB, &c);
  if (ret)
    return;

  ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_period_=
ns));
  if (ret)
    return;

  while (1) {
   =20
    ret =3D rt_task_set_mode(T_LOCK | T_SHIELD, T_RRB | T_PRIMARY, NULL);
    if (ret)
      return;

    ret =3D rt_task_wait_period(&overruns);
    if (ret =3D=3D -ETIMEDOUT) {
    } else if (ret) {
      clean_exit(0);
    }

    while (1);	/* infinite loop */

  }
  kill(0, SIGTERM);
}


int main(int argc, char** argv) {

  int err;

  signal(SIGTERM, clean_exit);
  signal(SIGINT, clean_exit);

  mlockall(MCL_CURRENT | MCL_FUTURE);

  err =3D rt_task_spawn(&timer_task_desc, "thread", STACK_SIZE, PRIO, 0, &t=
hread, NULL);
  if (err)
    return 0;

  pause();

  return EXIT_SUCCESS;

}
--=20
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail

