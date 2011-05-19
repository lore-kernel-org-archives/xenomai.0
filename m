Message-ID: <4DD5633C.6050708@domain.hid>
Date: Thu, 19 May 2011 20:36:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1305813493.2118.112.camel@domain.hid> <4DD55E3E.2030203@domain.hid>
In-Reply-To: <4DD55E3E.2030203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE21151B8DE3EF2C389ED1260"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [RFC] Getting rid of the NMI latency watchdog
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE21151B8DE3EF2C389ED1260
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-05-19 20:15, Gilles Chanteperdrix wrote:
> On 05/19/2011 03:58 PM, Philippe Gerum wrote:
>> For this reason, I'm considering issuing a patch for a complete remova=
l
>> of the NMI latency watchdog code in Xenomai 2.6.x, disabling the featu=
re
>> for 2.6.38 kernels and above in 2.5.x.
>>
>> Comments welcome.
>=20
> I am in the same case as you: I no longer use Xeno's NMI watchdog, so I=

> agree to get rid of it.

Yeah. The last time we wanted to use it get more information about a
hard hang, the CPU we used was not supported.

Philippe, did you test the Linux watchdog already, if it generate proper
results on artificial Xenomai lockups on a single core?

Jan


--------------enigE21151B8DE3EF2C389ED1260
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3VYzwACgkQitSsb3rl5xT5aQCgt4cYp3X8BT0wf659g9jKDc7F
Yf8AoOockGJRt52prhrGvtvVck/mOKiu
=67MN
-----END PGP SIGNATURE-----

--------------enigE21151B8DE3EF2C389ED1260--

