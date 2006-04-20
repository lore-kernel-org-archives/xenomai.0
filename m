From: Stefan Eletzhofer <stefan.eletzhofer@domain.hid>
Date: Thu, 20 Apr 2006 14:42:18 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2068742.mVHV7YX7Rc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604201442.18803.stefan.eletzhofer@domain.hid>
Subject: [Xenomai-help] rt_heap_bind in kernel module
Reply-To: stefan.eletzhofer@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--nextPart2068742.mVHV7YX7Rc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
reading the API docs (2.1.0) of the xenomai native API I noticed that the=20
rt_heap_bind() call is a userspace-only call and i'm wondering why that is
the case? Or am I missing something here?

I'm in the process of porting applications which use the RTAI shm module
in both user space and kernel space; these applications basically allocate=
=20
the shared memory chunks in user space and then have kernel modules dump
data into these areas.

To port things, I've coded a rt_heap_bind() for kernel space modelled after=
=20
the code in skins/native/syscalls.c using the nucleus registry API, and tha=
t=20
seems to work. So, is this missing call just laziness, then I'd post a patc=
h.

Thanks,
Stefan E.
=2D-=20
Stefan Eletzhofer
InQuant GmbH
Bahnhofstra=DFe 11
D-88214 Ravensburg
http://www.inquant.de
http://www.eletztrick.de
+49 (0) 751 35 44 112
+49 (0) 171 23 24 529 (Mobil)
+49 (0) 751 35 44 115 (FAX)

--nextPart2068742.mVHV7YX7Rc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBER4Gq20PMGlcwuNARAgsEAJ951WJBvYrxNObNfMAiO1v5y/a5eQCgtJuH
nwYZIEfbr1nVlXXTCc6B09I=
=uoj6
-----END PGP SIGNATURE-----

--nextPart2068742.mVHV7YX7Rc--

