Message-ID: <44900A19.1040702@domain.hid>
Date: Wed, 14 Jun 2006 15:07:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ns vs. tsc as internal timer base
References: <448E98A3.6080707@domain.hid>	<448E9E8B.70809@domain.hid>	<448EA7F7.5000802@domain.hid>	<448EB038.8070802@domain.hid>	<448EE593.7010809@domain.hid>	<448EF022.1040901@domain.hid>	<17550.61982.685449.470866@domain.hid>
	<448EFCC5.60308@domain.hid> <448FD5EC.4060109@domain.hid>
	<44900143.50806@domain.hid>
In-Reply-To: <44900143.50806@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD8FFE2A0E19C20E554BD905F"
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
--------------enigD8FFE2A0E19C20E554BD905F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jim Cromie wrote:
>> Philippe Gerum wrote:
>>
>>> Gilles Chanteperdrix wrote:
>>>
>>>> Philippe Gerum wrote:
>>>>  > Redone the check here on a Centrino 1.6Mhz, and still have
>>>> roughly x20  > improvement (a bit better actually). I'm using
>>>> Debian/sarge gcc 3.3.5.
>>>>
>>>> I think I remember that Pentium M has a much shorter mull instructio=
n
>>>> than other processors of the family.
>>>>
>>>
>>> That would explain. Anyway, as John Stulz put it:
>>> "math is hard, lets go shopping!"
>>>
>>
>> Heh.  Appropriate that his name (Stultz) comes up here, as his
>> generic-time (GTOD)
>> patchset looks headed for 2.6.18, bringing with it a full re-working
>> of linux timers / timeofday.  IN this new world, time is kept on
>> free-running counters.
>>
>> Ive been running this patchset on my soekris for some time, since
>> GTOD detects that the TSC counts slowly, calls it insane, and does tim=
ing
>> with the PIT.
>>
>> With GTOD, writing a new clocksource driver is easy, enough so I could=

>> do it.
>> My clocksource patch uses the 27 mhz timer on the Geode CPU.
>> Once the TSC is de-rated, mine becomes the best clocksource, and GTOD
>> switches to it.
>>
>> All of which is to say ..
>> new mainline code is coming, should this current rework notion wait,
>> given that its will all need revisited again later
>>
>=20
> Clearly yes, since this is going to impact Adeos too. GTOD is going to
> fiddle with the PIT channels in a way Adeos needs to be aware of, in
> order for the client RTOS to reuse such timer. Added to the flow of
> other core changes planned for 2.6.18, this is likely going to be funky=
=2E
>=20
> "Find wall. Beat head against same."
>=20

May not be required: the GTOD and clocksource abstractions could provide
a clean way to register some virtual, Adeos- or RTOS-provided clock with
Linux. And that clock may even lose ticks without Linux losing its
system time! So far for the theory, practice may still require walls...

Jan


--------------enigD8FFE2A0E19C20E554BD905F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEkAodniDOoMHTA+kRAgHMAJ9+1GN/pn+zWIPEIZYP6PgGTjnOTwCfcO2I
mQZuqAIzEeqlkbXHlWVPAkQ=
=ynjz
-----END PGP SIGNATURE-----

--------------enigD8FFE2A0E19C20E554BD905F--

