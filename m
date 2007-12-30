Message-ID: <477826BC.1040402@domain.hid>
Date: Mon, 31 Dec 2007 00:16:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>
In-Reply-To: <b131c9f0712300411w46996c98i395344b377c6bacf@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C87F6A6A3ECBCA4D6F6BF4E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Large (negative) latency test results and fast
 PC clock
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C87F6A6A3ECBCA4D6F6BF4E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

vikesh rambaran wrote:
> hi there
>=20
> I built and installed Xenomai 2.40 with kernel 2.6.23.12 on an AMD Athl=
on 64
> X 2 dual core PC.
> The linux distribution used is Ubuntu 7.10, 32 bit version
>=20
> When running the latency test, there are large negative and positive
> latencies reported.
> Sometimes the PC hangs while the latency test is running
> The PC time updates at almost twice the normal speed (ie almost 2 secon=
ds
> for every one second that elapses)
>=20
> Was not able to solve it using the xenomai TROUBLESHOOTING guide
>=20
> The kernel config file and xeno-test output are attached.
>=20
> Any help would be appreciated

You should have seen this message while configuring Xenomai:

"NOTE: Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER disabled=
=2E"

Please check if this message is visible (if not, we would like to know).
Then adopt your .config appropriately. Hint: Choose a processor type
that is reflecting your real hardware more precisely. CONFIG_M586 means
that there is no TSC, which is not true and quite suboptimal.

Jan


--------------enig8C87F6A6A3ECBCA4D6F6BF4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHeCbAniDOoMHTA+kRAljkAJ9524Wv3VbRlLrPCrfzNSeYwOcYcgCePytX
bwdZSBaUpLUO3xIa3GQQqzU=
=ILwa
-----END PGP SIGNATURE-----

--------------enig8C87F6A6A3ECBCA4D6F6BF4E--

