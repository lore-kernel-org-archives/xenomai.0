MIME-Version: 1.0
In-Reply-To: <201301191235.11402.paul_c@tuxcnc.org>
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301190052.19037.paul_c@tuxcnc.org>
	<CALJOq=UhOuExbOd+SLXQahQZi4PL8xrUTo27VQoKNvdUuKbizQ@mail.gmail.com>
	<201301191235.11402.paul_c@tuxcnc.org>
From: Pierre LE COZ <peter.le.coz@gmail.com>
Date: Sat, 19 Jan 2013 16:46:10 +0100
Message-ID: <CALJOq=VS548FH3W_tWdmpW8kYu69ZaXM4WiYVQu1CTwep0VD3A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

> Add some debug messages in the areas you request resources and then use
> dmesg - The most likely source of error is either attempting to use a
> resource that has been claimed or not releasing when you have finished
> with it.
>

Here's my entire init :

static int __init exemple_init (void)
{
        int err;

        printk(KERN_INFO "Requesting GPIO %d\n",GPIO_IN);
                if((err =3D gpio_request_one(GPIO_IN, GPIOF_DIR_IN,
THIS_MODULE->name)) !=3D0) {
                printk(KERN_INFO "error %d: could not request gpio: %d\n",
err, GPIO_IN);
                return err;
        }

        printk(KERN_INFO "Setting the irq type to trigger rising\n");
        irq_set_irq_type(BUTTON_IRQ,  IRQF_TRIGGER_RISING);


        printk(KERN_INFO "Requesting irq %d\n", BUTTON_IRQ);
        if((err =3D rtdm_irq_request(& irq_exemple, BUTTON_IRQ,
exemple_handler, 0, THIS_MODULE->name,  NULL)) !=3D0) {
                printk(KERN_INFO "error %d: could not request irq: %d\n",
err, GPIO_IN);
                gpio_free(GPIO_IN);
                return err;
        }

        printk(KERN_INFO "Enabling irq %d\n", BUTTON_IRQ);

        // enable_irq(BUTTON_IRQ);
        rtdm_irq_enable(& irq_exemple);
        return 0;
}

The module is running well, but still no interrupt detected  :
# insmod rpi-rtdm.ko

Requesting GPIO 23
Setting the irq type to trigger rising
Requesting irq 108
Enabling irq 108
/MyDEV/06_GPIO_rtdm_livre # cat /proc/xenomai/irq
IRQ         CPU0
  3:        3491         [timer]
108:           0         rpi_rtdm
259:           0         [virtual]
/MyDEV/06_GPIO_rtdm_livre #

When replacing "rtdm_irq_enable(& irq_exemple);" with
"enable_irq(BUTTON_IRQ);" to try to enable the irq, the module fails :
# insmod rpi-rtdm.ko
Requesting GPIO 23
Setting the irq type to trigger rising
Requesting irq 108
Enabling irq 108
------------[ cut here ]------------
WARNING: at kernel/irq/manage.c:421 enable_irq+0x50/0x6c()
Unbalanced enable for IRQ 108
Modules linked in: rpi_rtdm(O+)
[<c00136bc>] (unwind_backtrace+0x0/0xe4) from [<c0021c6c>]
(warn_slowpath_common+0x4c/0x64)
[<c0021c6c>] (warn_slowpath_common+0x4c/0x64) from [<c0021d04>]
(warn_slowpath_fmt+0x2c/0x3c)
[<c0021d04>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0060c50>]
(enable_irq+0x50/0x6c)
[<c0060c50>] (enable_irq+0x50/0x6c) from [<bf0020b4>]
(exemple_init+0xb4/0xe0 [rpi_rtdm])
[<bf0020b4>] (exemple_init+0xb4/0xe0 [rpi_rtdm]) from [<c00086a8>]
(do_one_initcall+0x9c/0x17c)
[<c00086a8>] (do_one_initcall+0x9c/0x17c) from [<c0051a5c>]
(sys_init_module+0x1658/0x1830)
[<c0051a5c>] (sys_init_module+0x1658/0x1830) from [<c000dbe0>]
(ret_fast_syscall+0x0/0x30)
---[ end trace d3f5d198ddeaf1cf ]---


 About the fact that interrupts are not detected :

This may be a generic issue, which I thought was fixed, but may not be.
> Could you try the following patch?
>

http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommit;h=3Dc14c79d29fed822675=
60c7bf26d628ef4d39f5b7


Thank you Gilles for the patch. I tried it but I could not rebuild my
kernel :

  CC      arch/arm/kernel/ipipe.o
arch/arm/kernel/ipipe.c: In function =91ipipe_get_sysinfo=92:
arch/arm/kernel/ipipe.c:226:23: error: =91__ipipe_hrclock_freq=92 undeclare=
d
(first use in this function)
arch/arm/kernel/ipipe.c:226:23: note: each undeclared identifier is
reported only once for each function it appears in
arch/arm/kernel/ipipe.c: In function =91__switch_mm_inner=92:
arch/arm/kernel/ipipe.c:450:3: error: =91active_mm=92 undeclared (first use=
 in
this function)
arch/arm/kernel/ipipe.c:456:3: error: implicit declaration of function
=91__do_switch_mm=92
arch/arm/kernel/ipipe.c: In function =91deferred_switch_mm=92:
arch/arm/kernel/ipipe.c:486:3: error: =91active_mm=92 undeclared (first use=
 in
this function)
arch/arm/kernel/ipipe.c:492:3: error: implicit declaration of function
=91__deferred_switch_mm=92
arch/arm/kernel/ipipe.c: At top level:
arch/arm/kernel/ipipe.c:564:1: error: =91cpu_set_reserved_ttbr0=92 undeclar=
ed
here (not in a function)
arch/arm/kernel/ipipe.c:564:1: warning: type defaults to =91int=92 in
declaration of =91cpu_set_reserved_ttbr0=92
make[1]: *** [arch/arm/kernel/ipipe.o] Error 1
make: *** [arch/arm/kernel] Error 2
