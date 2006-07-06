Message-ID: <44AD3C00.9050909@domain.hid>
Date: Thu, 06 Jul 2006 18:36:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
References: <44ACF5FA.2050205@domain.hid>
	<1152196379.4978.74.camel@domain.hid>		<44AD27AF.8050804@domain.hid>
	<1152200271.4978.85.camel@domain.hid> <44AD3048.5050602@domain.hid>
In-Reply-To: <44AD3048.5050602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9045C8CBCD950AB05E684041"
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
--------------enig9045C8CBCD950AB05E684041
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Thu, 2006-07-06 at 17:09 +0200, Jan Kiszka wrote:
>>>> We could do that from the current loop below, given that the
>>>> accumulation routine is changed to use thread->sched implicitely.
>>> The idea is avoid adding even further load to the nklock-protected lo=
op.
>>> And we only update the current thread, not each and every.
>>>
>> Yes, but why? I mean, accumulated time so far remains significant even=

>> for non-running threads.
>=20
> Update must only happen for the currently running thread on each cpu,
> otherwise you skew the stats up.
>=20
>=20
> But looking at the whole code in stat_seq_open() again, I now wonder if=

> that whole routine isn't
>=20
> a) fragile on task removal and
> b) still poorly scaling.
>=20
> The thread name is only copied by reference, a disappearing instance my=

> cause troubles on printing it. And, instead of holding the lock all the=

> time, shouldn't we better
>=20
> 1. pick some element from the queue and mark it somehow
>    in-use under lock
> 2. print or copy the entry
> 3. reacquire the lock to proceed to the next one - after checking if
>    that element happened to be removed from the queue meanwhile (in tha=
t
>    case we could abort the output or try to resync)

Not feasible (threads may not always be prevented from being deleted),
but what about this:

- maintain a modification counter for nkpod->threadq
- in our /proc-loops (sched and latency e.g.):
  1. take nklock
  2. get current counter
  3. compare with previous, restart whole loop if not matching
  4. copy current element (including the name...)
  5. forward element pointer
  6. release nklock
  7. goto 1 if not end-of-list

As modifications on threadq should be fairly rare, I don't see a risk of
looping endlessly here.

Jan


--------------enig9045C8CBCD950AB05E684041
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErTwAniDOoMHTA+kRAt2xAJ9PmGww1w7tDA2t5aoO8i2svwwd/QCfRL4q
TaENsJpKk6zP6Ghp/6i+tYQ=
=9Lbs
-----END PGP SIGNATURE-----

--------------enig9045C8CBCD950AB05E684041--

