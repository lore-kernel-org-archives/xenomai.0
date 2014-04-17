Message-ID: <1397694600.2625.4.camel@localhost.localdomain>
From: Peter Howard <pjh@northern-ridge.com.au>
Date: Thu, 17 Apr 2014 10:30:00 +1000
In-Reply-To: <534E328F.5030709@xenomai.org>
References: <1396407588.27578.5.camel@localhost.localdomain>
 <1396848843.2481.15.camel@localhost.localdomain>
 <5343BEFB.7050402@xenomai.org>
 <1396999856.2660.7.camel@localhost.localdomain>
 <53449244.8040502@xenomai.org>
 <1397003664.2660.14.camel@localhost.localdomain>
 <1397017658.2660.16.camel@localhost.localdomain>
 <534534FD.5090805@xenomai.org>
 <1397113300.2720.5.camel@localhost.localdomain>
 <5346895B.6080401@xenomai.org>
 <1397159850.2881.3.camel@localhost.localdomain>
 <53471389.6000000@xenomai.org>
 <1397168263.6356.11.camel@localhost.localdomain>
 <534719F5.2020605@xenomai.org>
 <1397169248.6356.15.camel@localhost.localdomain>
 <53471FDB.50008@xenomai.org>
 <1397170339.6356.17.camel@localhost.localdomain>
 <1397541812.6541.3.camel@localhost.localdomain>
 <534D19FA.3040506@xenomai.org>
 <1397599195.2652.0.camel@localhost.localdomain>
 <534DB1C7.4060905@xenomai.org>
 <1397609916.2652.6.camel@localhost.localdomain>
 <534E328F.5030709@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2014-04-16 at 09:34 +0200, Gilles Chanteperdrix wrote:
