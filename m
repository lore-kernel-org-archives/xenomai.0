MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17607.23166.422964.660390@domain.hid>
Date: Wed, 26 Jul 2006 14:05:18 +0200
Subject: RE: [Xenomai-help] Xenomai task (beginner)
In-Reply-To: <1299EF3181B10F479D85C3280132852422DABD@THEZE.intra.cea.fr>
References: <17606.21420.165431.429261@domain.hid>
	<1299EF3181B10F479D85C3280132852422DABD@THEZE.intra.cea.fr>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>
Cc: xenomai@xenomai.org

GUARDIOLA-FALCO Sebastien 204282 wrote:
 > GUARDIOLA-FALCO Sebastien 204282 wrote:
 >  >> Hello,
 >  >>=20
 >  >> I'm waiting for Xenomai to be included in the ElinOS Linux package=
, so I can't try it before next week.=20
 >  >> My question is simple : how to port a linux program to Xenomai so =
this program is recognized as a Xenomai task? (and has low latencies?). I=
s it done when launching the program? like "prio 255 myprogram" in LynxOS=
? or are there lines of code to include?
 >  >> My linux task doesn't have any system call, except mmap(). Next I'=
m using the pointer I get from mmap() and that's it.
 >  >>=20
 >=20
 > Gilles Chanteperdrix wrote:
 > >If you are talking about latencies, then your task has to suspend,
 > >waiting for some event using some other system call than mmap. I assu=
me
 > >here that you are using the POSIX interface for that purpose.=20
 >=20
 > Actually my program (see attached file) doesn't wait, it's a "polling"=
 task (on a VME bus) that reads a pointer.
 > And if data read shows that we missed an event/data (means that data r=
efresh is too fast, 500 microseconds for Linux for example), then I save/=
display the error.
 > So there's no blocking call here, only polling.
 >=20
 > >To have a Linux program "recognized" by Xenomai, you have to compile =
it
 > >with special compilation flags, provided by the xeno-config script. T=
he
 > >advantage of this approach is that the regular Linux services remain
 > >accessible by prefixing their names with the __real_ prefix. For exam=
ple
 > >Linux regular mmap remain accessible but is called __real_mmap.
 >=20
 > Interesting. About the compilation, does it means that when I launch s=
uch a task the Xenomai scheduler will do all the job? only because I incl=
ude this 'xeno-config' option?
 > If it's the case, I'm wondering if that scheduler will increase perfor=
mance for my polling thing... not sure.

The worst case latency of your polling program is given by the longest
time during which Linux will preempt your polling task. If this polling
program is the only program running, then the longest preemption will be
given by the execution time of the longest interruption handler, likely
the timer interrupt.

You will get similar behaviour with Xenomai, with the additional
constraint that Linux will not be running at all as long as your
program runs. If we assume that Xenomai timer interrupt handler is
shorter than Linux interrupt handler, then you will get a shorter
worst case latency with Xenomai.

Note however that either with Xenomai or with Linux using the SCHED_FIFO
policy, you can not be running your polling program all the time,
because everything else that is not running with the SCHED_FIFO policy
will be blocked.

Using only polling is generally considered a poor design. If the
activity on your VME bus is such that you can not tolerate one interrupt
by event, then you may adopt a design similar to Linux network drivers
using NAPI, that is:
- enable generation of interruptions upon VME bus event
- in the interrupt handler, disable generation of interruptions and wake
  up a polling thread
- in the polling thread, poll the VME bus for a limited amount of time,
  then re-enable generation of interruptions and go to sleep.

This way, the number of interruptions will be limited, and you will
leave some time for the system to run other activities than the
acquisition loop.

 > What is certain is that task priority handling must be greater in Xeno=
mai than Linux/premmptive.
 > About that, does my "sched_get_priority_max(SCHED_FIFO)" of my code wi=
ll have any effect on Xenomai? a Xenomai equivalent for this call?
 >=20

Xenomai posix skin uses the same priority range as Linux, so setting the
priority to sched_get_priority_max(SCHED_FIFO) will have the same effect
on Xenomai. Note however that with Xenomai, you will have to use
pthread_setschedparam in order to set the thread priority, instead of
sched_setscheduler.

 > Thanks,
 > S=E9bastien.


--=20


					    Gilles Chanteperdrix.

