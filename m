Message-ID: <4ADD90F3.5040905@domain.hid>
Date: Tue, 20 Oct 2009 12:29:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AD8A87C.4040706@domain.hid>	
	<1255799737.2862.15.camel@domain.hid> <4ADB100B.1060300@domain.hid>	
	<1255884524.2862.77.camel@domain.hid> <4ADB56C1.8020103@domain.hid>
	<1256032854.2862.117.camel@domain.hid>
In-Reply-To: <1256032854.2862.117.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6E40A016420F277BDEF21286"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Native: Fixing auto-cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E40A016420F277BDEF21286
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Well, I can tell you that there are quite a few corner cases you would
> face in rewriting the queue/heap cleanup code. I'm not saying this
> should not be done, I just won't merge this to 2.5.0 to avoid more
> regressions. Let's fix the obvious for now, such as the missing
> descriptor deallocation in the post-release callback, and schedule a
> global cleanup refactoring for 2.5.1.

I would suggest to let us discuss this based on my patch series that I'm
currently testing (I also wanted to run a xenosim build test, but that
looks like futile effort - no chance to even get it configured on a
x86-64 host). Maybe you may want to cherry pick some of them, but maybe
they will show that there is enough benefit (=3D=3D code simplification =3D=
=3D
bug risk reduction) to merge them all. Will be posted today.

Jan


--------------enig6E40A016420F277BDEF21286
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrdkPcACgkQitSsb3rl5xSwdQCeIaJJeMTPJfIcWnQJBNDrO64n
E7UAoMRVm0ieAusGjdnzUULky1KfmK+y
=6YVY
-----END PGP SIGNATURE-----

--------------enig6E40A016420F277BDEF21286--

