Message-ID: <4EA5D17C.7010000@domain.hid>
Date: Mon, 24 Oct 2011 22:58:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <584f2ab9.7f72956e.4e78ccaa.5171d@domain.hid>
	<4EA53FE7.6030803@domain.hid>
	<f8287c0.5ee210fc.4ea544fe.30636@domain.hid>
	<4EA546DE.2020207@domain.hid>
	<e966a6c.7f7f5548.4ea547f5.6fa69@domain.hid>
In-Reply-To: <e966a6c.7f7f5548.4ea547f5.6fa69@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] installing xenomai on pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert <robert-km@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 10/24/2011 01:11 PM, Robert wrote:
>=20
>=20
>=20
> Dnia 24 pa=C5=BAdziernika 2011 13:07 Gilles Chanteperdrix <gilles.chant=
eperdrix@domain.hid> napisa=C5=82(a):
>=20
>> On 10/24/2011 12:59 PM, Robert wrote:
>>> Dnia 24 pa=C5=BAdziernika 2011 12:37 Gilles Chanteperdrix <gilles.cha=
nteperdrix@domain.hid> napisa=C5=82(a):
>>
>>>> Ok. Try calling /usr/xenomai/bin/xeno-test instead of cding to the
>>>> directory and runing ./xeno-test.
>>>
>>> No difference.
>>
>> I am unable to reproduce this issue, but I am using ash, not bash. las=
t
>> attempt: could you try adding /usr/xenomai/bin to the PATH variable?
>=20
> The same.

Could you try the following patch?=20

http://git.xenomai.org/?p=3Dxenomai-head.git;a=3Dcommitdiff;h=3D8f2fd0b49=
e51fb2547c4972f2cda9e32dfc5dca6;hp=3D82ab99a3a840dd78c3ed8e5a6555f422420b=
7827

The problem is due to dash, not bash, which is linked to /bin/sh by=20
default on ubuntu.=20

>=20
>>>> I have not received the config file.
>>
>>> CONFIG_ARCH_OMAP2PLUS_TYPICAL=3Dy
>>> # CONFIG_ARCH_OMAP2 is not set
>>> CONFIG_ARCH_OMAP3=3Dy
>>> CONFIG_ARCH_OMAP4=3Dy
>>> # CONFIG_ARCH_OMAP3430 is not set
>>> CONFIG_OMAP_PACKAGE_CBL=3Dy
>>> CONFIG_OMAP_PACKAGE_CBS=3Dy
>>
>> Could you try disabling CONFIG_OMAP3?
>=20
> No. While running "make oldconfig" CONFIG_OMAP3 automatically set to ye=
s, so i didn't touch it.
> Ok, so now I will try to recompile kernel with new config.

The error is indeed due to OMAP3 + OMAP4 setting. In order to disable
CONFIG_OMAP3, you have to unselect all the omap3 based boards.=20
"make xconfig" has debug options allowing to find such dependencies.

And by the way, thanks for testing the release candidate.

Regards.

--=20
                                                                Gilles.


