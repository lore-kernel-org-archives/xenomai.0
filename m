Message-ID: <478F51D9.4050704@domain.hid>
Date: Thu, 17 Jan 2008 14:02:17 +0100
From: Bernhard Michael <michael.bernhard@domain.hid>
MIME-Version: 1.0
References: <47891672.4050409@domain.hid>
	<2ff1a98a0801140752y5e6e47e2tb9980bfb344522a4@domain.hid>
	<478CAB5F.70208@domain.hid>
	<2ff1a98a0801150509w2dae4826r4696cd95c21aecb3@domain.hid>
	<478CBD27.4020501@domain.hid>
	<2ff1a98a0801150610n4404224bl98be4fcbccba70b7@domain.hid>
	<478DD90B.6020302@domain.hid>
	<2ff1a98a0801160249t7e4c1989i5ebde8e6b69d52e7@domain.hid>
	<478E1270.1000409@domain.hid>
	<2ff1a98a0801160635n2040f566mb1bdd464aaa017e4@domain.hid>
	<2ff1a98a0801160930w3b63bc5dyd89f8ec867a3ae35@domain.hid>
In-Reply-To: <2ff1a98a0801160930w3b63bc5dyd89f8ec867a3ae35@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai problems on pxa
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

Gilles Chanteperdrix wrote:
> I tested it on another arm (without EABI, so I can not know if it
> works), and there is at least no regression.
 
I tested it too with the EABI toolchain and its working. Thank you
Gilles for your help.

To sum up, here are the necessary ipipe changes to get xenomai running
on pxa (compiled with an EABI toolchain). 

Kernel: 2.6.20, 
Adeos/Ipipe patch: ipipe-2.6.20-arm-1.8-03

Align the stack pointer to 8-byte boundary:

--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -216,11 +216,12 @@ ENTRY(vector_swi)
        stmdb   sp!, {r4, r5}                   @ push fifth and sixth args
 #ifdef CONFIG_IPIPE
        stmfd   sp!, {r0-r3, ip}
-       add     r1, sp, #S_OFF
-       add     r1, r1, #20
+       add     r1, sp, #S_OFF + 20
+       sub     sp, sp, #4
        mov     r0, scno
        bl      __ipipe_syscall_root
        cmp     r0, #0
+       add     sp, sp, #4
        ldmfd   sp!, {r0-r3, ip}
        blt     __ipipe_ret_fast_syscall
        bgt     __ipipe_fast_exit_syscall

Initialise local variable last_jiffy_time:

--- a/arch/arm/mach-pxa/time.c
+++ b/arch/arm/mach-pxa/time.c
@@ -199,7 +199,8 @@ static void __init pxa_timer_init(void)
        setup_irq(IRQ_OST0, &pxa_timer_irq);
        local_irq_save(flags);
        OIER = OIER_E0;         /* enable match on timer 0 to cause interrupts */
-       OSMR0 = OSCR + LATCH;   /* set initial match */
+       last_jiffy_time = OSCR; /* initialize last_jiffy_time */
+       OSMR0 = last_jiffy_time + LATCH; /* set initial match */
        local_irq_restore(flags);

        /*

The second change needs to be applied to ipipe-2.6.15-arm-1.5-08 as well.

Well, that's it. Thanks again.

--
Michael

