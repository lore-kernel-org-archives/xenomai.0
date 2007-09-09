Message-ID: <1ce16a2c0709090730o1a803c99r70aea4410eda49ed@domain.hid>
Date: Sun, 9 Sep 2007 16:30:14 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
In-Reply-To: <1189285467.6013.20.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>
	<1189285467.6013.20.camel@domain.hid>
Subject: Re: [Xenomai-help] serial module problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi, after doing some modifications as mentioned in your patch I did
compile serial as module without problems.

My problem is now that I don't have any /dev/rtserX devices :(
Do I need that?

My goal is to get serial communication working with xenomai for
controlling devices.

Linux default serial support ain't builtin to kernel anymore.
I'm running
Linux sandbox 2.6.22 #14 Sun Sep 9 15:01:50 CEST 2007 i686 GNU/Linux

I've checked out xenomai using svn according to:
svn co http://svn.gna.org/svn/xenomai/trunk xenomai
Adeos:
adeos-ipipe-2.6.22-i386-1.10-03.patch

sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# insmod
./xeno_16550A.ko io=0x3f8,0xbc00 irq=4,3 tx_fifo=10,20 start_index=0
sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# ls /dev/rtser*
ls: /dev/rtser*: No such file or directory

But I do have:
sandbox:/lib/modules/2.6.22/kernel/drivers/xenomai/serial# find /proc/
| grep rtser
/proc/xenomai/rtdm/rtser1
/proc/xenomai/rtdm/rtser1/information
/proc/xenomai/rtdm/rtser0
/proc/xenomai/rtdm/rtser0/information

There's a serial example coming with xenomai, I'm unsure about
exactlly what it's supposed to do, or how I should use it. Would be
glad if somebody could explain more about how to use the serial ports
with xenomai driver.

with a crossed cable between serialport1 at mobo and serialport1 at
sunix4066 8port controllercard I get:

sandbox:/usr/src/xenomai/examples/rtdm/profiles/serial# ./cross-link
main : write-file opened
main : write-config written
main : read-file opened
main : read-config written
main : write-task created
main : read-task created
main : starting write-task
main : starting read-task
 Nr |   write->irq    |    irq->read    |   write->read   |
-----------------------------------------------------------
read_task: error on rt_dev_read, code Success
main : rtser1 (read) -> closed
read_task: exit

dmesg: http://pastebin.ca/688553
.config: http://pastebin.ca/688558


Any hints are welcome.
/Bachman


On 08/09/07, Philippe Gerum <rpm@xenomai.org> wrote:
> On Sat, 2007-09-08 at 20:59 +0200, Bachman Kharazmi wrote:
> > Hi
> > I'm a new xenomai user and would like to get the serial module working.
> >
>
> Which Xenomai version, which kernel release, which Adeos/I-pipe release?
>
> > I've 'builtin' serial support in my kernel, and tried to add a new
> > modified kernel line according to the docs which looks like:
> >
>
> Make sure CONFIG_XENO_DRIVERS_16550A is enabled in your kernel
> configuration, and vanilla serial support disabled.
>
> > kernel          /boot/maikern2 8250.nr_uarts=0
> > xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800 xeno_16550A.irq=4,3,3,3
> > xeno_16550A.baud_base=115200,115200,115200,115200 root=/dev/hda3 ro
> >
> > But when I boot my dmesg sais:
> > Kernel command line: 8250.nr_uarts=0
> > xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800 xeno_16550A.irq=4,3,3,3
> > xeno_16550A.baud_base=115200,115200,115200,115200 root=/dev/hda3 ro
> > Unknown boot option `xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800': ignoring
> >
> >
> > the serial example gives:
> > sandbox:/usr/src/xenomai/examples/rtdm/profiles/serial# ./cross-link
> > main : can't open rtser0 (write), No such device
> >
> >
> > I've tried to build the Serial support as a module instead, but it ends up in:
> > ERROR: "per_cpu__ipipe_percpu_daddr"
> > [drivers/xenomai/serial/xeno_16550A.ko] undefined!
> > when doing make bzImage modules.
> >
>
> I guess you might be using the latest Xenomai trunk/ with the latest
> Adeos/x86 patches from the 2.6.22/1.10 series then. Some new symbols
> have not been exported as they should in the latest Adeos release. The
> patch below fixes that.
>
> index 4d5bf61..08f4c33 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1577,6 +1577,7 @@ EXPORT_SYMBOL(ipipe_control_irq);
>  EXPORT_SYMBOL(ipipe_suspend_domain);
>  EXPORT_SYMBOL(ipipe_alloc_virq);
>  EXPORT_PER_CPU_SYMBOL(ipipe_percpu_domain);
> +EXPORT_PER_CPU_SYMBOL(ipipe_percpu_darray);
>  EXPORT_SYMBOL(ipipe_root);
>  EXPORT_SYMBOL(ipipe_stall_pipeline_from);
>  EXPORT_SYMBOL(ipipe_test_and_stall_pipeline_from);
> @@ -1597,6 +1598,7 @@ EXPORT_SYMBOL(__ipipe_lock_irq);
>  EXPORT_SYMBOL(__ipipe_unlock_irq);
>  #ifndef CONFIG_SMP
>  EXPORT_SYMBOL(__ipipe_root_status);
> +EXPORT_PER_CPU_SYMBOL(ipipe_percpu_daddr);
>  #endif
>  EXPORT_SYMBOL(ipipe_register_domain);
>  EXPORT_SYMBOL(ipipe_unregister_domain);
>
> This fix is now part of the next Adeos/x86 release:
>
> http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.22-i386-1.10-03.patch
>
>
> > Any help is welcome
> > /Bachman
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> --
> Philippe.
>
>
>

