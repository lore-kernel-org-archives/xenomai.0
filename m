References: <8763c6b1-5bcb-62ee-056b-3329696b9ee3@nta-inc.net>
 <a3b259a3-af5f-e28a-8f8c-8470050dba13@xenomai.org>
 <03d954a8-b1d8-b101-8ea3-80999f99178e@nta-inc.net>
 <87412c1c-90c2-9824-b057-2909515f05a0@xenomai.org>
 <b3f70312-9c73-b981-5817-14865ece6783@nta-inc.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <598cb827-9cfb-4d10-6d28-3efaebc800a0@xenomai.org>
Date: Tue, 15 Aug 2017 15:40:39 +0200
MIME-Version: 1.0
In-Reply-To: <b3f70312-9c73-b981-5817-14865ece6783@nta-inc.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Trouble with ipipe/linux >= 4.4.43 on x86/64 system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>, xenomai@xenomai.org

On 08/02/2017 10:55 PM, Jeff Webb wrote:
> On 08/02/2017 01:51 PM, Philippe Gerum wrote:
>> On 08/02/2017 08:28 PM, Jeff Webb wrote:
>>> On 08/02/2017 12:04 PM, Philippe Gerum wrote:
>>>> On 08/02/2017 06:43 PM, Jeff Webb wrote:
>>>>> I am attempting to upgrade our x86/64 PC systems running
>>>>> linux-3.14.17/xenomai-2.6.4 to xenomai-3.x.  I have successfully
>>>>> built and booted a linux-4.1.18/xenomai-3.0.5 kernel on one of
>>>>> them using:
>>>>>
>>>>>     ipipe-core-4.1.18-x86-9.patch
>>>>>
>>>>> however, I cannot boot systems based on:
>>>>>
>>>>>     ipipe-core-4.4.43-x86-8.patch
>>>>>     ipipe-core-4.4.71-x86-8.patch
>>>>>     ipipe-core-4.9.24-x86-2.patch
>>>>>
>>>>> with the CONFIG_IPIPE=y.  I can get these configurations to boot
>>>>> by disabling CONFIG_IPIPE.  The main issue seems to be that
>>>>> the primary hard drive does not work.  There also seems to be an
>>>>> issue with some of the USB ports.
>>>>>
>>>>> I have attached several files:
>>>>>
>>>>> - cpuinfo.txt: cpuinfo for the first core
>>>>> - boot-4.4.43-ipipeoff.notime: serial boot log (system works)
>>>>> - boot-4.4.43-ipipeon.notime.matchup: serial boot log (system hangs)
>>>>> - config-4.4.43-ipipeoff: (system works)
>>>>> - config-4.4.43-ipipeon: (system hangs)
>>>>>
>>>>> The times have been stripped from the boot logs and the second
>>>>> boot log has been slightly rearranged to make diffing with the two
>>>>> logseasier.  I can send the raw logs instead, if that is helpful.
>>>>>
>>>>> Any help on getting later kernels to work would be appreciated.
>>>>
>>>> Maybe an issue with a secondary interrupt controller.
>>>>
>>>> - the output of /proc/interrupts on a booting kernel (say 4.9.24) would
>>>> help figuring out which ICs are active on this hw.
>>>
>>> Please see the interrupts.txt attachment.
>>
>> Ah, looks like yet another issue with interrupt remapping. Could you try
>> without CONFIG_IRQ_REMAP in your Kconfig to check this?
> 
> Yes, it boots when I turn off CONFIG_IRQ_REMAP.
> 
>>>> As a matter of fact,
>>>> the driver has issues receiving events from the SATA controller once
>>>> the
>>>> interrupt pipeline is engaged. Likewise for the USB part as you
>>>> mentioned as well.
>>>>
>>>> - does it boot in uniprocessor mode?
>>>>
>>>
>>> Yes, it boots with maxcpus=0 or noapic, but not maxcpus=1.
>>>
>>
>> This affects IR, so this would make sense.
>>
> 
> Thanks,
> 

Although I could not reproduce the original issue on the couple of x86 SoCs I have access to, I believe this patch should help. At any rate, the current implementation is broken wrt to holding remappable interrupts. If you can give this a try, any feedback welcome. Thanks.

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index f26d949..d800e58 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1954,6 +1954,16 @@ static void hold_ioapic_irq(struct irq_data *irq_data)
 	ioapic_ack_level(irq_data);
 }
 
+static void hold_ioapic_ir_irq(struct irq_data *irq_data)
+{
+	struct mp_chip_data *data = irq_data->chip_data;
+
+	raw_spin_lock(&ioapic_lock);
+	__mask_ioapic(data);
+	raw_spin_unlock(&ioapic_lock);
+	ioapic_ir_ack_level(irq_data);
+}
+
 static void release_ioapic_irq(struct irq_data *irq_data)
 {
 	struct mp_chip_data *data = irq_data->chip_data;
@@ -1997,7 +2007,7 @@ static struct irq_chip ioapic_ir_chip __read_mostly = {
 #ifdef CONFIG_SMP
 	.irq_move		= move_xxapic_irq,
 #endif
-	.irq_hold		= hold_ioapic_irq,
+	.irq_hold		= hold_ioapic_ir_irq,
 	.irq_release		= release_ioapic_irq,
 #endif
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-- 
Philippe.

