Message-ID: <4E1C44B4.50106@domain.hid>
Date: Tue, 12 Jul 2011 14:57:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B469A.8000703@domain.hid>
	<4E1B4AC0.80506@domain.hid> <4E1B4C19.2070205@domain.hid>
	<4E1B542B.2010906@domain.hid> <4E1B5638.1050005@domain.hid>
	<4E1B56E0.20109@domain.hid> <4E1B57D1.1070401@domain.hid>
	<4E1B5860.1000309@domain.hid> <4E1B5944.5030408@domain.hid>
	<4E1BEC9F.1020404@domain.hid> <4E1BF619.6010609@domain.hid>
	<4E1C2912.9050605@domain.hid> <4E1C2959.8080004@domain.hid>
	<4E1C2A2D.9090602@domain.hid> <4E1C2AA5.6060208@domain.hid>
	<4E1C2B44.5060907@domain.hid> <4E1C2B8F.5080700@domain.hid>
	<4E1C2F56.8020103@domain.hid> <4E1C302A.8050309@domain.hid>
	<4E1C3301.2030203@domain.hid> <4E1C3672.1030104@domain.hid>
	<4E1C36EE.70803@domain.hid> <4E1C38CE.7090202@domain.hid>
	<4E1C3A5D.3020700@domain.hid>
In-Reply-To: <4E1C3A5D.3020700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DF09978EB1CE5D327EC6E55"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and	thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DF09978EB1CE5D327EC6E55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-12 14:13, Jan Kiszka wrote:
> On 2011-07-12 14:06, Gilles Chanteperdrix wrote:
>> On 07/12/2011 01:58 PM, Jan Kiszka wrote:
>>> On 2011-07-12 13:56, Jan Kiszka wrote:
>>>> However, this parallel unsynchronized execution of the gatekeeper an=
d
>>>> its target thread leaves an increasingly bad feeling on my side. Did=
 we
>>>> really catch all corner cases now? I wouldn't guarantee that yet.
>>>> Specifically as I still have an obscure crash of a Xenomai thread on=

>>>> Linux schedule() on my table.
>>>>
>>>> What if the target thread woke up due to a signal, continued much
>>>> further on a different CPU, blocked in TASK_INTERRUPTIBLE, and then =
the
>>>> gatekeeper continued? I wish we could already eliminate this complex=
ity
>>>> and do the migration directly inside schedule()...
>>>
>>> BTW, we do we mask out TASK_ATOMICSWITCH when checking the task state=
 in
>>> the gatekeeper? What would happen if we included it (state =3D=3D
>>> (TASK_ATOMICSWITCH | TASK_INTERRUPTIBLE))?
>>
>> I would tend to think that what we should check is
>> xnthread_test_info(XNATOMIC). Or maybe check both, the interruptible
>> state and the XNATOMIC info bit.
>=20
> Actually, neither the info bits nor the task state is sufficiently
> synchronized against the gatekeeper yet. We need to hold a shared lock
> when testing and resetting the state. I'm not sure yet if that is
> fixable given the gatekeeper architecture.
>=20

This may work (on top of the exit-race fix):

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 50dcf43..90feb16 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -913,20 +913,27 @@ static int gatekeeper_thread(void *data)
 		if ((xnthread_user_task(target)->state & ~TASK_ATOMICSWITCH) =3D=3D TA=
SK_INTERRUPTIBLE) {
 			rpi_pop(target);
 			xnlock_get_irqsave(&nklock, s);
-#ifdef CONFIG_SMP
+
 			/*
-			 * If the task changed its CPU while in
-			 * secondary mode, change the CPU of the
-			 * underlying Xenomai shadow too. We do not
-			 * migrate the thread timers here, it would
-			 * not work. For a "full" migration comprising
-			 * timers, using xnpod_migrate_thread is
-			 * required.
+			 * Recheck XNATOMIC to avoid waking the shadow if the
+			 * Linux task received a signal meanwhile.
 			 */
-			if (target->sched !=3D sched)
-				xnsched_migrate_passive(target, sched);
+			if (xnthread_test_info(target, XNATOMIC)) {
+#ifdef CONFIG_SMP
+				/*
+				 * If the task changed its CPU while in
+				 * secondary mode, change the CPU of the
+				 * underlying Xenomai shadow too. We do not
+				 * migrate the thread timers here, it would
+				 * not work. For a "full" migration comprising
+				 * timers, using xnpod_migrate_thread is
+				 * required.
+				 */
+				if (target->sched !=3D sched)
+					xnsched_migrate_passive(target, sched);
 #endif /* CONFIG_SMP */
-			xnpod_resume_thread(target, XNRELAX);
+				xnpod_resume_thread(target, XNRELAX);
+			}
 			xnlock_put_irqrestore(&nklock, s);
 			xnpod_schedule();
 		}
@@ -1036,6 +1043,7 @@ redo:
 	 * to process this signal anyway.
 	 */
 	if (rthal_current_domain =3D=3D rthal_root_domain) {
+		XENO_BUGON(NUCLEUS, xnthread_test_info(thread, XNATOMIC));
 		if (XENO_DEBUG(NUCLEUS) && (!signal_pending(this_task)
 		    || this_task->state !=3D TASK_RUNNING))
 			xnpod_fatal
@@ -1044,6 +1052,8 @@ redo:
 		return -ERESTARTSYS;
 	}
=20
+	xnthread_clear_info(thread, XNATOMIC);
+
 	/* "current" is now running into the Xenomai domain. */
 	thread->gksched =3D NULL;
 	sched =3D xnsched_finish_unlocked_switch(thread->sched);
@@ -2650,6 +2660,8 @@ static inline void do_sigwake_event(struct task_str=
uct *p)
=20
 	xnlock_get_irqsave(&nklock, s);
=20
+	xnthread_clear_info(thread, XNATOMIC);
+
 	if ((p->ptrace & PT_PTRACED) && !xnthread_test_state(thread, XNDEBUG)) =
{
 		sigset_t pending;
=20

It totally ignores RPI and PREEMPT_RT for now. RPI is broken anyway,
ripping it out would allow to use solely XNATOMIC as condition in the
gatekeeper.

/me is now looking to get this applied to a testbox that still crashes
suspiciously.

Jan


--------------enig6DF09978EB1CE5D327EC6E55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4cRLQACgkQitSsb3rl5xSc+QCdFNGhHDJ5+Clpguegbg3DllXC
j5cAn3bQwK/8QwYco8Hn2KExaT7CG6oS
=Zuu/
-----END PGP SIGNATURE-----

--------------enig6DF09978EB1CE5D327EC6E55--

