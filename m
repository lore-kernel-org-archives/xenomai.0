Message-ID: <45A6A2F7.7040003@domain.hid>
Date: Thu, 11 Jan 2007 21:49:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name	leads
	to Kernel oops in /proc/xenomai/irq
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>	
	<45A4DDA8.6090800@domain.hid>	
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>	
	<45A4F18A.4040209@domain.hid>	
	<b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>	
	<45A4F9CC.6070807@domain.hid>	
	<b647ffbd0701100655wd47af96y244c74d5227d6e85@domain.hid>	
	<45A502A9.3060800@domain.hid>	
	<b647ffbd0701100758i1ea15b12qab5ac7c33acae0be@domain.hid>	
	<b647ffbd0701100759p5432558dv386b5b1a580e3921@domain.hid>
	<1168543157.25399.156.camel@domain.hid>
In-Reply-To: <1168543157.25399.156.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9EC260D639ABAE0E66E21015"
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
To: rpm@xenomai.org
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9EC260D639ABAE0E66E21015
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2007-01-10 at 16:59 +0100, Dmitry Adamushko wrote:
>>> Attached. Keep in mind that although it's a simple patch I,
>>> personally, haven't tested it (even compilation-wise).
>>> Anyone who would like to give it a try (Mathias?) is wellcome.
>> Now finally attached.
>>
>=20
> Merged, thanks.

Please also apply my patch to cover RTDM drivers passing NULL (though
this is discouraged -- now).

Thanks,
Jan


--------------enig9EC260D639ABAE0E66E21015
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFpqL8niDOoMHTA+kRAkTkAJ4y7LUbFSbhOOoDzsnK0cxYpSkrXwCeNeEt
UUilzPouFGN354M633++wHc=
=BFQi
-----END PGP SIGNATURE-----

--------------enig9EC260D639ABAE0E66E21015--

