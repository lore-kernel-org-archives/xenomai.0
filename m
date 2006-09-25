Message-ID: <4517B2F2.6090102@domain.hid>
Date: Mon, 25 Sep 2006 12:44:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
References: <451786B3.4020506@domain.hid>
In-Reply-To: <451786B3.4020506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB314F8A34B48A212FA8C2BBD"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB314F8A34B48A212FA8C2BBD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> A further idea of mine was to inline light-weight parts of the
> __ipipe_*_root API on UP (no SMP at hand to judge on it as well).

BTW: I haven't looked at any detail yet, but would PER_CPU here and
there (e.g. for ipipe_percpu_domain) buy us something on SMP (2.6)?

Jan


--------------enigB314F8A34B48A212FA8C2BBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFF7LyniDOoMHTA+kRAu3hAJ4wYSCI5M+59IJdWYTKf4bCcRElYACeNsi6
SxX1kvDQuE/QKigWLUtsrVQ=
=zdmq
-----END PGP SIGNATURE-----

--------------enigB314F8A34B48A212FA8C2BBD--

