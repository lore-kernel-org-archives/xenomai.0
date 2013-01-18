MIME-Version: 1.0
In-Reply-To: <201301182211.27006.paul_c@tuxcnc.org>
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301182211.27006.paul_c@tuxcnc.org>
From: Pierre LE COZ <peter.le.coz@gmail.com>
Date: Sat, 19 Jan 2013 00:47:16 +0100
Message-ID: <CALJOq=Vy2eqfikHRzxwxs=yC4sXp=cChC76Q4ZNfs8GudpSAdg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Thank you Gilles and Paul for your quick reply and your help !

I've checked my bcm2708_gpio.c, and in fact, the call to
ipipe_handle_demuxed_Igor() misses.


> In the meantime, in kernel space, use the following
> calls in conjunction with rtdm_irq_request:
>
>         // To enable an interrupt.
>         gpio_request_one(gpio_pin, GPIOF_DIR_IN, "module name");
>         irq_number = gpio_to_irq(gpio_pin);
>         irq_set_irq_type(irq_number,  IRQF_TRIGGER_RISING);
>         enable_irq(irq_number);
>
>
>         // To disable an interrupt and clean up.
>         disable_irq(irq_number);
>         free_irq(irq_number, NULL);
>         gpio_free(gpio_pin);
>

I tried it. Here is my code :

        rtdm_irq_request(& irq_exemple, num_irq, exemple_handler,
RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE,THIS_MODULE->name, NULL);

         gpio_request_one(GPIO_IN, GPIOF_DIR_IN, THIS_MODULE->name);
        irq_set_irq_type(num_irq,  IRQF_TRIGGER_RISING);
        enable_irq(num_irq);

        return 0;
}

But here is what I get :

# insmod rpi-rtdm.ko
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
[<c0060c50>] (enable_irq+0x50/0x6c) from [<bf0020a8>]
(exemple_init+0xa8/0xbc [rpi_rtdm])
[<bf0020a8>] (exemple_init+0xa8/0xbc [rpi_rtdm]) from [<c00086a8>]
(do_one_initcall+0x9c/0x17c)
[<c00086a8>] (do_one_initcall+0x9c/0x17c) from [<c0051a5c>]
(sys_init_module+0x1658/0x1830)
[<c0051a5c>] (sys_init_module+0x1658/0x1830) from [<c000dbe0>]
(ret_fast_syscall+0x0/0x30)
---[ end trace 6358198229f2f036 ]---

So do I need to rebuild my entire system after patching my bcm2708_gpio.c ?

Or, I am doing something wrong with the lines of code that Paul gave me?

Pierre
