From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Subject: Question about gdb and timeout
Message-ID: <6c79c68d-fa03-28cd-71e5-d02f1be7d6a2@mitrol.it>
Date: Thu, 8 Oct 2020 14:47:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi to all,
I have an ARM board (iMX6SX).
- kernel 4.9.88
- xenomai 3.0.9
- ipipe-core-4.9.51-arm-4

I have run a simple xenomai alchemy test :
- a task that wait an event (timeout 10 secs)
- a task=A0 that signal the event (every 100 msecs)
All works correctly.

When I use the example with gdb:
b 56 (at usleep(10000) in the main)
r
c
c
...
If I stay stopped in gdb for more that 10 seconds (that is the timeout=20
of the rt_event_wait), I get -110 (=3D -ETIMEDOUT).
This because I think the timer counts also when tasks are stopped in gdb.
Is there a way to avoid this behavior ? When I'm stopped in gdb, the=20
real-time"world" should be stopped.
Thanks for your support,
Best regards,
Paolo

#include <stdlib.h>
#include <stdio.h>
#include <alchemy/task.h>
#include <alchemy/event.h>

RT_TASK rt_task_wait,
 =A0=A0=A0=A0=A0=A0=A0 rt_task_signal;
volatile unsigned int cnt;

#define=A0 EVENT_WAIT_MASK 1

RT_EVENT ev;

#define MSEC(x) (RTIME)((x) * 1000ULL * 1000ULL)
#define SEC(x)=A0 (RTIME)(MSEC(x) * 1000ULL)

void xeno_task_wait(void *dummy)
{
 =A0=A0=A0 unsigned int mask_ret;
 =A0=A0=A0 rt_event_create(&ev, "ev", 0, 0);
 =A0=A0=A0 RTIME timeout =3D SEC(10);
 =A0=A0=A0 while(1)
 =A0=A0=A0 {
 =A0=A0=A0 =A0=A0=A0 cnt++;
 =A0=A0=A0 =A0=A0=A0 int res;
 =A0=A0=A0 =A0=A0=A0 res =3D rt_event_wait(&ev, EVENT_WAIT_MASK, &mask_ret,=
 EV_ANY,=20
timeout);
 =A0=A0=A0 =A0=A0=A0 if (res)
 =A0=A0=A0 =A0=A0=A0 {
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 printf(">>> res =3D %d\n", res);
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 exit(0);
 =A0=A0=A0 =A0=A0=A0 }
 =A0=A0=A0 =A0=A0=A0 rt_event_clear(&ev, EVENT_WAIT_MASK, &mask_ret);
 =A0=A0=A0 }
}

void xeno_task_signal(void *dummy)
{
 =A0=A0=A0 while(1)
 =A0=A0=A0 {
 =A0=A0=A0 =A0=A0=A0 rt_task_sleep( MSEC(100) );
 =A0=A0=A0 =A0=A0=A0 rt_event_signal(&ev, EVENT_WAIT_MASK);
 =A0=A0=A0 }
}


int main(int argc, char *const *argv)
{
 =A0=A0=A0 rt_task_create(&rt_task_wait,=A0=A0 "wait",=A0=A0 0, 98, 0);
 =A0=A0=A0 rt_task_start (&rt_task_wait, &xeno_task_wait,=A0=A0 NULL);

 =A0=A0=A0 rt_task_create(&rt_task_signal, "signal", 0, 99, 0);
 =A0=A0=A0 rt_task_start (&rt_task_signal, &xeno_task_signal, NULL);

 =A0=A0=A0 while(1)
 =A0=A0=A0 {
 =A0 =A0 =A0 =A0 usleep(10000);=A0=A0=A0=A0=A0=A0=A0=A0 // <<<=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D BREAKPOINT
 =A0=A0=A0 =A0=A0=A0 printf("%d\n", cnt);
 =A0=A0=A0 }
}


