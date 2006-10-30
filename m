Message-ID: <4545D257.3000602@domain.hid>
Date: Mon, 30 Oct 2006 11:22:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
	latency test
References: <21364954.1162202747823.JavaMail.ngmail@domain.hid>
In-Reply-To: <21364954.1162202747823.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0EB3D952986224B005CF04DB"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0EB3D952986224B005CF04DB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I am currently checking XENOMAI (V2.2.3 on a 2.6.17.7 kernel P4) to see=
 if I can use it
> as replacement for a RTAI 3.3-cv application.
> The first thing I did was to run the latency test in the the xenomai's =
testsuite directory.
> The results of the worst time latency are really ugly - about 40=B5s!
> On the very same PC I got a value of about 5=B5s using RTAI 3.3-cv runn=
ing the RTAI's
> user/latency test.

I'm _very_ sceptical about your 5 us. Could you elaborate on how you
load your box and how long those tests ran? See also TROUBLESHOOTING in
the Xenomai source tree on appropriate load for triggering the worst case=
=2E

The worst difference I once measured on a Pentium 133 MHz was 10% better
maximum latency for a timed task under RTAI. IIRC, it took longer for
RTAI to expose this than for Xenomai.

>=20
> My question is now: Why can there be such a huge difference between the=
 two systems on the very same
> hardware??
> Is there a way to improve this value?

You may what to have a look at the I-pipe tracer to analyse the worst
case - also under RTAI (requires a bit hacking to obtain the same
freezing feature with its latency test). It is helpful to see what
scenario both system faced when running on the maximum delay.

>=20
> The RTAI system uses a 2.4.33 kernel, the XENOMAI uses the 2.6.17.7 ker=
nel. Could this
> be an issue?

Nope, the latency differences between 2.4 and 2.6 are insignificant on
x86 last time I checked.

>=20
> Thanks for any feedback on that issue!
>=20
> Mathias
>=20
>=20

Jan


--------------enig0EB3D952986224B005CF04DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFRdJXniDOoMHTA+kRArpjAJ0UX/nvpEkMnYWGuTUcZRA4BA2bpgCfdzvR
BfmXseKz+QsLPVJtX2cXw2E=
=dOcw
-----END PGP SIGNATURE-----

--------------enig0EB3D952986224B005CF04DB--

