Message-ID: <4994A9EF.9070108@domain.hid>
Date: Thu, 12 Feb 2009 23:59:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7ed3bc8b0902120904r800de72q97e694001600051e@domain.hid>
	<499480EE.3040403@domain.hid> <49948E51.9000509@domain.hid>
	<49949E48.4010106@domain.hid> <4994A180.3020102@domain.hid>
	<4994A261.5050003@domain.hid>
In-Reply-To: <4994A261.5050003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7109E673420E30E447AEC44B"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Known-to-work motherboards?
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
Cc: xenomai@xenomai.org, Stuart O Anderson <soa@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7109E673420E30E447AEC44B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Stuart O Anderson wrote:
>>>>>> If there isn't a list online that I've missed, is anyone running
>>>>>> xenomai on a relatively recent machine with 8 or more cores withou=
t
>>>>>> problems?  If so, can you provide hardware specs?
>>>>> Xenomai will have scalability problems when running on an 8 cores s=
ystem
>>>>> (if you intend to run real-time tasks on each of the 8 cores).
>>>>>
>>>> We are running Xenomai on up to 4x4 boxes, but only with 1 or 2 core=
s
>>>> used by RT tasks. I've some patch hanging around that restricts Xeno=
mai
>>>> (specifically its host timer hook) to a CPU subset in order to mitig=
ate
>>>> the scalability issues - guess I should finally get it in shape and =
post it.
>>> The host timer already runs on only one CPU.
>> Not on x86.
>=20
> Some time ago, when using the APIC (which was always the case on x86
> SMP), the host timer was not even started, and the Linux APIC irqs were=

> triggered by a custom 8254 irq handler. Well, it seems things have
> changed since then...

=2E..around the Linux clocksource/clockevent rework. And it also makes
more sense with the number of cores increasing and NUMA becoming
standard. CPU-local timers are simply more efficient. That's why the
nklock hurts that any host tick must pass even if the core is not used
by Xenomai otherwise.

Jan


--------------enig7109E673420E30E447AEC44B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmUqfMACgkQniDOoMHTA+lKKQCffV/+L+Q2LpxCQLkNMg1X3dKm
j/sAnR+OZCdfbLG6jEFwJaKQDd3ntJUc
=Bj+7
-----END PGP SIGNATURE-----

--------------enig7109E673420E30E447AEC44B--

