Message-ID: <4CD1DC1B.8060407@domain.hid>
Date: Wed, 03 Nov 2010 23:03:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>	<4CD11AB1.8090407@domain.hid>	<4CD13A70.8040702@domain.hid>	<4CD14B1E.4000707@domain.hid>	<4CD14C92.90901@domain.hid>	<4CD14DBC.3060505@domain.hid>	<4CD1509A.3000908@domain.hid>	<4CD152F3.4080203@domain.hid>	<4CD16654.6080704@domain.hid>	<4CD18782.7090607@domain.hid>
	<4CD191EE.7000604@domain.hid>	<4CD1936E.50203@domain.hid>
	<4CD1BA29.9000303@domain.hid>
	<1288816871.1842.84.camel@domain.hid>
In-Reply-To: <1288816871.1842.84.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA926E23F66CB286FA1396CCF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA926E23F66CB286FA1396CCF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 03.11.2010 21:41, Philippe Gerum wrote:
> On Wed, 2010-11-03 at 20:38 +0100, Anders Blomdell wrote:
>> Jan Kiszka wrote:
>>> Am 03.11.2010 17:46, Anders Blomdell wrote:
>>>> Anders Blomdell wrote:
>>>>> Anders Blomdell wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> additional barrier. Can you check this?
>>>>>>>
>>>>>>> diff --git a/include/nucleus/sched.h b/include/nucleus/sched.h
>>>>>>> index df56417..66b52ad 100644
>>>>>>> --- a/include/nucleus/sched.h
>>>>>>> +++ b/include/nucleus/sched.h
>>>>>>> @@ -187,6 +187,7 @@ static inline int xnsched_self_resched_p(stru=
ct=20
>>>>>>> xnsched *sched)
>>>>>>>    if (current_sched !=3D (__sched__))    {                \
>>>>>>>        xnarch_cpu_set(xnsched_cpu(__sched__),=20
>>>>>>> current_sched->resched);    \
>>>>>>>        setbits((__sched__)->status, XNRESCHED);                \
>>>>>>> +      xnarch_memory_barrier();                        \
>>>>>>>    }                                    \
>>>>>>>  } while (0)
>>>>>> In progress, if nothing breaks before, I'll report status tomorrow=
=20
>>>>>> morning.
>>>>> It still breaks (in approximately the same way). I'm currently putt=
ing a=20
>>>>> barrier in the other macro doing a RESCHED, also adding some tracin=
g to=20
>>>>> see if a read barrier is needed.
>>>> Nope, no luck there either. Will start interesting tracepoint=20
>>>> adding/conversion :-(
>>>
>>> Strange. But it was too easy anyway...
>>>
>>>> Any reason why xn_nucleus_sched_remote should ever report status =3D=
 0?
>>>
>>> Really don't know yet. You could trigger on this state and call
>>> ftrace_stop() then. Provided you had the functions tracer enabled, th=
at
>>> should give a nice pictures of what happened before.
>>
>> Isn't there a race betweeen these two (still waiting for compilation t=
o=20
>> be finished)?
>=20
> We always hold the nklock in both contexts.
>=20

But we not not always use atomic ops for manipulating status bits (but
we do in other cases where this is no need - different story). This may
fix the race:

diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index d7a772f..af8ebeb 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -85,7 +85,7 @@ static void xnintr_irq_handler(unsigned irq, void *cook=
ie);
=20
 void xnintr_host_tick(struct xnsched *sched) /* Interrupts off. */
 {
-	__clrbits(sched->status, XNHTICK);
+	clrbits(sched->status, XNHTICK);
 	xnarch_relay_tick();
 }
=20
@@ -105,11 +105,13 @@ void xnintr_clock_handler(void)
 	trace_mark(xn_nucleus, irq_enter, "irq %u", XNARCH_TIMER_IRQ);
 	trace_mark(xn_nucleus, tbase_tick, "base %s", nktbase.name);
=20
+	xnlock_get(&nklock);
+
 	++sched->inesting;
 	__setbits(sched->status, XNINIRQ);
=20
-	xnlock_get(&nklock);
 	xntimer_tick_aperiodic();
+
 	xnlock_put(&nklock);
=20
 	xnstat_counter_inc(&nkclock.stat[xnsched_cpu(sched)].hits);
@@ -117,7 +119,7 @@ void xnintr_clock_handler(void)
 		&nkclock.stat[xnsched_cpu(sched)].account, start);
=20
 	if (--sched->inesting =3D=3D 0) {
-		__clrbits(sched->status, XNINIRQ);
+		clrbits(sched->status, XNINIRQ);
 		xnpod_schedule();
 	}
 	/*
@@ -178,7 +180,7 @@ static void xnintr_shirq_handler(unsigned irq, void *=
cookie)
 	trace_mark(xn_nucleus, irq_enter, "irq %u", irq);
=20
 	++sched->inesting;
-	__setbits(sched->status, XNINIRQ);
+	setbits(sched->status, XNINIRQ);
=20
 	xnlock_get(&shirq->lock);
 	intr =3D shirq->handlers;
@@ -220,7 +222,7 @@ static void xnintr_shirq_handler(unsigned irq, void *=
cookie)
 		xnarch_end_irq(irq);
=20
 	if (--sched->inesting =3D=3D 0) {
-		__clrbits(sched->status, XNINIRQ);
+		clrbits(sched->status, XNINIRQ);
 		xnpod_schedule();
 	}
=20
@@ -247,7 +249,7 @@ static void xnintr_edge_shirq_handler(unsigned irq, v=
oid *cookie)
 	trace_mark(xn_nucleus, irq_enter, "irq %u", irq);
=20
 	++sched->inesting;
-	__setbits(sched->status, XNINIRQ);
+	setbits(sched->status, XNINIRQ);
=20
 	xnlock_get(&shirq->lock);
 	intr =3D shirq->handlers;
@@ -303,7 +305,7 @@ static void xnintr_edge_shirq_handler(unsigned irq, v=
oid *cookie)
 		xnarch_end_irq(irq);
=20
 	if (--sched->inesting =3D=3D 0) {
-		__clrbits(sched->status, XNINIRQ);
+		clrbits(sched->status, XNINIRQ);
 		xnpod_schedule();
 	}
 	trace_mark(xn_nucleus, irq_exit, "irq %u", irq);
@@ -446,7 +448,7 @@ static void xnintr_irq_handler(unsigned irq, void *co=
okie)
 	trace_mark(xn_nucleus, irq_enter, "irq %u", irq);
=20
 	++sched->inesting;
-	__setbits(sched->status, XNINIRQ);
+	setbits(sched->status, XNINIRQ);
=20
 	xnlock_get(&xnirqs[irq].lock);
=20
@@ -493,7 +495,7 @@ static void xnintr_irq_handler(unsigned irq, void *co=
okie)
 		xnarch_end_irq(irq);
=20
 	if (--sched->inesting =3D=3D 0) {
-		__clrbits(sched->status, XNINIRQ);
+		clrbits(sched->status, XNINIRQ);
 		xnpod_schedule();
 	}
=20

Jan


--------------enigA926E23F66CB286FA1396CCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzR3CkACgkQitSsb3rl5xR2JgCffFUsG6FEs02Wzq4YxlZcPA64
jR0AnRLVwJ1I1+AHgDBtTcSDJQfr0O0N
=cVGu
-----END PGP SIGNATURE-----

--------------enigA926E23F66CB286FA1396CCF--

