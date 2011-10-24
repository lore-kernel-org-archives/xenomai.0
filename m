Message-ID: <4EA546DE.2020207@domain.hid>
Date: Mon, 24 Oct 2011 13:07:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <584f2ab9.7f72956e.4e78ccaa.5171d@domain.hid>
	<4EA53424.6050803@domain.hid>
	<9a6b34f.290ebc9d.4ea53837.4438c@domain.hid>
	<4EA53FE7.6030803@domain.hid>
	<f8287c0.5ee210fc.4ea544fe.30636@domain.hid>
In-Reply-To: <f8287c0.5ee210fc.4ea544fe.30636@domain.hid>
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
Cc: xenomai@xenomai.org

On 10/24/2011 12:59 PM, Robert wrote:
> Dnia 24 pa=C5=BAdziernika 2011 12:37 Gilles Chanteperdrix <gilles.chant=
eperdrix@domain.hid> napisa=C5=82(a):

>> Ok. Try calling /usr/xenomai/bin/xeno-test instead of cding to the
>> directory and runing ./xeno-test.
>=20
> No difference.

I am unable to reproduce this issue, but I am using ash, not bash. last
attempt: could you try adding /usr/xenomai/bin to the PATH variable?

>> I have not received the config file.

> CONFIG_ARCH_OMAP2PLUS_TYPICAL=3Dy
> # CONFIG_ARCH_OMAP2 is not set
> CONFIG_ARCH_OMAP3=3Dy
> CONFIG_ARCH_OMAP4=3Dy
> # CONFIG_ARCH_OMAP3430 is not set
> CONFIG_OMAP_PACKAGE_CBL=3Dy
> CONFIG_OMAP_PACKAGE_CBS=3Dy

Could you try disabling CONFIG_OMAP3?

--=20
                                                                Gilles.


