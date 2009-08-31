Message-ID: <4A9B8EF4.9050607@domain.hid>
Date: Mon, 31 Aug 2009 10:51:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A9CC@XVS-DCFR-21.europe.corp.altran.com>	<4A979E12.6070508@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9CE@XVS-DCFR-21.europe.corp.altran.com>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A9CE@XVS-DCFR-21.europe.corp.altran.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RE : Error compiling Xenomai 2.4.8 with I-pipe
 tracer
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Cc: xenomai@xenomai.org

Berruer S=E9bastien wrote:
> Hello,
>=20
>>> I can't achieve the compilation process when I enable the I-pipe tracer.
>>> I've tried some mixed configurations but it always fails with an error.
>>> I use :
>>>
>>>  - gcc version 4.2.3 (Sourcery G++ Lite 2008q1-126)
>>>  - GNU C Library stable release version 2.5, by Roland McGrath et al.
>>
>>
>> It is a known toolchain issue, you are using a toolchain too recent for
>> this kernel version. This is a mainline bug, there is a fix, but I do
>> not know if it has been merged yet. Though according to the fix, this
>> gnu_mcount stuff comes with gcc 4.4, so I am not sure you use the
>> compiler you think you are using.
>=20
>=20
> As I wrote, it's the version 2008q1 from CodeSourcery. I only type this
> command:
> arm-none-linux-gnueabi-gcc --version
>=20
> We can suppose that they applied a patch on their own version.
>=20
>=20
>> So, either downgrade your toolchain (I bet 2007q3 works, since it is the
>> one I have been using for a long time), when you want to use the tracer.
>> Or apply the patches which have been published on the linux-arm-kernel
>> mailing list.
>=20
>=20
> Using the 2007q3 toolchain, I get the same error than in the mailing list
> thread: "at91sam9263 and user-space support compile fails". The use of th=
is
> toolchain doesn't solve the problem for me.

No, 2007q3 works, without any doubt. What thread exactly are you
refering to? I can not find it in the last 12 monthes mails. The only
problem with 2007q3 is if you compile with -fomit-frame-pointer. When
you are refering to a thread, it is bet to put an URL, like:

https://mail.gna.org/public/xenomai-help/2009-08/msg00076.html

>=20
> When I checked the toolchain I get from CodeSourcery, I saw that it doesn=
't
> come with a cross-compile libc. If the package doesn't provide a complete
> library, I suppose it doesn't come with header files either.

What are you talking about? Codesourcery toolchain comes with several
cross-compiled libcs (armv4, armv6) and all the necessary headers. Are
you sure you have not downloaded the "free-standing" version?

>=20
>=20
> Best regards,
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> | BERRUER S=E9bastien
> | Trainee at Altran Ouest
> | Centre d'Affaires Alphasis
> | 35760 Saint-Gr=E9goire - FRANCE
> | Tel: 06-76-35-29-55
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> ------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
                                          Gilles


