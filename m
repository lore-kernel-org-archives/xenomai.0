Message-ID: <448EE9C3.4060706@domain.hid>
Date: Tue, 13 Jun 2006 18:37:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] strange periodic behavior
References: <45045.155.98.4.39.1150149018.squirrel@domain.hid>
	<448E5A2B.9060606@domain.hid>
	<3384.206.81.135.88.1150211884.squirrel@domain.hid>
	<448EDECA.7030302@domain.hid>
	<36429.155.98.4.39.1150216385.squirrel@domain.hid>
In-Reply-To: <36429.155.98.4.39.1150216385.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD109593141790380A8846707"
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
To: Brandt Erickson <brandt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD109593141790380A8846707
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Brandt Erickson wrote:
>> Sure your kernel was updated? Check /proc/cpuinfo for varying numbers
>> with and without system load.
>=20
> Yes, the kernel is up-to-date.  The config file on /boot confirms and
> there is no variation in frequency going from and idle load to ~full lo=
ad.
>=20
>> But maybe it is better to post a simple excerpt of your test which sho=
ws
>> your problem and let us cross-check.
>=20
> sample output from the latency program is attached.  Thanks for the hel=
p.

Grmbl, my fault. Your test looks ok, but I was rather referring to your
*code*.

Jan


--------------enigD109593141790380A8846707
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEjunDniDOoMHTA+kRApeyAJ0d+y2XCVlRlpklTSxFRMz4R3hcvQCaA8Ud
+4P3/eMQ57/xY7itEaUrB6w=
=hR2/
-----END PGP SIGNATURE-----

--------------enigD109593141790380A8846707--

