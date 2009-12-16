Message-ID: <4B28F11B.3090400@domain.hid>
Date: Wed, 16 Dec 2009 15:39:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B240D0B.50603@domain.hid>	
	<1260723757.2216.2.camel@domain.hid>
	<4B252909.9090304@domain.hid>	
	<1260727502.2216.19.camel@domain.hid>
	<4B253028.10607@domain.hid>	
	<1260962769.2216.203.camel@domain.hid>
	<4B28CA44.2080304@domain.hid>	
	<1260973175.2216.371.camel@domain.hid>
	<1260973801.2216.373.camel@domain.hid>
In-Reply-To: <1260973801.2216.373.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC661A64E5808B240C63AE66D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [pull request] x86: critical fix for
	native_safe_halt
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC661A64E5808B240C63AE66D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2009-12-16 at 15:19 +0100, Philippe Gerum wrote:
>> On Wed, 2009-12-16 at 12:53 +0100, Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> On Sun, 2009-12-13 at 19:19 +0100, Jan Kiszka wrote:
>>>>> Philippe Gerum wrote:
>>>>>> On Sun, 2009-12-13 at 18:48 +0100, Jan Kiszka wrote:
>>>>>>> Philippe Gerum wrote:
>>>>>>>> On Sat, 2009-12-12 at 22:37 +0100, Jan Kiszka wrote:
>>>>>>>>> Recent moving of ipipe_suspend_domain finally exposed a deeper =
flaw in
>>>>>>>>> cpu_idle on x86: We failed to check the pipeline log before iss=
uing the
>>>>>>>>> real hlt. This caused IRQ latencies or even drops for Linux,
>>>>>>>>> specifically on SMP. Credits go to plain QEMU whose slow SMP mo=
de caused
>>>>>>>>> ipipe_critical_enter to deadlock frequently enough.
>>>>>>>>>
>>>>>>>>> The first patch of this series fixes this (see below), the seco=
nd one
>>>>>>>>> simply removes the two useless ipipe_suspend_domain calls.
>>>>>>>>>
>>>>>>>> What your patch does as well, is killing the ability to run low =
priority
>>>>>>>> domains below the root level.
>>>>>>> Yes, I'm killing the dream.
>>>>>>>
>>>>>>> I heavily doubt that the functions I removed in the second patch =
ever
>>>>>>> contributed something good to this. It's always the job of the lo=
west
>>>>>>> domain to issue hardware halt, not of some arbitrary mid-prio dom=
ain.
>>>> Actually, no it's not. You may use a low-priority domain to run idle=

>>>> level jobs outside of the linux infrastructure for that purpose (e.g=
=2E
>>>> RCU). A high priority domain may want to post events for a low prior=
ity
>>>> domain to act upon when a mid priority domain is about to enter the =
CPU
>>>> idle state.
>>> Even if all the related bugs were fixed: When you pass down control t=
o
>>> the lower domain on cpu_idle via ipipe_suspend_domain, you won't get =
a
>>> Linux reschedule (without CONFIG_PREEMPT) until the low-prio domain
>>> finally returns from its event handler - likely not what "low-prio"
>>> suggests.
>> low prio suggests nothing else than "runs whenever nothing else has to=

>> be done higher in the pipeline".
>=20
> Nothing, meaning nothing interrupt-wise. For the rest, it's a deal
> between all OSes there.
>=20

Right, and that deal was, well, fairly incomplete in the previous code.
That's my whole point.

Jan


--------------enigC661A64E5808B240C63AE66D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkso8RsACgkQitSsb3rl5xQYYgCeMg2iko7fNWMS1CHa7XYyHrN/
660An1GaEgVJA4odFy866hV6gcJo4qjz
=F0d2
-----END PGP SIGNATURE-----

--------------enigC661A64E5808B240C63AE66D--

