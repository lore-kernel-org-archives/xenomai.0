Message-ID: <43B9696D.3080106@domain.hid>
Date: Mon, 02 Jan 2006 18:57:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCHES] various fixes
References: <43B92C73.6080004@domain.hid> <200601021848.54916.kisda@domain.hid>
In-Reply-To: <200601021848.54916.kisda@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD227115C6C2C9F9C5FA7CE9A"
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD227115C6C2C9F9C5FA7CE9A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Stefan Kisdaroczi wrote:
> Hi Jan,
> 
> Am Montag, 2. Januar 2006 14.36 schrieb Jan Kiszka:
> 
>> * rtdm-license.patch - add missing COPYING files to RTDM skin and lib
>>   (or go for just a single file for ksrc/skins and src/skins if this is
>>   applicable)
> 
> 
> The COPYING file in your patch contains the GPL license. Should'nt it be the 
> LGPL license ? I mean, its your choice :-), but all other skins are LGPL and 
> in the headers of the rtdm/*.c-files is also the LGPL license.
> 

[Hold on, re-checking...]

All fine: it's GPL for the core, but LGPL for the lib:

Index: src/skins/rtdm/COPYING
===================================================================
--- src/skins/rtdm/COPYING	(Revision 0)
+++ src/skins/rtdm/COPYING	(Revision 0)
@@ -0,0 +1,504 @@
+		  GNU LESSER GENERAL PUBLIC LICENSE
+		       Version 2.1, February 1999

Or what do you mean?

Jan

--------------enigD227115C6C2C9F9C5FA7CE9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDuWltniDOoMHTA+kRAmxGAJ4+BNNyNtL779VaVIuGMRvRQg9GQwCeOroG
gBJTPKjs1/L2fyMUlX5J6Qs=
=M4iG
-----END PGP SIGNATURE-----

--------------enigD227115C6C2C9F9C5FA7CE9A--

