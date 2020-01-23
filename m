MIME-Version: 1.0
References: <CAPm8-H6oDc4NogRLTFvi7-9vOv=a2OGE=fiRib1yUEOyR-rsAQ@mail.gmail.com>
 <CALLqZ8Qa1+WLUQHw7woNOJZGgjmhkjms+QYLpT9ggnD47XsUog@mail.gmail.com>
 <CAPm8-H6rz3ArzOcYas1mQyYfw-njGfQwZGriQz3Hrg5MdU9+vg@mail.gmail.com>
In-Reply-To: <CAPm8-H6rz3ArzOcYas1mQyYfw-njGfQwZGriQz3Hrg5MdU9+vg@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 23 Jan 2020 13:13:31 -0500
Message-ID: <CALLqZ8TtxHc-hsqkKMx2iX1_GZftFOEFnLSYH37UJVs4d5VM8A@mail.gmail.com>
Subject: Re: system freeze - beaglebone black xenomai - gpio interrupts driver
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,

On Thu, Jan 23, 2020 at 12:15 PM Laurentiu-Cristian Duca
<laurentiu.duca@gmail.com> wrote:
>
> Hi, the interrupt comes one per second in my test, so there is no flood. In 4.19 the system it blinks the gpioout but it does not respond to keyboard and does not show anything more on the screen.

Okay, there's a couple things that are different between 4.4 and 4.19
that I'm looking into, which is taking me a little long then I
thought.  I won't have this patch ready till tomorrow morning.  I
finally have beaglebone black hardware, I'll make sure the kernel
boots and then send the patch to you for testing.

-Greg


