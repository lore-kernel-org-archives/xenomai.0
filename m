Message-ID: <438EB666.4090300@domain.hid>
Date: Thu, 01 Dec 2005 09:37:58 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
References: <d2b06bd248f3.d248f3d2b06b@domain.hid>
In-Reply-To: <d2b06bd248f3.d248f3d2b06b@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEEC26CED1DE8228F263734A0"
Subject: [Xenomai-help] Re: [Xenomai-core] rt_heap_bind error -2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?wrnDucOTw67Dr8Kj?= <pigguo@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEEC26CED1DE8228F263734A0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=E9=83=AD=E5=AE=87=E9=93=AE wrote:
> Hi, I'm using xenomai instead of fusion.
> When I bind a heap in user space which is created by a kernel module,=20
> the return value is -2 which I don't know what it means for it is not=20
> one of several values explained by the document.
> This program runned well with fusion 0.9.
> My kernel is 2.6.13 patched with ipipe.
> Can anybody shed light on it?

Does /dev/rtheap still exist? Maybe something during your update has
killed it.

>=20
> And there's another strange error. In an ISR, printk must be called or =

> the interrupt can't be cleared. So now I add an empty printk to every=20
> ISR.

What do you mean by "cleared"? May a snippet of the ISR would help here
to explain what you do.

Jan


PS: The question better fits to the help mailing list where other users
can also benefit from your Q&As.
--=20
Dipl.-Ing. Jan Kiszka

Institute for Systems Engineering, Real-Time Systems Group (RTS)
Appelstra=C3=9Fe 9A, D-30167 Hannover
phone +49 511 762-3974 / fax +49 511 762-4012
http://www.rts.uni-hannover.de


--------------enigEEC26CED1DE8228F263734A0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDjrZuncNeS9Q0k+IRAmNsAKCPoQ5cSy8yv+LY8zfVdfYIseU4iACdH2LF
wgx1nqi1t3ZwbU9u3lpFBEA=
=+lvE
-----END PGP SIGNATURE-----

--------------enigEEC26CED1DE8228F263734A0--

