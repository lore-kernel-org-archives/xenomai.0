From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <634c78ce0909250305t157d2d5br2601da181fbe998@domain.hid>
References: <634c78ce0909250117p2f7dfbdfx74fe2d22b84ab1ee@domain.hid>
	<634c78ce0909250305t157d2d5br2601da181fbe998@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Sep 2009 16:23:26 +0200
Message-Id: <1253888606.2819.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] compilation failure of hal_common.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Soetens <peter@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-09-25 at 12:05 +0200, Peter Soetens wrote:
> I'm trying to compile vanilla Linux 2.6.28.9 prepared with Xenomai
> 2.4.9.1 for x86-64, SMP.
>=20
> I get this error in hal_common.c:
>=20
> arch/x86/xenomai/hal-common.c:113:1: warning: "send_IPI_allbutself" red=
efined
> In file included from
> /home/kaltan/vbox/host/linux-2.6.28.9/arch/x86/include/asm/xenomai/hal_=
64.h:129,
>                 from
> /home/kaltan/vbox/host/linux-2.6.28.9/arch/x86/include/asm/xenomai/hal.=
h:75,
>                 from arch/x86/xenomai/hal-common.c:32:
> arch/x86/include/asm/mach-default/mach_ipi.h:42:1: warning: this is
> the location of the previous definition
> arch/x86/xenomai/hal-common.c: In function
> =E2=80=98rthal_broadcast_to_local_timers=E2=80=99:
> arch/x86/xenomai/hal-common.c:119: error: =E2=80=98apic=E2=80=99 undecl=
ared (first use
> in this function)
> arch/x86/xenomai/hal-common.c:119: error: (Each undeclared identifier
> is reported only once
> arch/x86/xenomai/hal-common.c:119: error: for each function it appears =
in.)
>=20

Right. There seems to be a slight adjustment to do in my code (also
reads "I badly screwed up, damn it").

diff --git a/ksrc/arch/x86/hal-common.c b/ksrc/arch/x86/hal-common.c
index 1497fee..7286987 100644
--- a/ksrc/arch/x86/hal-common.c
+++ b/ksrc/arch/x86/hal-common.c
@@ -107,7 +107,7 @@ static inline void send_IPI_allbutself(int vector)
 			  | vector);
 	rthal_local_irq_restore_hw(flags);
 }
-#elif defined(__i386__) && LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
 #include <mach_ipi.h>
 #else
 #define send_IPI_allbutself(vector)	apic->send_IPI_allbutself(vector)

Please let me know if that fixes the issue on your side as well.

PS: btw, I fail compiling 2.6.28.9 with KPROBES on, but this does not
look like a Xenomai issue this time.

> The macro is
> #define send_IPI_allbutself(vector)     apic->send_IPI_allbutself(vecto=
r)
>=20
> and used in
>=20
> DECLARE_LINUX_IRQ_HANDLER(rthal_broadcast_to_local_timers, irq, dev_id)
> {
> #ifdef CONFIG_SMP
>        send_IPI_allbutself(LOCAL_TIMER_VECTOR);
> #endif
>        rthal_trigger_irq(RTHAL_HOST_TICK_IRQ);
>        return IRQ_HANDLED;
> }
>=20
> I have no idea where apic is supposed to come from.
>=20
> .config attached for completeness.
>=20
> Peter
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



