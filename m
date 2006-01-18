Message-ID: <43CEB043.1060303@domain.hid>
Date: Wed, 18 Jan 2006 22:16:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Scheduling while atomic
References: <fd6a47a90601171559x13acf2c2m@domain.hid>	
	<43CE9FCB.2070305@domain.hid>	
	<17358.42102.613327.327841@domain.hid>	
	<43CEA56D.8000407@domain.hid>	
	<fd6a47a90601181236u5a482ba5q@domain.hid>	
	<43CEA7AC.9080300@domain.hid>	
	<fd6a47a90601181254s11edbb28l@domain.hid>	
	<43CEADBE.4040802@domain.hid>
	<fd6a47a90601181311i2e726b46w@domain.hid>
In-Reply-To: <fd6a47a90601181311i2e726b46w@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA8EADA55AE322E1482C297CC"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8EADA55AE322E1482C297CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
>  Interesting, when writing to 2 different files, I get the same crashes=
=2E
> Will test with only one task/fd.

File ops doesn't matter for me. I took them out of task0/1, and I still
got the crashes. (BTW, this may explain the difference in your backtrace
you reported privately.)

Jan - now really leaving...


--------------enigA8EADA55AE322E1482C297CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzrBDniDOoMHTA+kRAjcrAJ90XDDZhV2R6FahkkW4RVO0HT+jvgCfR5Q1
Ol9AAh8SiXdWE9eRDZ+2bBA=
=sfSC
-----END PGP SIGNATURE-----

--------------enigA8EADA55AE322E1482C297CC--

