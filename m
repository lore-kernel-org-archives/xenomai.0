Message-ID: <48BD826E.5090401@domain.hid>
Date: Tue, 02 Sep 2008 20:14:06 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BD409B.8000309@domain.hid>
	<48BD4577.3000307@domain.hid>	<48BD4CE2.4020406@domain.hid>
	<48BD5180.4080509@domain.hid>	<48BD54FE.8010406@domain.hid>
	<48BD5BC3.4040903@domain.hid>	<48BD5D26.4010807@domain.hid>
	<48BD5F17.6050707@domain.hid> <48BD7EFE.1050302@domain.hid>
In-Reply-To: <48BD7EFE.1050302@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E5C5C02CF1A57B507C2B0F9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] POSIX: Fix race when setting claimed bit
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E5C5C02CF1A57B507C2B0F9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> OTOH, we can safe some text size which is precious as well. So I'm
>>>> convinced to go your way (with a modification):
>>> My approach sucks: we get a silly atomic_cmpxchg if the mutex is alre=
ady
>>> claimed, which is as least as much a common case as a currently
>>> unclaimed mutex. Need to think a bit. But I think a good solution is =
to
>>> re-read only if the mutex has been seen as already claimed.
>> That makes no difference as then we will go through the cmpxchg path a=
nyway.
>>
>> There is _no_ way around re-reading under nklock, all we can avoid is
>> atomic cmpxchg in the case of >1 waiters. But that would come at the
>> price of more complexity for all waiter.
>>
>> However, let's find some solution. I bet things will look different
>> again when we start fiddling with a generic lock + the additional bit =
to
>> replace XNWAKEN.
>=20
> What I meant is that if the claimed bit is already set, we can avoid th=
e
> cmpxchg altogether, which was the intent of the original code. So I pro=
pose
> the following version:
>=20
> 	if(test_claimed(owner))
> 		owner =3D xnarch_atomic_intptr_get(mutex->owner);

This version lacks a test for owner =3D=3D 0 here, otherwise you re-creat=
e
my old bug that bite me today.

> 	while(!test_claimed(owner)) {
> 		old =3D xnarch_atomic_intptr_cmpxchg(mutex->owner,
> 						   owner, set_claimed(owner, 1));
> 		if (likely(old =3D=3D owner))
> 			break;
> 		if (old =3D=3D NULL) {
> 			/* Owner called fast mutex_unlock
> 			   (on another cpu) */
> 			xnlock_put_irqrestore(&nklock, s);
> 			goto retry_lock;
> 		}
> 		owner =3D old;
> 	}
>=20
> The compiler rearranges things correctly (at least on ARM), and avoids =
the
> redundant test.
>=20

My latest concern remains: Is all this additional complexity, are all
these conditional branches and the text size increase worth the effort?
How much cycles or micoseconds would be gain on the most suffering
architecture?

Jan


--------------enig7E5C5C02CF1A57B507C2B0F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAki9gm8ACgkQniDOoMHTA+kq9gCfTxZxckUkVyZ/GDMdrUYoouy7
/7EAniwiYCPvCfLlsrKSULJiurQFJIwh
=oue7
-----END PGP SIGNATURE-----

--------------enig7E5C5C02CF1A57B507C2B0F9--

