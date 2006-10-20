Message-ID: <4538BE2A.4030406@domain.hid>
Date: Fri, 20 Oct 2006 14:16:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] maximum frequency for parallel port
References: <4537D0BF.1040903@domain.hid> <4537DAE0.3080801@domain.hid>
In-Reply-To: <4537DAE0.3080801@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A685E4BC77FFFF66023083E"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: Pavel Pirkl <pavelpirkl@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A685E4BC77FFFF66023083E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Pavel Pirkl wrote:
>> Hello,
>> I tried example for real time parallel port from www.captain.at.
>> I tried to generate maximum frequency of square waveform only about
>> 10kHz.
>> But for great value of frequency a I got error in rt_wait_period.
>> Where is problem?
>=20
> Which example ?
> Which error ?

Pavel, if you are referring to this example

http://www.captain.at/xenomai-parallel-port-interrupt.php

it might be wise to raise the thread priorities of the generator and the
IRQ handler above the printer.

Also, this test was not designed to run at high frequencies. It pushes
some value into a pipe for each occurred IRQ and requires main to read
from it at the same rate. This will quickly cause overflows of the pipe
when going to 10 KHz or higher.

Jan


--------------enig1A685E4BC77FFFF66023083E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOL4qniDOoMHTA+kRAoXXAKCDFCdqWtjeidIwBxPIi/CVrjQobQCfb6wf
cEbte9hQS4tnBqEA/Qwv5Mc=
=WXxM
-----END PGP SIGNATURE-----

--------------enig1A685E4BC77FFFF66023083E--

