Message-ID: <438E0807.6090000@domain.hid>
Date: Wed, 30 Nov 2005 21:13:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2A370B5B0CD98487C140AF35"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [bug?] calling xnpod_delete_thread after
	self-termination
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A370B5B0CD98487C140AF35
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi all,

as the subject already says: I face some warning of the nucleus (with
XENO_OPT_DEBUG on - useful switch) when I call xnpod_delete_thread for a
thread which has already terminated itself by leaving the thread
function. Is this double-deletion illegal? Or is it a cleanup-bug of the
nucleus?

To reproduce: this happens with RTnet over all Xenomai versions (i.e.
through the RTDM layer). I insert and remove the rtcfg module, and this
one cleans up some kernel tasks - and the nucleus complains.

Jan


PS: One open crash remaining on my list - likely RTnet-internal and
uncritical. ;)

--------------enig2A370B5B0CD98487C140AF35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDjggKniDOoMHTA+kRAs66AJ9NgsaS5gRXxtCFPKuQKbMgMMj73ACfRIeX
dqhPrcEF1ed+Rv3CXp44S0s=
=DaxY
-----END PGP SIGNATURE-----

--------------enig2A370B5B0CD98487C140AF35--

