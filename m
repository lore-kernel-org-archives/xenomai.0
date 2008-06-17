From: Michael <mwelling@domain.hid>
Date: Tue, 17 Jun 2008 15:21:26 -0500
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200806171521.26128.mwelling@domain.hid>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Blackfin BF-536 w/ Xenomai I-pipe Timer Issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I have run into a problem with reconfiguring the i-pipe timer on the a 
Blackfin BF-536 processor. The problem stems from having allocated TIMER0 to 
a be used as a PWM on a BF-536 based board. With this in mind I tried to 
modify the Linux kernel to use a different timer (TIMER7) for the i-pipe 
timer. Now when the board tries to boot the kernel it fails almost 
immediately. Here is a shot of the boot sequence.

CPU:   ADSP BF536 Rev.: 0.2
Board: Kryptic GCMB
Clock: VCO: 400 MHz, Core: 400 MHz, System: 80 MHz
SDRAM: 16 MB
FLASH:   4 MB
In:    serial
Out:   serial
Err:   serial
Using MAC Address 00:50:C2:0E:0D:9E
Net:    ADI BF53X EMAC
I2C:   ready
Hit any key to stop autoboot:  0
Using MAC Address 00:50:C2:0E:0D:9E
TFTP from server 10.0.2.131; our IP address is 10.0.2.75
Filename 'gcmb-vmImage'.
Load address: 0xa00000
Loading: #################################################################
         #################################################################
         ###########################################################
done
Bytes transferred = 967269 (ec265 hex)
## Booting image at 00a00000 ...
   Image Name:   Linux-2.6.19.3-ADI-2007R1-svn598
   Created:      2008-06-17  17:18:18 UTC
   Image Type:   Blackfin Linux Kernel Image (gzip compressed)
   Data Size:    967205 Bytes = 944.5 kB
   Load Address: 00001000
   Entry Point:  00001000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Starting Kernel at = 1000
Linux version 2.6.19.3-

It fails here and have not been able to get past this point. It looks as if 
the interrupt is not being handled properly.

The patches for modified files are shown below:
Index: arch/blackfin/mach-common/ints-priority-sc.c
===================================================================
--- arch/blackfin/mach-common/ints-priority-sc.c        (revision 598)
+++ arch/blackfin/mach-common/ints-priority-sc.c        (working copy)
@@ -839,8 +839,8 @@
        ipipe_load_cpuid();

        if (irq == IRQ_SYSTMR)
-           bfin_write_TIMER_STATUS(1); /* Latch TIMIL0 */
-
+           bfin_write_TIMER_STATUS(TIMIL6); /* Latch TIMIL6 */
+//         bfin_write_TIMER_STATUS(1); /* Latch TIMIL0 */
        /* This is basically what we need from the register frame. */
        __ipipe_irq_regs[cpuid].ipend = regs->ipend;
        __ipipe_irq_regs[cpuid].pc = regs->pc;
Index: include/asm-blackfin/ipipe.h
===================================================================
--- include/asm-blackfin/ipipe.h        (revision 598)
+++ include/asm-blackfin/ipipe.h        (working copy)
@@ -199,14 +199,17 @@

 #define IPIPE_TIMER_IRQ  IRQ_CORETMR

-#define IRQ_SYSTMR       IRQ_TMR0
+#define IRQ_SYSTMR       IRQ_TMR7
Index: arch/blackfin/kernel/time.c
===================================================================
--- arch/blackfin/kernel/time.c (revision 598)
+++ arch/blackfin/kernel/time.c (working copy)
@@ -149,15 +149,25 @@
        bfin_write_TCNTL(0);
        __builtin_bfin_csync();
        /* We use TIMER0 in PWM_OUT, periodic mode. */
-       bfin_write_TIMER_DISABLE(1);    /* Disable TIMER0 for now. */
+       //bfin_write_TIMER_DISABLE(1);    /* Disable TIMER0 for now. */
+       bfin_write_TIMER_DISABLE(1<<7);
+
        __builtin_bfin_ssync();
