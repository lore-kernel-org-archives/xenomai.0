Message-ID: <43C21BA7.4050806@domain.hid>
Date: Mon, 09 Jan 2006 09:15:35 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency kernel part crashes on ppc64
References: <43C12304.4040802@domain.hid>	<43C12CEC.8070403@domain.hid>	<43C14453.3040907@domain.hid>	<1136754149.17443.21.camel@domain.hid>
	<43C18CE1.5040509@domain.hid> <43C1CFC2.8040104@domain.hid>
In-Reply-To: <43C1CFC2.8040104@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig216D53720FFFC7D3F47052DD"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig216D53720FFFC7D3F47052DD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>=20
>> Stelian Pop wrote:
>>
>>> Le dimanche 08 janvier 2006 =E0 18:56 +0200, Heikki Lindholm a =E9cri=
t :
>>>
>>>
>>>
>>>>>> Some recent changes (*cough* RTDM benchmark driver *cough*) broke
>>>>>> kernel
>>>>>> mode benchmarking for ppc64. Previously klatency worked fine, but =
now
>>>>>> latency -t 1 crashes somewhere in xnpod_schedule. Jan, any pending=

>>>>>> patches a comin'?
>>>
>>>
>>>
>>> So it seems I'm not alone.
>>> I have done some additionnal debugging on this issue in the last days=
=2E I
>>> still haven't find the bug but I narrowed it down a bit.
>>>
>>>
>>>>> Nope, it should work as it is. But as Stelian also reported
>>>>> problems on
>>>>> his fresh ARM port with the in-kernel test, I cannot exclude that
>>>>> there
>>>>> /might/ be a problem in the benchmark.
>>>>>
>>>>> As I don't have any ppc64 hanging around somewhere, we will have to=
 go
>>>>> through this together. Things I would like to know:
>>>>
>>>>
>=20
> Hi guys, it's "/me too" time here for ppc. My mpc5200 board is jumping
> out of the window when running "./latency -t1", while "./latency -t2"
> works. No trace dump, hard freeze or spontaneous reboot, at your option=
=2E
> OPT_NUCLEUS_DEBUG spits nothing. No issue with the regular user-space
> test though.
>=20
> x86 has no problem at all.
>=20

Ok, three smart guys, all having the same bug on their systems - who
will be first shouting "I got it"? If it's an issue in my code, I'm
going to pay you a beer (which I likely have to schedule already). ;)

Jan


--------------enig216D53720FFFC7D3F47052DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwhusniDOoMHTA+kRAosTAJ0cjzqZk3mCnFbzhpJoqIm/JBuBiQCeMpyk
R5QJ6o9nc8lQIGtTrWFuCrY=
=khn/
-----END PGP SIGNATURE-----

--------------enig216D53720FFFC7D3F47052DD--

