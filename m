Message-ID: <4C06011A.7020507@domain.hid>
Date: Wed, 02 Jun 2010 08:58:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C04E8D8.8030101@domain.hid>
	<4C04EDAF.1080800@domain.hid>	<4C051100.7000803@domain.hid>
	<4C051E26.8020102@domain.hid>	<4C053217.5010809@domain.hid>
	<4C053608.3030604@domain.hid>
In-Reply-To: <4C053608.3030604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B1896485DD3477DF626D6DB"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Linux kernel 2.6.32.14 and Xenomai 2.5.2 does
	not boot
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B1896485DD3477DF626D6DB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Daniele Nicolodi wrote:
>> On 01/06/10 16:50, Jan Kiszka wrote:
>>> Daniele Nicolodi wrote:
>>>> On 01/06/10 13:23, Jan Kiszka wrote:
>>>>> Daniele Nicolodi wrote:
>>>>>> Hello.
>>>>>>
>>>>>> In the process of upgrading my data acquisition system from Xenoma=
i
>>>>>> 2.5.0 to Xenomai 2.5.2, I also upgraded the kernel from the 2.6.30=

>>>>>> release to 2.6.32.14.
>>>>> Latest Xenomai is 2.5.3, latest 2.6.32 patch is
>>>>> adeos-ipipe-2.6.32.13-x86-2.6-04.patch [1]. Make sure you have both=
=2E
>>>> This adeos patch does not apply cleanly to 2.6.32.14 kernel sources.=

>>>> Looks like a hunk in include/linux/modules.h has been applied upstre=
am.
>>>> However this was easy to merge.
>>>>
>>>> Using the latest xenomai and adeos patch however results again in a
>>>> kernel that does not boot on my hardware. This problem is present si=
nce
>>>> the first time I have been trying to use xenomai on this box, as I w=
rote
>>>> in an email to the list on the 17th February early this year, it is =
thus
>>>> not a recent regression.
>>>>
>>>> Further suggestions?
>>> Please send an updated .config file.
>> It is attached.
>=20
> OK, will try to build a test kernel from it later.

No problems on the target I have at hand.

Did you already enable a serial console, maybe even an early one, and
tried to catch the last word of your system (if any)?

>=20
> Does you system boot up as soon as you disable CONFIG_IPIPE (and
> Xenomai, of course)? CONFIG_IPIPE_DEBUG* has no influence either?

This question is also still relevant.

Jan


--------------enig8B1896485DD3477DF626D6DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwGARoACgkQitSsb3rl5xSdgQCgo7RjOhGr7LJr2j83Lykniql3
03MAoLQP2EEoUzIkQNT3T6GpQj9jxGUd
=1sZs
-----END PGP SIGNATURE-----

--------------enig8B1896485DD3477DF626D6DB--

