Message-ID: <44FECDFD.2070309@domain.hid>
Date: Wed, 06 Sep 2006 15:32:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] resubmission : memset of
	heap	crashes	Xenomai-Task
References: <5D63919D95F87E4D9D34FF7748CE2C2A4E9CDD@ARVMAIL1.mra.roland-man.biz>	<17662.49530.72472.462058@domain.hid>
	<44FEC63E.3070009@domain.hid>
In-Reply-To: <44FEC63E.3070009@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig51D9CCC22421EDAEAFD22277"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51D9CCC22421EDAEAFD22277
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> ...
> I was able to reproduce the problem on my MPC5200 system some time ago
> and I have checked the index "i" as well. "i" was not out-of-range,
> IIRC. The problem only shows up on PowerPC., at least Jan was unable
> to reproduce it on a x86 system. How could we debug the seg fault. Do
> you have a good idea? Would the IPIPE tracer help?

First of all, do we know where the demo precisely faults? In which
heap's memset? We could then analyse how this heap is being set up in
the kernel, if all mappings are done as expected, if reasonable address
are passed to the user, etc.

I may have my hands on a 405 board on Friday, but I'm not sure if I can
do much more testing than a simple run of the program. Of course,
testing will primarily take place over latest Xenomai...

Roderik, you said you tested under Qemu as well? For PPC or x86 arch?

Jan


--------------enig51D9CCC22421EDAEAFD22277
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE/s3+niDOoMHTA+kRAkbhAJ0SovJ2vtSRSwuNgSEXKgtIm4kJrQCfbxeE
0iUSufqa2Njun/4SNYc0mPU=
=Bb3J
-----END PGP SIGNATURE-----

--------------enig51D9CCC22421EDAEAFD22277--

