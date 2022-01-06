Message-ID: <512ba0a9-fa7b-acd8-6dc6-a3032481934e@siemens.com>
Date: Thu, 6 Jan 2022 09:18:58 +0100
MIME-Version: 1.0
Subject: Re: rtnet rt_igb I210 not working with ARM
Content-Language: en-US
References: <AS8PR09MB53544DAD9617B02126202C6381699@AS8PR09MB5354.eurprd09.prod.outlook.com>
 <ff8025f0-bdac-a99d-a69f-9fb77c824db5@siemens.com>
 <AS8PR09MB535414BA830FF82F9D26320B814B9@AS8PR09MB5354.eurprd09.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AS8PR09MB535414BA830FF82F9D26320B814B9@AS8PR09MB5354.eurprd09.prod.outlook.com>
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

On 06.01.22 00:39, Yann Le Chevoir via Xenomai wrote:
>>> Hello,
>>>
>>> I have an issue with rt_igb not working with an Intel I210 on ARM (see
>>> system configuration below).
>>> With Wireshark, looks like rtping is sending garbage on the network
>>> (see below).
>>> I notice there is no interrupt in /proc/xenomai/irq (see below).
>>> Looks like other people got issues with I210 in the past but I am not
>>> sure if they were similar and I am not able to find any conclusion.
>>>
>>> Below, I show you how I am inserting the kernel module + how I am able
>>> to have it working with igb (no realtime) and rt_fec (different driver
>>> for the other Ethernet controller on the same board).
>>>
>>> What can I do to solve this issue?
>>> Is there anything else I can try to give you more data?
>>>
>>
>> Could you check if that card works in a standard PC (x86-64) with RTnet?
>> Could you also check if latest 3.2.1 makes any difference? Not all fixes on
>> RTnet have been backported to very-old-stable.
>>
>> Jan
> 
> Hello Jan, all,
> 
> Happy new year!
> 
> Sorry for the delay, I needed to update my Linux kernel
> (Freescale/linux-fslc) from version 4.9.67 to version 5.4.147 to be able
> to compile Xenomai 3.2.1. I am still using I-pipe, not Dovetail, right?

Yes, everything up to and including 5.4 is I-pipe, 5.10 and later is
dovetail.

> I notice that the type of interruption changed since the previous version:
> we now have "Using MSI-X interrupts" instead of "Using MSI interrupts".

Maybe the host controller of your SoC gained MSI-X support betwen 4.9
and 5.4? Then both the standard driver and rt_igb would try to use that
instead (MSI is legacy).

> And there is this new error: "Error 2 getting interrupt" which prevents to
> have rteth0 configured (see below). That's different from last time.
> I notice that the driver igb itself does not work with the new Xenomai
> kernel (see below). That's also different from last time. I confirmed that
> it works with the non-xenomai kernel though (same kernel 5.4.147 without
> the I-pipe patch).

5.4.147 - that is no official ipipe-arm release. Did you integrate the
patch yourself base on which I-pipe core revision? And how about
ipipe-core-5.4.151-arm-4?

> Note: to have the driver igb working with the Xenomai kernel, I can use
> the legacy interrupts ("pci=nomsi" on the kernel command line).
> Does this "error 2" sound familiar? Is there anything else I can try?

ENOENT - you could try search the code for sources of this error code.
But it may also come from the PCI or MSI core.

> 
> I did not try with a standard x86-64 PC yet. Do you think it may still
> help? I have the feeling that this irq issue is very specific to my arm
> SOC.

Not unlikely. I'm afraid there is no way around digging for the source
of the error code. That can help to understand better what goes wrong

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

