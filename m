Message-ID: <4C3599A9.9040203@domain.hid>
Date: Thu, 08 Jul 2010 11:26:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimrbMuVq05BwyINdFIxrHIAiw0Hoc5O1go6VrXZ@mail.gmail.com>	<4C359374.3010204@domain.hid>
	<AANLkTikwRt6e6YRusYEJgEfB1FgFXmuO8S363gkqO39_@domain.hid>
In-Reply-To: <AANLkTikwRt6e6YRusYEJgEfB1FgFXmuO8S363gkqO39_@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomia installing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?R8O2cmtlbSBLYXJhZG/En2Fu?= <gkaradagan@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

G=C3=B6rkem Karado=C4=9Fan wrote:
>=20
>=20
> 2010/7/8 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>>
>=20
> G=C3=B6rkem Karado=C4=9Fan wrote:
>> when i build xenomia, i got this code.
>>=20
>> [CODE]root@domain.hid# scripts/prepare-kernel.sh=20
>> Linux tree [default /lib/modules/2.6.31-22-generic-pae/source]:=20
>> /opt/linux-02.01.03.11/ Target architecture [default i686]:
>>=20
>> How can i do this architecture to omap3530 ?
>>=20
>> and i use linux-02.01.03.11, which adeos pacht is it able ?
>=20
> To install Xenomai, please follow the installation instructions. You=20
> will find them in the README.INSTALL file in Xenomai sources=20
> distribution, or online:=20
> http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL
>=20
> -- Gilles.
>=20
>=20
> Suitable patches are available with Xenomai under=20
> ksrc/arch/<target-arch>/patches. it said that. I tried all of them.
> everypachts is not able with kernel 2.6.29-rc3. i cant see. Which
> pacht is it able ? Can you write here ?

It is said that if you want to compile a kernel for the ARM
architecture, you should use the patches in ksrc/arch/arm/patches. But
the patches are made to be applied on the mainline kernel. You are the
second person trying to apply the I-pipe patch on a different
omap-specific vendor branch. Understand that we can not support all
vendor branches around.

And please do not forget to CC the mailing list.

--=20
					    Gilles.


