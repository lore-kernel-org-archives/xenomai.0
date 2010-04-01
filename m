Message-ID: <4BB51529.9030404@domain.hid>
Date: Thu, 01 Apr 2010 23:50:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid>
	<4B9AD0DE.4020103@domain.hid>	<1268472523.27899.135.camel@domain.hid>	<4B9BB9B1.5050003@domain.hid>	<1268498034.27899.167.camel@domain.hid>	<4B9C2100.6090806@domain.hid>
	<1268584465.27899.197.camel@domain.hid>
	<4BB4F857.5020906@domain.hid>
In-Reply-To: <4BB4F857.5020906@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5B73491E6A0737FD2ED9789B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Analogy cmd_write example explanation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5B73491E6A0737FD2ED9789B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> ...
> Argh.... The switchtest driver is relying on __xn_exec_current to have
> context switches occur precisely in the mode we want. __xn_exec_adaptiv=
e
> introduce more context switches around which we can not place separate
> checks for fpu context, so, in short, breaks it badly. Fixing this
> requires turning the switchtest driver into a skin with its own syscall=
s.

Independent of how switchtest (or RTDM) is fixed again: Do you already
have a patch like this in your queue?

diff --git a/ksrc/drivers/testing/switchtest.c b/ksrc/drivers/testing/swi=
tchtest.c
index 057094b..09cd0ec 100644
--- a/ksrc/drivers/testing/switchtest.c
+++ b/ksrc/drivers/testing/switchtest.c
@@ -665,6 +665,9 @@ static int rtswitch_ioctl_rt(struct rtdm_dev_context =
*context,
 	struct rttst_swtest_dir fromto;
=20
 	switch (request) {
+	case RTTST_RTIOC_SWTEST_SET_TASKS_COUNT:
+	case RTTST_RTIOC_SWTEST_SET_CPU:
+	case RTTST_RTIOC_SWTEST_SET_PAUSE:
 	case RTTST_RTIOC_SWTEST_REGISTER_UTASK:
 	case RTTST_RTIOC_SWTEST_CREATE_KTASK:
 	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:

I.e. add the missing reflections of NRT IOCTLs.

Jan


--------------enig5B73491E6A0737FD2ED9789B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku1FTIACgkQitSsb3rl5xQ7PwCghNLHcMJdPPd+v4tQt/mxf/Gu
VUEAn2yKf6rV/etiCDtZcrxQD+U6Xs2D
=Wg4q
-----END PGP SIGNATURE-----

--------------enig5B73491E6A0737FD2ED9789B--

