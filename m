Message-ID: <48AFEA3B.4070702@domain.hid>
Date: Sat, 23 Aug 2008 12:45:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AEE3AB.6070001@domain.hid> <48AEE945.8000503@domain.hid>
	<48AFCD61.8040203@domain.hid> <48AFE515.70003@domain.hid>
In-Reply-To: <48AFE515.70003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD2A57A8189040A03A70150C0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 2/2] Unify asm-x86/atomic.h
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD2A57A8189040A03A70150C0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> ...and also automatically fixes the missing LOCK prefix for
>>>> pthread_mutex_* services on x86_32 SMP.
>>> This looks to me as a half-way unification. Can we not totally get ri=
d
>>> of atomic_32.h and atomic_64.h ? I mean since we are using unsigned l=
ong
>>> as atomic_t on both platforms, there should not be much difference
>>> (except maybe the inline asm).
>>>
>> I could merge all atomic_32/64.h hunks into atomic.h if that this
>> preferred, but I cannot help getting rid of the atomic_t vs. atomic64_=
t
>> differences, thus the sub-arch specific part cannot be reduced as far =
as
>> I see it ATM.
>=20
> We could use atomic_long_t on the two arches.

OK, but then it becomes wrapping business (2.4...) - on the long term a
vanishing issue, granted. Will look into this.

Jan



--------------enigD2A57A8189040A03A70150C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkiv6kEACgkQniDOoMHTA+nEIACeKoCwbyhnoxw3ndKXzNsjpA1A
kvEAni2Z3NpRo60oEigm2YwIDwoC72WZ
=Sce8
-----END PGP SIGNATURE-----

--------------enigD2A57A8189040A03A70150C0--

