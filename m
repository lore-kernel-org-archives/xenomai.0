Message-ID: <467AB963.60905@domain.hid>
Date: Thu, 21 Jun 2007 19:46:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46782305.4080501@domain.hid>	
	<b647ffbd0706201404r256038b7sbb9318cdc1746b7c@domain.hid>	
	<4679A302.2060403@domain.hid>	
	<b647ffbd0706210103q186c00d7wdb861759ff5c0d78@domain.hid>	
	<467A42F6.8080706@domain.hid> <467A5B85.9010103@domain.hid>
	<1182446655.9709.83.camel@domain.hid>
In-Reply-To: <1182446655.9709.83.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4EA3625F6C2B6E8F1C9AE233"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC][PATCH] shirq locking rework
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4EA3625F6C2B6E8F1C9AE233
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2007-06-21 at 13:05 +0200, Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Well, and I wonder what this xnarch_memory_barrier() at each handler
>>> entry is for. Seems to be there for ages, don't see why right now.
>=20
> AFAICT, this probably dates back to Xenomai 1.x, when we used to have a=

> threaded interrupt model. The actual code looked like as follows, and
> the barrier was likely here to make sure that any change to the
> interrupt hit counter was visible from any other CPU which would run th=
e
> interrupt service thread. The funny thing is that we did not have SMP
> support at that time, anyway...
>=20
> static void xnintr_irq_handler (unsigned irq, void *cookie)
>=20
> {
>     xnintr_t *intr =3D (xnintr_t *)cookie;
>     int s =3D XN_ISR_SCHED_T;
>=20
>     intr->hits++;
>=20
>     xnarch_memory_barrier();
>=20
>=20
> In short, I don't see any reason to keep this membar.

Fascinating: So many people came along this place, but no one dared to
touch it. :)

>=20
>>  (The
>>> kernel has a golden rule for this: no barrier without comments!)
>=20
> Yeah, right. It looks like the kernel has a slew of very official golde=
n
> rules it basically does not care one dime to enforce in practice.
> Looking at the code, commenting membars is surely one of them...
>=20

I saw Andrew Morton being strictly after uncommented ones in new code at
least.

Jan


--------------enig4EA3625F6C2B6E8F1C9AE233
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGerljniDOoMHTA+kRArA3AJ96KzmepjVEGe/cfxLdz1Jz8VfENgCfcWHV
/9DKQNzTGvBr6Lgg+2z1m/A=
=3N+D
-----END PGP SIGNATURE-----

--------------enig4EA3625F6C2B6E8F1C9AE233--

