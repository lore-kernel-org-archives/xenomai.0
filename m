Message-ID: <4A1514E7.90801@domain.hid>
Date: Thu, 21 May 2009 10:46:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <abaf774b0905180656y4eddca23h6241c9dc031a3ba4@domain.hid>	<4A116AC5.7010704@domain.hid>
	<abaf774b0905210135qce7c61dg46ae05bb40567c13@domain.hid>
In-Reply-To: <abaf774b0905210135qce7c61dg46ae05bb40567c13@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE0C70180C9EFDF871AB555F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] select(2) generates EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE0C70180C9EFDF871AB555F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steve wrote:
> On 18/05/2009, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> =
wrote:
>> Steve wrote:
>>> First, thank you for the help on my previous query.
>>>
>>> I am still working on porting a c++ application from RTAI to Xenomai,=

>>> and have encountered a problem with sockets, specifically the select
>>> function.
>>>
>>> When Xenomai is not being used the code runs as expected.  Once the
>>> Xenomai headers, compile options, etc, are used the select function
>>> fails with the error EFAULT.  I have reproduced the error (works
>>> without Xenomai, EFAULTs with Xenomai) using the following program:
>>>
> <snip>
>>> I am using Xenomai 2.4.6.1 on a vanilla 2.6.24.6 Linux kernel, and
>>> running on Ubuntu 8.04.
>> Could you try 2.4.7, to see if you are not having a bug which has
>> already been fixed?
>>
>> What you are trying should work, even though you are not really using
>> Xenomai's select but Linux plain select.
>>
>> --
>>                                                  Gilles.
>>
>=20
> I have just tested my example code with Xenomai version 2.4.7 but I am
> still encountering the problem.

You need to pull the latest 2.4.x git version [1].

Jan

[1] http://git.xenomai.org/?p=3Dxenomai-2.4.git;a=3Dsummary


--------------enigAE0C70180C9EFDF871AB555F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkoVFO8ACgkQniDOoMHTA+kEOACfa2T0JhnyLq0Rku3dn8shWz42
kysAn2ifEq2VO45PMvhuHh8sDOWD2Iy4
=h/TL
-----END PGP SIGNATURE-----

--------------enigAE0C70180C9EFDF871AB555F--

