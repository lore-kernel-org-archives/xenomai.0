Message-ID: <458A7185.8070803@domain.hid>
Date: Thu, 21 Dec 2006 12:35:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <458A4DE0.5030005@domain.hid>
	<31078593.1166623877982.JavaMail.ngmail@domain.hid>
	<45894179.8060805@domain.hid> <4587E404.2050101@domain.hid>
	<4587B287.2060603@domain.hid>
	<358035.1166518774710.JavaMail.ngmail@domain.hid>
	<4587A2D4.3020102@domain.hid> <45879DE5.5080507@domain.hid>
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>
	<458A67B6.8000207@domain.hid>
In-Reply-To: <458A67B6.8000207@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE3DB5B1103E05D14178AF0F2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3DB5B1103E05D14178AF0F2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> M. Koehrer wrote:
>> Hi Jan, hi everybody,
>>
>> I have stripped down my program that is crashing Xenomai even further.=

>> (I have attached the complete source code).
>> No rtnet is required.
>> Now I have the following real time task:
>>
>> static void realtimetask(void *arg)
>> {
>>     system("ls -l");
>=20
> If you want to use system (or any function calling fork, eg popen or
> vfork) with Xenomai, you have to make sure to fault all pages mapped
> with write permission after the fork before trying to use services in
> priimary mode, because fork write protects all pages with write
> permission and notably the threads stacks. A piece of code that faults
> all pages follows.

Let me check if I got this correctly: fork calls mark all pages
write-protected - also those of the father process, or only those of the
new child? That would mean we see unexpected page faults, right?
Anything more (probably not a lock-up)?

I think we should document this special property somewhere, e.g. in the
wiki, maybe also a demo program in the examples repos.

Jan


--------------enigE3DB5B1103E05D14178AF0F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFinGGniDOoMHTA+kRAiDMAJwOVdMDScpYzbAgOIaOU9e4ddhxOwCdENql
ECue2P0sXm8l3coplCU8i68=
=yZi9
-----END PGP SIGNATURE-----

--------------enigE3DB5B1103E05D14178AF0F2--

