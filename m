Message-ID: <4DFFB2F3.5080508@domain.hid>
Date: Mon, 20 Jun 2011 22:52:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DDA66CF.2010307@domain.hid>
	<4DFDCBEA.6010905@domain.hid>	<4DFDDAB8.4090709@domain.hid>
	<4DFDF2E1.1060106@domain.hid>	<4DFF7E4A.3070807@domain.hid>
	<4DFF8775.7080704@domain.hid>
In-Reply-To: <4DFF8775.7080704@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4BE1DB33EA2039806799AEBB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
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
--------------enig4BE1DB33EA2039806799AEBB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-20 19:46, Gilles Chanteperdrix wrote:
> On 06/20/2011 07:07 PM, Jan Kiszka wrote:
>>>  static inline void do_cleanup_event(struct mm_struct *mm)
>>>  {
>>> +	struct task_struct *p =3D current;
>>> +	struct mm_struct *old;
>>> +
>>> +	old =3D xnshadow_mm(p);
>>> +	xnshadow_mmptd(p) =3D mm;
>>> +
>>>  	ppd_remove_mm(mm, &detach_ppd);
>>> +
>>> +	xnshadow_mmptd(p) =3D old;
>>
>> I don't have the full picture yet, but that feels racy: If the context=

>> over which we clean up that foreign mm is also using xnshadow_mmptd,
>> other threads in that process may dislike this temporary change.
>=20
> This mmptd is only used by xnshadow_ppd_get (which never dereferences i=
t
> by the way

I know that the current code is safe. Avoiding mm_struct types is about
keeping it safe in the future. Why track the type if its just an opaque
key and should be handled as such?

). And if the current thread is running the cleanup event, it
> is not running any other service at the same time. So, this is safe.

Ah, xnshadow_mmptd is per-thread, not per-process as I incorrectly
assumed. Then it's safe.

>=20
> An alternative implementation would be to use some global per-cpu
> variable and disable the preemption during cleanup. But that would not
> fix the case of the shadow cleanups where current->mm is already null.
>=20
> The remaining problem is an irq interrupting the cleanup, and using
> xnshadow_ppd_get. But I would not expect that to happen. I mean,
> xnshadow_ppd_get is more a service to be used for implementation of
> system calls.

Yes, that kind of usage would be a bug in the first place.

>=20
>>> diff --git a/ksrc/skins/posix/mutex.c b/ksrc/skins/posix/mutex.c
>>> index 6ce75e5..cc86852 100644
>>> --- a/ksrc/skins/posix/mutex.c
>>> +++ b/ksrc/skins/posix/mutex.c
>>> @@ -219,10 +219,6 @@ void pse51_mutex_destroy_internal(pse51_mutex_t =
*mutex,
>>>  	xnlock_put_irqrestore(&nklock, s);
>>> =20
>>>  #ifdef CONFIG_XENO_FASTSYNCH
>>> -	/* We call xnheap_free even if the mutex is not pshared; when
>>> -	   this function is called from pse51_mutexq_cleanup, the
>>> -	   sem_heap is destroyed, or not the one to which the fastlock
>>> -	   belongs, xnheap will simply return an error. */
>>
>> I think this comment is not completely obsolete. It still applies /wrt=

>> shared/non-shared.
>=20
> If we apply this patch after the one changing the ppd cleanup order,
> everything falls in place (I can even put a warning in xnheap_destroy i=
f
> the heap has some bytes still in use when destroyed).

"We call xnheap_free even if the mutex is not pshared." This still
applies and is unrelated to the ppd changes.

Jan


--------------enig4BE1DB33EA2039806799AEBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3/svMACgkQitSsb3rl5xREPQCgkt4twuyDzvHJsAAWeZJsmQ9X
6ikAoMmPV8FOg+MSjO6jv7EYaDWMZD9e
=gPuv
-----END PGP SIGNATURE-----

--------------enig4BE1DB33EA2039806799AEBB--

