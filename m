MIME-Version: 1.0
In-Reply-To: <CALLqZ8SPSBYFwk7NXxeumepsQkxJLVf=yMg9SGz5L9=VmcoNTQ@mail.gmail.com>
References: <paidvn7iib5il2ch6f5si5v4.1520251853430@embeddedgreg.com>
 <60614.147.91.1.42.1520428526.squirrel@mail.imp.bg.ac.rs>
 <CALLqZ8QpjWWkj7Ra82CX3Bh52rQaUzsJvkf3b9hRoTKTuFBePA@mail.gmail.com>
 <41185.147.91.1.43.1520506417.squirrel@mail.imp.bg.ac.rs>
 <CALLqZ8SPSBYFwk7NXxeumepsQkxJLVf=yMg9SGz5L9=VmcoNTQ@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 15 Mar 2018 16:01:51 -0400
Message-ID: <CALLqZ8SNPdK7Zgw4oB6zoNTE3FQ1iCvuWiFLdD2KZpCorxhoiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] interrupt on edge problem, unexpected IRQ trap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: branislav.sasic@automatika.imp.bg.ac.rs
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Using the 4.14 arm ipipe tree, xenomai stable 3.0.x (from git) I was
able to receive an interrupt, if you are still having issues can you
try the below code?  Obviously modify the pin values to the pins you
require.

static unsigned int irq_num;
static unsigned int gpioLED = 953;
static unsigned int gpioButton = 957;
static bool value = false;
static rtdm_irq_t irq_handle;
static int num_of_intr = 0;


static int gpio_irq_handler(rtdm_irq_t * irq)
{
    value = !value;
    gpio_set_value(gpioLED, value); // toggle the led everytime irq
handler is invoked
    printk("GPIO interrupt \n");
    num_of_intr++;
    return RTDM_IRQ_HANDLED;
}


static int __init rtdm_init (void)
{
    int err;

    if ((err = gpio_request(gpioButton, THIS_MODULE->name)) != 0) {
        printk(" gpio_request gpioButton failed ! \n");
        return err;
    }

    if ((err = gpio_direction_input(gpioButton)) != 0) {
        printk(" gpio_direction_input gpioButton failed ! \n");
        gpio_free(gpioButton);

        return err;
    }

    irq_num = gpio_to_irq(gpioButton);

    printk(" IRQ number %d !  \n",irq_num);

    if ((err = gpio_request(gpioLED, THIS_MODULE->name)) != 0) {
        printk(" gpio_request gpioLED failed ! \n");
        gpio_free(gpioButton);
        return err;
    }

    if ((err = gpio_direction_output(gpioLED, 0)) != 0) {
        printk(" gpio_direction_input gpioLED failed ! \n");
        gpio_free(gpioLED);
        gpio_free(gpioButton);
        return err;
    }

    err = irq_set_irq_type(irq_num,  IRQF_TRIGGER_RISING);

    if(err) {
        gpio_free(gpioLED);
        gpio_free(gpioButton);
        printk(" irq_set_irq_type failed ! \n");
        return err;
    }

    err = rtdm_irq_request(&irq_handle,irq_num,(rtdm_irq_handler_t)gpio_irq_handler,
RTDM_IRQTYPE_EDGE,THIS_MODULE->name, NULL);

    printk("after request irq = %d \n",irq_handle.irq);

    if(err) {
        gpio_free(gpioLED);
        gpio_free(gpioButton);
        printk(" rtdm_irq_request failed ! \n");
        return err;
    }

    err = rtdm_irq_enable(&irq_handle);

    if (err < 0) {
        printk("rtdm_irq_enable failed \n");
        return err;
    }
    return 0;


}



static void __exit rtdm_exit (void)
{
    rtdm_irq_free(&irq_handle);
    gpio_free(gpioLED);
    gpio_free(gpioButton);

    printk("The number of intr is %d \n",num_of_intr);
}


module_init(rtdm_init);
module_exit(rtdm_exit);
MODULE_LICENSE("GPL");