>
> On Thu, Jan 23, 2020, 19:03 Greg Gallagher <greg@embeddedgreg.com> wrote:
>>
>> Hi,
>>
>> On Thu, Jan 23, 2020 at 9:21 AM Laurentiu-Cristian Duca via Xenomai
>> <xenomai@xenomai.org> wrote:
>> >
>> > Hello xenomai community,
>> >
>> >     I have successfully tested in xenomai SPI with interrupts on bbb.
>> > However, on bbb, if I try to test a basic gpio interrupts driver,
>> > problems appear.
>> >     Please see details below. I appreciate any idea.
>> >
>> > 1. xenomai-3 master linux 4.19.82, default dts
>> > # insmod xeno_osc-gpio-rtdm.ko
>> > [  105.582245]  IRQ number 62 !
>> > [  105.585976] after request irq = 62
>> > System freeze when first interrupt occurs and I must power off.
>> Is it possible to use raw_printk and see if the system is still
>> working but possibly getting flooded by interrupts?  When I
>> encountered this issue with the BCM2835 port I placed a raw_printk in
>> one of the functions that initially handles the interrupt to see if it
>> was being ack'd.
>> >
>> >
>> > 2. xenomai 3.0.5 linux 4.4.71, default dts
>> > # insmod xeno_osc-gpio-rtdm.ko
>> > [   39.901907]  IRQ number 142 !
>> > [   39.905447] after request irq = 142
>> >
>> > When first interrupt occurs:
>> > [  322.104560] irq 142, desc: df15e500, depth: 1, count: 0, unhandled: 0
>> > [  322.111310] ->handle_irq():  c00998b4, handle_edge_irq+0x0/0x168
>> > [  322.117606] ->irq_data.chip(): df156710, 0xdf156710
>> > [  322.122702] ->action():   (null)
>> > [  322.126067]    IRQ_NOPROBE set
>> > [  322.129252] unexpected IRQ trap at vector 8e
>> > [  322.133706] ------------[ cut here ]------------
>> > [  322.138530] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:843
>> > __ipipe_ack_bad_irq+0x24/0x3c()
>> > [  322.147244] Modules linked in: xeno_osc_gpio_rtdm(O)
>> > [  322.152444] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O
>> > 4.4.71-ipipe #1
>> > [  322.160434] Hardware name: Generic AM33XX (Flattened Device Tree)
>> > [  322.166791] I-pipe domain: Linux
>> > [  322.170175] [<c0017bf4>] (unwind_backtrace) from [<c0013d58>]
>> > (show_stack+0x10/0x14)
>> > [  322.178273] [<c0013d58>] (show_stack) from [<c0368a0c>]
>> > (dump_stack+0x9c/0xc4)
>> > [  322.185829] [<c0368a0c>] (dump_stack) from [<c003d168>]
>> > (warn_slowpath_common+0x78/0xb4)
>> > [  322.194280] [<c003d168>] (warn_slowpath_common) from [<c003d240>]
>> > (warn_slowpath_null+0x1c/0x24)
>> > [  322.203455] [<c003d240>] (warn_slowpath_null) from [<c00991a8>]
>> > (__ipipe_ack_bad_irq+0x24/0x3c)
>> > [  322.212542] [<c00991a8>] (__ipipe_ack_bad_irq) from [<c00df9b4>]
>> > (__ipipe_dispatch_irq+0x78/0x1d8)
>> > [  322.221903] [<c00df9b4>] (__ipipe_dispatch_irq) from [<c03a3948>]
>> > (omap_gpio_irq_handler+0x134/0x1a4)
>> > [  322.231532] [<c03a3948>] (omap_gpio_irq_handler) from [<c0095b1c>]
>> > (handle_irq_event_percpu+0xa4/0x304)
>> > [  322.241341] [<c0095b1c>] (handle_irq_event_percpu) from
>> > [<c0095db4>] (handle_irq_event+0x38/0x5c)
>> > [  322.250605] [<c0095db4>] (handle_irq_event) from [<c0099858>]
>> > (handle_level_irq+0x88/0xe4)
>> > [  322.259235] [<c0099858>] (handle_level_irq) from [<c0095198>]
>> > (generic_handle_irq+0x20/0x34)
>> > [  322.268045] [<c0095198>] (generic_handle_irq) from [<c009547c>]
>> > (__handle_domain_irq+0x64/0xd4)
>> > [  322.277127] [<c009547c>] (__handle_domain_irq) from [<c00df228>]
>> > (__ipipe_do_sync_stage+0x21c/0x25c)
>> > [  322.286665] [<c00df228>] (__ipipe_do_sync_stage) from [<c00093e4>]
>> > (__ipipe_grab_irq+0x5c/0x7c)
>> > [  322.295753] [<c00093e4>] (__ipipe_grab_irq) from [<c06462f4>]
>> > (__irq_svc+0x54/0x60)
>> > [  322.303745] Exception stack(0xc0937f58 to 0xc0937fa0)
>> > [  322.309017] 7f40:
>> >     00000000 df91d240
>> > [  322.317556] 7f60: 00000000 00000000 c092e240 c0938a24 00000000
>> > c09f4c3c c09389c4 00000001
>> > [  322.326095] 7f80: c064d88c 00000000 00000000 c0937fa8 c0080f04
>> > c00df35c 60000013 ffffffff
>> > [  322.334634] [<c06462f4>] (__irq_svc) from [<c00df35c>]
>> > (ipipe_unstall_root+0x38/0x50)
>> > [  322.342822] [<c00df35c>] (ipipe_unstall_root) from [<c0080f04>]
>> > (cpu_startup_entry+0x68/0x2b8)
>> > [  322.351826] [<c0080f04>] (cpu_startup_entry) from [<c08b0c28>]
>> > (start_kernel+0x370/0x3e8)
>> > [  322.360361] ---[ end trace 3de49b4cee31ba0b ]---
>> >
>> > When other interrupts occur:
>> > [  322.365188] irq 142, desc: df15e500, depth: 1, count: 0, unhandled: 0
>> > [  322.371908] ->handle_irq():  c00998b4, handle_edge_irq+0x0/0x168
>> > [  322.378183] ->irq_data.chip(): df156710, 0xdf156710
>> > [  322.383277] ->action():   (null)
>> > [  322.386641]    IRQ_NOPROBE set
>> > [  322.389825] unexpected IRQ trap at vector 8e
>> > [  324.664939] irq 142, desc: df15e500, depth: 1, count: 0, unhandled: 0
>> > [  324.671684] ->handle_irq():  c00998b4, handle_edge_irq+0x0/0x168
>> > [  324.677980] ->irq_data.chip(): df156710, 0xdf156710
>> > [  324.683077] ->action():   (null)
>> > [  324.686442]    IRQ_NOPROBE set
>> > ...
>> >
>> >
>> >
>> > 3. Source code of the basic gpio interrupt driver:
>> >
>> > #include <linux/fs.h>
>> > #include <linux/gpio.h>
>> > #include <linux/interrupt.h>
>> > #include <linux/module.h>
>> >
>> > #include <rtdm/driver.h>
>> >
>> >
>> > static unsigned int irq_num;
>> > // bbb gpios that work on PREEMPT_RT linux 4.19.59 and 5.4.5 with default dts
>> > static unsigned int gpio_out = 48;
>> > static unsigned int gpio_in = 115;
>> > static bool value = false;
>> > static rtdm_irq_t irq_handle;
>> > static int num_of_intr = 0;
>> >
>> >
>> > static int gpio_irq_handler(rtdm_irq_t * irq)
>> > {
>> >     value = !value;
>> >     gpio_set_value(gpio_out, value); // toggle the led everytime irq
>> > handler is invoked
>> >     trace_printk("GPIO interrupt \n");
>> >     num_of_intr++;
>> >     return RTDM_IRQ_HANDLED;
>> > }
>> >
>> >
>> > static int __init rtdm_init (void)
>> > {
>> >     int err;
>> >
>> >     if ((err = gpio_request(gpio_in, THIS_MODULE->name)) != 0) {
>> >         printk(" gpio_request gpio_in failed ! \n");
>> >         return err;
>> >     }
>> >
>> >     if ((err = gpio_direction_input(gpio_in)) != 0) {
>> >         printk(" gpio_direction_input gpio_in failed ! \n");
>> >         gpio_free(gpio_in);
>> >
>> >         return err;
>> >     }
>> >
>> >     irq_num = gpio_to_irq(gpio_in);
>> >
>> >     printk(" IRQ number %d !  \n",irq_num);
>> >
>> >     if ((err = gpio_request(gpio_out, THIS_MODULE->name)) != 0) {
>> >         printk(" gpio_request gpio_out failed ! \n");
>> >         gpio_free(gpio_in);
>> >         return err;
>> >     }
>> >
>> >     if ((err = gpio_direction_output(gpio_out, 0)) != 0) {
>> >         printk(" gpio_direction_input gpio_out failed ! \n");
>> >         gpio_free(gpio_out);
>> >         gpio_free(gpio_in);
>> >         return err;
>> >     }
>> >
>> >     err = irq_set_irq_type(irq_num,  IRQF_TRIGGER_RISING);
>> >
>> >     if(err) {
>> >         gpio_free(gpio_out);
>> >         gpio_free(gpio_in);
>> >         printk(" irq_set_irq_type failed ! \n");
>> >         return err;
>> >     }
>> >
>> >     err = rtdm_irq_request(&irq_handle,irq_num,(rtdm_irq_handler_t)gpio_irq_handler,
>> >                 RTDM_IRQTYPE_EDGE,THIS_MODULE->name, NULL);
>> >
>> >     printk("after request irq = %d \n",irq_handle.irq);
>> >
>> >     if(err) {
>> >         gpio_free(gpio_out);
>> >         gpio_free(gpio_in);
>> >         printk(" rtdm_irq_request failed ! \n");
>> >         return err;
>> >     }
>> >
>> >     err = rtdm_irq_enable(&irq_handle);
>> >
>> >     if (err < 0) {
>> >         printk("rtdm_irq_enable failed \n");
>> >         return err;
>> >     }
>> >     return 0;
>> >
>> >
>> > }
>> >
>> >
>> >
>> > static void __exit rtdm_exit (void)
>> > {
>> >     rtdm_irq_free(&irq_handle);
>> >     gpio_free(gpio_out);
>> >     gpio_free(gpio_in);
>> >
>> >     printk("The number of intr is %d \n",num_of_intr);
>> > }
>> >
>> >
>> > module_init(rtdm_init);
>> > module_exit(rtdm_exit);
>> > MODULE_LICENSE("GPL");
>> >
>> >
>> > Thank you,
>> > L-C Duca
>> >
>> My above comments would be good to start debugging the issue.  Looking
>> at the ipipe trees I think we are missing some ipipe things in the
>> GPIO driver from 4.4 to 4.19.  When I diff the files it looks like
>> there are some things missing in 4.19.  I can make a patch for you to
>> try, I'll have it ready shortly.
>>
>> -Greg

