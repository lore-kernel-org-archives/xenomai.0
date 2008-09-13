Message-ID: <48CB967B.3080203@domain.hid>
Date: Sat, 13 Sep 2008 12:31:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48CAACEF.3010902@domain.hid>
	<219129.74725.qm@domain.hid>
	<48CB648F.2090509@domain.hid>
In-Reply-To: <48CB648F.2090509@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] compile error xenomai 2.4.5
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> [ Don't start new topics by replying to unrelated ones! ]
>=20
> George Pitich wrote:
>> Tried to compile linux 2.6.26.5 kernel with xenomai 2.4.5 (also ran ./co=
nfigure --disable-x86-tsc --enable-x86-sep)
>>
>> ./prepare-kernel.sh  --arch=3Di386 --adeos=3D/usr/src/xenomai-2.4.5/ksrc=
/arch/x86/patches/adeos-ipipe-2.6.26-x86-2.0-09.patch --linux=3D/usr/src/li=
nux-2.6.26.5
>>
>> make gave the error:
>>
>> arch/x86/xenomai/hal_32.c: In function =E2rthal_latency_above_max=E2:
>> arch/x86/xenomai/hal_32.c:139: error: implicit declaration of function =
=E2die_nmi=E2
>> make[1]: *** [arch/x86/xenomai/hal_32.o] Error 1
>> make: *** [arch/x86/xenomai] Error 2
>=20
> That's an issue of the 2.6.26 ipipe patch. Philippe, you dropped the
> nmi_32.h hunk:
>

No I didn't, but the die_nmi() prototype is now different between the 32 an=
d 64bit
implementations; the i386 decl is missing. Here is the proper fix:

diff --git a/include/asm-x86/nmi.h b/include/asm-x86/nmi.h
index 765a6d6..f0fc7c5 100644
--- a/include/asm-x86/nmi.h
+++ b/include/asm-x86/nmi.h
@@ -42,6 +42,7 @@ extern void die_nmi(char *str, struct pt_regs *regs, int =
do_panic);
 extern void nmi_watchdog_default(void);
 #else
 #define nmi_watchdog_default() do {} while (0)
+extern void die_nmi(struct pt_regs *regs, const char *msg);
 #endif

 extern int check_nmi_watchdog(void);


> diff --git a/include/asm-x86/nmi_32.h b/include/asm-x86/nmi_32.h
> index 70a958a..da25e1c 100644
> --- a/include/asm-x86/nmi_32.h
> +++ b/include/asm-x86/nmi_32.h
> @@ -29,7 +29,8 @@ extern void setup_apic_nmi_watchdog (void *);
>  extern void stop_apic_nmi_watchdog (void *);
>  extern void disable_timer_nmi_watchdog(void);
>  extern void enable_timer_nmi_watchdog(void);
> -extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
> +extern int (*nmi_watchdog_tick)(struct pt_regs * regs, unsigned reason);
> +extern void die_nmi(struct pt_regs *, const char *msg);
>=20
>  extern atomic_t nmi_active;
>  extern unsigned int nmi_watchdog;
>=20
> Should be merged into the unified nmi.h now.
>=20
> George, in the meantime you can simply disable NMI watchdog support in
> Xenomai, and then the build should succeed again.
>=20
> Jan
>=20


--=20
Philippe.

