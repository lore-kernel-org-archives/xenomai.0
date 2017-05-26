References: <DB5PR0401MB1813C24618A1A44608C3A27AFEF80@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <2703c0a3-c0a8-409f-8489-2f250b7ff596@xenomai.org>
 <DB5PR0401MB1813090F12B177061B3D8922FEF80@DB5PR0401MB1813.eurprd04.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7d9a2e4a-2b8e-0098-52f6-dcff3c656903@xenomai.org>
Date: Fri, 26 May 2017 18:40:18 +0200
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB1813090F12B177061B3D8922FEF80@DB5PR0401MB1813.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel crash issues - cobalt mode on ARM A53 with
	32bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerry Huang <jerry.huang@nxp.com>, Jorge Ramirez <jro@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/22/2017 10:28 AM, Jerry Huang wrote:
> 
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Monday, May 22, 2017 4:11 PM
>> To: Jerry Huang <jerry.huang@nxp.com>; Jorge Ramirez <jro@xenomai.org>;
>> xenomai@xenomai.org
>> Subject: Re: kernel crash issues - cobalt mode on ARM A53 with 32bit
>>
>> On 05/22/2017 05:33 AM, Jerry Huang wrote:
>>> Hi, all guys,
>>> I want to make the e1000e work with cobalt mode on ARM A53 with 32bit,
>> however, I encountered some critical issues.
>>>
>>> 1> I want to use PCIe MSIx or MSI mode, but that does not work, we need
>> to use legacy INTx on PCIe, that can work.
>>> Anyone can give some advice how to make PCIe MSIx/MSI interrupt work?
>>>
>>> 2> After modifying the e1000e driver to adapt the IPIPE interrupt mode
>> with INTx, first, the e1000e NIC can work well, I can ping other machine, and
>> can login other machine. But when the interrupt number reaches 1000 (that
>> means there are 1000 interrupts on NIC), the issue is reported:
>>> [ 1577.539977] [Xenomai] xnintr_irq_handler: IRQ83 not handled.
>>> Disabling IRQ line # cat /proc/xenomai/irq
>>>   IRQ         CPU0
>>>    17:        6320         [timer/0]
>>>    26:           9         fsl-ifc
>>>    83:        1000         eth7
>>>  1033:           0         [sync]
>>>  1034:           0         [timer-ipi]
>>>  1035:           0         [reschedule]
>>>  1036:           0         [virtual]
>>>  1040:           0         [virtual]
>>>
>>> Since that, the NIC can't work, must reboot the board.
>>> Anyone can give some advice how to remove the interrupt number 1000
>> limitation?
>>
>> Check the interrupt handler in your driver, it does not return
>> RTDM_IRQ_HANDLED upon success handling an IRQ.
>>
>>>
>>> 3> after booting up the Linux with Cobalt mode and e1000e NIC, and I
>> don't' set the IP address (not use command  "ifconfig eth7 xx.xx.xx.xx up"),
>> that means I don't enable the NIC card.
>>
>> A quick check at both the e1000e driver code and the backtrace dump below
>> reveals that the work queue handler that crashes starts running periodically
>> when the NIC is probed, regardless of whether an IP address is set.
>>
>>> After around 1 day, kernel crash as below, anyone can give some advice
>> how to make the system stable?
>>>
>>
>> Around one day doing what? Idle, running Xenomai, running a common load?
>> Is this reproducible without enabling Cobalt and/or the pipeline?
>>
>>> [253287.272440] Unhandled fault: synchronous external abort (0x1210)
>>> at 0xf05cb600 [253287.279740] pgd = 80203000 [253287.282523]
>>> [f05cb600] *pgd=80000080207003, *pmd=ecb6b003, *pte=c00050400cb713
>>> [253287.289831] Internal error: : 1210 [#1] SMP ARM [253287.294437]
>>> Modules linked in: ipv6 [253287.298011] CPU: 0 PID: 4 Comm:
>>> kworker/0:0 Not tainted 4.1.35-ipipe #1 [253287.304699] Hardware name:
>>> Generic DT based system [253287.309571] Workqueue: events
>>> e1000e_systim_overflow_work [253287.315047] task: ed860e40 ti:
>>> ed878000 task.ti: ed878000 [253287.320523] PC is at
>>> e1000e_cyclecounter_read+0x14/0x124
>>> [253287.325913] LR is at timecounter_read+0x14/0x8c
>>> [253287.330520] pc : [<808a3a74>]    lr : [<802bcad0>]    psr: 600d0013
>>> [253287.330520] sp : ed879e68  ip : 00000000  fp : ee7a31c0
>>> [253287.342157] r10: a014d0c8  r9 : 00000000  r8 : 00000000
>>> [253287.347457] r7 : a014c4c0  r6 : a014f0c4  r5 : ed879ef0  r4 :
>>> a014f0e0 [253287.354059] r3 : f05cb600  r2 : 00000000  r1 : 00000000
>>> r0 : a014f0c8 [253287.360662] Flags: nZCv  IRQs on  FIQs on  Mode
>>> SVC_32  ISA ARM  Segment kernel [253287.368045] Control: 30c5383d
>>> Table: eb174fc0  DAC: fffffffd [253287.373866] Process kworker/0:0
>>> (pid: 4, stack limit = 0xed878228) [253287.380121] Stack: (0xed879e68 to
>> 0xed87a000)
>>> [253287.384554] 9e60:                   7f03c874 03046c00 812c9400 eb184900
>> 7f03c874 a014f0e0
>>> [253287.392808] 9e80: ed879ef0 a014f0c4 a014c4c0 00000000 00000000
>>> 00000000 ee7a31c0 802bcad0 [253287.401061] 9ea0: a014f078 a014f0c4
>>> a014c4c0 00000000 00000000 00000000 ee7a31c0 808ae078 [253287.409315]
>>> 9ec0: 00000000 00000001 81311b94 81311b94 a014f078 ed829980 ee7a31c0
>>> ee7a6e00 [253287.417568] 9ee0: 00000000 00000000 ed829980 808ae1dc
>>> ed814000 ee7a31c0 a014f078 ed829980 [253287.425821] 9f00: a014f078
>>> 8027a588 ee7a31c0 ee7a31d4 ed878000 ee7a31c0 ed829998 ee7a31d4
>>> [253287.434075] 9f20: ed878000 00000008 812803dc ed829980 ee7a31c0
>>> 8027a8a0 8117c140 ee7a3324 [253287.442328] 9f40: 8027a854 00000000
>>> ed82d000 ed829980 8027a854 00000000 00000000 00000000 [253287.450581]
>>> 9f60: 00000000 8027f700 8f0141c7 00000000 382a8206 ed829980 00000000
>>> 00000000 [253287.458834] 9f80: ed879f80 ed879f80 00000000 00000000
>>> ed879f90 ed879f90 ed879fac ed82d000 [253287.467087] 9fa0: 8027f624
>>> 00000000 00000000 80222f54 00000000 00000000 00000000 00000000
>>> [253287.475340] 9fc0: 00000000 00000000 00000000 00000000 00000000
>>> 00000000 00000000 00000000 [253287.483593] 9fe0: 00000000 00000000
>>> 00000000 00000000 00000013 00000000 6822c08a 2600680a [253287.491851]
>>> [<808a3a74>] (e1000e_cyclecounter_read) from [<802bcad0>]
>>> (timecounter_read+0x14/0x8c) [253287.500889] [<802bcad0>]
>>> (timecounter_read) from [<808ae078>] (e1000e_phc_gettime+0x34/0x6c)
>>> [253287.509403] [<808ae078>] (e1000e_phc_gettime) from [<808ae1dc>]
>>> (e1000e_systim_overflow_work+0x1c/0x44)
>>> [253287.518875] [<808ae1dc>] (e1000e_systim_overflow_work) from
>>> [<8027a588>] (process_one_work+0x12c/0x3f8) [253287.528347]
>>> [<8027a588>] (process_one_work) from [<8027a8a0>]
>>> (worker_thread+0x4c/0x530) [253287.536515] [<8027a8a0>]
>>> (worker_thread) from [<8027f700>] (kthread+0xdc/0xf4) [253287.543816]
>>> [<8027f700>] (kthread) from [<80222f54>] (ret_from_fork+0x18/0x24)
>>> [253287.551115] Code: e240aa02 e24dd014 e51a37e0 e2833cb6 (e5936000)
>>> [253287.557286] ---[ end trace 795e386dc7b45ae9 ]--- [253287.562873]
>>> Unable to handle kernel paging request at virtual address ffffffec
>>>
>>
>> In the message above, you have all the information you need to start digging
>> that issue. The "Unhandled fault" message is sent from a single place in the
>> ARM kernel, i.e. do_DataAbort(), so this should ring a bell about the reason
>> for that fault.
>>
>> Since that fault is synchronous, you also know that the PC value reported in
>> the message must be the address of the faulting instruction living in
>> e1000e_cyclecounter_read(). Disassembling the vmlinux image will give you
>> the exact instruction from the offset mentioned from the beginning of that
>> routine.
>>
>> From that point, you need to deduce the most probable cause by yourself,
>> trying different configurations such as disabling PTP, to make sure the issue
>> does not reappear elsewhere, showing some randomness, which would
>> reveal a deeper problem.
>>
>> For my part, I don't see any way to answer a question such as "how to make
>> the system stable", except maybe debugging it.
>>
>> --
> Thanks,  Philippe.
> I added RTDM_IRQ_HANDLED to irq hander, and no 1000 IRQs issue.
> And I will redo the stable test.
> For my test, I don't do anything, let the kernel idle after startup the Linux.
> 
> BTW, can we make MSIx or MSI work for PCIe? If can, how to do it?
> Because I just can make INTx work for PCIe.
> 

The driver has to configure the device to use message-signaled IRQs, and
CONFIG_PCI_MSI is required.

-- 
Philippe.

