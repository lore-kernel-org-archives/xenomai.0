Message-ID: <44C25DB0.50601@domain.hid>
Date: Sat, 22 Jul 2006 19:17:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Beginner's question / testsuite / latency
References: <442248c90607201417m24729b7cs23a8b82b719ff1cc@domain.hid>
	<44BFFC73.9080603@domain.hid> <200607221152.34298.bidsonux@domain.hid>
In-Reply-To: <200607221152.34298.bidsonux@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD8EDFBD067F57FD5C9887C55"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Heyman <bidsonux@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8EDFBD067F57FD5C9887C55
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Julien Heyman wrote:
> Hi,
>=20
> On Thursday 20 July 2006 23:58, Jan Kiszka wrote:
>> Julien Heyman wrote:
>>> Hi,
>>>
>>> I am currently trying to evaluate Xenomai, and my current setup is :
>>> VIA C3 533Mhz processor, Kubuntu 6.06 Linux distribution.
>>> I am using Xenomai-2.1.0 over a 2.6.17.4 kernel.
>> General advice: especially when starting new, try to pick the latest
>> version, at least the latest from the preferred series (here 2.1.2). B=
ut
>> 2.2 is even better. :)
>>
>=20
> OK. Actually started with Xenomai-2.1.0 then switched to 2.1.1 to fix a=
 kernel=20
> build error. But anyway, I will start with a fresh install of 2.2 as so=
on as=20
> I have figured out the other points :)
>=20
>>> When I run the latency part of the testsuite (in a console under KDE)=
, I
>>> get
>>> results that I cannot understand, so I probably did something wrong
>>> (execution trace included below).
>>> I get reasonable values during the first seconds, then all of a sudde=
n
>>> latencies begin to rise, continuously, to very large values.
>>> - I did check that DMA transfer is activated on my HD.
>>> - I did select "Enable SMI workaround" + "Globally disable SMI" in th=
e
>>> Xenomai
>>> options while configuring the kernel.
>>> - I have disabled power management at BIOS level and disabled ACPI
>>> support and
>>> CPU frequency scaling during kernel configuration.
>>> - I checked that I don't have anything called "legacy USB" in my BIOS=
=2E I
>>> do have an "OnChip USB" option enable in the BIOS though.
>>>
>>> Any advice would be appreciated !
>> Maybe it's related to some other weird on-chip hardware. At work we ru=
n
>> Xenomai only on a head-less VIA C3 box, i.e. without X. No problems so=

>> far. I would suggest to try stopping X and run the test from the text =
mode.
>=20
> This is interesting : indeed when I switch to console mode (Ctrl+Atl+F1=
) and=20
> run the test, the latency values stay right on track.
> If I let the test run, switch to X, and switch back to the original con=
sole,=20
> the values have gone wild in the meantime.
> So there seems to be a strong link with X.=20
> What does that say about potential causes of my issue ?

Don't know. Might be a weird hardware design (wrt bus latencies) - or do
you use any binary-only driver for X?

>=20
>> A further tool to analyse such effects in details is the I-pipe tracer=
=2E
>> It's an additional patch you have to apply to your kernel (see
>> http://download.gna.org/adeos/patches/v2.6/i386/tracer). Enable this
>> I-pipe option, rebuild your kernel, and start the latency test with -f=
=2E
>> The test will then capture on every new worst-case delay a backtrace t=
o
>> /proc/ipipe/trace/frozen. You may want to play with the number of
>> back-trace points or the verbose mode (see /proc/ipipe/trace/*) even
>> after the capturing.
>>
>=20
> I had already used an adeos patch during my initial kernel-patching
> (adeos-ipipe-2.6.17-i386-1.3-07.patch)

The tracer is an additional patch on top of I-pipe, see link above.

> I tried running the latency test using /usr/xenomai/bin/xeno-load laten=
cy -f
> but I get this error :
>=20
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> latency: failed to open benchmark device, code -19
> (modprobe xeno_timerbench?)
>=20
> What am I doing wrong ?

For < 2.2: check if CONFIG_XENO_DRIVERS_TIMERBENCH is y or m. If it's a
module, follow the suggestion latency printed.

In 2.2 the required tracing interface was moved to the nucleus, no need
for these steps then.

Jan


--------------enigD8EDFBD067F57FD5C9887C55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEwl2wniDOoMHTA+kRAsmLAJ0Vbf6yqxr1k3DDEutepkvId0Xi3ACeLCGX
0gZAo1YB0d0bGoxtm6+jFEo=
=aQca
-----END PGP SIGNATURE-----

--------------enigD8EDFBD067F57FD5C9887C55--

