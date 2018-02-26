MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24563AD93D8C2C0D5771A10AB5C10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <36415.147.91.1.44.1519652762.squirrel@mail.imp.bg.ac.rs>
 <CALLqZ8RdzYhzCYFfvvnsD_M7HXo2T4q9-n_6tedpWzEFsEd+mg@mail.gmail.com>
 <DB6PR0701MB24563AD93D8C2C0D5771A10AB5C10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 26 Feb 2018 11:06:00 -0500
Message-ID: <CALLqZ8QdQFu6qVf47VkS7bjgR2Q1+qJu0eqV4VtaN+cgu03qFw@mail.gmail.com>
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
To: Giulio Moro <g.moro@qmul.ac.uk>
Cc: "branislav.sasic@automatika.imp.bg.ac.rs" <branislav.sasic@automatika.imp.bg.ac.rs>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

 In this case you have Xenomai installed and are using the GPIO in a
non rt situation?  On Zynq I can use both the RTDM gpios and the sysfs
gpios (non rt) at the same time as long as it's not the same pin.  I
will look into this this week, I have RPI stuff on the go as well so
patience is appreciated.

-Greg

On Mon, Feb 26, 2018 at 10:54 AM, Giulio Moro <g.moro@qmul.ac.uk> wrote:
> We have a similar issue on Linux 4.4.87 and  4.4.113, with xenomai 3.0.5: https://github.com/RobertCNelson/ti-linux-kernel-dev/issues/16  (comes with code to reproduce issue).
>
> Best,
> Giulio
>
> ________________________________________
> From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Greg Gallagher <greg@embeddedgreg.com>
> Sent: 26 February 2018 15:37
> To: branislav.sasic@automatika.imp.bg.ac.rs
> Cc: Xenomai@xenomai.org
> Subject: Re: [Xenomai] interrupt on edge problem, unexpected IRQ trap
>
> Can you provide what version of Xenomai you are using and what ipipe
> patch you are using?  It also may be helpful if you could provide some
> sort of sample code that reproduces the problem.
>
> -Greg
>
> On Mon, Feb 26, 2018 at 8:46 AM,
> <branislav.sasic@automatika.imp.bg.ac.rs> wrote:
>> Hello,
>>
>> I have a problem with new I-pipe patch, which was not existing with legacy
>> patch on 3.14 kernel, on BeagleBone platform.
>>
>> When GPIO pin is configured as input with edge interrupt enable, on IRQ
>> occurrence the following message appears:
>>
>>
>> [  303.331386] irq 88, desc: dc1be400, depth: 0, count: 0, unhandled: 0
>> [  303.331401] ->handle_irq():  c01a810c,
>> [  303.331435] handle_edge_irq+0x0/0x194
>> [  303.331442] ->irq_data.chip(): dc097b50,
>> [  303.331454] 0xdc097b50
>> [  303.331461] ->action(): da097380
>> [  303.331467] ->action->handler(): c078dce4,
>> [  303.331483] gpio_sysfs_irq+0x0/0x24
>> [  303.331493]    IRQ_NOPROBE set
>> [  303.331503] unexpected IRQ trap at vector 58
>>
>> [  303.335814] ------------[ cut here ]------------
>> [  303.335832] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:883
>> __ipipe_ack_bad_irq+0x3c/0x48
>> [  303.335839] Modules linked in:
>> [  303.335863] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.82 #2
>> [  303.335871] Hardware name: Generic AM33XX (Flattened Device Tree)
>> [  303.335878] I-pipe domain: Linux
>> [  303.335918] [<c0113520>] (unwind_backtrace) from [<c010d320>]
>> (show_stack+0x20/0x24)
>> [  303.335946] [<c010d320>] (show_stack) from [<c073c99c>]
>> (dump_stack+0xbc/0xec)
>> [  303.335968] [<c073c99c>] (dump_stack) from [<c013dddc>]
>> (__warn+0xe4/0x110)
>> [  303.335984] [<c013dddc>] (__warn) from [<c013de38>]
>> (warn_slowpath_null+0x30/0x38)
>> [  303.335998] [<c013de38>] (warn_slowpath_null) from [<c01a74a0>]
>> (__ipipe_ack_bad_irq+0x3c/0x48)
>> [  303.336027] [<c01a74a0>] (__ipipe_ack_bad_irq) from [<c020ccdc>]
>> (__ipipe_dispatch_irq+0x80/0x1e4)
>> [  303.336048] [<c020ccdc>] (__ipipe_dispatch_irq) from [<c0790630>]
>> (omap_gpio_irq_handler+0x15c/0x1d0)
>> [  303.336066] [<c0790630>] (omap_gpio_irq_handler) from [<c01a3874>]
>> (__handle_irq_event_percpu+0x68/0x2bc)
>> [  303.336081] [<c01a3874>] (__handle_irq_event_percpu) from [<c01a3af4>]
>> (handle_irq_event_percpu+0x2c/0x68)
>> [  303.336095] [<c01a3af4>] (handle_irq_event_percpu) from [<c01a3b78>]
>> (handle_irq_event+0x48/0x6c)
>> [  303.336111] [<c01a3b78>] (handle_irq_event) from [<c01a8348>]
>> (handle_level_irq+0xa8/0xfc)
>> [  303.336127] [<c01a8348>] (handle_level_irq) from [<c01a2ea0>]
>> (generic_handle_irq+0x28/0x38)
>> [  303.336141] [<c01a2ea0>] (generic_handle_irq) from [<c01a3014>]
>> (__handle_domain_irq+0x8c/0x10c)
>> [  303.336164] [<c01a3014>] (__handle_domain_irq) from [<c0109c28>]
>> (handle_IRQ+0x2c/0x30)
>> [  303.336182] [<c0109c28>] (handle_IRQ) from [<c0117990>]
>> (__ipipe_do_IRQ+0x38/0x40)
>> [  303.336198] [<c0117990>] (__ipipe_do_IRQ) from [<c020c4b4>]
>> (__ipipe_do_sync_stage+0x268/0x278)
>> [  303.336214] [<c020c4b4>] (__ipipe_do_sync_stage) from [<c020c820>]
>> (ipipe_unstall_root+0x50/0x5c)
>> [  303.336244] [<c020c820>] (ipipe_unstall_root) from [<c0cbb4c8>]
>> (default_idle_call+0x54/0x7c)
>> [  303.336271] [<c0cbb4c8>] (default_idle_call) from [<c0187c4c>]
>> (cpu_startup_entry+0xd0/0x144)
>> [  303.336289] [<c0187c4c>] (cpu_startup_entry) from [<c0cb5c80>]
>> (rest_init+0x80/0x98)
>> [  303.336315] [<c0cb5c80>] (rest_init) from [<c1300d08>]
>> (start_kernel+0x370/0x3d8)
>> [  303.336327] ---[ end trace fd2436447809c122 ]---
>>
>> [  303.336343] irq 88, desc: dc1be400, depth: 0, count: 0, unhandled: 0
>> [  303.336349] ->handle_irq():  c01a810c,
>> [  303.336361] handle_edge_irq+0x0/0x194
>> [  303.336367] ->irq_data.chip(): dc097b50,
>> [  303.336376] 0xdc097b50
>> [  303.336382] ->action(): da097380
>> [  303.336389] ->action->handler(): c078dce4,
>> [  303.336399] gpio_sysfs_irq+0x0/0x24
>> [  303.336406]    IRQ_NOPROBE set
>> [  303.336413] unexpected IRQ trap at vector 58
>>
>> [  306.761879] irq 88, desc: dc1be400, depth: 0, count: 1, unhandled: 0
>> [  306.761893] ->handle_irq():  c01a810c,
>> [  306.761928] handle_edge_irq+0x0/0x194
>> [  306.761935] ->irq_data.chip(): dc097b50,
>> [  306.761947] 0xdc097b50
>> [  306.761954] ->action(): da097380
>> [  306.761960] ->action->handler(): c078dce4,
>> [  306.761976] gpio_sysfs_irq+0x0/0x24
>> [  306.761985]    IRQ_NOPROBE set
>> [  306.761995] unexpected IRQ trap at vector 58
>>
>> [  306.766311] irq 88, desc: dc1be400, depth: 0, count: 1, unhandled: 0
>> [  306.766318] ->handle_irq():  c01a810c,
>> [  306.766330] handle_edge_irq+0x0/0x194
>> [  306.766336] ->irq_data.chip(): dc097b50,
>> [  306.766344] 0xdc097b50
>> [  306.766351] ->action(): da097380
>> [  306.766357] ->action->handler(): c078dce4,
>> [  306.766366] gpio_sysfs_irq+0x0/0x24
>> [  306.766373]    IRQ_NOPROBE set
>> [  306.766380] unexpected IRQ trap at vector 58
>>
>> [  306.892617] irq 88, desc: dc1be400, depth: 0, count: 2, unhandled: 0
>> [  306.892634] ->handle_irq():  c01a810c,
>> [  306.892666] handle_edge_irq+0x0/0x194
>> [  306.892673] ->irq_data.chip(): dc097b50,
>> [  306.892683] 0xdc097b50
>> [  306.892690] ->action(): da097380
>> [  306.892697] ->action->handler(): c078dce4,
>> [  306.892712] gpio_sysfs_irq+0x0/0x24
>> [  306.892723]    IRQ_NOPROBE set
>> [  306.892732] unexpected IRQ trap at vector 58
>>
>> [  306.897047] irq 88, desc: dc1be400, depth: 0, count: 2, unhandled: 0
>> [  306.897054] ->handle_irq():  c01a810c,
>> [  306.897065] handle_edge_irq+0x0/0x194
>> [  306.897071] ->irq_data.chip(): dc097b50,
>> [  306.897079] 0xdc097b50
>> [  306.897086] ->action(): da097380
>> [  306.897092] ->action->handler(): c078dce4,
>> [  306.897101] gpio_sysfs_irq+0x0/0x24
>> [  306.897108]    IRQ_NOPROBE set
>> [  306.897115] unexpected IRQ trap at vector 58
>>
>>
>> Best regards,
>> Branislav
>>
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

