Message-ID: <44F5A0CD.2040706@domain.hid>
Date: Wed, 30 Aug 2006 16:29:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Fwd: Performance decrease]
References: <DD39B5C3F4963040ADC9768BE7E430CB01082A7C@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01082A7C@is-hdq-exchange.marel.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA08897C807073EA34619D5B3"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <danielsch@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA08897C807073EA34619D5B3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Hi,
>=20
>=20
>>>> For what is the real-time support in user space option good for ?
>>>>
>> This allows running Xenomai applications in user-space, instead of
>> implementing them as kernel modules.
>>
>=20
> Everyone planning to write kernel-space drivers and/or applications
> should keep an eye on some non-technical aspect as well: the license.
> That's no problem for in-house, unpublished work. But for things that
> are to be given away / sold, one should recall that the kernel communit=
y
> is more and more considering non-GPL modules in general as a license
> infringement.
>=20
>=20
> Hmm, if I am writing an application that uses Xenomai's magic, e.g. in
> using the POSIX API, that shouldn't violate any GPL code isn't it ? Of
> course a kernel module should be GPL, because it is linked to the GPL
> kernel.

Well, kernel developers have a standard answer: "Consult a lawyer." And
if you are really going for a non-GPL kernel-based product, this is
probably a good idea to assess potential risks. Note that the Xenomai
API in kernel space is GPL due to the GPL environment of the kernel.
Only the user-space libs are LGPL.

>=20
> So are RTDM drivers principially running in user space then ?

RTDM drivers are currently running in kernel space only, but they are
providing services to both user and kernel space, symmetrically.

Jan


--------------enigA08897C807073EA34619D5B3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE9aDNniDOoMHTA+kRAgEQAJ4l2tUtE3jHWetMAKsUuAS26BmMowCeO0lg
mNOyF3JNGW7vYyo/lZ7eLn4=
=ODz1
-----END PGP SIGNATURE-----

--------------enigA08897C807073EA34619D5B3--

