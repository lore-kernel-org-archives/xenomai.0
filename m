Message-ID: <36cd4a03-9d83-22c6-7bc0-9490820dd123@siemens.com>
Date: Mon, 7 Feb 2022 08:18:40 +0100
MIME-Version: 1.0
Subject: Re: rtnet rt_igb I210 not working with ARM
Content-Language: en-US
References: <AS8PR09MB53544DAD9617B02126202C6381699@AS8PR09MB5354.eurprd09.prod.outlook.com>
 <ff8025f0-bdac-a99d-a69f-9fb77c824db5@siemens.com>
 <AS8PR09MB535414BA830FF82F9D26320B814B9@AS8PR09MB5354.eurprd09.prod.outlook.com>
 <512ba0a9-fa7b-acd8-6dc6-a3032481934e@siemens.com>
 <AS8PR09MB53547FCFB3BEC71C11C9AAC081229@AS8PR09MB5354.eurprd09.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AS8PR09MB53547FCFB3BEC71C11C9AAC081229@AS8PR09MB5354.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Yann Le Chevoir <yann.lechevoir@cae.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 29.01.22 00:31, Yann Le Chevoir wrote:
>>>>> I have an issue with rt_igb not working with an Intel I210 on ARM
>>>>> (see system configuration below).
>>>>> With Wireshark, looks like rtping is sending garbage on the network
>>>>> (see below).
>>>>> I notice there is no interrupt in /proc/xenomai/irq (see below).
>>>>> Looks like other people got issues with I210 in the past but I am
>>>>> not sure if they were similar and I am not able to find any conclusion.
>>>>>
>>>>> Below, I show you how I am inserting the kernel module + how I am
>>>>> able to have it working with igb (no realtime) and rt_fec (different
>>>>> driver for the other Ethernet controller on the same board).
>>>>>
>>>>> What can I do to solve this issue?
>>>>> Is there anything else I can try to give you more data?
>>>>>
>>>> Could you check if that card works in a standard PC (x86-64) with RTnet?
>>>> Could you also check if latest 3.2.1 makes any difference? Not all
>>>> fixes on RTnet have been backported to very-old-stable.
>>>>
>>>> Jan
>>>
>>> Sorry for the delay, I needed to update my Linux kernel
>>> (Freescale/linux-fslc) from version 4.9.67 to version 5.4.147 to be
>>> able to compile Xenomai 3.2.1. I am still using I-pipe, not Dovetail, right?
>>
>> Yes, everything up to and including 5.4 is I-pipe, 5.10 and later is dovetail.
>>
>>> I notice that the type of interruption changed since the previous version:
>>> we now have "Using MSI-X interrupts" instead of "Using MSI interrupts".
>>
>> Maybe the host controller of your SoC gained MSI-X support betwen 4.9 and
>> 5.4? Then both the standard driver and rt_igb would try to use that instead
>> (MSI is legacy).
>>
>>> And there is this new error: "Error 2 getting interrupt" which
>>> prevents to have rteth0 configured (see below). That's different from last
>> time.
>>> I notice that the driver igb itself does not work with the new Xenomai
>>> kernel (see below). That's also different from last time. I confirmed
>>> that it works with the non-xenomai kernel though (same kernel 5.4.147
>>> without the I-pipe patch).
>>
>> 5.4.147 - that is no official ipipe-arm release. Did you integrate the patch
>> yourself base on which I-pipe core revision? And how about ipipe-core-
>> 5.4.151-arm-4?
> 
> Hello Jan, all,
> 
> What I "always" did for kernels linux-fslc-imx
>     4.1.38 (Yocto Morty),
>     4.9.67 (Yocto Thud)
>     and 5.4.147 (Yocto Dunfell)
> is that I tried to apply the closest arm I-pipe patch as possible:
>     - Given an example, I used ipipe-core-5.4.151-arm-4.patch to patch
>       Yocto Dunfell.
>     - Then, I manually resolved the conflicts.
>     - That went well (happy with the performances and the rtcan driver).
>     - Idea was to stay as close as possible of the official Yocto branch
>       we are using. Does that make sense?

I would not blindly use downstream kernels (Yocto, Freescale/NXP etc.)
unless you know why you need them.

> By reading your answer, I wondered if I did right. So I also tried to
> compile the kernel from the ipipe-arm repo:
>     - Branch ipipe/5.4.y.
>     - That compiles and boots.
>     - But, for the rt_igb, same issue as previous procedure:
>       "Error 2 getting interrupt".
> 
>>> Note: to have the driver igb working with the Xenomai kernel, I can
>>> use the legacy interrupts ("pci=nomsi" on the kernel command line).
>>> Does this "error 2" sound familiar? Is there anything else I can try?
>>
>> ENOENT - you could try search the code for sources of this error code.
>> But it may also come from the PCI or MSI core.
>>
>>>
>>> I did not try with a standard x86-64 PC yet. Do you think it may still
>>> help? I have the feeling that this irq issue is very specific to my
>>> arm SOC.
>>
>> Not unlikely. I'm afraid there is no way around digging for the source of the
>> error code. That can help to understand better what goes wrong
> 
> I tried so many different versions.
> I finally came back to my initial version:
>     linux-fslc-imx 4.9.67
>       + ipipe-core-4.9.51-arm-4.patch (adapted)
>       + Xenomai 3.0.9 or 3.0.12.
>     - With this one, at least, the non-Xenomai igb driver works with the
>       I-pipe patch.
>     - I figured out that by disabling MSI (pci=nomsi), the irq counter in
>       /proc/xenomai/irq started to increment for rt_igb.
>     - Then, I confirmed that the buffers (ICMP or ARP frames) were correct
>       (printk in the igb_main.c source code).
>     - I also realized that the RX was working.
>       The RTnet stack was preparing an ARP response to my Windows ping.
>     - Only the TX was not good (garbage on Wireshark).
> 
> I finally have something working with the patch bellow.
> So:
>     - pci=nomsi to have the irq counter incrementing.
>     - dma_sync_single_for_device in igb_tx_map to have rt_igb sending
>       good data.
> 
> My questions:
> What are your feeling about that?
> Is dma_sync real-time? Is it a good fix/workaround?

In the best case, it's just a barrier (but there is already a wmb()). In
the worst case, Linux code is triggered that actually does more, e.g.
because DMA is not cache-coherent. You will have to analyze what is
actually done in that function on your platform.

> Why do I need to add such a dma_sync with my arm SoC?
>     - I suspect that this driver would work on a regular x86...
>     - Can you tell if it works on other arm SoC?

I don't think this was tried on ARM so far, but then the topic will
actually be rather SoC-specific.

> Any suggestion to do work the driver with MSI instead of legacy interrupts?
> Any suggestion to do work rt_igb with Kernel 5.4 + Xenomai 3.2?
> 
> The patch (igb_tx_map with Xenomai 3.0.12):
> --- kernel.ori/drivers/net/drivers/igb/igb_main.c
> +++ kernel/drivers/net/drivers/igb/igb_main.c
> @@ -4095,6 +4095,7 @@
>  	size = skb->len;
> 
>    dma = rtskb_data_dma_addr(skb, 0);
> +  dma_sync_single_for_device(tx_ring->dev, dma, size, DMA_BIDIRECTIONAL);
> 

Comparing the code against the related Linux driver regarding DMA and
possibly also regarding configuration for MSI-X will be needed. There
will be no way around understanding how DMA works as well as how MSI-X
is delivered. Then it should become clearer what is missing in the
rt_igb driver or possibly also in ARM-enablement of Xenomai for that SoC.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

