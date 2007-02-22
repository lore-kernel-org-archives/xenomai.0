Message-ID: <45DDCEE0.7070901@domain.hid>
Date: Thu, 22 Feb 2007 18:12:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] possible future conflict w LOCAL_APIC
References: <451C586A.7020309@domain.hid>
	<1159628606.5014.33.camel@domain.hid>	<4522A377.5030503@domain.hid>
	<45DDCC6D.6020908@domain.hid>
In-Reply-To: <45DDCC6D.6020908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCA490DEEF359771E5696CF24"
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
To: =?ISO-8859-15?Q?Jan_R=FCdiger?= <ruediger@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCA490DEEF359771E5696CF24
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan R=FCdiger wrote:
> Hello
>=20
> Few months ago there was a discussion about disabling local apic in the=

> kernel. The last point in this discussion was:
>=20
>> update:
>>
>> Ingo Molnar has voiced strong preference that the config option remain=
,
>> citing 60kb growth in its removal.  So its probably safe for now ;-)
>=20
> Now i have the problem that i cant disable the X86_UP_APIC anymore when=

> building the kernel 2.6.19. Normally this isn't a problem since it is

???

There is no "select X86_UP_APIC" in kbuild that would make this mandatory=
=2E

> disabled during boot (my machine doesn't have APIC). But xenomai is
> build with enabled APIC and thus refuses to run on the new kernel.
>=20
> Is there a way to disable APIC during kernel build? or can i build
> xenomai without APIC?

We are running Xenomai over 2.6.19 (and later) here, mostly on APIC-less
(or broken) boxes. There is no known issue.

I don't see why you shouldn't be able to switch "Local APIC support on
uniprocessors" off.

Jan


--------------enigCA490DEEF359771E5696CF24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3c7gniDOoMHTA+kRAsmoAJ9pfiw37bYm+kCNlFFKgr4dMnSBYgCfTcdM
czZk/wQA9aPfSNkaCcSUQnQ=
=ag1J
-----END PGP SIGNATURE-----

--------------enigCA490DEEF359771E5696CF24--

