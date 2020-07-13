Subject: Re: FW: Xenomai with isolcpus and workqueue task
References: <c25a1993-e0e1-eebf-a4f8-a5c5f0d7604c@nicevt.ru>
 <VI1PR05MB5917C0D09456A2D0B2FF2CA1F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB5917D1573DCB81C9DA2CEAB3F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Alexander Frolov <frolov@nicevt.ru>
Message-ID: <941d830d-981c-3514-0776-9394ba34a3e1@nicevt.ru>
Date: Mon, 13 Jul 2020 13:26:46 +0300
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917D1573DCB81C9DA2CEAB3F6600@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: xenomai@xenomai.org

-----Original Message-----
>> From: Lange Norbert
>> Sent: Montag, 13. Juli 2020 10:34
>> To: Alexander Frolov <frolov@nicevt.ru>
>> Subject: RE: Xenomai with isolcpus and workqueue task
>>
>>
>>
>>> -----Original Message-----
>>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Alexander
>>> Frolov via Xenomai
>>> Sent: Samstag, 11. Juli 2020 16:26
>>> To: xenomai@xenomai.org
>>> Subject: Xenomai with isolcpus and workqueue task
>>>
>>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>>
>>> Hi all!
>>>
>>> I am using Xenomai 3.1 with 4.19.124 I-pipe patchon a smp motherboard=
.
>>> For my RT task I allocate few CPU cores with isolcpus option. However=
,
>>> large latency spikes are noticed due to igb watchdog activities (I am
>>> using common igb driver, not rt_igb).
>>>
>>> Looking into igb sources, it was understood that workqueue is used fo=
r
>>> some tasks (afaiu, it is used to link status
>>> monitoring)
>>>
>>> from igb_main.c
>>> ...
>>>     INIT_WORK(&adapter->reset_task, igb_reset_task);
>>>     INIT_WORK(&adapter->watchdog_task, igb_watchdog_task); ...
>>>
>>> The Linux kernel scheduler runs this igb activities on isolated CPUs
>>> disregarding isolcpus option, ruining real-time system behavior.
>> isolcpus does not mean the CPUs aren't used, it means they are exclude=
d
>> from the normal CPU scheduler. No process will automatically be moved
>> from/to isolated CPUs, but you still need to make sure to free them of=
 any
>> tasks.
>> Irq-handlers still run anywhere, and processes still can allow those C=
PUs to
>> be used.
>>
>>> So the question, is it a correct way to use normal igb on Xenomai at
>>> all or it is not recommended? What can be done to prohibit Linux
>>> scheduler to allocate those tasks on isolated cores?
>> I use the normal igb and rt_igb concurrently, I doubt it is recommende=
d but
>> possible ;)
>>
>> You should add irqaffinity=3D0 to the cmdline (CPU0 is apparently alwa=
ys used
>> for irqs), then check 'cat /proc/irq/*/smp_affinity'. This keeps the o=
ther
>> CPUs free from linux IRQs.
>> You can use some measures to bind Linux tasks to CPU0 aswell. One of:
>>
>> -   isolcpus (sets default affinity mask aswell)
>> -   set affinity early (like in Ramdisk)
>> -   Use cgroups (cset-shield)
>>
>> Only cgroups actually prohibit processes ignoring your defaults and us=
ing
>> other CPUs, I did not get around playing with this, and just use isolc=
pus.
>>
>> But the most important part is to dont run RT on cores dealing with Li=
nux
>> interrupts, some handlers/drivers don=E2=80=99t expects being preempte=
d, had the
>> MMC driver bail because of a timeout.
>>
>> I haven=E2=80=99t solved moving the rtnet-stack, rtnet-rpc off CPU0, a=
nd the rt_igb
>> IRQs will use all CPUs.
>>
>> Norbert
Thank you! Using an IRQ affinity feature to move handlers to specified=20
cores is very
practical, but in this case we experience problem with another artefakt=20
of igb.

Just as example of influence of igb activity (igb_watchdog_task) on CPU4=20
(which is an
isolated one).

# cat /proc/ipipe/trace/frozen | grep '\!'
...
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -1231!=C2=A0 52.379=C2=A0 igb_rd32+0x0 [igb]=20
(igb_update_stats+0x520 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -1145!=C2=A0 45.864=C2=A0 igb_rd32+0x0 [igb]=20
(igb_update_stats+0x536 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -1099!=C2=A0 51.917=C2=A0 igb_rd32+0x0 [igb]=20
(igb_update_stats+0x75a [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 -1047!=C2=A0 51.517=C2=A0 igb_rd32+0x0 [igb]=20
(igb_update_stats+0x782 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -996!=C2=A0 51.988=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x54e [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -944!=C2=A0 51.436=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x564 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -893!=C2=A0 52.569=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x57a [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -840!=C2=A0 52.529=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x590 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -787!=C2=A0 52.018=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x5a6 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -735!=C2=A0 52.058=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x5bc [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -683!=C2=A0 51.497=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x5d2 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -632!=C2=A0 51.436=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x5e8 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -580!=C2=A0 51.416=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x5fe [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -529!=C2=A0 52.038=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x614 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -477!=C2=A0 52.058=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x62a [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -425!=C2=A0 51.436=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x6f4 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -373!=C2=A0 51.416=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x70a [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -322!=C2=A0 51.517=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x720 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -271!=C2=A0 51.847=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_update_stats+0x736 [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -189!=C2=A0 47.247=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_ptp_rx_hang+0x1e [igb])
:=C2=A0 +func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -103!=C2=A0 72.735=C2=A0 igb_rd32+0x0 [igb=
]=20
(igb_watchdog_task+0x66a [igb])


 From the other side, rt kernels do not have this issue, probably=20
because of modified workqueue
subsystem.

Any ideas how to keep this work out of critical code?

Thank you,
 =C2=A0=C2=A0 Alex Frolov