On Thu, Mar 8, 2018 at 10:39 AM, Greg Gallagher <greg@embeddedgreg.com> wrote:
> I'll have to run this on my known working set up and see what I can
> find.  The only difference between gpio-core and your file is
> gpio-core uses the same label in the gpio_request and the
> rtdm_irq_request.  For fun you can try to pass "gpio203" to
> rtdm_irq_request. I'll have to take a deeper look at what's happening
> in cobalt.
>
> -Greg
>
> On Thu, Mar 8, 2018 at 5:53 AM,
> <branislav.sasic@automatika.imp.bg.ac.rs> wrote:
>> In attachment is example kernel module code that work when used
>> request_irq but not with rtdm_irq_request.
>> I need to measure time intervals between signal edges and to do some
>> processing inside that module. This worked fine on 3.14 kernel on
>> BeagleBone with Xenomai 2.6.x. Now, on NanoPi NEO (4.14, xenomai 3.0.6) it
>> seams it doesn't work.
>>
>>
>> Branislav
>>
>>
>>> I'd have to see more of the code to understand how you are setting
>>> that up.  If you look at the rtdm gpio code that is in Xenomai
>>> (kernel/drivers/gpio/gpio-core.c) that would be a good example to work
>>> from.  Are you planning on using the gpio pins from user space or from
>>> another rtdm driver?  IF you want to use them via user space there are
>>> better and quicker approaches then creating a custom RTDM driver.
>>>
>>> -Greg
>>>
>>> On Wed, Mar 7, 2018 at 8:15 AM,
>>> <branislav.sasic@automatika.imp.bg.ac.rs> wrote:
>>>> Thank you.
>>>> Meanwhile, I tried ipipe-arm kernel with latest xenomai from git on
>>>> NanoPi-NEO. Interrupts configured from sysfs interface works, doesn't
>>>> display any message, but when requested with rtdm_irq_request
>>>>
>>>> //request_irq(irq, irig_r_isr_test, 0, DRIVER_NAME, NULL); //this works
>>>> rtdm_irq_request(&irq_handle, irq, irig_r_isr_test, RTDM_IRQTYPE_EDGE,
>>>> DRIVER_NAME, NULL); //this not
>>>> irq_set_irq_type(irq, IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING);
>>>> rtdm_irq_enable(&irq_handle);
>>>>
>>>> sunxi_pinctrl_irq_handler(struct irq_desc *desc) routine never get
>>>> called.
>>>>
>>>>
>>>> Branislav
>>>>
>>>>
>>>>> I should have access to a beaglebone green this week. I wasn't able to
>>>>> reproduce it with a zynq or raspberry Pi 2 board.
>>>>>
>>>>> Greg
>>>>>
>>>>>
>>>>>
>>>>>   Original Message
>>>>> From: branislav.sasic@automatika.imp.bg.ac.rs
>>>>> Sent: March 5, 2018 3:24 AM
>>>>> To: branislav.sasic@automatika.imp.bg.ac.rs
>>>>> Cc: xenomai@xenomai.org
>>>>> Subject: Re: [Xenomai] interrupt on edge problem, unexpected IRQ trap
>>>>>
>>>>> Nothing? :|
>>>>>
>>>>>
>>>>>> Thank you for your help Greg & Philippe!
>>>>>>
>>>>>> I merged gpio-omap.c from 4.14 kernel to my 4.11 kernel, result is
>>>>>> freezed
>>>>>> cpu after interrupt. Then, I compiled 4.14 latest ipipe-arm kernel
>>>>>> from
>>>>>> git (nothing added, nothing removed), and similar thing happens. Only
>>>>>> I
>>>>>> could see some time after, until complete freeze, are messages
>>>>>>
>>>>>> [   62.463002] unexpected IRQ trap at vector 3f
>>>>>> [   63.643847] unexpected IRQ trap at vector 3f
>>>>>> [   63.648204] unexpected IRQ trap at vector 3f
>>>>>> [   65.605123] unexpected IRQ trap at vector 3f
>>>>>> [   66.418225] unexpected IRQ trap at vector 3f
>>>>>>
>>>>>> Tested through sysfs gpio interface.
>>>>>>
>>>>>>
>>>>>> Branislav
>>>>>>
>>>>>>
>>>>>>
>>>>>>> As Philippe mentioned, they are some missing pieces that need to be
>>>>>>> added to the ipipe.  The link Philippe provided will give you
>>>>>>> guidance
>>>>>>> on how to make those changes to your custom kernel.  The other option
>>>>>>> is you could use the ipipe-arm tree and the mainline kernel.  Also,
>>>>>>> unrelated, the gpios that are exposed in sysfs are not RTDM gpios.
>>>>>>> There currently isn't a RTDM driver for beaglebone gpio, but one can
>>>>>>> be added very easily.
>>>>>>>
>>>>>>>
>>>>>>> -Greg
>>>>>>>
>>>>>>> On Mon, Feb 26, 2018 at 1:05 PM,
>>>>>>> <branislav.sasic@automatika.imp.bg.ac.rs> wrote:
>>>>>>>> Xenomai 3.0.6, and ipipe-core-4.9.51-arm-3, patched on sunxi 4.11.2
>>>>>>>> kernel
>>>>>>>> (with BeagleBone patches applied too). Same situation with this
>>>>>>>> kernel
>>>>>>>> ->
>>>>>>>> https://github.com/beagleboard/linux/tree/4.9-xenomai
>>>>>>>>
>>>>>>>>
>>>>>>>> Just as Giulio wrote, GPIO is configured with:
>>>>>>>>
>>>>>>>> echo 60 > /sys/class/gpio/export
>>>>>>>> echo both > /sys/class/gpio/gpio60/edge
>>>>>>>>
>>>>>>>> or in kernel module init routine with:
>>>>>>>>
>>>>>>>> gpio_request(gpio, "test");
>>>>>>>> gpio_direction_input(gpio);
>>>>>>>> irq = gpio_to_irq(gpio);
>>>>>>>> irq_set_irq_type(irq, IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING);
>>>>>>>> rtdm_irq_request(&irq_handle, irq, test_isr, RTDM_IRQTYPE_EDGE,
>>>>>>>> DRIVER_NAME, NULL);
>>>>>>>> rtdm_irq_enable(&irq_handle);
>>>>>>>>
>>>>>>>>
>>>>>>>> Both reproduce the problem. In the second case, when requested with
>>>>>>>> rtdm_irq_request, IRQ is visible both in /proc/interrupts, and in
>>>>>>>> /proc/xenomai/irq
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks!
>>>>>>>>
>>>>>>>>
>>>>>>>> Branislav
>>>>>>>>
>>>>>>>>
>>>>>>>>> Can you provide what version of Xenomai you are using and what
>>>>>>>>> ipipe
>>>>>>>> patch you are using?  It also may be helpful if you could provide
>>>>>>>> some
>>>>>>>> sort of sample code that reproduces the problem.
>>>>>>>>>
>>>>>>>>> -Greg
>>>>>>>>>
>>>>>>>>> On Mon, Feb 26, 2018 at 8:46 AM,
>>>>>>>>> <branislav.sasic@automatika.imp.bg.ac.rs> wrote:
>>>>>>>>>> Hello,
>>>>>>>>>> I have a problem with new I-pipe patch, which was not existing
>>>>>>>>>> with
>>>>>>>>>> legacy
>>>>>>>>>> patch on 3.14 kernel, on BeagleBone platform.
>>>>>>>>>> When GPIO pin is configured as input with edge interrupt enable,
>>>>>>>>>> on
>>>>>>>>>> IRQ
>>>>>>>> occurrence the following message appears:
>>>>>>>>>> [  303.331386] irq 88, desc: dc1be400, depth: 0, count: 0,
>>>>>>>>>> unhandled:
>>>>>>>>>> 0
>>>>>>>> [  303.331401] ->handle_irq():  c01a810c,
>>>>>>>>>> [  303.331435] handle_edge_irq+0x0/0x194
>>>>>>>>>> [  303.331442] ->irq_data.chip(): dc097b50,
>>>>>>>>>> [  303.331454] 0xdc097b50
>>>>>>>>>> [  303.331461] ->action(): da097380
>>>>>>>>>> [  303.331467] ->action->handler(): c078dce4,
>>>>>>>>>> [  303.331483] gpio_sysfs_irq+0x0/0x24
>>>>>>>>>> [  303.331493]    IRQ_NOPROBE set
>>>>>>>>>> [  303.331503] unexpected IRQ trap at vector 58
>>>>>>>>>> [  303.335814] ------------[ cut here ]------------
>>>>>>>>>> [  303.335832] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:883
>>>>>>>>>> __ipipe_ack_bad_irq+0x3c/0x48
>>>>>>>>>> [  303.335839] Modules linked in:
>>>>>>>>>> [  303.335863] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.82 #2
>>>>>>>>>> [
>>>>>>>> 303.335871] Hardware name: Generic AM33XX (Flattened Device Tree) [
>>>>>>>> 303.335878] I-pipe domain: Linux
>>>>>>>>>> [  303.335918] [<c0113520>] (unwind_backtrace) from [<c010d320>]
>>>>>>>> (show_stack+0x20/0x24)
>>>>>>>>>> [  303.335946] [<c010d320>] (show_stack) from [<c073c99c>]
>>>>>>>>>> (dump_stack+0xbc/0xec)
>>>>>>>>>> [  303.335968] [<c073c99c>] (dump_stack) from [<c013dddc>]
>>>>>>>>>> (__warn+0xe4/0x110)
>>>>>>>>>> [  303.335984] [<c013dddc>] (__warn) from [<c013de38>]
>>>>>>>>>> (warn_slowpath_null+0x30/0x38)
>>>>>>>>>> [  303.335998] [<c013de38>] (warn_slowpath_null) from [<c01a74a0>]
>>>>>>>> (__ipipe_ack_bad_irq+0x3c/0x48)
>>>>>>>>>> [  303.336027] [<c01a74a0>] (__ipipe_ack_bad_irq) from
>>>>>>>>>> [<c020ccdc>]
>>>>>>>> (__ipipe_dispatch_irq+0x80/0x1e4)
>>>>>>>>>> [  303.336048] [<c020ccdc>] (__ipipe_dispatch_irq) from
>>>>>>>>>> [<c0790630>]
>>>>>>>> (omap_gpio_irq_handler+0x15c/0x1d0)
>>>>>>>>>> [  303.336066] [<c0790630>] (omap_gpio_irq_handler) from
>>>>>>>>>> [<c01a3874>]
>>>>>>>> (__handle_irq_event_percpu+0x68/0x2bc)
>>>>>>>>>> [  303.336081] [<c01a3874>] (__handle_irq_event_percpu) from
>>>>>>>>>> [<c01a3af4>]
>>>>>>>>>> (handle_irq_event_percpu+0x2c/0x68)
>>>>>>>>>> [  303.336095] [<c01a3af4>] (handle_irq_event_percpu) from
>>>>>>>>>> [<c01a3b78>]
>>>>>>>> (handle_irq_event+0x48/0x6c)
>>>>>>>>>> [  303.336111] [<c01a3b78>] (handle_irq_event) from [<c01a8348>]
>>>>>>>> (handle_level_irq+0xa8/0xfc)
>>>>>>>>>> [  303.336127] [<c01a8348>] (handle_level_irq) from [<c01a2ea0>]
>>>>>>>> (generic_handle_irq+0x28/0x38)
>>>>>>>>>> [  303.336141] [<c01a2ea0>] (generic_handle_irq) from [<c01a3014>]
>>>>>>>> (__handle_domain_irq+0x8c/0x10c)
>>>>>>>>>> [  303.336164] [<c01a3014>] (__handle_domain_irq) from
>>>>>>>>>> [<c0109c28>]
>>>>>>>> (handle_IRQ+0x2c/0x30)
>>>>>>>>>> [  303.336182] [<c0109c28>] (handle_IRQ) from [<c0117990>]
>>>>>>>>>> (__ipipe_do_IRQ+0x38/0x40)
>>>>>>>>>> [  303.336198] [<c0117990>] (__ipipe_do_IRQ) from [<c020c4b4>]
>>>>>>>>>> (__ipipe_do_sync_stage+0x268/0x278)
>>>>>>>>>> [  303.336214] [<c020c4b4>] (__ipipe_do_sync_stage) from
>>>>>>>>>> [<c020c820>]
>>>>>>>> (ipipe_unstall_root+0x50/0x5c)
>>>>>>>>>> [  303.336244] [<c020c820>] (ipipe_unstall_root) from [<c0cbb4c8>]
>>>>>>>> (default_idle_call+0x54/0x7c)
>>>>>>>>>> [  303.336271] [<c0cbb4c8>] (default_idle_call) from [<c0187c4c>]
>>>>>>>> (cpu_startup_entry+0xd0/0x144)
>>>>>>>>>> [  303.336289] [<c0187c4c>] (cpu_startup_entry) from [<c0cb5c80>]
>>>>>>>> (rest_init+0x80/0x98)
>>>>>>>>>> [  303.336315] [<c0cb5c80>] (rest_init) from [<c1300d08>]
>>>>>>>>>> (start_kernel+0x370/0x3d8)
>>>>>>>>>> [  303.336327] ---[ end trace fd2436447809c122 ]---
>>>>>>>>>> [  303.336343] irq 88, desc: dc1be400, depth: 0, count: 0,
>>>>>>>>>> unhandled:
>>>>>>>>>> 0
>>>>>>>> [  303.336349] ->handle_irq():  c01a810c,
>>>>>>>>>> [  303.336361] handle_edge_irq+0x0/0x194
>>>>>>>>>> [  303.336367] ->irq_data.chip(): dc097b50,
>>>>>>>>>> [  303.336376] 0xdc097b50
>>>>>>>>>> [  303.336382] ->action(): da097380
>>>>>>>>>> [  303.336389] ->action->handler(): c078dce4,
>>>>>>>>>> [  303.336399] gpio_sysfs_irq+0x0/0x24
>>>>>>>>>> [  303.336406]    IRQ_NOPROBE set
>>>>>>>>>> [  303.336413] unexpected IRQ trap at vector 58
>>>>>>>>>> [  306.761879] irq 88, desc: dc1be400, depth: 0, count: 1,
>>>>>>>>>> unhandled:
>>>>>>>>>> 0
>>>>>>>> [  306.761893] ->handle_irq():  c01a810c,
>>>>>>>>>> [  306.761928] handle_edge_irq+0x0/0x194
>>>>>>>>>> [  306.761935] ->irq_data.chip(): dc097b50,
>>>>>>>>>> [  306.761947] 0xdc097b50
>>>>>>>>>> [  306.761954] ->action(): da097380
>>>>>>>>>> [  306.761960] ->action->handler(): c078dce4,
>>>>>>>>>> [  306.761976] gpio_sysfs_irq+0x0/0x24
>>>>>>>>>> [  306.761985]    IRQ_NOPROBE set
>>>>>>>>>> [  306.761995] unexpected IRQ trap at vector 58
>>>>>>>>>> [  306.766311] irq 88, desc: dc1be400, depth: 0, count: 1,
>>>>>>>>>> unhandled:
>>>>>>>>>> 0
>>>>>>>> [  306.766318] ->handle_irq():  c01a810c,
>>>>>>>>>> [  306.766330] handle_edge_irq+0x0/0x194
>>>>>>>>>> [  306.766336] ->irq_data.chip(): dc097b50,
>>>>>>>>>> [  306.766344] 0xdc097b50
>>>>>>>>>> [  306.766351] ->action(): da097380
>>>>>>>>>> [  306.766357] ->action->handler(): c078dce4,
>>>>>>>>>> [  306.766366] gpio_sysfs_irq+0x0/0x24
>>>>>>>>>> [  306.766373]    IRQ_NOPROBE set
>>>>>>>>>> [  306.766380] unexpected IRQ trap at vector 58
>>>>>>>>>> [  306.892617] irq 88, desc: dc1be400, depth: 0, count: 2,
>>>>>>>>>> unhandled:
>>>>>>>>>> 0
>>>>>>>> [  306.892634] ->handle_irq():  c01a810c,
>>>>>>>>>> [  306.892666] handle_edge_irq+0x0/0x194
>>>>>>>>>> [  306.892673] ->irq_data.chip(): dc097b50,
>>>>>>>>>> [  306.892683] 0xdc097b50
>>>>>>>>>> [  306.892690] ->action(): da097380
>>>>>>>>>> [  306.892697] ->action->handler(): c078dce4,
>>>>>>>>>> [  306.892712] gpio_sysfs_irq+0x0/0x24
>>>>>>>>>> [  306.892723]    IRQ_NOPROBE set
>>>>>>>>>> [  306.892732] unexpected IRQ trap at vector 58
>>>>>>>>>> [  306.897047] irq 88, desc: dc1be400, depth: 0, count: 2,
>>>>>>>>>> unhandled:
>>>>>>>>>> 0
>>>>>>>> [  306.897054] ->handle_irq():  c01a810c,
>>>>>>>>>> [  306.897065] handle_edge_irq+0x0/0x194
>>>>>>>>>> [  306.897071] ->irq_data.chip(): dc097b50,
>>>>>>>>>> [  306.897079] 0xdc097b50
>>>>>>>>>> [  306.897086] ->action(): da097380
>>>>>>>>>> [  306.897092] ->action->handler(): c078dce4,
>>>>>>>>>> [  306.897101] gpio_sysfs_irq+0x0/0x24
>>>>>>>>>> [  306.897108]    IRQ_NOPROBE set
>>>>>>>>>> [  306.897115] unexpected IRQ trap at vector 58
>>>>>>>>>> Best regards,
>>>>>>>>>> Branislav
>>>>>>>>>> _______________________________________________
>>>>>>>>>> Xenomai mailing list
>>>>>>>>>> Xenomai@xenomai.org
>>>>>>>>>> https://xenomai.org/mailman/listinfo/xenomai
>>>>>>>>>
>>>>>>>>> _______________________________________________
>>>>>>>>> Xenomai mailing list
>>>>>>>>> Xenomai@xenomai.org
>>>>>>>>> https://xenomai.org/mailman/listinfo/xenomai
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> Xenomai mailing list
>>>>>> Xenomai@xenomai.org
>>>>>> https://xenomai.org/mailman/listinfo/xenomai
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Xenomai mailing list
>>>>> Xenomai@xenomai.org
>>>>> https://xenomai.org/mailman/listinfo/xenomai
>>>>>
>>>>
>>>>
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai
>>>

