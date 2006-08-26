Message-ID: <44F00125.40103@domain.hid>
Date: Sat, 26 Aug 2006 10:07:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] broken PI-chain
References: <44EF2BA6.9040601@domain.hid> <1156530834.4338.42.camel@domain.hid>
	<1156550618.4338.74.camel@domain.hid>
In-Reply-To: <1156550618.4338.74.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3EDA2F212969CF970076320F"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3EDA2F212969CF970076320F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2006-08-25 at 20:33 +0200, Philippe Gerum wrote:
>> On Fri, 2006-08-25 at 18:56 +0200, Jan Kiszka wrote:
>>> Hi,
>>>
>>> the following (academic?) scenario is not handled as expected by the
>>> nucleus:
>>>
>>>  Prio	^
>>> 	|                  -- T2
>>> 	|                 /
>>> 	|  T0 <----- T1 <- M1
>>> 	| (M0)  M0  (M1)
>>> 	+------------------------
>>>
>>> That means: Task T0 at, e.g., prio 1 holds mutex M0. T1, also at prio=
 1,
>>> happens to interrupt T0 (round-robin?). T1 already holds M1 and now
>>> tries to acquire M0. As both are at the same prio level, no boosting
>>> takes place, all fine. Then T2 comes in play. It's at prio 2 and trie=
s
>>> to gain access to M1. T1 gets therefore boosted to prio 2 as well, bu=
t
>>> T0 will stay at prio 1 under Xenomai.
>>>
>> Ok, confirmed. The way the PI chain is handled is very academically
>> broken.
>>
>=20
> xnsynch_renice_sleeper() is the culprit. It does not boost the current
> owner of an unclaimed resource when moving down the PI chain, albeit it=

> should. The main patch below fixes the issue here.
>=20
> Btw, the test code needs likely needs fixing too:
>=20
> -	for (i =3D 1; i < MAX; i++)
> +	for (i =3D 1; i < MAX; i++) {
>  		rt_task_spawn(&task[i], NULL, 0, (i =3D=3D MAX-1) ? 2 : 1, 0, task_f=
unc, (void *)i);
> +		rt_task_yield();
> +	}

True for kernel-space and simulator. It's in my model as well but I
forgot to port it to Real Life. User-space does this yield implicitly
due to the Linux thread creation underneath.

>=20
> AFAICS, since the main thread (T0) is shadowed with priority 1,
> the sequence is going to be:
>=20
> T0, T2, T0 ... rt_task_inquire()
>=20
> With T1 remaining in limbo since there is no reason to preempt T0,
> in which case T0's priority should remain 1, since there is no
> reason to boost it in the first place (i.e. T1 did not run).
> With the added yield, the test works as expected, and T0 properly
> undergoes a priority boost (=3D2).
>=20
>>> I hacked this scenario in the attached demo. Set MAX to 2 to let it
>>> work, leave it 3 and it breaks.
>> Ouch. It does indeed...
>>
>>> The problem looks on first sight like this test [1]: the claiming
>>> relation is only establish if there is a priority delta on entry, but=

