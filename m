Subject: Re: Interrupt timeout
References: <VI1PR05MB5917D6B0922458527599EDE1F6ED0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <CALLqZ8RSqv_OZTRApV+n+3zmgjz1KcLRBLmd+vLWE6MRYaS9ag@mail.gmail.com>
 <VI1PR05MB591716533325E3DB1EEBD573F6ED0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2e8126ff-7b0d-e114-568f-1e38c530f895@siemens.com>
Date: Tue, 25 Feb 2020 16:46:34 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB591716533325E3DB1EEBD573F6ED0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 25.02.20 16:40, Lange Norbert via Xenomai wrote:
> 
> 
>> -----Original Message-----
>> From: Greg Gallagher <greg@embeddedgreg.com>
>> Sent: Dienstag, 25. Februar 2020 16:24
>> To: Lange Norbert <norbert.lange@andritz.com>
>> Cc: Xenomai (xenomai@xenomai.org) <xenomai@xenomai.org>; Philippe
>> Gerum (rpm@xenomai.org) <rpm@xenomai.org>
>> Subject: Re: Interrupt timeout
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> Hi,
>>
>> On Tue, Feb 25, 2020 at 8:57 AM Lange Norbert via Xenomai
>> <xenomai@xenomai.org> wrote:
>>>
>>> Hello,
>>>
>>> I hope you can give me some pointers to understand why this Bug
>> happened.
>>> It seems an interrupt got lost somehow, maybe some issue with
>> leveltriggers?
>>>
>>> Note that I run on an Apollo Lake, which would normally use
>>> PINCTRL_BROXTON, but that’s not fixed up for Xenomai yet. The system
>>> works fine from eMMC otherwise, this bug occurred only once so far.
>>>
>>> 00:1b.0 SD Host controller: Intel Corporation Atom/Celeron/Pentium
>>> Processor N4200/N3350/E3900 Series SDXC/MMC Host Controller (rev 0b)
>>> Subsystem: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900
>>> Series SDXC/MMC Host Controller Kernel driver in use: sdhci-pci Kernel
>>> modules: sdhci_pci
>>> 00:1c.0 SD Host controller: Intel Corporation Atom/Celeron/Pentium
>>> Processor N4200/N3350/E3900 Series eMMC Controller (rev 0b)
>>> Subsystem: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900
>>> Series eMMC Controller Kernel driver in use: sdhci-pci Kernel modules:
>>> sdhci_pci
>>>
>>> # cat /proc/interrupts
>>>              CPU0       CPU1       CPU2       CPU3
>>>     0:         50          0          0          0   IO-APIC    2-edge      timer
>>>     4:          0          0        498          0   IO-APIC    4-edge      ttyS0
>>>     8:          0          0          0          0   IO-APIC    8-edge      rtc0
>>>     9:          0          0          0          0   IO-APIC    9-fasteoi   acpi
>>>    20:         20          0          0          0   IO-APIC   20-fasteoi   i801_smbus
>>>    39:          0       1315          0          0   IO-APIC   39-fasteoi   mmc0
>>>   129:          0          1          0          0   PCI-MSI 1048576-edge      enp2s0
>>>   130:          0          0        839          0   PCI-MSI 1048577-edge      enp2s0-rx-0
>>>   131:          0          0          0        773   PCI-MSI 1048578-edge      enp2s0-rx-1
>>>   132:        985          0          0          0   PCI-MSI 1048579-edge      enp2s0-tx-0
>>>   133:          0        773          0          0   PCI-MSI 1048580-edge      enp2s0-tx-1
>>>   134:          0          0          0          1   PCI-MSI 1572864-edge      enp3s0
>>>   135:      11464          0          0          0   PCI-MSI 1572865-edge      enp3s0-rx-0
>>>   136:          0        781          0          0   PCI-MSI 1572866-edge      enp3s0-rx-1
>>>   137:          0          0        899          0   PCI-MSI 1572867-edge      enp3s0-tx-0
>>>   138:          0          0          0       9701   PCI-MSI 1572868-edge      enp3s0-tx-1
>>>   139:          1          0          0          0   PCI-MSI 2097152-edge      enp4s0
>>>   140:          0       1985          0          0   PCI-MSI 2097153-edge      enp4s0-TxRx-0
>>>   141:          0          0        774          0   PCI-MSI 2097154-edge      enp4s0-TxRx-1
>>>   142:          0          0          0       1905   PCI-MSI 2097155-edge      enp4s0-TxRx-2
>>>   143:        775          0          0          0   PCI-MSI 2097156-edge      enp4s0-TxRx-3
>>>   144:          0          0      97790          0   PCI-MSI 344064-edge      xhci_hcd
>>>   NMI:          0          0          0          0   Non-maskable interrupts
>>>   LOC:      47839     147583      13807      32602   Local timer interrupts
>>>   SPU:          0          0          0          0   Spurious interrupts
>>>   PMI:          0          0          0          0   Performance monitoring interrupts
>>>   IWI:          0          0          0          0   IRQ work interrupts
>>>   RTR:          0          0          0          0   APIC ICR read retries
>>>   RES:      11955       6931       6567       4946   Rescheduling interrupts
>>>   CAL:        268        223        210        217   Function call interrupts
>>>   TLB:         63         57         61         50   TLB shootdowns
>>>   TRM:          0          0          0          0   Thermal event interrupts
>>>   THR:          0          0          0          0   Threshold APIC interrupts
>>>   MCE:          0          0          0          0   Machine check exceptions
>>>   MCP:          5          6          6          6   Machine check polls
>>>   ERR:          0
>>>   MIS:          0
>>>   PIN:          0          0          0          0   Posted-interrupt notification event
>>>   NPI:          0          0          0          0   Nested posted-interrupt event
>>>   PIW:          0          0          0          0   Posted-interrupt wakeup event
>>>
>>>
>>
>>> [  238.245509] mmc0: Timeout waiting for hardware interrupt.
>>> [  238.250944] mmc0: sdhci: ============ SDHCI REGISTER DUMP
>>> =========== [  238.257422] mmc0: sdhci: Sys addr:  0x20000008 |
>>> Version:  0x00001002 [  238.263900] mmc0: sdhci: Blk size:  0x00007200
>>> | Blk cnt:  0x00000000 [  238.270373] mmc0: sdhci: Argument:  0x00118678 |
>> Trn mode: 0x0000002b
>>> [  238.276848] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x0000003d
>>> [  238.283323] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> [  238.289797] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>> [  238.296265] mmc0: sdhci: Timeout:   0x00000007 | Int stat: 0x00000003
>>> [  238.302734] mmc0: sdhci: Int enab:  0x03ff000b | Sig enab:
>>> 0x03ff000b [  238.309206] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int:
>> 0x00000001
>>> [  238.315682] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>> [  238.322154] mmc0: sdhci: Cmd:       0x0000193a | Max curr: 0x00000000
>>> [  238.328618] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
>>> [  238.335080] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00000900
>>> [  238.341547] mmc0: sdhci: Host ctl2: 0x0000008d [  238.346016] mmc0:
>>> sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000179fcb20c [
>>> 238.353180] mmc0: sdhci:
>> ============================================
>>> [  248.485507] mmc0: Timeout waiting for hardware interrupt.
>>> [  248.490937] mmc0: sdhci: ============ SDHCI REGISTER DUMP
>>> =========== [  248.497412] mmc0: sdhci: Sys addr:  0x20000008 |
>>> Version:  0x00001002 [  248.503887] mmc0: sdhci: Blk size:  0x00007200
>>> | Blk cnt:  0x00000000 [  248.510362] mmc0: sdhci: Argument:  0x00000000 |
>> Trn mode: 0x00000023
>>> [  248.516838] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x0000003d
>>> [  248.523313] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> [  248.529790] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>> [  248.536266] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00018002
>>> [  248.542742] mmc0: sdhci: Int enab:  0x03ff000b | Sig enab:
>>> 0x03ff000b [  248.549219] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int:
>> 0x00000001
>>> [  248.555693] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>> [  248.562167] mmc0: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
>>> [  248.568643] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
>>> [  248.575117] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00000900
>>> [  248.581594] mmc0: sdhci: Host ctl2: 0x0000008d [  248.586065] mmc0:
>>> sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000179fcb20c [
>>> 248.593228] mmc0: sdhci:
>> ============================================
>>> [  249.137502] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>> [  249.143462] rcu:     1-...!: (1 GPs behind) idle=84a/1/0x4000000000000000
>> softirq=5875/5876 fqs=2479
>>> [  249.152458] rcu:     (detected by 3, t=21016 jiffies, g=5793, q=391)
>>> [  249.158588] Sending NMI from CPU 3 to CPUs 1:
>>> [  249.163984] rcu: rcu_sched kthread starved for 10920 jiffies! g5793
>>> f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2 [  249.174284] rcu: RCU
>> grace-period kthread stack dump:
>>> [  249.179364] rcu_sched       I    0    10      2 0x80000000
>>> [  249.184882] Call Trace:
>>> [  249.187360]  ? __schedule+0x340/0x8a0 [  249.191046]
>>> schedule+0x32/0x80 [  249.194211]  schedule_timeout+0x180/0x360 [
>>> 249.198248]  ? __next_timer_interrupt+0xd0/0xd0 [  249.202806]
>>> rcu_gp_kthread+0x522/0xec0 [  249.206667]  ? call_rcu_sched+0x20/0x20
>>> [  249.210528]  kthread+0x115/0x130 [  249.213779]  ?
>>> kthread_create_worker_on_cpu+0x70/0x70
>>> [  249.218861]  ret_from_fork+0x20/0x30 [  256.449655] igb
>>> 0000:04:00.0 enp4s0: igb: enp4s0 NIC Link is Down [  258.725508] mmc0:
>>> Timeout waiting for hardware cmd interrupt.
>>> [  258.731286] mmc0: sdhci: ============ SDHCI REGISTER DUMP
>>> =========== [  258.737761] mmc0: sdhci: Sys addr:  0x20000008 |
>>> Version:  0x00001002 [  258.744238] mmc0: sdhci: Blk size:  0x00007200
>>> | Blk cnt:  0x00000000 [  258.750716] mmc0: sdhci: Argument:  0x00010000 |
>> Trn mode: 0x00000023
>>> [  258.757191] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x0000003d
>>> [  258.763666] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> [  258.770143] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>> [  258.776620] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00018001
>>> [  258.783097] mmc0: sdhci: Int enab:  0x03ff000b | Sig enab:
>>> 0x03ff000b [  258.789570] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int:
>> 0x00000001
>>> [  258.796044] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>> [  258.802518] mmc0: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
>>> [  258.808994] mmc0: sdhci: Resp[0]:   0x00400900 | Resp[1]:  0xffffffff
>>> [  258.815468] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00000900
>>> [  258.821940] mmc0: sdhci: Host ctl2: 0x0000008d [  258.826411] mmc0:
>>> sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000179fcb20c [
>>> 258.833578] mmc0: sdhci:
>> ============================================
>>> [  268.965509] mmc0: Timeout waiting for hardware cmd interrupt.
>>> [  268.971285] mmc0: sdhci: ============ SDHCI REGISTER DUMP
>>> =========== [  268.977759] mmc0: sdhci: Sys addr:  0x20000008 |
>>> Version:  0x00001002 [  268.984233] mmc0: sdhci: Blk size:  0x00007200
>>> | Blk cnt:  0x00000000 [  268.990704] mmc0: sdhci: Argument:  0x00010000 |
>> Trn mode: 0x00000023
>>> [  268.997174] mmc0: sdhci: Present:   0x1fff0000 | Host ctl: 0x0000003d
>>> [  269.003647] mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
>>> [  269.010118] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>>> [  269.016590] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00018001
>>> [  269.023067] mmc0: sdhci: Int enab:  0x03ff000b | Sig enab:
>>> 0x03ff000b [  269.029538] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int:
>> 0x00000001
>>> [  269.036011] mmc0: sdhci: Caps:      0x546ec881 | Caps_1:   0x80000807
>>> [  269.042484] mmc0: sdhci: Cmd:       0x00000d1a | Max curr: 0x00000000
>>> [  269.048958] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
>>> [  269.055432] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00000900
>>> [  269.061904] mmc0: sdhci: Host ctl2: 0x0000008d [  269.066373] mmc0:
>>> sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000179fcb20c [
>>> 269.073542] mmc0: sdhci:
>> ============================================
>>>
>>>
>>> Kind regards,
>>> Norbert
>> I've seen this before when I was playing around with getting the ipipe to run
>> on my edison board.  I don't think it's ipipe related.  I found this thread on
>> patchwork:
>>
>> https://hes32-
>> ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fpatch
>> work.kernel.org%2fpatch%2f10705823%2f&umid=244f247b-9424-4d97-a301-
>> 43c83cda477c&auth=144056baf7302d777acad187aac74d4b9ba425e1-
>> f573aabf7731d50ca6bcfe66d4d4d92dfe84b1b2
> 
> Ah thanks,
> 
> Quote: "Commands and resets are under spin lock, so no possibility for preemption,
> and certainly a few microseconds isn't going to make any difference to these
> timeouts, so I don't see how this patch could help."
> 
> So I guess this is not an issue under plain Linux, but Cobalt could preempt for a
> couple of ms (or even longer if you managed to get an RT thread stuck).

That may also be different on PREEMPT-RT.

>>
>> There was another thread on the Ubuntu forums that solved the issue by
>> disabling the sdcard in the bios.
> 
> I can't do that, as this is the eMMC the system is running from.
> 
> BTW, if I would want to limit such issues, could I limit Linux IRQs (apart from a handful of necessary maintainance/timer) to a single core?
> 

Yes, that's the best option on a multicore system for both sides, RT and 
Linux.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

