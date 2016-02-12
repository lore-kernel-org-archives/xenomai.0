References: <56BDB259.2050606@sigmatek.at> <20160212113322.42ff3b8a@md1em3qc>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <56BDC574.4040008@sigmatek.at>
Date: Fri, 12 Feb 2016 12:43:48 +0100
MIME-Version: 1.0
In-Reply-To: <20160212113322.42ff3b8a@md1em3qc>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IRQ of pci express claimed by linux domain
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: henning.schild@siemens.com
Cc: xenomai@xenomai.org


Am 2016-02-12 um 11:33 schrieb Henning Schild:
> On Fri, 12 Feb 2016 11:22:17 +0100
> Wolfgang Netbal <wolfgang.netbal@sigmatek.at> wrote:
>
>> Dear all,
>>
>> I am using an imx6 controller where a FPGA-device is connected via
>> PCI express.
>> To use the FPGA in realtime I try to claim the IRQ 155 using
>> rtdm_irq_request() but the IRQ is hold by the linux domain.
>> It looks like the default driver claims the IRQ, but I have my own
>> driver that is linked to the device if we can trust the output of
>> lspci Has anyone of you an idea what could be the reason for this
>> issue or an idea how to fix it ?
> If you want to use another driver for the device you have to unload the
> driver currently in use, afterwards you should be able to claim the
> device in your driver.
> At runtime you can unbind the driver and keep the module loaded, or
> just unload the module. To avoid the driver taking control by default
> you have to blacklist the module in your distro, or disable it in your
> kernel config.
What I tried right now is that I use the function free_irq()
in my driver when probing the device,
but I got an error that the IRQ is not used, so no free is needed.
It seems that the IRQ was claimed after the driver was loaded,
I thought that no other driver should assigned to the device
if a driver is still in use.

Additional I tried another kernel image I created in november,
with this image everything works fine.
So it looks like I have change some kernel configs to produce this error,
do you have a hint what config could be the reason for this ?

>>   > cat /proc/interrupts
>>              CPU0       CPU1       CPU2       CPU3
>> ...
>> 150:      39833          0          0          0       GIC
>> 2188000.ethernet 151:          0          0          0
>> 0       GIC 2188000.ethernet 155:          0          0
>> 0          0       GIC  PCIe PME ...
>>
>>   > lspci -v
>> 00:00.0 PCI bridge: Device 16c3:abcd (rev 01) (prog-if 00 [Normal
>> decode]) Flags: bus master, fast devsel, latency 0
>>       Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
>>       Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>       Memory behind bridge: 01100000-012fffff
>>       [virtual] Expansion ROM at 01300000 [disabled] [size=64K]
>>       Capabilities: [40] Power Management version 3
>>       Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>>       Capabilities: [70] Express Root Port (Slot-), MSI 00
>>       Capabilities: [100] Advanced Error Reporting
>>       Capabilities: [140] Virtual Channel
>>       Kernel driver in use: pcieport
>>
>> 01:00.0 ACCESS Bus: Device 5112:0c00
>>       Subsystem: Device 5112:0c00
>>       Flags: bus master, fast devsel, latency 0, IRQ 155
>>       Memory at 01100000 (32-bit, non-prefetchable) [size=1M]
>>       Memory at 01200000 (32-bit, non-prefetchable) [size=1M]
>>       Capabilities: [40] Power Management version 3
>>       Capabilities: [48] MSI: Enable- Count=1/1 Maskable- 64bit+
>>       Capabilities: [58] Express Endpoint, MSI 00
>>       Capabilities: [100] Device Serial Number 00-00-00-01-01-00-0a-35
>>       Kernel driver in use: Sigmatek PCIE
>>
>>
>> Kind regards
>>
>


