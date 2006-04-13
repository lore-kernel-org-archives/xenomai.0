Message-ID: <443E56C3.70407@domain.hid>
Date: Thu, 13 Apr 2006 15:48:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency -t 1 crashes on SMP.
References: <17465.8101.106079.634470@domain.hid>	<4439233D.4050800@domain.hid>
	<17470.21416.517240.286135@domain.hid>
In-Reply-To: <17470.21416.517240.286135@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDEF5AFF576E7E56B04AA95B0"
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
--------------enigDEF5AFF576E7E56B04AA95B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > o instrument the xenomai exception handler with an ipipe_trace_freez=
e()
>  >   (something which should be merged into SVN later)
>=20
> The I-pipe tracer as well as Linux NMI handling have the same issue
> which is the cause for the exceptions 14: they rely on a correct
> "current" to read the processor id. The first attached patch, to be
> applied after the ipipe patch, add an ipipe_processor_id_notrace
> function, which is called instead of raw_smp_processor_id() in the
> second, I-pipe tracer, attached patch.
>=20

Ah, good point! But why not make the original __ipipe_*_cpuid functions
non-traced? I don't think we would loose significant information.

Jan


--------------enigDEF5AFF576E7E56B04AA95B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPlbDniDOoMHTA+kRAkRmAJ0e6qesNRth35zik/Cm/XmDonUfQACePk+M
ucFbetY8PwT8uAmQ2zrRk8w=
=qvVY
-----END PGP SIGNATURE-----

--------------enigDEF5AFF576E7E56B04AA95B0--

