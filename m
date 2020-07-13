Subject: Re: FW: Xenomai with isolcpus and workqueue task
References: <c25a1993-e0e1-eebf-a4f8-a5c5f0d7604c@nicevt.ru>
 <VI1PR05MB5917C0D09456A2D0B2FF2CA1F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB5917D1573DCB81C9DA2CEAB3F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <941d830d-981c-3514-0776-9394ba34a3e1@nicevt.ru>
 <VI1PR05MB5917E51B793D4A2F1ADECF41F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Alexander Frolov <frolov@nicevt.ru>
Message-ID: <95137112-f581-d8f6-5988-cf6fb73040f6@nicevt.ru>
Date: Mon, 13 Jul 2020 14:08:54 +0300
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917E51B793D4A2F1ADECF41F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>



On 7/13/20 1:48 PM, Lange Norbert wrote:
>
>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Alexander
>> Frolov via Xenomai
>> Sent: Montag, 13. Juli 2020 12:27
>> To: xenomai@xenomai.org
>> Subject: Re: FW: Xenomai with isolcpus and workqueue task
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> -----Original Message-----
>>>> From: Lange Norbert
>>>> Sent: Montag, 13. Juli 2020 10:34
>>>> To: Alexander Frolov <frolov@nicevt.ru>
>>>> Subject: RE: Xenomai with isolcpus and workqueue task
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of
>> Alexander
>>>>> Frolov via Xenomai
>>>>> Sent: Samstag, 11. Juli 2020 16:26
>>>>> To: xenomai@xenomai.org
>>>>> Subject: Xenomai with isolcpus and workqueue task
>>>>>
>>>>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>>>> ATTACHMENTS.
>>>>> Hi all!
>>>>>
>>>>> I am using Xenomai 3.1 with 4.19.124 I-pipe patchon a smp motherboa=
rd.
>>>>> For my RT task I allocate few CPU cores with isolcpus option.
>>>>> However, large latency spikes are noticed due to igb watchdog
>>>>> activities (I am using common igb driver, not rt_igb).
>>>>>
>>>>> Looking into igb sources, it was understood that workqueue is used
>>>>> for some tasks (afaiu, it is used to link status
>>>>> monitoring)
>>>>>
>>>>> from igb_main.c
>>>>> ...
>>>>>      INIT_WORK(&adapter->reset_task, igb_reset_task);
>>>>>      INIT_WORK(&adapter->watchdog_task, igb_watchdog_task); ...
>>>>>
>>>>> The Linux kernel scheduler runs this igb activities on isolated CPU=
s
>>>>> disregarding isolcpus option, ruining real-time system behavior.
>>>> isolcpus does not mean the CPUs aren't used, it means they are
>>>> excluded from the normal CPU scheduler. No process will automaticall=
y
>>>> be moved from/to isolated CPUs, but you still need to make sure to
>>>> free them of any tasks.
>>>> Irq-handlers still run anywhere, and processes still can allow those
>>>> CPUs to be used.
>>>>
>>>>> So the question, is it a correct way to use normal igb on Xenomai a=
t
>>>>> all or it is not recommended? What can be done to prohibit Linux
>>>>> scheduler to allocate those tasks on isolated cores?
>>>> I use the normal igb and rt_igb concurrently, I doubt it is
>>>> recommended but possible ;)
>>>>
>>>> You should add irqaffinity=3D0 to the cmdline (CPU0 is apparently
>>>> always used for irqs), then check 'cat /proc/irq/*/smp_affinity'.
>>>> This keeps the other CPUs free from linux IRQs.
>>>> You can use some measures to bind Linux tasks to CPU0 aswell. One of=
:
>>>>
>>>> -   isolcpus (sets default affinity mask aswell)
>>>> -   set affinity early (like in Ramdisk)
>>>> -   Use cgroups (cset-shield)
>>>>
>>>> Only cgroups actually prohibit processes ignoring your defaults and
>>>> using other CPUs, I did not get around playing with this, and just u=
se
>> isolcpus.
>>>> But the most important part is to dont run RT on cores dealing with
>>>> Linux interrupts, some handlers/drivers don=E2=80=99t expects being
>>>> preempted, had the MMC driver bail because of a timeout.
>>>>
>>>> I haven=E2=80=99t solved moving the rtnet-stack, rtnet-rpc off CPU0,=
 and the
