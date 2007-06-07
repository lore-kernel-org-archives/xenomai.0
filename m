Message-ID: <4667D2CC.2060006@domain.hid>
Date: Thu, 07 Jun 2007 11:41:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01FAF561@domain.hid>	<1181143109.17978.101.camel@domain.hid>	<7289437c0706062254v2a386894oeb498459877d5086@domain.hid>	<4667AA4D.6070505@domain.hid>	<7289437c0706070042gf4346ddj1c4ee3ac20a068d2@domain.hid>
	<4667BBBE.1040405@domain.hid> <4667CEF2.2050509@domain.hid>
	<4667D008.80109@domain.hid> <4667D167.9030001@domain.hid>
In-Reply-To: <4667D167.9030001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig390DEBB0F84618DE8D721C82"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Cyclictest
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig390DEBB0F84618DE8D721C82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Perrine Martignoni wrote:
>>>>
>>>>
>>>>> Ok. I'll do this.
>>>>>
>>>>> But I don't understand why the same application compiled without an=
y links
>>>>> with Xenomai give different results if there is Xenomai in the kern=
el.
>>>> [Looking at your numbers again] Hmm, maybe some rounding issue of ti=
cks
>>>> due to whatever side-effect of I-pipe. We would first of all need th=
e
>>>> usual set of information (.config, involved versions) and also
>>>> /sys/devices/system/clocksource/clocksource0/current_clocksource.
>>> Maybe what Perrine is observing is simply the overhead of the I-pipe =
?
>>> I mean, Linux is Xenomai idle task, so it is acceptable for Linux
>>> numbers to be a bit worse than when Xenomai is not running.
>>
>> I bit worse is expected. But I think we are seeing 1 or 2 ticks wake-u=
p
>> delays here. As far as I understood, they are not due to Xenomai
>> consuming significant cycles in the background, are they, Perrine?
>=20
> What I see is latencies 5us longer. 5us on ARM is almost nothing, keep
> in mind that a simple syscall on ARM already takes 10 us.
>=20

T: 0 (  732) P:99 I:   10500 C:    2291 Min:      41 Act:    2281 Avg:   =
 5075 Max:   10224=20

vs.

T: 0 (  893) P:99 I:   10000 C:    1756 Min:   13407 Act:   13536 Avg:   =
13452 Max:   13693=20

Thus the _minimum_ and the _average_ wakeup time of a Linux task
increase fairly significant here. That's the point. Given a reasonable
runtime of both test, this /could/ be considered as a regression of a
Xenomai-enabled Linux kernel.

Jan


--------------enig390DEBB0F84618DE8D721C82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZ9LMniDOoMHTA+kRAjDIAJ9F+NEPWZAG7z0SsjLhUmxWNdMPJwCfcV1M
2XWpKMSVkdZTGaajvscvlRE=
=jjut
-----END PGP SIGNATURE-----

--------------enig390DEBB0F84618DE8D721C82--

