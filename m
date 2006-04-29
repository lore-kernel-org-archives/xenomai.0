Message-ID: <44539DDD.9060200@domain.hid>
Date: Sat, 29 Apr 2006 19:09:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Problems compiling
	arch/ppc/xmon/xmon.o	(CONFIG_XMON=y)
References: <200604291850.36231.niklaus.giger@domain.hid>
In-Reply-To: <200604291850.36231.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
>=20
> After a clean checkout of xenomai (r1016) and with a config
> which defines CONFIG_XMON I get the following errors:
>   CC      arch/ppc/xmon/xmon.o
> In file included=20

xmon looks like pretty much broken actually, and I see no issue=20
regarding Xeno here. privinst.h's GSETSPR creates inlines with different=20
return types than the declarations found in asm-ppc/time.h, so no wonder=20
why the compiler is whining.

> from /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/xmon.c:23:
> /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/privinst.h:26: e=
rror:=20
> conflicting types for =E2=80=98get_rtcu=E2=80=99
> include2/asm/time.h:102: error: previous definition of =E2=80=98get_rtc=
u=E2=80=99 was here
> /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/privinst.h:27: e=
rror:=20
> conflicting types for =E2=80=98get_rtcl=E2=80=99
> include2/asm/time.h:95: error: previous definition of =E2=80=98get_rtcl=
=E2=80=99 was here
> /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/privinst.h:32: e=
rror:=20
> conflicting types for =E2=80=98get_dec=E2=80=99
> include2/asm/time.h:39: error: previous definition of =E2=80=98get_dec=E2=
=80=99 was here
> /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/privinst.h:32: e=
rror:=20
> conflicting types for =E2=80=98set_dec=E2=80=99
> include2/asm/time.h:48: error: previous definition of =E2=80=98set_dec=E2=
=80=99 was here
> make[2]: *** [arch/ppc/xmon/xmon.o] Fehler 1
> make[1]: *** [arch/ppc/xmon] Fehler 2
>=20
> Best regards


--=20

Philippe.

