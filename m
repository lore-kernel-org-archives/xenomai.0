Message-ID: <46C08D64.4050903@domain.hid>
Date: Mon, 13 Aug 2007 18:57:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid> <46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid> <46C07EDC.4040305@domain.hid>
In-Reply-To: <46C07EDC.4040305@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig89DEF9CAA03367701AC10AE3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig89DEF9CAA03367701AC10AE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi
>=20
>>> There is definitely something between the two that is not right.
>>>
>>
>> In 9 of 10 cases (if not more): timing. Running both alone doesn't
>> expose some timing issue (race) or transient overload. I can't help wi=
th
>> EML complaints, maybe the FMTC guys have an idea what can trigger this=

>> and how to debug it.
> Out of interest, what timing exactly? These two systems (rtcan and eml)=

> run separately, they don;t need to access the same address space or
> otherwise share resources that would require timing? What am I not
> understanding?

The share the same CPU? Varying the load can re-order the execution
order in otherwise independent components.

>=20
>=20
>>>>>>> RTnet:rtskb allocation from real-time cache failed.
>>> Could I get some tips as to what I can do about this? I seem to get
>>> it even when I do not have rtcan activity running in my application
>>> and (because I am clueless) I would like to prevent this message
>>> which may signify the root of the problem.
>>
>> You have created the socket for some/all EML activity from primary mod=
e
>> of some Xenomai thread,=20
> 100% correct.
>=20
>=20
> thus network buffer allocation is ought to run
>> against the real-time rtskb pool - which is by default empty :p. See
>> README.pools from the RTnet documentation on this.
>=20
>=20
>> I don't have the EML design at hand, but you might be able to avoid th=
is
>> by initialising before creating the shadow task or by explicitly
> In fact this is what I tried initially. IT does not work at all. so I
> ended up initializing in the thread. Problem?

Not necessarily. But it would have been nice to report the other issue
as well, because maybe there is something to be fixed (either in the
code or in the docs). Initialisation almost always happens in non-RT
context, and you shouldn't be force to do this under RT constraints. If
this is an RTnet and/or EML problem, please report it on the related list=
s!

>=20
> Is this allocation possibly the cause of the problem or is the rtnet
> warning harmless? At least it is not related to rtcan in any manner
> because it appears even if rtcan is not activated in the application.

Did you set the rtskb_cache_size module parameter for the rtnet.ko? Did
you choose it appropriately large so that buffer pool do not exhaust if
RTnet is blocked by other system activity? Again, check the documentation=
=2E

Jan


--------------enig89DEF9CAA03367701AC10AE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwI1lniDOoMHTA+kRApQHAJ47VnDPxIqRV6xX34ObqpDPXecjvgCeKfN6
2lCIVreGT5ktWYRYzwBI6aI=
=spt4
-----END PGP SIGNATURE-----

--------------enig89DEF9CAA03367701AC10AE3--

