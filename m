Message-ID: <460C5D45.90705@domain.hid>
Date: Fri, 30 Mar 2007 02:43:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Few questions xenomai schedule, for porting Therad,
	TCB for MIPS 4KeC
References: <90a126800703290413n5c7f01fbm5a7e293cb487fa1c@domain.hid>
In-Reply-To: <90a126800703290413n5c7f01fbm5a7e293cb487fa1c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24CCCDCFE8ACE989CEFE2093"
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
To: Andrew Xeno <andrew.xeno@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24CCCDCFE8ACE989CEFE2093
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Andrew Xeno wrote:
> Hello All,
> This is my first mail on Xenomai, earIier I posted my messages on ADEOS=

> forum regarding IPIPE-1.0.5 porting on MIPS. Recently I started porting=

> Xenomai for the same architecture  and could do some work related to
> 1. Xenomai Intialization of ROOT task
> 2. Timer and Interrupt related code.
> 3. XENO_SYSCALLS.
> 4. Trap Handlers
> The Code changes are done considering MIPS 4KeC

[Not directly answering your question - but this would help to.]

This is now the third announcement of someone working on a MIPS port
[1,2]. Great news, definitely! But could we please

 - roll out code (even if it's incomplete, utterly broken, targeting
   different boards)
 - create some branches or whatever repositories
 - *work in public*

Then it should be far easier to discuss things, synchronise efforts,
avoid duplicate work (and pain...). Remember: the development model
makes open source so nice!

My 2 cents. :)

Jan


[1] https://mail.gna.org/public/xenomai-core/2007-03/msg00033.html
[2] https://mail.gna.org/public/xenomai-help/2007-03/msg00180.html


--------------enig24CCCDCFE8ACE989CEFE2093
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGDF1FniDOoMHTA+kRAgL/AJ981SzXvJK/Tsgzo7dsKStCnbAAKACfZzzd
oHaocbw0h3Bt5UfbNRheryE=
=CuaO
-----END PGP SIGNATURE-----

--------------enig24CCCDCFE8ACE989CEFE2093--

