Message-ID: <4A9BB9B8.4030509@domain.hid>
Date: Mon, 31 Aug 2009 13:53:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A9CC@XVS-DCFR-21.europe.corp.altran.com>	<4A979E12.6070508@domain.hid>	<EB48F2CADC239E44A8598CC0B0571102E4A9CE@XVS-DCFR-21.europe.corp.altran.com>	<4A9B8EF4.9050607@domain.hid>	<EB48F2CADC239E44A8598CC0B0571102E4A9D0@domain.hid>	<4A9BABC9.1030506@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A9D1@domain.hid>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A9D1@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RE : RE : RE : Error compiling Xenomai 2.4.8
 with I-pipe tracer
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
>>> I downloaded the toolchain from:
>>> http://www.codesourcery.com/sgpp/lite/arm/portal/release316
>>>
>>> It's the free version but it's supposed to have a Newlib library. Why
>>> can't I
>>> find any *.so? I only have *.a files. Must I only statically compile my
>>> software?
>>
>> No. This version is the free-standing version, made to compile code
>> without an OS. This is sufficient for compiling the Linux kernel, not
>> for compiling any Linux user-space applications. What you should
>> download is:
>>
>> http://www.codesourcery.com/sgpp/lite/arm/portal/release313
>=20
> Thank you for the link. I'll try this.
>=20
> NOTE: for anyone who's interested
> I applied the patch found in:
> http://marc.info/?l=3Dlinux-arm-kernel&m=3D124946219616111&w=3D2
> <http://marc.info/?l=3Dlinux-arm-kernel&m=3D124946219616111&w=3D2>
>=20
> And try to compile the kernel with the 2008q1 toolchain but it fails with:
> [...]
>   LD      .tmp_vmlinux1
> init/built-in.o: In function `do_one_initcall':
> calibrate.c:(.text+0x14): undefined reference to `__gnu_mcount_nc'
> init/built-in.o: In function `run_init_process':
> calibrate.c:(.text+0x1b0): undefined reference to `__gnu_mcount_nc'
> init/built-in.o: In function `init_post':
> calibrate.c:(.text+0x1e0): undefined reference to `__gnu_mcount_nc'
> init/built-in.o: In function `name_to_dev_t':
> calibrate.c:(.text+0x2e0): undefined reference to `__gnu_mcount_nc'
> init/built-in.o: In function `rest_init':
> calibrate.c:(.ref.text+0x10): undefined reference to `__gnu_mcount_nc'
> init/built-in.o:calibrate.c:(.cpuinit.text+0x10): more undefined
> references to `__gnu_mcount_nc' follow
> make[3]: *** [.tmp_vmlinux1] Erreur 1
> make[2]: *** [sub-make] Erreur 2
> make[1]: *** [zImage] Erreur 2
> make: *** [sub-make] Erreur 2
>=20
> Even if the patch permits the export of both symbols.

exporting symbols is only useful for modules. Defining the symbol is
sufficient to avoid such undefined references. So, in a nutshell I
thinkg you screwed up somehow.

--=20
                                          Gilles


