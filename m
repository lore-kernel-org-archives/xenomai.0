MIME-Version: 1.0
In-Reply-To: <4C4F7B47.6040709@domain.hid>
References: <1279046702.31665.65.camel@domain.hid> <4C3CB655.1020801@domain.hid>
	<1279048661.31665.81.camel@domain.hid> <1280149567.1856.15.camel@domain.hid>
	<4C4D9131.7080504@domain.hid> <1280153187.1856.25.camel@domain.hid>
	<4C4D97AC.2030609@domain.hid> <1280154697.1856.29.camel@domain.hid>
	<4C4D9E04.6060407@domain.hid> <1280156219.1856.32.camel@domain.hid>
	<4C4DA340.4030400@domain.hid> <1280187666.1963.34.camel@domain.hid>
	<4C4E8A64.1000701@domain.hid> <1280239972.1865.7.camel@domain.hid>
	<4C4EEBE3.9020806@domain.hid>
	<AANLkTim4A+3sLGzgdhc_Xhfn0bAW+hLZtuUJVyVocLOZ@mail.gmail.com>
	<AANLkTimGA5k4Vu_aQNXx1bBhT2X3KAZytAKZHWD-HNHK@mail.gmail.com>
	<4C4F7B47.6040709@domain.hid>
Date: Tue, 3 Aug 2010 15:07:39 -0300
Message-ID: <AANLkTin-4N_AdZiEK+dqxsz=E_ZHxDnoGxQikOJCkVo9@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello,

I have successfully cross-compiled the linux-2.6-imx.git with
Xenomai's patches (adeos-ipipe-2.6.31-arm-1.16-01.patch and
adeos-ipipe-2.6.31-arm-1.15-01-imx51.patch, in this sequence) for
iMX51EVK. Does this kernel works with this board?

Thanks,
Leandro Favarin

On Tue, Jul 27, 2010 at 9:35 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Leandro Favarin wrote:
>> Hi,
>>
>> I'm working on the same project with Flavio, and followed the
>> discussion since the beginning.
>> The result I got after running ltib (compiling) was:
>>
>> (...)
>> =A0CC =A0 =A0 =A0arch/arm/plat-mxc/mc13783_xc.o
>> arch/arm/plat-mxc/mc13783_xc.c:18:32: error: mach/pmic_external.h: No
>> such file or directory
>> make[1]: *** [arch/arm/plat-mxc/mc13783_xc.o] Error 1
>> make: *** [arch/arm/plat-mxc] Error 2
>>
>> What I have to do now?
>
> This does not look like an error related to Xenomai. Please report to
> the relevant mailing list.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

