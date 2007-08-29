Message-ID: <46D50DFC.5080304@domain.hid>
Date: Wed, 29 Aug 2007 08:11:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>	
	<46BC1494.2010303@domain.hid>	
	<Pine.LNX.4.64.0708100951160.23969@domain.hid>	
	<3535aae80708100805l526475ebt5e4ff54c92f7daab@domain.hid>	
	<46BC8074.3090104@domain.hid>	
	<Pine.LNX.4.64.0708130903220.14311@domain.hid>	
	<18112.1512.506911.608273@domain.hid>	
	<3535aae80708130810s603edb7fo9f7be56342ddf921@domain.hid>	
	<46C08E61.9060204@domain.hid>	
	<3535aae80708140826o107e0fa3wee8db991ec1e14bd@domain.hid>
	<3535aae80708270627l4064dd1fif3e6aa10314d38f@domain.hid>
	<46D301EE.5020805@domain.hid>
In-Reply-To: <46D301EE.5020805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC11FF41489A125A1C587E646"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC11FF41489A125A1C587E646
Content-Type: multipart/mixed;
 boundary="------------000402000409000405040409"

This is a multi-part message in MIME format.
--------------000402000409000405040409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> andy motten wrote:
>>> I will run continuously several tests on the pc (including "latency -=
f")
>>> for the rest of this week. Since I am not in the office during this p=
eriod
>>> (so not in the neighborhood of this problematic pc).
>>> And I hope (I hope not in vain) that the latency tracer will give us =
a
>>> hint for the reason of the hard lock ups (if a hard lock up happens d=
uring
>>> this period).
>>>
>>> andy
>>>
>>
>> Hello,
>>
>> Since  we are having a hard time finding the hard lock-ups. We have ta=
ken a
>> closer look at the failed tests of orocos (maybe the source of the pro=
blem
>> is the same). These failures occur during the make check execution.
>>
>>     The following tests FAILED:
>>         2 - task-test (OTHER-FAULT)
>>         3 - event-test (OTHER-FAULT)
>>         4 - taskcontext-test (OTHER-FAULT)
>>
>> When we perform a single test, e.g task-test, we get the the following=

>> messages: Killed
>> The OROCOS messages are then:
>>
>> 0.000 [ Info   ][Logger] Successfully extracted environment variable
>> ORO_LOGLEVEL
>> 0.001 [ Info   ][Logger]  OROCOS version '1.2.1' compiled with GCC
>> 4.1.2.Orocos Logging Activated at level : [ Debug  ] ( 6 )
>> 0.001 [ Info   ][Logger] Reference System Time is : 880886725351 ticks=
 (
>> 315.369 seconds ).
>> 0.002 [ Info   ][Logger] Logging is relative to this time.
>> 0.002 [ Info   ][Logger] Xenomai Periodic Timer runs in preemptive
>> 'one-shot' mode.
>> 0.003 [ Debug  ][Logger] Xenomai Timer and Main Task Created
>> 0.003 [ Debug  ][Logger] MainThread started.
>> 0.003 [ Debug  ][Logger] Starting StartStopManager.
>> 0.004 [ Info   ][Toolkit] Loading Tool RealTime.
>> 0.005 [ Debug  ][Toolkit] Registered Type 'int' to the Orocos Type Sys=
tem.
>> 0.005 [ Debug  ][Toolkit] Registered Type 'uint' to the Orocos Type Sy=
stem.
>> 0.006 [ Debug  ][Toolkit] Registered Type 'double' to the Orocos Type
>> System.
>> 0.006 [ Debug  ][Toolkit] Registered Type 'bool' to the Orocos Type Sy=
stem.
>> 0.006 [ Debug  ][Toolkit] Registered Type 'PropertyBag' to the Orocos =
Type
>> System.
>> 0.007 [ Debug  ][Toolkit] Registered Type 'float' to the Orocos Type S=
ystem.
>> 0.007 [ Debug  ][Toolkit] Registered Type 'char' to the Orocos Type Sy=
stem.
>> 0.008 [ Debug  ][Toolkit] Registered Type 'array' to the Orocos Type S=
ystem.
>> 0.008 [ Debug  ][Toolkit] Registered Type 'string' to the Orocos Type
>> System.
>> 0.010 [ Debug  ][./task-test::main()] ORO_main starting...
>> 0.010 [ Info   ][./task-test::main()] LogLevel unaltered by test-runne=
r.
>> 0.011 [ Info   ][./task-test::main()] Creating PeriodicThread for sche=
duler:
>> 0
>> 0.012 [ Info   ][TimerThreadInstance] PeriodicThread created with sche=
duler
>> type '0', priority 15 and period 0.01.
>> 0.013 [ Debug  ][Logger] Periodic Thread TimerThreadInstance started.
>> 0.014 [ Info   ][PThread] PeriodicThread created with scheduler type '=
0',
>> priority 99 and period 0.1.
>> 0.014 [ Debug  ][Logger] Periodic Thread PThread started.
>> 0.115 [ Debug  ][Logger] Periodic Thread PThread stopping... done.
>> 0.115 [ Debug  ][Logger] Periodic Thread PThread started.
>> 1.216 [ Debug  ][Logger] Periodic Thread PThread stopping... done.
>> 1.216 [ Debug  ][~PeriodicThread] Terminating PThread
>>
>> On the serial console we get the following listing (complete listing i=
n
>> appendix):
>>
>> Xenomai: starting native API services.
>> I-pipe: Detected illicit call from domain 'Xenomai'
>>         into a service reserved for domain 'Linux' and below.
>>        f635be74 00000000 00000000 52544149 f635be98 c0104789 c02cfa4f
>> c02f5b80
>>        f6c4e2f0 f635beb0 c0137d69 c02c256c c02c1186 c02c01b8 f8c0b280
>> f635bebc
>>        c0132981 f60a1730 f635bed8 f8bd8570 c010ef8c 00000000 f60a0120
>> f8beefe0
>> Call Trace:
>>  [<c0103ffb>] show_trace_log_lvl+0x1f/0x35
>>  [<c01040bb>] show_stack_log_lvl+0xaa/0xcf
>>  [<c0104789>] show_stack+0x2f/0x36
>>  [<c0137d69>] ipipe_check_context+0x7a/0x81
>>  [<c0132981>] module_put+0x19/0x7d
>>  [<f8bd8570>] xnshadow_unmap+0xbc/0xff [xeno_nucleus]
>>  [<f8bfdc75>] __shadow_delete_hook+0x25/0x27 [xeno_native]
>>  [<f8bd1454>] xnpod_delete_thread+0x1b9/0x2aa [xeno_nucleus]
>>  [<f8bfc36b>] rt_task_delete+0x140/0x145 [xeno_native]
>>  [<f8bfe02a>] __rt_task_delete+0x58/0x69 [xeno_native]
>>  [<f8bd8165>] hisyscall_event+0x185/0x291 [xeno_nucleus]
>>  [<c0138940>] __ipipe_dispatch_event+0xc0/0x1da
>>  [<c010ed6b>] __ipipe_syscall_root+0x43/0x10a
>>  [<c0102e79>] system_call+0x29/0x41
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>=20
> That specific Xenomai bug should be fixed in 2.4, please check your
> testcase against -rc1 e.g. Unfortunately we have no backport of the fix=

> in 2.3 yet. Can't tell right now if this is tricky, but this test
> demonstrates that $SOMETHING should be done...

OK, in order to start fixing things: Here comes a back-port of the 2.4
patch to 2.3.x-SVN, moving module_put out of RT context. Be warned, it's
an early-morning hack, not even compile-tested. Feedback welcome!

Thanks,
Jan

--------------000402000409000405040409
Content-Type: text/plain;
 name="postpone-module_put.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="postpone-module_put.patch"

Index: xenomai-2.3.x/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai-2.3.x/ChangeLog	(Revision 2954)
+++ xenomai-2.3.x/ChangeLog	(Arbeitskopie)
@@ -1,3 +1,8 @@
+2007-08-29  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* ksrc/nucleus/shadow.c: Postpone module_put() to the lo-stage
+	APC handler (back-ported from 2.4).
+
 2007-08-24  Wolfgang Grandegger  <wg@domain.hid>
=20
 	* ksrc/drivers/can/rtcan_socket.c: protect the list of RTCAN
Index: xenomai-2.3.x/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai-2.3.x/ksrc/nucleus/shadow.c	(Revision 2954)
+++ xenomai-2.3.x/ksrc/nucleus/shadow.c	(Arbeitskopie)
@@ -99,6 +99,7 @@ static struct __lostagerq {
 #define LO_RENICE_REQ 2
 #define LO_SIGGRP_REQ 3
 #define LO_SIGTHR_REQ 4
+#define LO_UNMAP_REQ  5
 		int type;
 		struct task_struct *task;
 		int arg;
@@ -753,6 +754,28 @@ void xnshadow_reset_shield(void)
=20
 #endif /* CONFIG_XENO_OPT_ISHIELD */
=20
+static void xnshadow_dereference_skin(unsigned magic)
+{
+	unsigned muxid;
+
+	for (muxid =3D 0; muxid < XENOMAI_MUX_NR; muxid++) {
+		if (muxtable[muxid].magic =3D=3D magic) {
+			if (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
+				xnarch_atomic_dec(&muxtable[0].refcnt);
+			if (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
+
+				/* We were the last thread, decrement the counter,
+				   since it was incremented by the xn_sys_bind
+				   operation. */
+				xnarch_atomic_dec(&muxtable[muxid].refcnt);
+			if (muxtable[muxid].module)
+				module_put(muxtable[muxid].module);
+
+			break;
+		}
+	}
+}
+
 static void lostage_handler(void *cookie)
 {
 	int cpuid =3D smp_processor_id(), reqnum, sig;
@@ -777,6 +800,12 @@ static void lostage_handler(void *cookie
=20
 			goto do_wakeup;
=20
+		case LO_UNMAP_REQ:
+
+			xnshadow_dereference_skin(
+				(unsigned)rq->req[reqnum].arg);
+
+		/* fall through */
 		case LO_WAKEUP_REQ:
=20
 			/* We need to downgrade the root thread
@@ -1256,7 +1285,6 @@ int xnshadow_map(xnthread_t *thread, xnc
 void xnshadow_unmap(xnthread_t *thread)
 {
 	struct task_struct *p;
-	unsigned muxid, magic;
=20
 	if (XENO_DEBUG(NUCLEUS) &&
 	    !testbits(xnpod_current_sched()->status, XNKCOUT))
@@ -1264,25 +1292,6 @@ void xnshadow_unmap(xnthread_t *thread)
=20
 	p =3D xnthread_archtcb(thread)->user_task;
=20
-	magic =3D xnthread_get_magic(thread);
-
-	for (muxid =3D 0; muxid < XENOMAI_MUX_NR; muxid++) {
-		if (muxtable[muxid].magic =3D=3D magic) {
-			if (xnarch_atomic_dec_and_test(&muxtable[0].refcnt))
-				xnarch_atomic_dec(&muxtable[0].refcnt);
-			if (xnarch_atomic_dec_and_test(&muxtable[muxid].refcnt))
-
-				/* We were the last thread, decrement the counter,
-				   since it was incremented by the xn_sys_bind
-				   operation. */
-				xnarch_atomic_dec(&muxtable[muxid].refcnt);
-			if (muxtable[muxid].module)
-				module_put(muxtable[muxid].module);
-
-			break;
-		}
-	}
-
 	xnthread_clear_state(thread, XNMAPPED);
 	rpi_pop(thread);
=20
@@ -1298,13 +1307,7 @@ void xnshadow_unmap(xnthread_t *thread)
=20
 	xnshadow_thrptd(p) =3D NULL;
=20
-	if (p->state !=3D TASK_RUNNING)
-		/* If the shadow is being unmapped in primary mode or blocked
-		   in secondary mode, the associated Linux task should also
-		   die. In the former case, the zombie Linux side returning to
-		   user-space will be trapped and exited inside the pod's
-		   rescheduling routines. */
-		schedule_linux_call(LO_WAKEUP_REQ, p, 0);
+	schedule_linux_call(LO_UNMAP_REQ, p, xnthread_get_magic(thread));
 }
=20
 int xnshadow_wait_barrier(struct pt_regs *regs)
@@ -2010,6 +2013,7 @@ RTHAL_DECLARE_EVENT(losyscall_event);
 static inline void do_taskexit_event(struct task_struct *p)
 {
 	xnthread_t *thread =3D xnshadow_thread(p); /* p =3D=3D current */
+	unsigned magic;
 	spl_t s;
=20
 	if (!thread)
@@ -2018,6 +2022,8 @@ static inline void do_taskexit_event(str
 	if (xnpod_shadow_p())
 		xnshadow_relax(0);
=20
+	magic =3D xnthread_get_magic(thread);
+
 	xnlock_get_irqsave(&nklock, s);
 	/* Prevent wakeup call from xnshadow_unmap(). */
 	xnshadow_thrptd(p) =3D NULL;
@@ -2028,6 +2034,7 @@ static inline void do_taskexit_event(str
 	xnlock_put_irqrestore(&nklock, s);
 	xnpod_schedule();
=20
+	xnshadow_dereference_skin(magic);
 	xnltt_log_event(xeno_ev_shadowexit, thread->name);
 }
=20

--------------000402000409000405040409--

--------------enigC11FF41489A125A1C587E646
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG1Q38niDOoMHTA+kRAvrMAJ0ebPERdZdZK7JCKrDWN/rxS7S0AgCfd6bN
BgSIPTYTZ5r6v9irUHC8mTQ=
=AZ68
-----END PGP SIGNATURE-----

--------------enigC11FF41489A125A1C587E646--

