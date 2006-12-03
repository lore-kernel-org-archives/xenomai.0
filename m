Message-ID: <4572DB4F.9030600@domain.hid>
Date: Sun, 03 Dec 2006 15:12:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	
	<4566C5AF.7030107@domain.hid>	
	<20061124113009.08c0a490.benjamin.zores@domain.hid>	
	<4569E699.6050003@domain.hid>	
	<20061127092143.e633cd91.benjamin.zores@domain.hid>	
	<456ACA35.8030206@domain.hid>	
	<20061127125419.3852edd9.benjamin.zores@domain.hid>	
	<456AD5EB.5040901@domain.hid>	
	<20061130133745.272ab4b1.benjamin.zores@domain.hid>	
	<456EDA4B.3060809@domain.hid> <1165013200.4952.177.camel@domain.hid>	
	<1165014875.4952.199.camel@domain.hid> <4571491D.502@domain.hid>	
	<1165078727.4952.222.camel@domain.hid>
	<4571B9DF.6010101@domain.hid>	
	<1165081330.4952.228.camel@domain.hid> <4571BEF8.5080900@domain.hid>
	<1165102321.4952.331.camel@domain.hid>
In-Reply-To: <1165102321.4952.331.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig39BDB8E1EEF4E2501716D3FA"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: I-pipe git trees
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39BDB8E1EEF4E2501716D3FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2006-12-02 at 18:59 +0100, Jan Kiszka wrote:
>=20
> [...Resuming the discussion on both interested lists...]
>=20
>> Rough idea from my side on a potential organisation of the git trees:
>>
>>  o A generic I-pipe core tree that primarily targets git head (i.e. 2.=
6)
>>  o One branch for git head, pulls both from Linus' tree and the I-pipe=

>>    core
>=20
> What would be the purpose of this branch?

Let me first sort the term chaos of "trees" and "branches" I left
behind. Each line in the following ascii graphic represents a git
repository (or tree). The 2.6 repositories may have branches to maintain
I-pipe patches for certain kernel releases.

  ^        ^          ^        ^       ^    ^
  |        | ...      |        |       |    |
  |        |/         |        |       |    |
  |        | 2.6.19   |        | ...   |    |
  |        |/         |        |/      |    |
  |        | 2.6.17   |        | ?     |    |
  |        |/         |        |/      |    |
  |        | 2.6.16   |        | ?     |    |
  |        |/         |        |/      |    |
I-pipe  Mainline   Blackfin [other    2.4  2.4
 Core     Head     CVS HEAD archs?]   x86  ELDK

Except for the 2.4 repositories or if some branch is in maintenance mode
and only tracks bug fixes, all trees pull their generic I-pipe support
regularly from the core tree.

Centre of gravity is the mainline tree. Its head tries to follow Linus'
tree closely (probably best during the last weeks of a -rc cycle).
Meanwhile, it's branches maintain support for official releases. This
support is kept up-to-date until we have a more recent Linux version for
all archs in question. Or we keep it running as a stable branch (I have
2.6.16 in mind here).

If some arch is not in mainline or has a better tree to follow, we need
a separate repository like for Blackfin. Another reason for separation
could be access control, i.e. granting some arch maintainer exclusive
access to a tree.

And for I-pipe support based on vendor-specific board patches,
maintained by people "out-of-tree", we will then have the core + the
mainline repository to cherry-pick I-pipe changes, helping to build
I-pipe patches "from scratch" - when really required.

Jan


--------------enig39BDB8E1EEF4E2501716D3FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcttUniDOoMHTA+kRAineAJ924uOfZRQpqFvaO5TCdzD5iDi40ACeMYwB
YiCFP5HIWcuuNQWZq9rUZnc=
=b8vM
-----END PGP SIGNATURE-----

--------------enig39BDB8E1EEF4E2501716D3FA--

