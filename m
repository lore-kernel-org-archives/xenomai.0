Message-ID: <4B30BF0A.1020502@domain.hid>
Date: Tue, 22 Dec 2009 13:43:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B309A29.6030405@domain.hid> <4B30AF29.4050303@domain.hid>
	<4B30B154.2010203@domain.hid> <4B30B3A9.4000905@domain.hid>
	<4B30BBD0.6030002@domain.hid>
In-Reply-To: <4B30BBD0.6030002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF251DFDB7B6E0CF4BF77D864"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Build tests: analogy, blackfin, rtcan and nios2.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Grandegger <wg@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF251DFDB7B6E0CF4BF77D864
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> * rtcan: on blackfin we seem to have a conflict with rtcan.
>>>>> The warning is about CAN_ERR_MASK, sure blackfin is a bit strange t=
o
>>>>> define this in core headers which are included everywhere. This sai=
d,
>>>>> not prefixing a Xenomai symbol with something like XN seems to be a=
sking
>>>>> for trouble. Wolfgang, do you think it would be possible to rename =
the
>>>>> symbols with such prefix? Or do you share some code with socket-can=
 that
>>>>> you do not want to touch?
>>>> CAN_ERR_MASK is part of the Socket-CAN interface (include/linux/can.=
h),
>>>> it must not be called differently. Blackfin is obviously doing names=
pace
>>>> pollution which should be fixed upstream and meanwhile worked around=
 in
>>>> Xenomai (e.g. via #undef CAN_ERR_MASK).
>>> Ok. But according to the build logs, it is redefined in rtdm/rtcan.h.=

>>> The error seems to have been fixed upstream, since we get this warnin=
g
>>> with 2.6.30 and not with 2.6.31.
>> Right, the error comes from:
>>
>> http://lxr.linux.no/#linux+v2.6.32/arch/blackfin/mach-bf537/include/ma=
ch/bf537.h#L20
>>
>> and is in conflict with "include/linux/can/can.h" anyhow.
>=20
> Ok, ok. My question was about rtdm/rtcan.h redefining what is already
> defined in linux/can.h. Would not it make sense to include linux/can.h
> instead? Of course, this is not something that needs fixing right now,
> but would be better on the long run.

Right. We just need to take care for pre-CAN kernels.

Jan


--------------enigF251DFDB7B6E0CF4BF77D864
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkswvw4ACgkQitSsb3rl5xQfSwCfY1VmYOt1MZV3yCi6W9kI3W09
IuIAmweD+LRVar01RZvfKjKJKbY+k9EJ
=Bfa3
-----END PGP SIGNATURE-----

--------------enigF251DFDB7B6E0CF4BF77D864--

