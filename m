From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4c3de30f.cf7d0e0a.6141.4e93@domain.hid>
References: <4c3de30f.cf7d0e0a.6141.4e93@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Jul 2010 18:31:28 +0200
Message-ID: <1279125088.1995.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] arch 'powerpc' make: error 'struct
 ipipe_sysinfo' has no member named 'cpufreq'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter =?ISO-8859-1?Q?K=FCnnemann?= ITB <itb.pkue@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-07-14 at 18:17 +0200, Peter K=C3=BCnnemann ITB wrote:
> Hi all
>=20
> I am about to get a xenomai kernel 2.6.34 to be run on a lite5200 platfor=
m (IceCube?).
> The patches from=20
>=20
> "http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.34-po=
werpc-2.10-03.patch"
>=20
> did apply without any problem. The make however resulted in the failure r=
eported below.
>=20
> ...
>   CC      kernel/time/tick-sched.o
>   LD      kernel/time/built-in.o
>   CC      kernel/xenomai/arch/generic/hal.o
> In file included from /opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch=
/powerpc/include/asm/xenomai/hal.h:32,
>                  from kernel/xenomai/arch/generic/hal.c:47:
> include/asm-generic/xenomai/hal.h: In function 'rthal_get_cpufreq':
> include/asm-generic/xenomai/hal.h:176: error: 'struct ipipe_sysinfo' has =
no member named 'cpufreq'
> include/asm-generic/xenomai/hal.h: In function 'rthal_get_timerfreq':
> include/asm-generic/xenomai/hal.h:183: error: 'struct ipipe_sysinfo' has =
no member named 'archdep'
> In file included from kernel/xenomai/arch/generic/hal.c:47:

You did not specify which Xenomai release you are trying to build in
your kernel, but I guess it belongs to the 2.4.x series. You need to
upgrade to the 2.5.x series to support 2.6.34/powerpc. 2.5.3 is a
recommended.

> /opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h: In function 'rthal_get_active_mm':
> /opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h:109: error: 'ipipe_active_mm' undeclared
> (first use in this function)
> /opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h:109: error: (Each undeclared identifier is
> reported only once
> /opt/eldk/ppc_6xx/usr/src/linux-2.6.34-xenomai/arch/powerpc/include/asm/x=
enomai/hal.h:109: error: for each function it appears in.)
> kernel/xenomai/arch/generic/hal.c: In function 'rthal_add_proc_leaf':
> kernel/xenomai/arch/generic/hal.c:740: error: 'struct proc_dir_entry' has=
 no member named 'owner'
> kernel/xenomai/arch/generic/hal.c: In function 'rthal_proc_register':
> kernel/xenomai/arch/generic/hal.c:755: error: 'struct proc_dir_entry' has=
 no member named 'owner'
>=20
> I'ld really like to get the 2.34 kernel running because I managed to make=
 it running without Xenomai already, whereas 2.6.24 did not
> made it because of other problems with the board settings
>=20
> Any help would be very much appreciated
>=20
>   mit freundlichen Gr=C3=BC=C3=9Fen,
>   sincerely yours
>   sinc=C3=A8res salutations
>=20
> Peter Kuennemann
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