>>> that breaks when the claiming thread's prio changes later. Can we sim=
ply
>>> remove this test?
>> It seems that there is even more than this, and I'm wondering now if
>> something fishy is not happening with the CLAIMED bit handling too, wh=
en
>> an attempt is made to clear the priority boost.
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/synch.c=
?v=3DSVN-trunk#L265
>>
>=20
> Ok, this one was a red herring. The CLAIMED bit is properly handled.
>=20
>> I've slightly adapted your test code so that my friend the simulator
>> helps us, and a segfault is raised upon exit of task_func(), which goe=
s
>> south, likely trying to flush the pend queue of some synch object it
>> should not still be waiting for.
>=20
> Red herring again. Wrong simulation libraries. Sorry for the noise.
>=20
> Index: ksrc/nucleus/synch.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/nucleus/synch.c	(revision 1509)
> +++ ksrc/nucleus/synch.c	(working copy)
> @@ -116,8 +116,8 @@
>  		xnsynch_renice_sleeper(thread);
>  	else if (thread !=3D xnpod_current_thread() &&
>  		 testbits(thread->status, XNREADY))
> -		/* xnpod_resume_thread() must be called for runnable threads
> -		   but the running one. */
> +		/* xnpod_resume_thread() must be called for runnable
> +		   threads but the running one. */
>  		xnpod_resume_thread(thread, 0);
> =20
>  #if defined(__KERNEL__) && defined(CONFIG_XENO_OPT_PERVASIVE)
> @@ -210,8 +210,8 @@
>  		else
>  			__setbits(synch->status, XNSYNCH_CLAIMED);
> =20
> +		insertpqf(&owner->claimq, &synch->link, thread->cprio);
>  		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
> -		insertpqf(&owner->claimq, &synch->link, thread->cprio);
>  		xnsynch_renice_thread(owner, thread->cprio);
>  	} else
>  		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
> @@ -262,8 +262,8 @@
>  	int downprio;
> =20
>  	removepq(&lastowner->claimq, &synch->link);
> +	downprio =3D lastowner->bprio;
>  	__clrbits(synch->status, XNSYNCH_CLAIMED);
> -	downprio =3D lastowner->bprio;
> =20
>  	if (emptypq_p(&lastowner->claimq))
>  		__clrbits(lastowner->status, XNBOOST);
> @@ -295,19 +295,35 @@
>  void xnsynch_renice_sleeper(xnthread_t *thread)
>  {
>  	xnsynch_t *synch =3D thread->wchan;
> +	xnthread_t *owner;
> =20
> -	if (testbits(synch->status, XNSYNCH_PRIO)) {
> -		xnthread_t *owner =3D synch->owner;
> +	if (!testbits(synch->status, XNSYNCH_PRIO))
> +		return;
> =20
> -		removepq(&synch->pendq, &thread->plink);
> -		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
> +	owner =3D synch->owner;
> +	removepq(&synch->pendq, &thread->plink);
> +	insertpqf(&synch->pendq, &thread->plink, thread->cprio);
> =20
> -		if (testbits(synch->status, XNSYNCH_CLAIMED) &&
> -		    xnpod_compare_prio(thread->cprio, owner->cprio) > 0) {
> +	if (xnpod_compare_prio(thread->cprio, owner->cprio) > 0) {
> +		/* The new priority of the sleeping thread is higher
> +		 * than the priority of the current owner of the
> +		 * resource: we need to update the PI state. */
> +		if (testbits(synch->status, XNSYNCH_CLAIMED)) {
> +			/* The resource is already claimed, just
> +			   reorder the claim queue. */
>  			removepq(&owner->claimq, &synch->link);
>  			insertpqf(&owner->claimq, &synch->link, thread->cprio);
> -			xnsynch_renice_thread(owner, thread->cprio);
> +		} else {
> +			/* The resource was NOT claimed, claim it now
> +			 * and boost the owner. */
> +			__setbits(synch->status, XNSYNCH_CLAIMED);
> +			insertpqf(&owner->claimq, &synch->link, thread->cprio);
> +			owner->bprio =3D owner->cprio;
> +			__setbits(owner->status, XNBOOST);
>  		}
> +		/* Renice the owner thread, progressing in the PI
> +		   chain as needed. */
> +		xnsynch_renice_thread(owner, thread->cprio);
>  	}
>  }
> =20
> @@ -605,8 +621,9 @@
> =20
>  	for (holder =3D getheadpq(&thread->claimq); holder !=3D NULL;
>  	     holder =3D nholder) {
> -		/* Since xnsynch_wakeup_one_sleeper() alters the claim queue,
> -		   we need to be conservative while scanning it. */
> +		/* Since xnsynch_wakeup_one_sleeper() alters the claim
> +		   queue, we need to be conservative while scanning
> +		   it. */
>  		xnsynch_t *synch =3D link2synch(holder);
>  		nholder =3D nextpq(&thread->claimq, holder);
>  		xnsynch_wakeup_one_sleeper(synch);
>=20
>=20

Patch works fine for me.

But I still wonder what the idea is to officially claim a resource (i.e.
add yourself to the claim queue) only when you boost. That doesn't seem
to be intuitive. Isn't a thread always claiming the resource,
independent of its prio delta?

Jan


--------------enig3EDA2F212969CF970076320F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE8AElniDOoMHTA+kRAsc0AKCCMeDd8OYB9wRD9X0Lf3o89s709ACbBlB3
CRkzDBa0Q6YhTCs1TYMCN9k=
=vJ1N
-----END PGP SIGNATURE-----

--------------enig3EDA2F212969CF970076320F--

