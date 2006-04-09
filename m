Message-ID: <4439233D.4050800@domain.hid>
Date: Sun, 09 Apr 2006 17:07:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency -t 1 crashes on SMP.
References: <17465.8101.106079.634470@domain.hid>
In-Reply-To: <17465.8101.106079.634470@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC242D75A6E8CDA55E4810947"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC242D75A6E8CDA55E4810947
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> I tried latency -t 1 on an SMP machines, and observed a very
> reproducible crash. Most of the time, the machine locks up
> completely. The rest of the time, I get :
>=20
> Xenomai: suspending kernel thread e7559044 ('timerbench') at 0xb01051f2=
 after ex
> ception #14
>=20
> And the system remains runnable, but 0xb01051f2 is not a valid kernel
> module text address.
>=20
> The lock up does not seem to be detected by any Xenomai or Linux
> debug or watchdog. Only enabling the NMI watchdog seems to
> systematically produce the exception 14 instead of the lockup.
>=20
> I ve tried to put a printk at the beginning of timer_task_proc outer
> loop. It get printed once when getting the exception 14, and twice when=

> getting the lock up.
>=20
> Any idea where to look ?
>=20

Two proposals to collect information:

o give KGDB a try
o instrument the xenomai exception handler with an ipipe_trace_freeze()
  (something which should be merged into SVN later)

Jan


--------------enigC242D75A6E8CDA55E4810947
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEOSM9niDOoMHTA+kRAmEbAJwMuog2DZxGTyDbgwiIhZpFkWqquwCeO81s
xNTcVk1LDYjiWNQ3unHiaaU=
=Gsju
-----END PGP SIGNATURE-----

--------------enigC242D75A6E8CDA55E4810947--

