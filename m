Message-ID: <4E760186.3040907@domain.hid>
Date: Sun, 18 Sep 2011 16:34:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4E6C927F.3070901@domain.hid> <4E6CC49C.1020403@domain.hid>
	<4E6CC5CC.5020204@domain.hid> <4E73AE00.3040002@domain.hid>
	<4E73B403.1060706@domain.hid> <1316354565.2169.20.camel@domain.hid>
In-Reply-To: <1316354565.2169.20.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8540094B6ED1AED3802C239D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Policy switching and XNOTHER maintenance
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8540094B6ED1AED3802C239D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-09-18 16:02, Philippe Gerum wrote:
> On Fri, 2011-09-16 at 22:39 +0200, Gilles Chanteperdrix wrote:
>> On 09/16/2011 10:13 PM, Gilles Chanteperdrix wrote:
>>> On 09/11/2011 04:29 PM, Jan Kiszka wrote:
>>>> On 2011-09-11 16:24, Gilles Chanteperdrix wrote:
>>>>> On 09/11/2011 12:50 PM, Jan Kiszka wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> just looked into the hrescnt issue again, specifically the corner =
case
>>>>>> of a shadow thread switching from real-time policy to SCHED_OTHER.=

>>>>>
>>>>> Doing this while holding a mutex looks invalid.
>>>>
>>>> Looking at POSIX e.g., is there anything in the spec that makes this=

