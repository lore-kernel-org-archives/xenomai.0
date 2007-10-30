Message-ID: <472741E2.9040206@domain.hid>
Date: Tue, 30 Oct 2007 15:38:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47266BC6.7060807@domain.hid> <4726EB6E.8020207@domain.hid>
	<4726F05F.3060105@domain.hid>
In-Reply-To: <4726F05F.3060105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF809DF59249FE577A2AF556E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] build kernel missing  System.map, vmlinuz,
 initrd when using $xenomai_root/configure --enable-x86-sep
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF809DF59249FE577A2AF556E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dennis Nguyen wrote:
> Yes, I used make install after run $xenomai/configure --enable-x86-sep.=
=20
> Sorry, I forgot to mention in the previous email
> I could not get the System.map. vxlimux, and initrd.
> Also make clean, make menuconfig would not work after that.
> The message was: make: *** No rule to make target 'clean'. Stop.
> I have to remove the kernel and start over.

You need to run make install in the kernel directory. The other
"install" is for user land libs, tools, etc.

Jan


--------------enigF809DF59249FE577A2AF556E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJ0HiniDOoMHTA+kRAvKNAJ9rAAFg57Gf7rXjd7ztVBL0pqSWlwCdF0DI
hJTv9WSjmPWfZ+z3wK9vQh8=
=mmln
-----END PGP SIGNATURE-----

--------------enigF809DF59249FE577A2AF556E--

