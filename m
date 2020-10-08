Date: Thu, 8 Oct 2020 11:31:43 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1908941175.1265140.1602174703558.JavaMail.zimbra@wolfram.com>
In-Reply-To: <6c79c68d-fa03-28cd-71e5-d02f1be7d6a2@mitrol.it>
References: <6c79c68d-fa03-28cd-71e5-d02f1be7d6a2@mitrol.it>
Subject: Re: Question about gdb and timeout
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
Cc: xenomai <xenomai@xenomai.org>



----- Den 8 okt 2020, p=C3=A5 kl 14:47, xenomai xenomai@xenomai.org skrev:

> Hi to all,
> I have an ARM board (iMX6SX).
> - kernel 4.9.88
> - xenomai 3.0.9
> - ipipe-core-4.9.51-arm-4

> I have run a simple xenomai alchemy test :
> - a task that wait an event (timeout 10 secs)
> - a task that signal the event (every 100 msecs)
> All works correctly.

> When I use the example with gdb:
> b 56 (at usleep(10000) in the main)
> r
> c
> c
> ...
> If I stay stopped in gdb for more that 10 seconds (that is the timeout
> of the rt_event_wait), I get -110 (=3D -ETIMEDOUT).
> This because I think the timer counts also when tasks are stopped in gdb.
> Is there a way to avoid this behavior ? When I'm stopped in gdb, the
> real-time"world" should be stopped.

This is not exactly my home arena, but I'm waiting for a kernel compile so =
I'll give you my two cents...

Not easily, or plainly just no. At least not without rewriting your timeout=
 code. I'm not sure what alchemy uses as base clock for it's timers, but fo=
r the posix skin you have the option of CLOCK_HOST and CLOCK_HOST_REALTIME,=
 CLOCK_MONOTONIC and CLOCK_REALTIME (and maybe others) that represents the =
Linux kernel time and the Xenomai kernel time. Gdb just stops your applicat=
ion while the kernel timers will keep running.

However, If you base a timer on the linux CLOCK_REALTIME and reset the linu=
x host time before your timer times out you could be able to trick it. The =
difference between CLOCK_MONOTONIC and CLOCK_REALTIME is that CLOCK_REALTIM=
E can jump backwards, e.g. when a NTP client resets it, although I am not s=
ure what this does to different timers.

Per =C3=96berg=20

> Thanks for your support,
> Best regards,
> Paolo

> #include <stdlib.h>
> #include <stdio.h>
> #include <alchemy/task.h>
> #include <alchemy/event.h>

> RT_TASK rt_task_wait,
> rt_task_signal;
> volatile unsigned int cnt;

> #define EVENT_WAIT_MASK 1

> RT_EVENT ev;

> #define MSEC(x) (RTIME)((x) * 1000ULL * 1000ULL)
> #define SEC(x) (RTIME)(MSEC(x) * 1000ULL)

> void xeno_task_wait(void *dummy)
> {
> unsigned int mask_ret;
> rt_event_create(&ev, "ev", 0, 0);
> RTIME timeout =3D SEC(10);
> while(1)
> {
> cnt++;
> int res;
> res =3D rt_event_wait(&ev, EVENT_WAIT_MASK, &mask_ret, EV_ANY,
> timeout);
> if (res)
> {
> printf(">>> res =3D %d\n", res);
> exit(0);
> }
> rt_event_clear(&ev, EVENT_WAIT_MASK, &mask_ret);
> }
> }

> void xeno_task_signal(void *dummy)
> {
> while(1)
> {
> rt_task_sleep( MSEC(100) );
> rt_event_signal(&ev, EVENT_WAIT_MASK);
> }
> }

> int main(int argc, char *const *argv)
> {
> rt_task_create(&rt_task_wait, "wait", 0, 98, 0);
> rt_task_start (&rt_task_wait, &xeno_task_wait, NULL);

> rt_task_create(&rt_task_signal, "signal", 0, 99, 0);
> rt_task_start (&rt_task_signal, &xeno_task_signal, NULL);

> while(1)
> {
> usleep(10000); // <<<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D BREAKPOINT
> printf("%d\n", cnt);
> }
> }

