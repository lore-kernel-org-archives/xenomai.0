From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>
References: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>
Content-Type: text/plain
Date: Sat, 08 Sep 2007 23:04:27 +0200
Message-Id: <1189285467.6013.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] serial module problems
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
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: xenomai@xenomai.org

On Sat, 2007-09-08 at 20:59 +0200, Bachman Kharazmi wrote:
> Hi
> I'm a new xenomai user and would like to get the serial module working.
> 

Which Xenomai version, which kernel release, which Adeos/I-pipe release?

> I've 'builtin' serial support in my kernel, and tried to add a new
> modified kernel line according to the docs which looks like:
> 

Make sure CONFIG_XENO_DRIVERS_16550A is enabled in your kernel
configuration, and vanilla serial support disabled.

> kernel          /boot/maikern2 8250.nr_uarts=0
> xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800 xeno_16550A.irq=4,3,3,3
> xeno_16550A.baud_base=115200,115200,115200,115200 root=/dev/hda3 ro
> 
> But when I boot my dmesg sais:
> Kernel command line: 8250.nr_uarts=0
> xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800 xeno_16550A.irq=4,3,3,3
> xeno_16550A.baud_base=115200,115200,115200,115200 root=/dev/hda3 ro
> Unknown boot option `xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800': ignoring
> 
> 
> the serial example gives:
> sandbox:/usr/src/xenomai/examples/rtdm/profiles/serial# ./cross-link
> main : can't open rtser0 (write), No such device
> 
> 
> I've tried to build the Serial support as a module instead, but it ends up in:
> ERROR: "per_cpu__ipipe_percpu_daddr"
> [drivers/xenomai/serial/xeno_16550A.ko] undefined!
> when doing make bzImage modules.
> 

I guess you might be using the latest Xenomai trunk/ with the latest
Adeos/x86 patches from the 2.6.22/1.10 series then. Some new symbols
have not been exported as they should in the latest Adeos release. The
patch below fixes that.

index 4d5bf61..08f4c33 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1577,6 +1577,7 @@ EXPORT_SYMBOL(ipipe_control_irq);
 EXPORT_SYMBOL(ipipe_suspend_domain);
 EXPORT_SYMBOL(ipipe_alloc_virq);
 EXPORT_PER_CPU_SYMBOL(ipipe_percpu_domain);
+EXPORT_PER_CPU_SYMBOL(ipipe_percpu_darray);
 EXPORT_SYMBOL(ipipe_root);
 EXPORT_SYMBOL(ipipe_stall_pipeline_from);
 EXPORT_SYMBOL(ipipe_test_and_stall_pipeline_from);
@@ -1597,6 +1598,7 @@ EXPORT_SYMBOL(__ipipe_lock_irq);
 EXPORT_SYMBOL(__ipipe_unlock_irq);
 #ifndef CONFIG_SMP
 EXPORT_SYMBOL(__ipipe_root_status);
+EXPORT_PER_CPU_SYMBOL(ipipe_percpu_daddr);
 #endif
 EXPORT_SYMBOL(ipipe_register_domain);
 EXPORT_SYMBOL(ipipe_unregister_domain);

This fix is now part of the next Adeos/x86 release:

http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-i386-1.10-03.patch


> Any help is welcome
> /Bachman
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



