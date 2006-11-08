Message-ID: <4551D531.8000501@domain.hid>
Date: Wed, 08 Nov 2006 14:01:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai on Athlon XP (and PIII)
References: <4550E7A6.9090408@domain.hid> <45518795.5070507@domain.hid>
	<4551A02A.7090503@domain.hid> <4551B5D7.1030505@domain.hid>
In-Reply-To: <4551B5D7.1030505@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig58266B3DDBF6376DCED0C990"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig58266B3DDBF6376DCED0C990
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Wolfgang Grandegger wrote:
>>>
>>>> Hello,
>>>>
>>>> I'm currently setting up a PC for Xenomai-Tests. I'm using my good o=
ld
>>>> PC with an Athlon XP (Thunderbird) for this purpose. The kernel
>>>> hangs at
>>>> boot time when I enable APIC via boot argument (lapic). With local A=
PIC
>>>> disabled the kernel boots but I see some Opps messages while running=

>>>> the
>>>> latency test and trying a slogin to the system (in the scheduler). A=
re
>>>> there any known issues with this X86 arch? I remember, that I have s=
een
>>>> similar problems with my (old) PIII-Notebook (lapic did not work).
>>>
>>>
>>> No known issues, both scenarios *must* work, the P-III at least in PI=
C
>>> mode when Linux refuses to enabled lapic on boot.
>>
>> Some athlons have a buggy local APIC, so disabling it may be the best
>> option.
>=20
> Ah, I found some similar statement on the RTAI mailing list as well.

Still, it must neither oops nor hang in this case - or does plain Linux
so as well?

Jan


--------------enig58266B3DDBF6376DCED0C990
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUdUxniDOoMHTA+kRAqLIAJ9Qs+vzzukOeXyC+Gon4ppiab5iXACfWPzV
U9Zq8k+5GVZicjM2Z0HqzSE=
=/0vk
-----END PGP SIGNATURE-----

--------------enig58266B3DDBF6376DCED0C990--

