Message-ID: <47ADCD94.8000107@domain.hid>
Date: Sat, 09 Feb 2008 16:58:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18340.31233.591834.293535@domain.hid>	<47A63D49.4050700@domain.hid>
	<18349.51607.459245.139367@domain.hid>
In-Reply-To: <18349.51607.459245.139367@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7D12986F014C1139BC2C65D0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 0/5] Support for select v2.
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D12986F014C1139BC2C65D0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Hi,
>  > >=20
>  > > after some tests, bug fixes and optimizations, here comes a second=
 version of=20
>  > > the patch-set adding select support to xenomai posix skin.
>  > >=20
>  >=20
>  > Puh, a lot of code, and my brain is still full of KGDB stuff I'm try=
ing
>  > to polish for mainline since days.
>  >=20
>  > The approach looks consistent to me. I would just suggest to make th=
e
>  > whole thing configurable, so that it doesn't add overhead to systems=

>  > which do not use it.
>=20
> I am getting back to this select stuff. So I have a question, would you=

> agree if the select support was made configurable, but if when this
> support was enabled, support for select was added to vanilla
> rtdm_event_t and rtdm_sem_t ? This would ease maintenance, since it
> would avoid a lot of code duplication, without adding to much overhead
> in my opinion (an empty list test when signaling the objects).

Looking at the code again, this really makes sense, go for it.

>=20
>  >=20
>  > Out of curiosity: Did you already have a chance to compare a
>  > multi-threaded demo application with one based on these new select s=
ervices?
>  >=20
>  > I guess your current test cases are built on top of RTnet, aren't th=
ey?
>  > Would be nice, also for regression testing, to have some demo for
>  > /examples, e.g. exploiting the CAN stack (because it has virtual CAN=
,
>  > thus it is usable without hardware).
>=20
> Ok, I had a look at the CAN stack, if I understand correctly when
> receiving, the recv_sem defined in rcan_socket.h is used, and when
> sending, the tx_sem defined in rtcan_dev.h is used. Can you confirm thi=
s
> ?=20

Yep, that's correct. rx_sem counts received packets, tx_sem the number
of available output slots in the CAN port.

Jan


--------------enig7D12986F014C1139BC2C65D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHrc2YniDOoMHTA+kRAh2qAJ0Yw8cfVAyl39wt0vYOvhOL4MPqwQCfUmaA
MIUR1/Hcbaz+Li4bwfv9gXU=
=u+St
-----END PGP SIGNATURE-----

--------------enig7D12986F014C1139BC2C65D0--

