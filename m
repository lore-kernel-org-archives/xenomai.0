Message-ID: <44903372.2010104@domain.hid>
Date: Wed, 14 Jun 2006 18:04:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
References: <448E98A3.6080707@domain.hid>	<448E9E8B.70809@domain.hid>	<448EA7F7.5000802@domain.hid>	<448EB038.8070802@domain.hid>	<448EE593.7010809@domain.hid>	<448EF022.1040901@domain.hid>	<17550.61982.685449.470866@domain.hid>
	<448EFCC5.60308@domain.hid> <448FD5EC.4060109@domain.hid>
	<44900143.50806@domain.hid> <44900A19.1040702@domain.hid>
In-Reply-To: <44900A19.1040702@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig720BD8951FB504CD82A429CB"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig720BD8951FB504CD82A429CB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jim Cromie wrote:
>>> Philippe Gerum wrote:
>>>
>>>> Gilles Chanteperdrix wrote:
>>>>
>>>>> Philippe Gerum wrote:
>>>>>  > Redone the check here on a Centrino 1.6Mhz, and still have
>>>>> roughly x20  > improvement (a bit better actually). I'm using
>>>>> Debian/sarge gcc 3.3.5.
>>>>>
>>>>> I think I remember that Pentium M has a much shorter mull instructi=
on
>>>>> than other processors of the family.
>>>>>
>>>> That would explain. Anyway, as John Stulz put it:
>>>> "math is hard, lets go shopping!"
>>>>
>>> Heh.  Appropriate that his name (Stultz) comes up here, as his
>>> generic-time (GTOD)
>>> patchset looks headed for 2.6.18, bringing with it a full re-working
>>> of linux timers / timeofday.  IN this new world, time is kept on
>>> free-running counters.
>>>
>>> Ive been running this patchset on my soekris for some time, since
>>> GTOD detects that the TSC counts slowly, calls it insane, and does ti=
ming
>>> with the PIT.
>>>
>>> With GTOD, writing a new clocksource driver is easy, enough so I coul=
d
>>> do it.
>>> My clocksource patch uses the 27 mhz timer on the Geode CPU.
>>> Once the TSC is de-rated, mine becomes the best clocksource, and GTOD=

>>> switches to it.
>>>
>>> All of which is to say ..
>>> new mainline code is coming, should this current rework notion wait,
>>> given that its will all need revisited again later
>>>
>> Clearly yes, since this is going to impact Adeos too. GTOD is going to=

>> fiddle with the PIT channels in a way Adeos needs to be aware of, in
>> order for the client RTOS to reuse such timer. Added to the flow of
>> other core changes planned for 2.6.18, this is likely going to be funk=
y.
>>
>> "Find wall. Beat head against same."
>>
>=20
> May not be required: the GTOD and clocksource abstractions could provid=
e
> a clean way to register some virtual, Adeos- or RTOS-provided clock wit=
h
> Linux. And that clock may even lose ticks without Linux losing its
> system time! So far for the theory, practice may still require walls...=

>=20

Some refinement: clocksource may either remain TSC or become a
Xenomai-provided clock if its handling (PIT...) requires
synchronisation. The clockevent, the one thing that triggers timer IRQs,
could become a virtual device driven by Xenomai. And GTOD should happily
make use of them instead of messing up with shared hardware.

Jan


--------------enig720BD8951FB504CD82A429CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEkDNzniDOoMHTA+kRAqTVAJ9b1+T5sPKKJeNhcnGr2eGAi5czggCfWIp4
twLrmtwEqY+lES+s1UnityA=
=gFX3
-----END PGP SIGNATURE-----

--------------enig720BD8951FB504CD82A429CB--

