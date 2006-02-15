Message-ID: <43F2761D.2050702@domain.hid>
Date: Wed, 15 Feb 2006 01:30:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] provide rtdm_mmap_to_user / rtdm_munmap
References: <200602141114.23856.lbocseg@domain.hid>
In-Reply-To: <200602141114.23856.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig96B84E4913B446E013A1F3BB"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96B84E4913B446E013A1F3BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Ter=E7a 14 Fevereiro 2006 05:55, voc=EA escreveu:
>> Rodrigo Rosenfeld Rosas wrote:
>>> I forgot to mention, I have one more problem. Since I call mmap on
>>> driver initialization (thus before any rtdm_dev_open), I do not have =
any
>>> rtdm_user_info_t, so I need to use current instead, but I'm not sure =
if
>>> this will work. Maybe mmap needs the 'current' struct of the user
>>> program... I don't know this very well... If that is true, so I'll ha=
ve
>>> to do the maps in a non-rt context anyway...
>> You cannot mmap before you know precisely for which user this should
>> take place.
>=20
> Do you mean that if I use the 'current' and current->mm struct of the d=
river,
> when mmaping, the user won't be able to use the returned pointer?

To mmap you need to know the target process, more precisely its mm. This
is typically derived from the invocation context of the service call
("current" is a pointer to the current process). But init_module runs in
the context of modprobe. Even worse, the process later opening and
mapping some buffer may not even exist at that time!

>=20
>> During init, it's the insmod/modprobe process - likely not
>> the one you are interested in.
>=20
> Actually, that is the way I was planning for making the maping in a
> deterministic way...
>=20
>> So the earliest point for mmap is device
>> open. If this is too late for you, then now finally forget about this
>> pre-mmapping and turn it into a normal function for secondary mode. It=

>> will be hard anyway to find a user who will notice the difference.
>=20
> That is not a question of noting any difference or not... An applicatio=
n can
> works great most of the time but it can fail under some not common
> circunstances. The user will need to know, at least, that he will can n=
ot
> rely on rt-capabilities when doing that and will be forced to do that o=
nly on
> initialization. But that is ok for most cases. I think I'll do that (I =
do not
> have other options at all :) ).

Just place enough warning signs in your documentation around the
mmap-wrapper you provide, saying that no one should expect bounded
delays from this service.

Jan


--------------enig96B84E4913B446E013A1F3BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD8nYdniDOoMHTA+kRAldHAJsEbwyABRzqdFkCghBPYkCERUp6yQCdHSkT
OIPL6dRL0czpYTaqcwyGnoo=
=d1R6
-----END PGP SIGNATURE-----

--------------enig96B84E4913B446E013A1F3BB--

