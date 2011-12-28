From: "Gregory Gosse" <gregory.gosse@domain.hid>
References: <000101ccc4b8$74856eb0$5d904c10$@soterem.fr>	<4EF9F949.5000708@domain.hid>
	<000001ccc541$7fa8d960$7efa8c20$@soterem.fr>
	<4EFAE1BF.4090203@domain.hid>
	<000301ccc556$168472e0$438d58a0$@soterem.fr>
	<4EFB0456.9010409@domain.hid>
In-Reply-To: <4EFB0456.9010409@domain.hid>
Date: Wed, 28 Dec 2011 13:28:42 +0100
Message-ID: <000d01ccc55c$3cc52d40$b64f87c0$@soterem.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: fr
Subject: Re: [Xenomai-help] problem following 'xenomai quick build guide'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: 'xenomai-help' <xenomai@xenomai.org>

For the moment I use an Intel Core I5 as host and target .

Since I think I have to compile a  64bits kernel .

Do you know where is located CONFIG_CC_STACKPROTECTOR in the =
configuration menu ?

Gregory

-----Message d'origine-----
De : Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=C3=A9 : mercredi 28 d=C3=A9cembre 2011 12:58
=C3=80 : Gregory Gosse
Cc : 'Philippe Gerum'; 'xenomai-help'
Objet : Re: [Xenomai-help] problem following 'xenomai quick build guide'

On 12/28/2011 12:44 PM, Gregory Gosse wrote:
> Now I use:
>=20
> - xenomai 2.6.0   2011-11-05
>=20
> - kernel 2.6.38.8
>=20
> - patch adeos-ipipe-2.6.38.8-x86-2.10-01.patch
>=20
> =20
>=20
> The following command works well:
>=20
> scripts/prepare-kernel.sh --linux=3D/usr/src/linux-2.6.38.8=20
> =
--adeos=3D/usr/src/xenomai-2.6.0/ksrc/arch/x86/patches/adeos-ipipe-2.6.3
> 8.8-x86-2.10-01.patch --arch=3Dx86
>=20
> Then I enter the configuration menu with
>=20
> Make menuconfig
>=20
> =20
>=20
> I apply the changes suggested in 'hard real time linux using xenomai =
on intel Multi-Core processors'
>=20
> Save and exit
>=20
> =20
>=20
> When I try to compile the kernel with 'Make'  , the compilation =
finishes on:
>=20
> CC      kernel/xenomai/nucleus/pod.o
> In file included from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch.h:2:0,
>                  from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod_32.h:27,
>                  from =
/usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/bits/pod.h:2,
>                  from kernel/xenomai/nucleus/pod.c:47:
> /usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch_32.h:30:2: =

> attention : #warning "Buffer overflow detection not supported in 32bit =

> mode" [-Wcpp]
> /usr/src/linux-2.6.38.8/arch/x86/include/asm/xenomai/switch_32.h:31:2: =
erreur: #error "Disable CONFIG_CC_STACKPROTECTOR in your kernel =
configuration"
> make[3]: *** [kernel/xenomai/nucleus/pod.o] Erreur 1
> make[2]: *** [kernel/xenomai/nucleus] Erreur 2
> make[1]: *** [kernel/xenomai] Erreur 2
> make: *** [kernel] Erreur 2

Then do as the message says, disable "CONFIG_CC_STACKPROTECTOR" in the =
kernel configuration. But are you sure you want to compile a 32 bits =
kernel, not a 64 bits one?

--=20
                                                                Gilles.