> On 04/16/2014 02:58 AM, Peter Howard wrote:
> > On Wed, 2014-04-16 at 00:25 +0200, Gilles Chanteperdrix wrote:
> >> On 04/15/2014 11:59 PM, Peter Howard wrote:
> >>> On Tue, 2014-04-15 at 13:37 +0200, Gilles Chanteperdrix wrote:
> >>>> On 04/15/2014 08:03 AM, Peter Howard wrote:
> >>>>> On Fri, 2014-04-11 at 08:52 +1000, Peter Howard wrote:
> >>>>>> On Fri, 2014-04-11 at 00:48 +0200, Gilles Chanteperdrix wrote:
> >>>>>>> On 04/11/2014 12:34 AM, Peter Howard wrote:
> >>>>>>>> On Fri, 2014-04-11 at 00:23 +0200, Gilles Chanteperdrix wrote:
> >>>>>>>> (Stripping back conversation on this one - apologies if that's bad
> >>>>>>>> etiquette for this list)
> >>>>>>>>  
> >>>>>>>>> Attachment is better. Also please post the changes you made for omapL138
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> >>>>>>>> index a075b3e..3d8bc59 100644
> >>>>>>>> --- a/arch/arm/mach-davinci/Kconfig
> >>>>>>>> +++ b/arch/arm/mach-davinci/Kconfig
> >>>>>>>> @@ -41,6 +41,8 @@ config ARCH_DAVINCI_DA850
> >>>>>>>>  	select ARCH_DAVINCI_DA8XX
> >>>>>>>>  	select ARCH_HAS_CPUFREQ
> >>>>>>>>  	select CP_INTC
> >>>>>>>> +    select IPIPE_ARM_KUSER_TSC if IPIPE
> >>>>>>>> +    select ARM_FCSE if IPIPE
> >>>>>>>
> >>>>>>> You may want to leave the choice of enabling or disabling FCSE to the user.
> >>>>>>>
> >>>>>>
> >>>>>> Understood; at the moment the variance on max latency is really bad if
> >>>>>> you don't enable FCSE.  When I sort out the crashing issues I'll re-test
> >>>>>> with it off.
> >>>>>
> >>>>> Well, FCSE turned out to be my problem.
> >>>>>
> >>>>> More specifically,  FCSE and ARM_FCSE_BEST_EFFORT.  Either a) disabling
> >>>>> ARM_FCSE altogether, or b) selecting ARM_FCSE with ARM_FCSE_GUARENTEED
> >>>>> gets rid of the crashes/panics with ipipe latency tracing enabled.
> >>>>>
> >>>>> So now things seem reasonably stable, I'll go through the full set of
> >>>>> tests.  Though I still can't do 'xeno-test -l "dohell -l /opt/ltp"' as
> >>>>> ltp takes out the system without any ipipe/xenomai bits.
> >>>>>
> >>>> Ok, FCSE best effort is currently being validated on 3.14, so it may
> >>>> well be broken. After all, the raw/* branches are work in progress.
> >>>>
> >>>
> >>> Note: selecting ARM_FCSE_BEST_EFFORT produces the same result on the
> >>> master branch too . . .
> >>>
> >>
> >> Could you turn CONFIG_ARM_FCSE_MESSAGES on and show us the messages you
> >> get (with the 3.14 kernel, not the master branch)?
> >>
> > 
> > OK - sadly there's not much, but here's what I get from the "dies at, or
> > immediately after, login" rootfs.  That also has all ipipe debugging,
> > and stack unwinding, enabled.
> 
> You should enable CONFIG_DEBUG_USER and boot with the user_debug=29
> kernel parameter. Disabling stack unwinding enable frame pointers which
> usually lead to better stack traces.
> 
> > 
> > Arago Project http://arago-project.org arago ttyS2                              
> >                                                                                 
> > Arago 2011.06 arago ttyS2                                                       
> >                                                                                 
> > arago login: Unable to handle kernel paging request at virtual address e5902f10 
> > fcse pid: 0, 0x00000000, hw pid: 0x00000000                                     
> > pgd = c6934000, hw pgd = c6934000                                               
> > [e5902f10] *pgd=00000000                                                        
> > Internal error: Oops: 80000005 [#1] PREEMPT ARM                                 
> > Modules linked in:                                                              
> > CPU: 0 PID: 2456 Comm: matrix_guiE Not tainted 3.12.0-ipipe-12092-g1f7fa99-dirt7
> 
> Please do not base your work on the 3.12 kernel: the previous released
> I-pipe was 3.10 and the next will be 3.14.

OK, I now get a decent (long) stack trace on failure:

Arago Project http://arago-project.org arago ttyS2

Arago 2011.06 arago ttyS2

arago login: Unable to handle kernel paging request at virtual address e154000c
fcse pid: 0, 0x00000000, hw pid: 0x00000000
pgd = c71d0000, hw pgd = c71d0000
[e154000c] *pgd=00000000
Unable to handle kernel paging request at virtual address e154000c
fcse pid: 0, 0x00000000, hw pid: 0x00000000
pgd = c71d0000, hw pgd = c71d0000
[e154000c] *pgd=00000000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/ipipe/core.c:605 __ipipe_lock_irq+0x160/0x184()
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-ipipe-38808-gd8d4639-dirty #56
Backtrace: 
[<c000d228>] (dump_backtrace) from [<c000d7d0>] (show_stack+0x20/0x24)
 r6:c04cc8d0 r5:0000025d r4:00000000 r3:00000000
[<c000d7b0>] (show_stack) from [<c03fa760>] (dump_stack+0x20/0x28)
[<c03fa740>] (dump_stack) from [<c001f634>] (warn_slowpath_common+0x78/0x98)
[<c001f5bc>] (warn_slowpath_common) from [<c001f680>] (warn_slowpath_null+0x2c/0x34)
 r8:00000001 r7:c05b6b80 r6:c0580a98 r5:c059bee6 r4:00000010
[<c001f654>] (warn_slowpath_null) from [<c008ab40>] (__ipipe_lock_irq+0x160/0x184)
[<c008a9e0>] (__ipipe_lock_irq) from [<c001b0b0>] (cp_intc_mask_irq+0x68/0x7c)
 r8:00000001 r7:c05b6b80 r6:c0580a98 r5:00000010 r4:c0575e50 r3:c05b6ba0
[<c001b048>] (cp_intc_mask_irq) from [<c0065b98>] (handle_edge_irq+0x124/0x170)
 r4:c0575e50 r3:c001b048
[<c0065a74>] (handle_edge_irq) from [<c0061560>] (generic_handle_irq+0x28/0x3c)
 r4:c058afdc r3:c0065a74
[<c0061538>] (generic_handle_irq) from [<c000a514>] (handle_IRQ+0x40/0x94)
[<c000a4d4>] (handle_IRQ) from [<c000f644>] (__ipipe_do_IRQ+0x1c/0x24)
 r6:00000000 r5:00000011 r4:00000010 r3:c000f628
[<c000f628>] (__ipipe_do_IRQ) from [<c008bcb8>] (__ipipe_do_sync_stage+0x218/0x2f4)
[<c008baa0>] (__ipipe_do_sync_stage) from [<c008c580>] (ipipe_unstall_root+0x80/0x88)
 r10:00000805 r9:c0569108 r8:c055f110 r7:60000013 r6:c055e000 r5:00000000
 r4:c055f110
[<c008c500>] (ipipe_unstall_root) from [<c0011f30>] (do_page_fault+0x298/0x344)
[<c0011c98>] (do_page_fault) from [<c0012130>] (do_translation_fault+0xd8/0x144)
 r10:c025fad4 r9:00000004 r8:c055f110 r7:00000005 r6:00000805 r5:c055f110
 r4:60000013
[<c0012058>] (do_translation_fault) from [<c0008794>] (do_DataAbort+0x50/0x160)
 r7:00000005 r6:c056a154 r5:00000805 r4:60000013
[<c0008744>] (do_DataAbort) from [<c000e530>] (__dabt_svc+0x50/0x80)
Exception stack(0xc055f110 to 0xc055f158)
f100:                                     60000013 00000000 c055f300 00000000
f120: 00000003 01000000 60000013 c059dc5c 00000801 00000004 c025fad4 c055f174
f140: 00000002 c055f158 c0014b20 c0014688 40000013 ffffffff
 r10:c025fad4 r8:00000801 r7:c055f144 r6:ffffffff r5:40000013 r4:c0014688
[<c0014638>] (do_alignment_ldrstr) from [<c0014b20>] (do_alignment+0x1a0/0x928)
 r6:60000013 r5:00000000 r4:c055f300 r3:c0014638
[<c0014980>] (do_alignment) from [<c0008794>] (do_DataAbort+0x50/0x160)
 r10:80000005 r9:c0569fd8 r8:c055f300 r7:00000001 r6:c056a154 r5:00000801
 r4:60000013
[<c0008744>] (do_DataAbort) from [<c000e530>] (__dabt_svc+0x50/0x80)
Exception stack(0xc055f300 to 0xc055f348)
f300: c055f364 ffffffe4 ffffffe4 00000000 00000000 e154000c c055f364 60000013
f320: c73dd860 c0569fd8 80000005 c055f394 0000001c c055f34c c0400da4 c025fad8
f340: 00000013 ffffffff
 r10:80000005 r8:c73dd860 r7:c055f334 r6:ffffffff r5:00000013 r4:c025fad4
[<c000dbc8>] (is_valid_bugaddr) from [<c024f310>] (report_bug+0x18/0xf8)
 r6:e154000c r5:c055f510 r4:c059db64
[<c024f2f8>] (report_bug) from [<c000d984>] (die+0x1b0/0x298)
 r8:c73dd860 r7:60000013 r6:c04c2ac8 r5:c055f510 r4:c059db64 r3:80000013
[<c000d7d4>] (die) from [<c0011c78>] (__do_kernel_fault+0x74/0x94)
 r10:00000001 r9:00000000 r8:c73dd860 r7:80000005 r6:00000000 r5:e154000c
 r4:c055f510
[<c0011c04>] (__do_kernel_fault) from [<c001202c>] (do_bad_area+0x50/0x7c)
 r8:c055f510 r7:00000000 r6:80000005 r5:c055f510 r4:e154000c r3:c055f510
[<c0011fdc>] (do_bad_area) from [<c001211c>] (do_translation_fault+0xc4/0x144)
[<c0012058>] (do_translation_fault) from [<c00088ec>] (do_PrefetchAbort+0x48/0x148)
 r7:c056a154 r6:00000050 r5:e154000c r4:00000005
[<c00088a4>] (do_PrefetchAbort) from [<c000e750>] (__pabt_svc+0x50/0xa0)
Exception stack(0xc055f510 to 0xc055f558)
f500:                                     c0574cc0 c7837a00 00000001 e154000e
f520: c7837a00 00000001 c0574cc0 60000013 00000000 00000000 00000001 c055f574
f540: 00000418 c055f558 c004d518 e154000c 80000013 ffffffff
 r10:00000001 r8:00000000 r7:c055f544 r6:ffffffff r5:80000013 r4:e154000c
[<c004d4dc>] (enqueue_task) from [<c004d638>] (activate_task+0x38/0x3c)
 r6:00000001 r5:00000080 r4:c7837a00 r3:00000001
[<c004d600>] (activate_task) from [<c004de78>] (try_to_wake_up+0xf0/0x1cc)
[<c004dd88>] (try_to_wake_up) from [<c004df70>] (default_wake_function+0x1c/0x20)
 r8:00000000 r7:c7097ea8 r6:00000000 r5:c0054fbc r4:c717de24 r3:00000000
[<c004df54>] (default_wake_function) from [<c0054fd8>] (autoremove_wake_function+0x1c/0x44)
[<c0054fbc>] (autoremove_wake_function) from [<c005581c>] (__wake_up_common+0x6c/0xa8)
 r4:c7097e9c r3:00000000
[<c00557b0>] (__wake_up_common) from [<c0055b50>] (__wake_up+0x70/0xe0)
 r10:60000013 r9:c057e754 r8:00000001 r7:00000001 r6:c7097ea8 r5:00000000
 r4:00000001
[<c0055ae0>] (__wake_up) from [<c02fa6f4>] (mmc_wait_data_done+0x34/0x38)
 r10:c055e000 r8:00000000 r7:00000000 r6:00000004 r5:00000000 r4:c7097ec0
[<c02fa6c0>] (mmc_wait_data_done) from [<c02f962c>] (mmc_request_done+0x44/0x68)
[<c02f95e8>] (mmc_request_done) from [<c030de40>] (mmc_davinci_irq+0x224/0x410)
[<c030dc1c>] (mmc_davinci_irq) from [<c030e1a0>] (mmc_davinci_start_command+0x174/0x220)
 r8:00000000 r7:00000094 r6:c7170dcc r5:0000001c r4:c7097ec0
[<c030e02c>] (mmc_davinci_start_command) from [<c030df58>] (mmc_davinci_irq+0x33c/0x410)
 r7:00000001 r6:00001001 r5:c7170e00 r4:c7097ec0
[<c030dc1c>] (mmc_davinci_irq) from [<c0061d4c>] (handle_irq_event_percpu+0x7c/0x3dc)
 r8:00000000 r7:00000010 r6:c0580a98 r5:c7161200 r4:c7161200
[<c0061cd0>] (handle_irq_event_percpu) from [<c006210c>] (handle_irq_event+0x60/0x94)
 r10:00000002 r9:c05b6ba0 r8:00000001 r7:c05b6b80 r6:c0580a98 r5:c7161200
 r4:c0575e50
[<c00620ac>] (handle_irq_event) from [<c0065b08>] (handle_edge_irq+0x94/0x170)
 r5:00000010 r4:c0575e50
[<c0065a74>] (handle_edge_irq) from [<c0061560>] (generic_handle_irq+0x28/0x3c)
 r4:c058afdc r3:c0065a74
[<c0061538>] (generic_handle_irq) from [<c000a514>] (handle_IRQ+0x40/0x94)
[<c000a4d4>] (handle_IRQ) from [<c000f644>] (__ipipe_do_IRQ+0x1c/0x24)
 r6:00000000 r5:00000011 r4:00000010 r3:c000f628
[<c000f628>] (__ipipe_do_IRQ) from [<c008bcb8>] (__ipipe_do_sync_stage+0x218/0x2f4)
[<c008baa0>] (__ipipe_do_sync_stage) from [<c008c580>] (ipipe_unstall_root+0x80/0x88)
 r10:00000805 r9:c0569108 r8:c055f908 r7:60000013 r6:c055e000 r5:00000000
 r4:c055f908
[<c008c500>] (ipipe_unstall_root) from [<c0011f30>] (do_page_fault+0x298/0x344)
[<c0011c98>] (do_page_fault) from [<c0012130>] (do_translation_fault+0xd8/0x144)
 r10:c025fad4 r9:00000004 r8:c055f908 r7:00000005 r6:00000805 r5:c055f908
 r4:60000013
[<c0012058>] (do_translation_fault) from [<c0008794>] (do_DataAbort+0x50/0x160)
 r7:00000005 r6:c056a154 r5:00000805 r4:60000013
[<c0008744>] (do_DataAbort) from [<c000e530>] (__dabt_svc+0x50/0x80)
Exception stack(0xc055f908 to 0xc055f950)
f900:                   60000013 00000000 c055faf8 00000000 00000003 01000000
f920: 60000013 c059dc5c 00000801 00000004 c025fad4 c055f96c 00000001 c055f950
f940: c0014b20 c0014688 40000013 ffffffff
 r10:c025fad4 r8:00000801 r7:c055f93c r6:ffffffff r5:40000013 r4:c0014688
[<c0014638>] (do_alignment_ldrstr) from [<c0014b20>] (do_alignment+0x1a0/0x928)
 r6:60000013 r5:00000000 r4:c055faf8 r3:c0014638
[<c0014980>] (do_alignment) from [<c0008794>] (do_DataAbort+0x50/0x160)
 r10:80000005 r9:c0569fd8 r8:c055faf8 r7:00000001 r6:c056a154 r5:00000801
 r4:60000013
[<c0008744>] (do_DataAbort) from [<c000e530>] (__dabt_svc+0x50/0x80)
Exception stack(0xc055faf8 to 0xc055fb40)
fae0:                                                       c055fb5c ffffffe4
fb00: ffffffe4 00000000 00000000 e154000c c055fb5c 60000013 c73dd860 c0569fd8
fb20: 80000005 c055fb8c 0000001c c055fb44 c0400da4 c025fad8 00000013 ffffffff
 r10:80000005 r8:c73dd860 r7:c055fb2c r6:ffffffff r5:00000013 r4:c025fad4
[<c000dbc8>] (is_valid_bugaddr) from [<c024f310>] (report_bug+0x18/0xf8)
 r6:e154000c r5:c055fd08 r4:c059db64
[<c024f2f8>] (report_bug) from [<c000d984>] (die+0x1b0/0x298)
 r8:c73dd860 r7:60000013 r6:c04c2ac8 r5:c055fd08 r4:c059db64 r3:80000013
[<c000d7d4>] (die) from [<c0011c78>] (__do_kernel_fault+0x74/0x94)
 r10:00000002 r9:0000000c r8:c73dd860 r7:80000005 r6:00000000 r5:e154000c
 r4:c055fd08
[<c0011c04>] (__do_kernel_fault) from [<c001202c>] (do_bad_area+0x50/0x7c)
 r8:c055fd08 r7:00000000 r6:80000005 r5:c055fd08 r4:e154000c r3:c055fd08
[<c0011fdc>] (do_bad_area) from [<c001211c>] (do_translation_fault+0xc4/0x144)
[<c0012058>] (do_translation_fault) from [<c00088ec>] (do_PrefetchAbort+0x48/0x148)
 r7:c056a154 r6:00000050 r5:e154000c r4:00000005
[<c00088a4>] (do_PrefetchAbort) from [<c000e750>] (__pabt_svc+0x50/0xa0)
Exception stack(0xc055fd08 to 0xc055fd50)
fd00:                   c0574cc0 c7834740 00000001 e154000e c7834740 00000001
fd20: c0574cc0 60000013 00000000 0000000c 00000002 c055fd6c 00000418 c055fd50
fd40: c004d518 e154000c 80000013 ffffffff
 r10:00000002 r8:00000000 r7:c055fd3c r6:ffffffff r5:80000013 r4:e154000c
[<c004d4dc>] (enqueue_task) from [<c004d638>] (activate_task+0x38/0x3c)
 r6:00000001 r5:00000080 r4:c7834740 r3:00000001
[<c004d600>] (activate_task) from [<c004de78>] (try_to_wake_up+0xf0/0x1cc)
[<c004dd88>] (try_to_wake_up) from [<c004dfa8>] (wake_up_process+0x34/0x50)
 r8:00000003 r7:00000000 r6:c055e000 r5:00000002 r4:c7834740 r3:00000001
[<c004df74>] (wake_up_process) from [<c002417c>] (wakeup_softirqd+0x34/0x3c)
 r4:60000013 r3:00000001
[<c0024148>] (wakeup_softirqd) from [<c0024460>] (__do_softirq+0x204/0x364)
[<c002425c>] (__do_softirq) from [<c0024944>] (irq_exit+0xc0/0x110)
 r10:00000002 r9:c05b6ba0 r8:00000001 r7:c05b6b80 r6:00000000 r5:00000022
 r4:c055e000
[<c0024884>] (irq_exit) from [<c000a518>] (handle_IRQ+0x44/0x94)
 r4:c058afdc r3:c0065a74
[<c000a4d4>] (handle_IRQ) from [<c000f644>] (__ipipe_do_IRQ+0x1c/0x24)
 r6:00000000 r5:00000023 r4:00000022 r3:c000f628
[<c000f628>] (__ipipe_do_IRQ) from [<c008bcb8>] (__ipipe_do_sync_stage+0x218/0x2f4)
[<c008baa0>] (__ipipe_do_sync_stage) from [<c008be54>] (__ipipe_do_sync_pipeline+0xc0/0x10c)
 r10:00002340 r9:0000119c r8:c05b6b80 r7:c057e754 r6:c05b6ba0 r5:c05b6ba0
 r4:c057e754
[<c008bd94>] (__ipipe_do_sync_pipeline) from [<c008c0cc>] (__ipipe_dispatch_irq+0x22c/0x2e0)
 r10:c057e754 r9:c059c464 r8:c057e750 r7:00000000 r6:00000023 r5:c057e754
 r4:00000022 r3:c05b6ba0
[<c008bea0>] (__ipipe_dispatch_irq) from [<c00086dc>] (__ipipe_grab_irq+0x48/0xb0)
 r10:c059c464 r8:00000000 r7:c055ff5c r6:c057e754 r5:c055ff28 r4:00000022
[<c0008694>] (__ipipe_grab_irq) from [<c000e5b0>] (__irq_svc+0x50/0x9c)
Exception stack(0xc055ff28 to 0xc055ff70)
ff20:                   00000000 00000000 62240000 00000000 c055e000 c057e754
ff40: 60000013 c0566094 00000000 c059c464 c059c464 c055ff9c c0580b10 c055ff70
ff60: c008e214 c00613f0 60000013 ffffffff
 r6:febfd000 r5:60000013 r4:c00613f0 r3:c008e214
[<c00612c8>] (cpu_startup_entry) from [<c03f8f94>] (rest_init+0x80/0x98)
 r10:c7ffc980 r9:41069265 r8:c0566000 r7:c0554510 r6:c059d9c0 r5:ffffffff
 r4:00000002 r3:00000001
[<c03f8f14>] (rest_init) from [<c0528ae8>] (start_kernel+0x364/0x3c8)
 r4:c0566c68 r3:60000053
[<c0528784>] (start_kernel) from [<c0008040>] (0xc0008040)
---[ end trace 9b973359c02939c1 ]---

-- 
Peter Howard <pjh@northern-ridge.com.au>


