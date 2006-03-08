Message-ID: <440F3354.3010106@domain.hid>
Date: Wed, 08 Mar 2006 20:41:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] RTDM mmap and vm_operations
References: <200603081558.02034.lbocseg@domain.hid>
In-Reply-To: <200603081558.02034.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBA5694578D9EC1032E07E4C1"
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
--------------enigBA5694578D9EC1032E07E4C1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan,
>=20
> Is there a way of knowing what was the src_addr or pptr data passed to =

> rtdm_mmap_to_user without using the vm_private_data struct? I mean, can=
 I=20
> obtain those information directly in the vma struct passed to the close=
=20
> handler? If so, I could pass a more generic struct to vm_private and us=
e=20
> those information,making my life a bit easier... :)
>=20

I do not see a clean, official way right now. It would definitely be
something you have to obtain via vma_area_struct or something that's
contained in it. The information is likely there - somewhere. But I
doubt that obtaining it would make your code very portable across
different kernel versions.

Jan


--------------enigBA5694578D9EC1032E07E4C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEDzNUniDOoMHTA+kRAgW8AJ9b5o8lqDHDvevgOkYerm9/kqZcHACeI70v
PaQ3qTBqHZftY5kbwliaEZM=
=bjL+
-----END PGP SIGNATURE-----

--------------enigBA5694578D9EC1032E07E4C1--

