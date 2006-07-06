Message-ID: <44AD3048.5050602@domain.hid>
Date: Thu, 06 Jul 2006 17:46:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
References: <44ACF5FA.2050205@domain.hid> <1152196379.4978.74.camel@domain.hid>	
	<44AD27AF.8050804@domain.hid> <1152200271.4978.85.camel@domain.hid>
In-Reply-To: <1152200271.4978.85.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0895B377834580B611FB7BB7"
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
--------------enig0895B377834580B611FB7BB7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-07-06 at 17:09 +0200, Jan Kiszka wrote:
>>> We could do that from the current loop below, given that the
>>> accumulation routine is changed to use thread->sched implicitely.
>> The idea is avoid adding even further load to the nklock-protected loo=
p.
>> And we only update the current thread, not each and every.
>>
>=20
> Yes, but why? I mean, accumulated time so far remains significant even
> for non-running threads.

Update must only happen for the currently running thread on each cpu,
otherwise you skew the stats up.


But looking at the whole code in stat_seq_open() again, I now wonder if
that whole routine isn't

a) fragile on task removal and
b) still poorly scaling.

The thread name is only copied by reference, a disappearing instance my
cause troubles on printing it. And, instead of holding the lock all the
time, shouldn't we better

1. pick some element from the queue and mark it somehow
   in-use under lock
2. print or copy the entry
3. reacquire the lock to proceed to the next one - after checking if
   that element happened to be removed from the queue meanwhile (in that
   case we could abort the output or try to resync)

I'm worrying about a potential nice xeno-top tool polling the stats at
high frequency and causing unexpected jitters if there are a significant
number tasks registered (think of passive shadows we may create
automatically in the future!).

Jan


--------------enig0895B377834580B611FB7BB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErTBIniDOoMHTA+kRAnXOAJ4k7QcEtphW0fGg9V5u4j4EhSzRJgCggvrQ
1D6aZkB8V7kzVk0P3pJ7k6g=
=9Rgd
-----END PGP SIGNATURE-----

--------------enig0895B377834580B611FB7BB7--

