Message-ID: <4354B258.6080901@domain.hid>
Date: Tue, 18 Oct 2005 10:29:12 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] compiling xenomai on x86_64
References: <4353F109.7000707@domain.hid>
	<4353F411.4000500@domain.hid>
	<4353F896.1040508@domain.hid>
	<435402B4.5060004@domain.hid> <435403C8.80400@domain.hid>
	<43540531.8050304@domain.hid>
	<435406E0.8020405@domain.hid> <435408E5.8020007@domain.hid>
	<435419B0.8030004@domain.hid>
	<4354AD5A.7010305@domain.hid>
	<17236.44759.217634.762329@domain.hid>
In-Reply-To: <17236.44759.217634.762329@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig584AB7D2C8C23003A5199DA2"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig584AB7D2C8C23003A5199DA2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Jan Kiszka wrote:
>  > I just analysed this further: the problem disappears when I manually
>  > remove any "-I<path-to-kernel-includes>" from the makefiles. Seems to be
>  > the well-known user space include issue again... ;)
> 
> This is wrong, the include files that should be used are those from the
> Adeos/I-pipe patched 2.6 kernel you are compiling for, not those which
> come from your distribution.
> 

Yep, true. But then the build system is still somehow confused, because
it seems to include headers from both sources - otherwise I would not
see redefinitions when only asm/sigcontext.h contains the structs.

Jan

--------------enig584AB7D2C8C23003A5199DA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVLJYncNeS9Q0k+IRAmqyAJ9sDsiA2GXdBkbTzrWytFlzHqf5HwCgjJyy
h+AkbwpjNHDKjtKkAuOwNqg=
=iL/2
-----END PGP SIGNATURE-----

--------------enig584AB7D2C8C23003A5199DA2--

