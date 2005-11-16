In-Reply-To: <437AE923.7020004@domain.hid>
Subject: Re: [Xenomai-core] Question about shadow migration
Message-ID: <OF5FF1274A.4919E255-ONC12570BB.002EA267-C12570BB.00331586@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Wed, 16 Nov 2005 10:17:58 +0100
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFA28DFBD24F78f9e8a93df938690918c4EBBFA28DFBD24F7"
Content-Disposition: inline
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

--0__=4EBBFA28DFBD24F78f9e8a93df938690918c4EBBFA28DFBD24F7
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



xenomai-core-bounces@domain.hid wrote on 16.11.2005 09:09:07:

>
> The question for me is now if I got these details right: first a
> migration request is issued [1] but not immediately executed,

This request is about scheduling an APC for execution (which is lostage=
_apc
in that case). The APC mechanism is implemented on top of the VIRQ
mechanism so when Linux gets control back it has a pending VIRQ that wi=
ll
be executed at the first appropriate point. It's not immediately actual=
ly
since the Linux domain could have been preempted last time at some poin=
t
with the interrupts off.
The VIRQ handler, in turn, wakes up a desired process (i.e. puts it in =
the
linux's runqueue) so it can be run again at the next preempteble point.=

Sure, there can be other runnable processes with higher prios.

> then the
> priority of the root thread (Linux) is lifted to the one of the shado=
w
> thread [2]

Yes, in order to prevent other rt activities with lower rt prios from
preempting a soon-to-be-relaxed thread while it's going to be run in th=
e
secondary mode. So it's about keeping the sole priority scheme across
domains (classical RTAI does the opposite to my knowledge).

>, and then the shadow thread is suspend with respect to the
> xenomai scheduler [3]. The last step should let the Linux kernel star=
t
> over again, run to its next preemption point (and this is the region
> where non-deterministic delays may be injected with current kernels,
> isn't it?),

Yes, there are 2 points:

- a time between a moment when the Linux domain gets control back and t=
he
moment when VIRQ->APC->lostage_handler may be executed (*);

e.g. the Linux domain could have been preempted last time at some point=

with the interrupts off so we are dependent on the lenght of irq-off
sections in the linux kernel.

- a time between (*) and the next preemption point when a newly awakene=
n
task may get control back.

e.g. other asynch. activities have been previously scheduled in the lin=
ux
domain (pending interrupts, bottom halves).

The IRQ shield (if used) protects only from the asynch. activities that=
 may
occur when a rt task is already executing in the linux domain, not from=

those that were scheduled for execution before the rt task has entered =
the
linux domain.


> and switch over to lostage_handler() [4] to resume the Linux
> part of the shadow thread. After that the execution of the shadow, no=
w
> in secondary mode, continues in xnshadow_relax() after [3]. Am I righ=
t?

Yes, Actually, another interesting point here is rthal_reenter_root().
It's about properly (re-)adjusting a priority of the linux thread if th=
e
shadow counterpart has changed its priority while running in the primar=
y
domain. The linux thread is executing with its old priority between L54=
3
and L551. So it's a small priority-related flaw regarding the migration=

scheme. The reason is that it's not possible (likely it's possible with=

linux versions >=3D 2.6.13) to properly change the priority of the linu=
x task
on top of VIRQs (ISR handlers). Once we have discussed it with Philippe=
 and
there can be another solution though. But we decided to wait a bit unti=
l
all the dust with scheduler-related changes in 2.6.x settles down.

Hopefully, I haven't misled you too much with my comments :o)

>
> Thanks,
> Jan
>
>

---
Best regards,
Dmitry=

--0__=4EBBFA28DFBD24F78f9e8a93df938690918c4EBBFA28DFBD24F7
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font face=3D"Arial"><br>
</font><tt>xenomai-core-bounces@domain.hid wrote on 16.11.2005 09:09:07:<b=
r>
<br>
&gt; <br>
&gt; The question for me is now if I got these details right: first a<b=
r>
&gt; migration request is issued [1] but not immediately executed,</tt>=
<br>
<br>
<tt>This request is about scheduling an APC for execution (which is los=
tage_apc in that case). The APC mechanism is implemented on top of the =
VIRQ mechanism so when Linux gets control back it has a pending VIRQ th=
at will be executed at the first appropriate point. It's not immediatel=
y actually since the Linux domain could have been preempted last time a=
t some point with the interrupts off.</tt><br>
<tt>The VIRQ handler, in turn, wakes up a desired process (i.e. puts it=
 in the linux's runqueue) so it can be run again at the next preemptebl=
e point. Sure, there can be other runnable processes with higher prios.=
</tt><br>
<br>
<tt>&gt; then the<br>
&gt; priority of the root thread (Linux) is lifted to the one of the sh=
adow<br>
&gt; thread [2]</tt><br>
<br>
<tt>Yes, in order to prevent other rt activities with lower rt prios fr=
om preempting a soon-to-be-relaxed thread while it's going to be run in=
 the secondary mode. So it's about keeping the sole priority scheme acr=
oss domains (classical RTAI does the opposite to my knowledge).</tt><br=
>
<br>
<tt>&gt;, and then the shadow thread is suspend with respect to the<br>=

&gt; xenomai scheduler [3]. The last step should let the Linux kernel s=
tart<br>
&gt; over again, run to its next preemption point (and this is the regi=
on<br>
&gt; where non-deterministic delays may be injected with current kernel=
s,<br>
&gt; isn't it?),</tt><br>
<br>
<tt>Yes, there are 2 points:</tt><br>
<br>
<tt>- a time between a moment when the Linux domain gets control back a=
nd the moment when VIRQ-&gt;APC-&gt;lostage_handler may be executed (*)=
;</tt><br>
<br>
<tt>e.g. the Linux domain could have been preempted last time at some p=
oint with the interrupts off so we are dependent on the lenght of irq-o=
ff sections in the linux kernel.</tt><br>
<br>
<tt>- a time between (*) and the next preemption point when a newly awa=
kenen task may get control back.</tt><br>
<br>
<tt>e.g. other asynch. activities have been previously scheduled in the=
 linux domain (pending interrupts, bottom halves).</tt><br>
<br>
<tt>The IRQ shield (if used) protects only from the asynch. activities =
that may occur when a rt task is already executing in the linux domain,=
 not from those that were scheduled for execution before the rt task ha=
s entered the linux domain.</tt><br>
<br>
<br>
<tt>&gt; and switch over to lostage_handler() [4] to resume the Linux<b=
r>
&gt; part of the shadow thread. After that the execution of the shadow,=
 now<br>
&gt; in secondary mode, continues in xnshadow_relax() after [3]. Am I r=
ight?</tt><br>
<br>
<tt>Yes, Actually, another interesting point here is </tt><tt>rthal_ree=
nter_root().</tt><br>
<tt>It's about properly (re-)adjusting a priority of the linux thread i=
f the shadow counterpart has changed its priority while running in the =
primary domain. The linux thread is executing with its old priority bet=
ween L543 and L551. So it's a small priority-related flaw regarding the=
 migration scheme. The reason is that it's not possible (likely it's po=
ssible with linux versions &gt;=3D 2.6.13) to properly change the prior=
ity of the linux task on top of VIRQs (ISR handlers). Once we have disc=
ussed it with Philippe and there can be another solution though. But we=
 decided to wait a bit until all the dust with scheduler-related change=
s in 2.6.x settles down.</tt><br>
<br>
<tt>Hopefully, I haven't misled you too much with my comments :o)</tt><=
br>
<tt><br>
&gt; <br>
&gt; Thanks,<br>
&gt; Jan<br>
&gt; <br>
&gt; <br>
</tt><br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
</body></html>=

--0__=4EBBFA28DFBD24F78f9e8a93df938690918c4EBBFA28DFBD24F7--


