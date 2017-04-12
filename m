MIME-Version: 1.0
In-Reply-To: <861193a4-0741-db5b-06ff-cdcaa3ed1d59@xenomai.org>
References: <CAKbLDQOXrHX2bZd0jZ=WEBG7rDZ8OeKuFHpSDZy98s6NxR50FQ@mail.gmail.com>
 <861193a4-0741-db5b-06ff-cdcaa3ed1d59@xenomai.org>
From: Ashwin Narayan <ashwinnarayan1994@gmail.com>
Date: Wed, 12 Apr 2017 19:56:11 +0800
Message-ID: <CAKbLDQNvWphPRx3nsJMbhyW=uX_G5-ur0RQ3xk-SqNBo0Nqi+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Advantech PCM3680I with Xenomai: Probe failed with
 error -5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Apr 12, 2017 at 5:14 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 04/11/2017 12:22 PM, Ashwin Narayan wrote:
>> Dear All,
>>
>> I'm having trouble getting the Advantech PCM3680I working under
>> xenomai. I scanned the dmesg log and this is what I get:
>>
>> [    1.344697] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
>> [    1.344794] RTCAN SJA1000 driver initialized
>> [    1.344989] ADV-PCI-CAN 0000:01:04.0: RTCAN Registering card
>> [    1.345281] ADV-PCI-CAN 0000:01:04.0: RTCAN detected Advantech PCI
>> card at slot #4
>> [    1.345295] ADV-PCI-CAN: Initializing device 13fe:c002:c002
>> [    1.345310] ADV-PCI-CAN: base_addr=000000000001ef00 conf_addr=
>>     (null) irq=16 ocr=0xfa cdr=0xc0
>> [    1.345373] rtcan: registered rtcan0
>> [    1.345386] Unregistering SJA1000 device rtcan0
>> [    1.345403] RTCAN: unregistered rtcan0
>> [    1.345646] ADV-PCI-CAN: probe of 0000:01:04.0 failed with error -5
>> [    1.345793] rtcan: registered rtcan0
>> [    1.345799] rtcan0: VIRT driver loaded
>> [    1.345818] rtcan: registered rtcan1
>> [    1.345824] rtcan1: VIRT driver loaded
>>
>> At first I suspected that the problem could be that the kernel was
>> compiled with the Networking Devices -> CAN Subsystem enabled. So I
>> disabled that and recompiled the kernel and I got the same error
>> message.
>>
>> To find out where the error message is coming from, I tried running
>> the command grep -rnw . -e "probe f" from the directory
>> xenomai-3.0.4/. Couldn't find that string anywhere in the source.
>>
>
> This message is issued by the regular Linux driver core, upon return
> from some probe() routine in the RTCAN driver. errno 5 is EIO, you may
> want to check sja1000/rtcan_adv_pci.c to figure out the reason for
> receiving it.
>
> --
> Philippe.


Hi Philippe,

>Sorry, I forgot to send the reply to the mailing list.:

Thanks for the suggestion. I made some progress looking in that file.

I tried adding printk() statements in rtcan_adv_pci.c and compiling
and I figured out where the error is happening. In the rtcan_adv_pci.c
line 202 - 207:

    202 /* check if mode is set */
    203 ret = chip->read_reg(dev, SJA_CDR);
    204 if (ret != SJA_CDR_CAN_MODE) {
    205     ret = -EIO;
    206     goto failure_iounmap;
    207 }

The chip->read_reg(dev, SJA_CDR) does not return SJA_CDR_CAN_MODE. So
ret = -EIO (-5) and the probe fails. Could this be something wrong
with the way the driver assignes the io regions? I compared the code
in this file with the driver that is provided by advantech (which is
not realtime) and there were a few differences. Namely, the advantech
driver uses request_region() instead of pci_iomap(). I tried following
the execution paths of both the advantech and the xenomai drivers. My
device id is c002

For the advantech driver it goes like:
pci_enable_device(pdev)
ifndef CONFIG_PCI_MSI
pci_enable_msi(pdev)
#endif
for i=0; i<2: i++
    address = pci_resource_start(pdev, 0) + 0x100*i
    request_region(address, 0x100, "advcan")

For the xenomai driver, pci_iomap(pdev, 0, ADV_PCI_BASE_SIZE) is used instead.

I basically hit a dead end here because I only have a beginner's
knowledge of how PCI drivers work. Is this an error that is fixable by
modifying just rtcan_adv_pci.c?

Thanks for all the help,

-Ashwin

