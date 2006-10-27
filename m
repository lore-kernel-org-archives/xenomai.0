Message-ID: <45420754.4040907@domain.hid>
Date: Fri, 27 Oct 2006 15:19:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mmap and secondary mode
References: <5D63919D95F87E4D9D34FF7748CE2C2A5FF8EC@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A5FF8EC@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFC22D0DA2DD0424CC099A23A"
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC22D0DA2DD0424CC099A23A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roderik_Wildenburg@domain.hid wrote:
> Just to be sure :
> Does the access of a mmaped address (real_mmamp of a device file e.g.
> /dev/dualportmemory) force Xenomai to switch to secondary mode ?
> I would say yes, as the access of the address probably results into a
> read/write of the device file.
> Am I right ?

Depends. If that mapping takes place directly on a physical memory
region *ahead-of-use*, then you are safe (like with rtdm_iomap_to_user
from 2.3-devel). But if there is some Linux driver logic in between that
is triggered via page faults on access to those memory blocks, this is
certainly indeterministic. Probably easy to find out by analysing the
Linux driver in question /wrt its mapping code.

Jan


--------------enigFC22D0DA2DD0424CC099A23A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFQgdUniDOoMHTA+kRAnJlAJ45liaqLQ1Wq5crnYVDBf1zA3NZZwCeKsyE
956cenzGXYVJYrG2YIikMjw=
=G8Oa
-----END PGP SIGNATURE-----

--------------enigFC22D0DA2DD0424CC099A23A--

