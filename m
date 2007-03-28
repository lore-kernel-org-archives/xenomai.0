From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17930.56329.893396.220621@domain.hid>
Date: Wed, 28 Mar 2007 23:20:09 +0200
Subject: Re: [Xenomai-help] Preemptive scheduling 
In-Reply-To: <20070328203115.190280@domain.hid>
References: <20070328203115.190280@domain.hid>
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jack Whorn <jackwhorn@domain.hid>
Cc: xenomai@xenomai.org

Jack Whorn wrote:
 > Hi,
 >=20
 > I`m new to Xenomai and I`m experiencing some issues.
 >=20
 > Why does a Xenomai thread (native skin) with an infinite loop hang the=
 system, though there are higher-priority RT-threads present, and
 > rt_task_set_mode periodically clears T_LOCK and T_SHIELD and sets T_RR=
B?
 >=20
 > Isn`t the scheduler preemptive, first considering the thread`s priorit=
y and subsequently the thread`s position in its priority`s ready queue?
 >=20
 > I have attached some sample code.
 >=20
 > Thanks for any hint,
 >=20
 > Jack
 >=20
 >=20
 > #include <stdio.h>
 > #include <unistd.h>
 > #include <stdlib.h>
 > #include <signal.h>
 > #include <string.h>
 > #include <sys/time.h>
 > #include <sys/io.h>
 > #include <sys/mman.h>
 > #include <sys/types.h>
 >=20
 > #include <native/task.h>
 > #include <native/queue.h>
 > #include <native/intr.h>
 > #include <native/timer.h>
 >=20
 >=20
 > #define STACK_SIZE 8192
 > #define PRIO 10
 >=20
 >=20
 > static RT_TASK timer_task_desc;
 >=20
 > //		              ..s.ms.=B5s.ns
 > static RTIME task_period_ns =3D   0100000000llu;
 >=20
 > static unsigned long overruns =3D 0;
 >=20
 > static void clean_exit(int dummy) {
 >=20
 >   rt_task_delete(&timer_task_desc);
 >=20
 > }
 >=20
 > static void thread(void *cookie) {
 >=20
 >   int ret;
 >   int i;
 >   int c;
 >=20
 >=20
 >   ret =3D rt_task_set_mode(T_LOCK, T_RRB, &c);
 >   if (ret)
 >     return;
 >=20
 >   ret =3D rt_task_set_periodic(NULL, TM_NOW, rt_timer_ns2ticks(task_pe=
riod_ns));
 >   if (ret)
 >     return;
 >=20
 >   while (1) {
 >    =20
 >     ret =3D rt_task_set_mode(T_LOCK | T_SHIELD, T_RRB | T_PRIMARY, NUL=
L);
 >     if (ret)
 >       return;
 >=20
 >     ret =3D rt_task_wait_period(&overruns);
 >     if (ret =3D=3D -ETIMEDOUT) {
 >     } else if (ret) {
 >       clean_exit(0);
 >     }
 >=20
 >     while (1);	/* infinite loop */

Once your program enters this infinte loop, it never gets out, so :
- your assumption that "t_task_set_mode periodically clears T_LOCK and
  T_SHIELD and sets T_RRB" is false;
- even if higher priority task runs, Linux, which is Xenomai idle task
  never runs, so the system locks up.

In short, maybe you have observed some scheduling problems, but your
example does not demonstrate them. Such misuse of Xenomai should be
caught by the watchdog, if you enable it.


--=20


					    Gilles Chanteperdrix.

