Message-ID: <4DFFA27F.3020808@domain.hid>
Date: Mon, 20 Jun 2011 21:41:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>	<4DFBA305.9000303@domain.hid>	<4DFC7C0E.1090700@domain.hid>	<4DFC9575.1030904@domain.hid>	<4DFC95B7.8070703@domain.hid>	<4DFCA09B.20609@domain.hid>	<4DFCA323.6030704@domain.hid>
	<4DFCA432.3070203@domain.hid>	<4DFCAF07.8020607@domain.hid>
	<4DFE189D.5030908@domain.hid>	<4DFF78AA.9050904@domain.hid>
	<4DFF8476.2000306@domain.hid> <4DFFA19C.30000@domain.hid>
	<4DFFA24F.4050601@domain.hid>
In-Reply-To: <4DFFA24F.4050601@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig187B516576259E50EB777332"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig187B516576259E50EB777332
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-06-20 21:41, Gilles Chanteperdrix wrote:
> On 06/20/2011 09:38 PM, Jan Kiszka wrote:
>> On 2011-06-20 19:33, Gilles Chanteperdrix wrote:
>>> On 06/20/2011 06:43 PM, Jan Kiszka wrote:
>>>> On 2011-06-19 17:41, Gilles Chanteperdrix wrote:
>>>>> Merged your whole branch, but took the liberty to change it a bit
>>>>> (replacing the commit concerning unlocked context switches with com=
ments
>>>>> changes only, and changing the commit about xntbase_tick).
>>>>
>>>> What makes splmax() redundant for the unlocked context switch case? =
IMO
>>>> that bug is still present.
>>>
>>> No, the bug is between my keyboard and chair. On architectures with
>>> unlocked context switches, the Linux task switch still happens with i=
rqs
>>> off, only the mm switch happens with irqs on.
>>
>> Then why do we call xnlock_get_irqsave in
>> xnsched_finish_unlocked_switch? Why not simply xnlock_get if irqs are
>> off anyway?
>=20
> Because of the Xenomai task switch, not the Linux task switch.

--verbose please.

Jan


--------------enig187B516576259E50EB777332
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3/on8ACgkQitSsb3rl5xR+qQCfYqVPIIQLnVU6r5Er5fwrFRFv
ZPkAn2yEnlbc3siZ3BJSxBuBlTa1wSy0
=nSb7
-----END PGP SIGNATURE-----

--------------enig187B516576259E50EB777332--

