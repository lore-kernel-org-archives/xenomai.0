Message-ID: <4C2C3A74.6010608@domain.hid>
Date: Thu, 01 Jul 2010 08:49:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>	<4C2A518F.8030302@domain.hid>	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>	<4C2B0043.1070108@domain.hid>
	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
In-Reply-To: <AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Felipe Brand=C3=A3o Cavalcanti wrote:
> I am actually trying to do the exact same thing.
>=20
> On Wed, Jun 30, 2010 at 5:28 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>=20
>> Fredrik Asplund wrote:
>>>> Xenomai 2.5.3 was tested on OMAP3 with the mainline kernel. If you
>>>> absolutely want to use this vendor branch, you will have to fix the
>>>>  patch rejects by hand.
>>> Ok, yes, I thought so. I guess I was hoping someone had done the same=

>>> thing and had some pointers on what to do in this specific case (i.e.=

>>> applying Xenomai using Bitbake on a vendor branch).
>>>
>>> I will try to apply the patch rejects (I want to deviate from the
>>> original setup as little as possible, at least to begin with)
>> If you do not want to deviate from Xenomai usual setup, use the mainli=
ne
>> kernel. If I were you, I would have serious doubts on a vendor kernel
>> which touches generic files such as include/asm/cacheflush.h in order =
to
>> add some board-specific code.
>>
>>
> My first choice was to run a vanilla kernel, but no luck - didn't find =
any
> suitable config files, or any reports of success. I am on the same syst=
em -
> Gumstix Overo, kernel 2.6.33, Xenomai 2.5.3.

The 2.6.33 kernel has an overo_defconfig. This defconfig sets
CONFIG_MACH_OVERO. arch/arm/mach-omap2/Kconfig contains the following lin=
es:

config MACH_OVERO
        bool "Gumstix Overo board"
        depends on ARCH_OMAP3 && ARCH_OMAP34XX
        select OMAP_PACKAGE_CBB

So, it looks to me like the vanilla kernel supports Gumstix overo.

>=20
> Anyway, I've managed to change the files manually - the changes seem ve=
ry
> minor (the changes in include/asm/cacheflush.h just move a function
> elsewhere, no code changes at all).

That is not the point. The point is that to add support for a board, you
should not mess with generic code. So, it is probably safer to get the
vanilla support working. The I-pipe patch modifies only SOC-specific
files, so, any well written board support which adds board-specific
files should merge with the I-pipe patch without any reject.

>=20
> However, I am having problems with the kernel - any user-space Xenomai
> program gives me the following error:
> Xenomai or CONFIG_OPT_PERVASIVE disabled.
> (modprobe xeno_nucleus?)

is CONFIG_XENO_OPT_PERVASIVE in your configuration?

> All the logs seem normal to me (I-pipe reports normal starup, Xenomai
> reports successful start). I am starting to think that one of my change=
s to
> the kernel might be making the system to fail silently.

I use Xenomai 2.5.3 on an OMAP3 based board without any problems. So,
yes, either you are mis-configured (in order to check that, just use
Xenomai default configuration), or your kernel is broken.

>=20
> So, any clues? I can send my changes and logs tomorrow morning, if they=
 are
> of any help.
>=20
> Another option which I am considering is trying Xenomai with the 2.6.31=

> kernel, or maybe even 2.6.30 or 2.6.28.

I am sorry, but I am not willing to debug this, I am afraid you are on
your own.

--=20
					    Gilles.


