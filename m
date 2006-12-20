Message-ID: <45894179.8060805@domain.hid>
Date: Wed, 20 Dec 2006 14:58:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4587E404.2050101@domain.hid> <4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
In-Reply-To: <13529671.1166621136153.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E16F65FB8E6DFD7F57A7946"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the PC
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
--------------enig8E16F65FB8E6DFD7F57A7946
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan and Gilles,
>=20
> after a long debug-reboot-try-again-session I was able to reduce the pr=
oblem I had
> to a very short application that leads to a complete system freeze on a=
 2.6.19.1 kernel.
> As with my PC I am not able to run the NMI stuff within Xenomai, I forw=
ard the application to you
> and the list. Perhaps somebody can try out the enclosed application wit=
h the latest Xenomai version
> on 2.6.19.1.

Thanks for the test case, I will give this a try ASAP.

> Please adjust the IP settings in the C file and in the xenorun script t=
o your setup.
> It is sufficient to send out UDP frames, if the remote device does not =
answer this does not hurt.
> However the remote device should listen on a specified port to avoid IC=
MP complains about
> no-opened UDP ports...
> Using Ethereal I monitored the traffic.
> Here is the summary of it:
> ARP request/response (from the xenorun script)
> ARP request/response (from the applicaion)
> UDP message to port 18765 (no answer)
> 2 seconds later: UDP message to port 18765 (no answer)
> 2+5=3D7 seconds later: ARP request/response (from the application)
> 2 seconds later: UDP message to port 18765
> Here the system freezes. I do not see the message "Step A".

Could you set me the Ethereal dump for reference? Just in case the test
does not kick immediately for me and I need to check the event flow.

>=20
> One important piece is the system() call out of the realtime applicatio=
n to do a rtroute.
> When I remove this call, there is no error...
>=20
>=20
> I am using Xenomai SVN #1969 and the included 2.6.19.1 patch. Pentium 4=
 UP.

Do you have a different (slower) execution platform at hand to check if
the CPU speed as influence on the lock-up? I hope it is not the case -
makes tracking easier. But it wouldn't be the first time.

>=20
> Any feedback on this is highly welcome!
>=20

You will get it.

Thanks again,
Jan


--------------enig8E16F65FB8E6DFD7F57A7946
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiUF5niDOoMHTA+kRAj+pAJ9gEUI6BMdQ9jTAlzIbE8by/eCHfACcDI/S
qhzpjWubB3GGugUdck3gPZM=
=1dFB
-----END PGP SIGNATURE-----

--------------enig8E16F65FB8E6DFD7F57A7946--

