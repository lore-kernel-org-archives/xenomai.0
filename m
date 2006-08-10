Message-ID: <44DAEDF9.8060500@domain.hid>
Date: Thu, 10 Aug 2006 10:27:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] SMI update
References: <200608091837.55424.schwab@domain.hid> <44DA6568.6050300@domain.hid>
	<200608100944.34068.schwab@domain.hid>
In-Reply-To: <200608100944.34068.schwab@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F05A54EA7D1236CC35F130B"
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
To: Ulrich Schwab <schwab@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F05A54EA7D1236CC35F130B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ulrich Schwab wrote:
> On Thursday 10 August 2006 00:44, Jan Kiszka wrote:
>> Thanks for the patch, we just need some additional define of
>> PCI_DEVICE_ID_INTEL_ICH7_0 for kernel 2.4 compatibility. And if you
>> additionally provide a ChangeLog fragment, your patch would be perfect=
!
>> (I tend to forget the last part often too... :) )
> Where to add the new define for kernel 2.4 ?
>=20

I would say to smi.c directly as there are no other users in sight.
Otherwise, wrapping code goes to include/asm-{generic|<arch>}/wrapper.h.

Jan


--------------enig6F05A54EA7D1236CC35F130B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE2u35niDOoMHTA+kRAhvgAJ4gg9DScNEaqfHlg1QEeXSM5mriSQCeK+Q2
REsP292rqBVLe5Pk0XS4uxA=
=hM28
-----END PGP SIGNATURE-----

--------------enig6F05A54EA7D1236CC35F130B--

