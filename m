Subject: Re: ipipe 4.19: spurious APIC interrupt when setting rt_igp to up
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <VI1PR05MB5917761A9138FE1E9EC30710F6FA0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <9ebf71d7-6a49-3eeb-d5a6-89d122136999@siemens.com>
Message-ID: <788b682a-4845-31af-df17-f1008d143068@siemens.com>
Date: Thu, 4 Jul 2019 12:21:02 +0200
MIME-Version: 1.0
In-Reply-To: <9ebf71d7-6a49-3eeb-d5a6-89d122136999@siemens.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 04.07.19 12:15, Jan Kiszka wrote:
> On 04.07.19 10:57, Lange Norbert via Xenomai wrote:
>> Hello,
>>
>> using the rt_igb driver with the recent ipipe/kernel will result in a broken 
>> state
>> (I assume one cpu core is “stuck”).
>>
>> This is a quote from Phillipe (note that I tested the plain upstream 
>> revivision below)
>>> This happens specifically when the igb driver enables the device at 
>>> rtifconfig up only with 4.19+.
>>> The HIPASE clock device is fine and can be enabled manually with no issue. 
>>> The spurious IRQ
>>> message is only a symptom, something seems wrong with this fairly old 
>>> (rt_)igb code on recent kernels.
>>
>> + modprobe rtnet
>> + modprobe rtpacket
>> + modprobe rt_igp
>> [  325.791715] RTnet: registered rteth0
>> [  325.795328] rt_igb 0000:03:00.0: Intel(R) Gigabit Ethernet Network Connection
>> [  325.802505] rt_igb 0000:03:00.0: rteth0: (PCIe:2.5Gb/s:Width x1) 
>> 22:20:47:8d:0f:c9
>> [  325.810103] rt_igb 0000:03:00.0: rteth0: PBA No: FFFFFF-0FF
>> [  325.815696] rt_igb 0000:03:00.0: Using MSI-X interrupts. 1 rx queue(s), 1 
>> tx queue(s)
>> [  325.823638] sdhci-pci 0000:00:1b.0: SDHCI controller found [8086:5aca] (rev b)
>>
>> + rtifconfig rteth0 up
>> [  326.066500] spurious APIC interrupt through vector ff on CPU#0, should 
>> never happen.
>>
> 
> Can you retry with https://lkml.org/lkml/2019/7/3/143 applied? It should tell us 
> the real vector number.
> 
> I'll see in parallel if I can reproduce with rt_igb here.

Already succeeded, with rt_e1000e in KVM. Debugging...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

