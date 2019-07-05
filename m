Subject: Re: ipipe 4.19: spurious APIC interrupt when setting rt_igp to up
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <VI1PR05MB5917761A9138FE1E9EC30710F6FA0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <9ebf71d7-6a49-3eeb-d5a6-89d122136999@siemens.com>
 <788b682a-4845-31af-df17-f1008d143068@siemens.com>
 <ab6862a6-de5c-2c37-50a1-86e509768ecf@siemens.com>
 <VI1PR05MB5917125E023F3F1588F1B817F6F50@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <6a2a0a5e-7390-a303-5fdf-0d6cd662d413@siemens.com>
Message-ID: <39f2b9f2-845b-5746-e1c7-530ac48561b3@siemens.com>
Date: Fri, 5 Jul 2019 15:56:56 +0200
MIME-Version: 1.0
In-Reply-To: <6a2a0a5e-7390-a303-5fdf-0d6cd662d413@siemens.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 05.07.19 13:29, Jan Kiszka wrote:
> On 05.07.19 12:43, Lange Norbert wrote:
>>
>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Freitag, 5. Juli 2019 09:39
>>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>>> (xenomai@xenomai.org) <xenomai@xenomai.org>; Philippe Gerum
>>> <rpm@xenomai.org>
>>> Subject: Re: ipipe 4.19: spurious APIC interrupt when setting rt_igp to up
>>>
>>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>>> ATTACHMENTS.
>>>
>>>
>>> On 04.07.19 12:21, Jan Kiszka wrote:
>>>> On 04.07.19 12:15, Jan Kiszka wrote:
>>>>> On 04.07.19 10:57, Lange Norbert via Xenomai wrote:
>>>>>> Hello,
>>>>>>
>>>>>> using the rt_igb driver with the recent ipipe/kernel will result in
>>>>>> a broken state (I assume one cpu core is “stuck”).
>>>>>>
>>>>>> This is a quote from Phillipe (note that I tested the plain upstream
>>>>>> revivision below)
>>>>>>> This happens specifically when the igb driver enables the device at
>>>>>>> rtifconfig up only with 4.19+.
>>>>>>> The HIPASE clock device is fine and can be enabled manually with no
>>> issue.
>>>>>>> The spurious IRQ
>>>>>>> message is only a symptom, something seems wrong with this fairly
>>>>>>> old (rt_)igb code on recent kernels.
>>>>>>
>>>>>> + modprobe rtnet
>>>>>> + modprobe rtpacket
>>>>>> + modprobe rt_igp
>>>>>> [  325.791715] RTnet: registered rteth0 [  325.795328] rt_igb
>>>>>> 0000:03:00.0: Intel(R) Gigabit Ethernet Network Connection [
>>>>>> 325.802505] rt_igb 0000:03:00.0: rteth0: (PCIe:2.5Gb/s:Width x1)
>>>>>> 22:20:47:8d:0f:c9
>>>>>> [  325.810103] rt_igb 0000:03:00.0: rteth0: PBA No: FFFFFF-0FF [
>>>>>> 325.815696] rt_igb 0000:03:00.0: Using MSI-X interrupts. 1 rx
>>>>>> queue(s), 1 tx queue(s) [  325.823638] sdhci-pci 0000:00:1b.0: SDHCI
>>>>>> controller found [8086:5aca] (rev b)
>>>>>>
>>>>>> + rtifconfig rteth0 up
>>>>>> [  326.066500] spurious APIC interrupt through vector ff on CPU#0,
>>>>>> should never happen.
>>>>>>
>>>>>
>>>>> Can you retry with https://lkml.org/lkml/2019/7/3/143 applied? It
>>>>> should tell us the real vector number.
>>>>>
>>>>> I'll see in parallel if I can reproduce with rt_igb here.
>>
>> Applying that patch then causes the ipipe-patch to fail.
>> Would take me some time to cleanup.
>>
> 
> Yes, did this yesterday, and it requires more work. But the information from it 
> is no longer essential.
> 
>>>>
>>>> Already succeeded, with rt_e1000e in KVM. Debugging...
>>>>
>>>
>>> This addresses it on x86 for me:
>>>
>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c index
>>> 6c279e065879..d503b875f086 100644
>>> --- a/kernel/irq/chip.c
>>> +++ b/kernel/irq/chip.c
>>> @@ -1099,7 +1099,8 @@ void ipipe_enable_irq(unsigned int irq)
>>>                  ipipe_root_only();
>>>
>>>                  raw_spin_lock_irqsave(&desc->lock, flags);
>>> -               if (desc->istate & IPIPE_IRQS_NEEDS_STARTUP) {
>>> +               if (desc->istate & IPIPE_IRQS_NEEDS_STARTUP &&
>>> +                   !WARN_ON(irq_activate(desc))) {
>>>                          desc->istate &= ~IPIPE_IRQS_NEEDS_STARTUP;
>>>                          chip->irq_startup(&desc->irq_data);
>>>                  }
>>
>> Problem still persists for me with that patch. I use a nfsroot (with a 
>> USB->ETH adapter so I can kick out the linux igb driver),
>> Maybe that’s related.
> 
> Does reducing your machine to maxcpus=1 resolve the issue? I could imagine we an 
> affinity problem on top.
> 

We do have an affinity problem, will try to fix it soon, but that didn't allow 
me to reproduce your issue with my patch applied.

Could you turn on CONFIG_GENERIC_IRQ_DEBUGFS and grab the content of 
/sys/kernel/debug/irq? Maybe Linux considers the interrupt in question here as 
"affinity managed by kernel", and then my patch is nop. Still need to understand 
all implications of this managed mode for I-pipe.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

