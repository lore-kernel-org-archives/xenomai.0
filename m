Message-ID: <4568564C.1010803@domain.hid>
Date: Sat, 25 Nov 2006 15:42:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: Aw: Re: Aw: Re: [Xenomai-help] Strange SIGXCPU signal at
References: <1164379061.4973.65.camel@domain.hid>
	<1164377274.4973.62.camel@domain.hid>	<29451992.1164376099993.JavaMail.ngmail@domain.hid>	<29192885.1164378650832.JavaMail.ngmail@domain.hid>
	<24272255.1164380283049.JavaMail.ngmail@domain.hid>
In-Reply-To: <24272255.1164380283049.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig070D0FBCC9D0E3261C6E8DDE"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig070D0FBCC9D0E3261C6E8DDE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> HI Philippe,=20
>=20
>>> unfortunately this patch did not help.
>>> It is the same situation as before.
>>>
>> Mm, ok, thanks for trying this out. Is T_WARNSW passed to
>> rt_task_create() in your case?
> No, I pass T_FPU | T_CPU(0)
>=20
> Well, I have decided to restructure the application to create the tasks=

> only once during lifetime (which has some other benefits as well).
> That means, that this issue hopefully will no longer hurt...
>=20

As I just read over the related code in the nucleus: SIGXCPU is also
raised if the process's memory isn't locked. Did you invoke mlockall? Or
do we see a false positive cause be that part here?

Jan


--------------enig070D0FBCC9D0E3261C6E8DDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFaFZMniDOoMHTA+kRAs0yAJ495eQ3gnWuWGRzNnIorPvU4JcoTQCfdv/9
b3IDJEAEGRqNqx8oofrOs+4=
=M4En
-----END PGP SIGNATURE-----

--------------enig070D0FBCC9D0E3261C6E8DDE--

