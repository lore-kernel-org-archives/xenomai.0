Message-ID: <4523CD42.7040702@domain.hid>
Date: Wed, 04 Oct 2006 17:03:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] root_thread_exit in pSOS skin
References: <e3291e320610030716i59d9bf11q286b2d142b79ef8d@domain.hid>	
	<4523BD6F.2050708@domain.hid>
	<e3291e320610040739y2ae413abkd4c037378f75b74f@domain.hid>
In-Reply-To: <e3291e320610040739y2ae413abkd4c037378f75b74f@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3941B5261B509E60C873FA3B"
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
To: d p <dogpointer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3941B5261B509E60C873FA3B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

d p wrote:
> On 04/10/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>
>> root_thread_exit maps to __xeno_user_exit [1], and that should get
>> called by the UVM main function [2].
>=20
>=20
> OK, but I  put a  xnprintf in root_thread_exit and I never saw this
> print. I
> stop the emulation with CTRL+C.

Yeah, that correlates very well with the endless loop a few line above
in [2]...

In fact, I don't see how you should be able to install cleanup code this
way under the UVM. Maybe replacing the for loop with something like this
helps

while (uvm_thread_idle(&uvm_irqlock) >=3D 0)
	/* empty loop */;

but I'm leaving terra firma right now (never worked with the UVM).

Jan


--------------enig3941B5261B509E60C873FA3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFI81CniDOoMHTA+kRAnsEAJ99jgyD8l9S8VT5yT1iVeY6U8jXFACfc2Ej
5/RtFwybIlpWhMtMjX0N1AE=
=amm6
-----END PGP SIGNATURE-----

--------------enig3941B5261B509E60C873FA3B--

