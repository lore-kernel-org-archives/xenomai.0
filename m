MIME-Version: 1.0
In-Reply-To: <AANLkTim4A+3sLGzgdhc_Xhfn0bAW+hLZtuUJVyVocLOZ@mail.gmail.com>
References: <1279046702.31665.65.camel@domain.hid> <4C3CB655.1020801@domain.hid>
	<1279048661.31665.81.camel@domain.hid> <1280149567.1856.15.camel@domain.hid>
	<4C4D9131.7080504@domain.hid> <1280153187.1856.25.camel@domain.hid>
	<4C4D97AC.2030609@domain.hid> <1280154697.1856.29.camel@domain.hid>
	<4C4D9E04.6060407@domain.hid> <1280156219.1856.32.camel@domain.hid>
	<4C4DA340.4030400@domain.hid> <1280187666.1963.34.camel@domain.hid>
	<4C4E8A64.1000701@domain.hid> <1280239972.1865.7.camel@domain.hid>
	<4C4EEBE3.9020806@domain.hid>
	<AANLkTim4A+3sLGzgdhc_Xhfn0bAW+hLZtuUJVyVocLOZ@mail.gmail.com>
Date: Tue, 27 Jul 2010 18:03:16 -0300
Message-ID: <AANLkTimGA5k4Vu_aQNXx1bBhT2X3KAZytAKZHWD-HNHK@mail.gmail.com>
From: Leandro Favarin <leandro.favarin@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Kernel compilation procedures for imx51
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Cc: xenomai@xenomai.org

Hi,

I'm working on the same project with Flavio, and followed the
discussion since the beginning.
The result I got after running ltib (compiling) was:

(...)
 CC      arch/arm/plat-mxc/mc13783_xc.o
arch/arm/plat-mxc/mc13783_xc.c:18:32: error: mach/pmic_external.h: No
such file or directory
make[1]: *** [arch/arm/plat-mxc/mc13783_xc.o] Error 1
make: *** [arch/arm/plat-mxc] Error 2

What I have to do now?

Thanks,
Leandro Favarin

On Tue, Jul 27, 2010 at 3:42 PM, Flavio de Castro Alves Filho
<flavio.alves@domain.hid> wrote:
> It worked.
>
> As soon as I have the compilation done, I report the result.
>
> Thanks for the help.
>
> Best regards.
>
> Flavio
>
> Flavio de Castro Alves Filho
> Phi Innovations - Embedded Software Services
> www.phiinnovations.com
> Phone: +55 19 81 55 72 40
> Skype: flavio.de.castro.alves.filho
>
>
> 2010/7/27 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>> Flavio Alves wrote:
>> > Hello,
>> >
>> > I am still having problems with the patch:
>> >
>> > I performed the following procedures
>> >
>> > 1) git clone
>> > http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git
>> > 2) cd linux-2.6-imx
>> > 3) git checkout rel_imx_2.6.31_10.02.00
>> > 4) patch -p0 < ../adeos-ipipe-2.6.31-arm-1.16-01.patch
>>
>> It should be patch -p1
>>
>> --
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

