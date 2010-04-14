Message-ID: <4BC57405.1080403@domain.hid>
Date: Wed, 14 Apr 2010 09:51:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid>
	<1268472523.27899.135.camel@domain.hid>		<4B9BB9B1.5050003@domain.hid>		<1268498034.27899.167.camel@domain.hid>		<4B9C2100.6090806@domain.hid>		<1268584465.27899.197.camel@domain.hid>		<4BB4F857.5020906@domain.hid>
	<4BB50C8B.2000405@domain.hid>		<1270156940.2418.403.camel@domain.hid>	<4BB50F7C.1020102@domain.hid>		<1270157507.2418.409.camel@domain.hid>	<4BB511C7.1050507@domain.hid>		<1270158532.2418.420.camel@domain.hid>	<4BB51631.5030609@domain.hid>		<1270159246.2418.432.camel@domain.hid>	<4BB51931.3080307@domain.hid>	
	<4BB523E8.705@domain.hid>	<4BB5250F.1040409@domain.hid>	
	<4BB52769.4080702@domain.hid>	<4BB5348B.2070805@domain.hid>	
	<4BB5C95E.9060502@domain.hid>	<4BB5D0D4.40908@domain.hid>	
	<4BB5D1A0.8030007@domain.hid>	<4BB5D4FB.4010901@domain.hid>		<1271191271.2365.436.camel@domain.hid>	<4BC4F8CA.4080202@domain.hid>	<1271229750.2365.444.camel@domain.hid.
	org> <4BC570A4.1090203@domain.hid>
In-Reply-To: <4BC570A4.1090203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig321FC3F6D0B972065AC297E3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Analogy cmd_write example
	explanation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig321FC3F6D0B972065AC297E3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Wed, 2010-04-14 at 01:05 +0200, Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> The steps now:
>>>>
>>>> - we implement the automatic switchback of shadow nrt threads to
>>>> secondary mode, upon return from Xenomai (primary) syscalls. I am
>>>> working on this. The most significant impact is on userland, due to =
the
>>>> fastsynch support, actually. Kernel-wise, it's rather straightforwar=
d.
>>>> The only exception to this would be when the caller owns an exclusiv=
e
>>>> resource (like a mutex), in which case the mode downgrade should be
>>>> postponed until the syscall releasing the last resource held returns=
=2E
>>> Kernel is clear, but user space sounds indeed interesting. I guess we=

>>> need an out-of-band channel to tell the kernel about pending
>>> user-space-only lock ownerships when calling some unrelated syscall. =
How
>>> does your current approach look like?
>> I want to keep things simple: shadow nrt will go through the syscalls
>> for acquisition/release of owned resources, instead of fastsynchs.
>=20
> Then I'll have to pick this up as that will very likely create unhappy
> customers. In fact, the majority of our Xenomai threads are nrt (yeah,
> that happens if you convert existing applications).

Hmm, thinking about it again, there not that much to optimize in the
trivial, non-nested locking case (on entry, we already go through the
syscall if we aren't migrated yet, just the release syscall will be
new). I will check what share of our load is nested and would actually
suffer from unconditional syscalls. I just hope there is no issue with
dropping the lazy scheme as that would complicate things in a way I
would not want to go as well.

Jan


--------------enig321FC3F6D0B972065AC297E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvFdAkACgkQitSsb3rl5xR99ACdFMfMot2sRk1nZWKWxZ/miVOS
ljwAn3Xsitv6jbNLIYlgr2660Shiii0s
=oCLv
-----END PGP SIGNATURE-----

--------------enig321FC3F6D0B972065AC297E3--

