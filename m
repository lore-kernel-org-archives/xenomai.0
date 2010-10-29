Message-ID: <4CCA70F1.3010501@domain.hid>
Date: Fri, 29 Oct 2010 09:00:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC998FB.3070102@domain.hid> <4CC9CBE1.6030006@domain.hid>
	<1288294469.1816.107.camel@domain.hid>
In-Reply-To: <1288294469.1816.107.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig99222E40CBD75965E938FA3E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] arm: Unprotected access to irq_desc field?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99222E40CBD75965E938FA3E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 28.10.2010 21:34, Philippe Gerum wrote:
> On Thu, 2010-10-28 at 21:15 +0200, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles,
>>>
>>> I happened to come across rthal_mark_irq_disabled/enabled on arm. On
>>> first glance, it looks like these helpers manipulate irq_desc::status=

>>> non-atomically, i.e. without holding irq_desc::lock. Isn't this fragi=
le?
>>
>> I have no idea. How do the other architectures do? As far as I know,
>> this code has been copied from there.
>=20
> Other archs do the same, simply because once an irq is managed by the
> hal, it may not be shared in any way with the regular kernel. So lockin=
g
> is pointless.

Indeed, I missed that all the other archs have this uninlined in hal.c.

However, this leaves at least a race between xnintr_disable/enable and
XN_ISR_PROPAGATE (ie. the related Linux path) behind. Not sure if it
matters practically - but risking silent breakage for this micro
optimization? Is disabling/enabling really in the highly
latency-critical anywhere? Otherwise, I would suggest to just plug this
by adding the intended lock for this field.

Jan


--------------enig99222E40CBD75965E938FA3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzKcPMACgkQitSsb3rl5xSjlQCeOyly3Akqc4A6NFHqzIVMHWxH
E/kAni8guMIt3KfpVtGU1YBulyP3NKRP
=E3cM
-----END PGP SIGNATURE-----

--------------enig99222E40CBD75965E938FA3E--

