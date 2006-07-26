Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Xenomai task (beginner)
Date: Wed, 26 Jul 2006 15:48:45 +0200
Message-ID: <1299EF3181B10F479D85C3280132852422DABF@THEZE.intra.cea.fr>
In-Reply-To: <17607.23166.422964.660390@domain.hid>
From: "GUARDIOLA-FALCO Sebastien 204282" <Sebastien.GUARDIOLA-FALCO@domain.hid>
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
Cc: xenomai@xenomai.org, CAULIER Gilles 169574 <Gilles.CAULIER@cea.fr>

Gilles Chanteperdrix wrote :
>The worst case latency of your polling program is given by the longest
>time during which Linux will preempt your polling task. If this polling
>program is the only program running, then the longest preemption will =
be
>given by the execution time of the longest interruption handler, likely
>the timer interrupt.

Ok so if I understand, during a polling cycle interrupted by preemption =
of the timer interrupt, we are in the worst case latency. Could you =
explain a little what is this timer interrupt please? As far as I know, =
this soft irq is how the kernel stops doing whatever it's currently =
doing to check if it needs to be doing something else. I'm using Linux =
2.4 with the preemptible kernel option. Do you have an idea of the =
frequency of the timer interrupt or how to know it? My results shows =
weird things like a quite long latency (a value between 100 and 200 =
microseconds) EVERY 60 seconds! May be it's this timer we are talking =
about?


>You will get similar behaviour with Xenomai, with the additional
>constraint that Linux will not be running at all as long as your
>program runs. If we assume that Xenomai timer interrupt handler is
>shorter than Linux interrupt handler, then you will get a shorter
>worst case latency with Xenomai.

By "if we assume", you may say that it depends on kernel version. On =
this point, do you know the differences of my linux 2.4 alone, versus =
Xenomai patched to 2.6?

>Note however that either with Xenomai or with Linux using the =
SCHED_FIFO
>policy, you can not be running your polling program all the time,
>because everything else that is not running with the SCHED_FIFO policy
>will be blocked.

I disabled this policy since today, precisely trying to run other =
processes in order to load cpu usage. But it's obvious that even with a =
normal policy, my prompt is completely blocked! Same result on serial =
port console and with a telnet...

>Using only polling is generally considered a poor design. If the
>activity on your VME bus is such that you can not tolerate one =
interrupt
>by event, then you may adopt a design similar to Linux network drivers
>using NAPI, that is:
>- enable generation of interruptions upon VME bus event
>- in the interrupt handler, disable generation of interruptions and =
wake
>  up a polling thread
>- in the polling thread, poll the VME bus for a limited amount of time,
>  then re-enable generation of interruptions and go to sleep.
>This way, the number of interruptions will be limited, and you will
>leave some time for the system to run other activities than the
>acquisition loop.

Ok, for the moment VME interruptions are not used in our context (see =
below). So enabling or disabling interrupt handling in the driver should =
lead to the same results. In other words, if there is no interruption to =
handle it would be a surprise that the VME driver executes some code in =
the interrupt handler.
In fact, we intend to use polling not every cycle like in my test =
program, but regularly when there is more data to pick on the bus. This =
test is designed to know more easily the worst case, because we do not =
tolerate any missing data/event.
We use interruptions too, in other acquisition programs... but this is =
another story.

Thanks again Gilles,
S=E9bastien.