-       bfin_write_TIMER0_CONFIG(0x59); /* IRQ enable, periodic, PWM_OUT, 
SCLKed, OUT PAD disabled */
+       //bfin_write_TIMER0_CONFIG(0x59); /* IRQ enable, periodic, PWM_OUT, 
SCLKed, OUT PAD disabled */
+       bfin_write_TIMER7_CONFIG(0x59);
+
        __builtin_bfin_ssync();
-       bfin_write_TIMER0_PERIOD(get_sclk() / HZ);
+       //bfin_write_TIMER0_PERIOD(get_sclk() / HZ);
+       bfin_write_TIMER7_PERIOD(get_sclk() / HZ);
+
        __builtin_bfin_ssync();
-       bfin_write_TIMER0_WIDTH(1);
+       //bfin_write_TIMER0_WIDTH(1);
+       bfin_write_TIMER7_WIDTH(1);
+
        __builtin_bfin_ssync();
-       bfin_write_TIMER_ENABLE(1);     /* Enable TIMER0. */
+       //bfin_write_TIMER_ENABLE(1);     /* Enable TIMER0. */
+       bfin_write_TIMER_ENABLE(1<<7);
+
        __builtin_bfin_ssync();
 #else /* !CONFIG_IPIPE */
        u32 tcount;
@@ -201,8 +211,12 @@
        /* When the I-pipe is active, Linux uses TMR0 and not the core
           timer, which is then reserved to any real-time subsystem
           that may rely on Adeos for interrupt virtualization. */
-       clocks_per_jiffy =  bfin_read_TIMER0_PERIOD();
-       offset =  bfin_read_TIMER0_COUNTER() / (((clocks_per_jiffy + 1) * 
HZ) / USEC_PER_SEC);
+       //clocks_per_jiffy =  bfin_read_TIMER0_PERIOD();
+       clocks_per_jiffy =  bfin_read_TIMER7_PERIOD();
+
+       //offset =  bfin_read_TIMER0_COUNTER() / (((clocks_per_jiffy + 1) * 
HZ) / USEC_PER_SEC);
+       offset =  bfin_read_TIMER7_COUNTER() / (((clocks_per_jiffy + 1) * 
HZ) / USEC_PER_SEC);
+
 #else /* !CONFIG_IPIPE */
        clocks_per_jiffy = bfin_read_TPERIOD();
        offset =
Index: arch/blackfin/kernel/ipipe.c
===================================================================
--- arch/blackfin/kernel/ipipe.c        (revision 598)
+++ arch/blackfin/kernel/ipipe.c        (working copy)
@@ -415,16 +415,26 @@

        x = ipipe_critical_enter(NULL);

-       bfin_write_TIMER_DISABLE(1);
+       //bfin_write_TIMER_DISABLE(1);
+       bfin_write_TIMER_DISABLE(1<<7);
+
        __builtin_bfin_ssync();
-       bfin_write_TIMER0_CONFIG(0x59); /* IRQ enable, periodic, PWM_OUT, 
SCLKed, OUT PAD disabled */
+       //bfin_write_TIMER0_CONFIG(0x59);       /* IRQ enable, periodic, 
PWM_OUT, SCLKed, OUT PAD disabled */
+       bfin_write_TIMER7_CONFIG(0x59);
+
        __builtin_bfin_ssync();
        hz = (flags & IPIPE_RESET_TIMER) ? HZ : 1000000000L / ns;
-       bfin_write_TIMER0_PERIOD(get_sclk() / hz);
+       //bfin_write_TIMER0_PERIOD(get_sclk() / hz);
+       bfin_write_TIMER7_PERIOD(get_sclk() / hz);
+
        __builtin_bfin_ssync();
-       bfin_write_TIMER0_WIDTH(1);
+       //bfin_write_TIMER0_WIDTH(1);
+       bfin_write_TIMER7_WIDTH(1);
+
        __builtin_bfin_ssync();
-       bfin_write_TIMER_ENABLE(1);
+       //bfin_write_TIMER_ENABLE(1);
+       bfin_write_TIMER_ENABLE(1<<7);
+
        __builtin_bfin_ssync();

        ipipe_critical_exit(x);


Is there anything obvious that I am missing? Has this ever been attempted?

FYI
The ucLinux kernel is version 2.6.19.3-ADI-2007R1-svn598 patched with 
xenomai-2.3.1.