>>>> rt_igb IRQs will use all CPUs.
>>>>
>>>> Norbert
>> Thank you! Using an IRQ affinity feature to move handlers to specified=
 cores
>> is very practical, but in this case we experience problem with another
>> artefakt of igb.
>>
>> Just as example of influence of igb activity (igb_watchdog_task) on CP=
U4
>> (which is an isolated one).
> Hmm, I dont have that task.
> You can use taskset -p 0 <pidof igb_watchdog_task> to change affinity,
> If not pretty but should work.
>
> (isolcpus doesn=E2=80=99t work the way you think, it only affects CPU m=
igration)

  Not sure, that I can find out <pidof igb_watchdog_task>, cause it can b=
e kworker
  thread which takes this task to execution. I can try to move all kworke=
rs to general-
  purposed cores, which looks a bit crazy.

>
>> # cat /proc/ipipe/trace/frozen | grep '\!'
>> ...
>> :  +func               -1231!  52.379  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x520 [igb])
>> :  +func               -1145!  45.864  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x536 [igb])
>> :  +func               -1099!  51.917  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x75a [igb])
>> :  +func               -1047!  51.517  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x782 [igb])
>> :  +func                -996!  51.988  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x54e [igb])
>> :  +func                -944!  51.436  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x564 [igb])
>> :  +func                -893!  52.569  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x57a [igb])
>> :  +func                -840!  52.529  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x590 [igb])
>> :  +func                -787!  52.018  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x5a6 [igb])
>> :  +func                -735!  52.058  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x5bc [igb])
>> :  +func                -683!  51.497  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x5d2 [igb])
>> :  +func                -632!  51.436  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x5e8 [igb])
>> :  +func                -580!  51.416  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x5fe [igb])
>> :  +func                -529!  52.038  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x614 [igb])
>> :  +func                -477!  52.058  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x62a [igb])
>> :  +func                -425!  51.436  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x6f4 [igb])
>> :  +func                -373!  51.416  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x70a [igb])
>> :  +func                -322!  51.517  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x720 [igb])
>> :  +func                -271!  51.847  igb_rd32+0x0 [igb]
>> (igb_update_stats+0x736 [igb])
>> :  +func                -189!  47.247  igb_rd32+0x0 [igb]
>> (igb_ptp_rx_hang+0x1e [igb])
>> :  +func                -103!  72.735  igb_rd32+0x0 [igb]
>> (igb_watchdog_task+0x66a [igb])
>>
>>
>>   From the other side, rt kernels do not have this issue, probably bec=
ause of
>> modified workqueue subsystem.
>>
>> Any ideas how to keep this work out of critical code?
> Is this task blocking RT from running? I mean it's better to run it at =
another core,
> particularly because register accesses are painfully slow on that hardw=
are.
> But I don=E2=80=99t see why it should make a big impact.
Yes, that what it does. I think igb_rd32 is too slow, do not know why,=20
however.
>
> Norbert
>
> ________________________________
>
> This message and any attachments are solely for the use of the intended=
 recipients. They may contain privileged and/or confidential information =
or other information protected from disclosure. If you are not an intende=
d recipient, you are hereby notified that you received this email in erro=
r and that any review, dissemination, distribution or copying of this ema=
il and any attachment is strictly prohibited. If you have received this e=
mail in error, please contact the sender and delete the message and any a=
ttachment from your system.
>
> ANDRITZ HYDRO GmbH
>
>
> Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Co=
rporation
>
> Firmensitz/ Registered seat: Wien
>
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>
> Firmenbuchnummer/ Company registration: FN 61833 g
>
> DVR: 0605077
>
> UID-Nr.: ATU14756806
>
>
> Thank You
> ________________________________