>>>> invalid? If the kernel preserves or established proper priority
>>>> boosting, I do not see what could break in principle.
>>>>
>>>> It is nothing I would design into some app, but we should somehow ha=
ndle
>>>> it (doc update or code adjustments).
>>>>
>>>>> If we do not do it, the current code is valid.
>>>>
>>>> Except for its dependency on XNOTHER which is not updated on RT->NOR=
MAL
>>>> transitions.
>>>
>>> The fact that this update did not take place made the code work. No=20
>>> negative rescnt could happen with that code.
>>>
>>> Anyway, here is a patch to allow switching back from RT to NORMAL, bu=
t=20
>>> send a SIGDEBUG to a thread attempting to release a mutex while its=20
>>> counter is already 0. We end up avoiding a big chunk of code that wou=
ld=20
>>> have been useful for a really strange corner case.
>>>
>>
>> Here comes version 2:
>> diff --git a/include/nucleus/sched-idle.h b/include/nucleus/sched-idle=
=2Eh
>> index 6399a17..417170f 100644
>> --- a/include/nucleus/sched-idle.h
>> +++ b/include/nucleus/sched-idle.h
>> @@ -39,6 +39,8 @@ extern struct xnsched_class xnsched_class_idle;
>>  static inline void __xnsched_idle_setparam(struct xnthread *thread,
>>  					   const union xnsched_policy_param *p)
>>  {
>> +	if (xnthread_test_state(thread, XNSHADOW))
>> +		xnthread_clear_state(thread, XNOTHER);
>>  	thread->cprio =3D p->idle.prio;
>>  }
>> =20
>> diff --git a/include/nucleus/sched-rt.h b/include/nucleus/sched-rt.h
>> index 71f655c..cc1cefa 100644
>> --- a/include/nucleus/sched-rt.h
>> +++ b/include/nucleus/sched-rt.h
>> @@ -86,6 +86,12 @@ static inline void __xnsched_rt_setparam(struct xnt=
hread *thread,
>>  					 const union xnsched_policy_param *p)
>>  {
>>  	thread->cprio =3D p->rt.prio;
>> +	if (xnthread_test_state(thread, XNSHADOW)) {
>> +		if (thread->cprio)
>> +			xnthread_clear_state(thread, XNOTHER);
>> +		else
>> +			xnthread_set_state(thread, XNOTHER);
>> +	}
>>  }
>> =20
>>  static inline void __xnsched_rt_getparam(struct xnthread *thread,
>> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
>> index 9a02e80..d19999f 100644
>> --- a/ksrc/nucleus/pod.c
>> +++ b/ksrc/nucleus/pod.c
>> @@ -1896,16 +1896,6 @@ int __xnpod_set_thread_schedparam(struct xnthre=
ad *thread,
>>  		xnsched_putback(thread);
>> =20
>>  #ifdef CONFIG_XENO_OPT_PERVASIVE
>> -	/*
>> -	 * A non-real-time shadow may upgrade to real-time FIFO
>> -	 * scheduling, but the latter may never downgrade to
>> -	 * SCHED_NORMAL Xenomai-wise. In the valid case, we clear
>> -	 * XNOTHER to reflect the change. Note that we keep handling
>> -	 * non real-time shadow specifics in higher code layers, not
>> -	 * to pollute the core scheduler with peculiarities.
>> -	 */
>> -	if (sched_class =3D=3D &xnsched_class_rt && sched_param->rt.prio > 0=
)
>> -		xnthread_clear_state(thread, XNOTHER);
>>  	if (propagate) {
>>  		if (xnthread_test_state(thread, XNRELAX))
>>  			xnshadow_renice(thread);
>> diff --git a/ksrc/nucleus/sched-sporadic.c b/ksrc/nucleus/sched-sporad=
ic.c
>> index fd37c21..ffc9bab 100644
>> --- a/ksrc/nucleus/sched-sporadic.c
>> +++ b/ksrc/nucleus/sched-sporadic.c
>> @@ -258,6 +258,8 @@ static void xnsched_sporadic_setparam(struct xnthr=
ead *thread,
>>  		}
>>  	}
>> =20
>> +	if (xnthread_test_state(thread, XNSHADOW))
>> +		xnthread_clear_state(thread, XNOTHER);
>>  	thread->cprio =3D p->pss.current_prio;
>>  }
>> =20
>> diff --git a/ksrc/nucleus/sched-tp.c b/ksrc/nucleus/sched-tp.c
>> index 43a548e..a2af1d3 100644
>> --- a/ksrc/nucleus/sched-tp.c
>> +++ b/ksrc/nucleus/sched-tp.c
>> @@ -100,6 +100,8 @@ static void xnsched_tp_setparam(struct xnthread *t=
hread,
>>  {
>>  	struct xnsched *sched =3D thread->sched;
>> =20
>> +	if (xnthread_test_state(thread, XNSHADOW))
>> +		xnthread_clear_state(thread, XNOTHER);
>>  	thread->tps =3D &sched->tp.partitions[p->tp.ptid];
>>  	thread->cprio =3D p->tp.prio;
>>  }
>> diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
>> index b956e46..47bc0c5 100644
>> --- a/ksrc/nucleus/synch.c
>> +++ b/ksrc/nucleus/synch.c
>> @@ -684,9 +684,13 @@ xnsynch_release_thread(struct xnsynch *synch, str=
uct xnthread *lastowner)
>> =20
>>  	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
>> =20
>> -	if (xnthread_test_state(lastowner, XNOTHER))
>> -		xnthread_dec_rescnt(lastowner);
>> -	XENO_BUGON(NUCLEUS, xnthread_get_rescnt(lastowner) < 0);
>> +	if (xnthread_test_state(lastowner, XNOTHER)) {
>> +		if (xnthread_get_rescnt(lastowner) =3D=3D 0)
>> +			xnshadow_send_sig(lastowner, SIGDEBUG,
>> +					  SIGDEBUG_MIGRATE_PRIOINV, 1);
>> +		else
>> +			xnthread_dec_rescnt(lastowner);
>> +	}
>>  	lastownerh =3D xnthread_handle(lastowner);
>> =20
>>  	if (use_fastlock &&
>>
>>
>>
>=20
> Agreed, the logic of this patch sounds right. Switching from -rt to -nr=
t
> while holding a -rt mutex is pathological behavior. We don't have to
> support apps implementing voluntary priority inversion.
>=20

No concerns either.

Now we just need

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 21cc191..27bc829 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -2756,9 +2756,12 @@ static inline void do_setsched_event(struct task_s=
truct *p, int priority)
 	union xnsched_policy_param param;
 	struct xnsched *sched;
=20
-	if (!thread || p->policy !=3D SCHED_FIFO)
+	if (!thread)
 		return;
=20
+	if (p->policy =3D=3D SCHED_FIFO)
+		priority =3D 0;
+
 	/*
 	 * Linux's priority scale is a subset of the core pod's
 	 * priority scale, so there is no need to bound the priority


to track the policy change when done via Linux.

Jan


--------------enig8540094B6ED1AED3802C239D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk52AYsACgkQitSsb3rl5xQHMgCgx2EPdf2SCEzylMWyfxgXv/ZY
OX8AoM0vypwyt5pMz6igzw0se4ajqYOV
=vetU
-----END PGP SIGNATURE-----

--------------enig8540094B6ED1AED3802C239D--

