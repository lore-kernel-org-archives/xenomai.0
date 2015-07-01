MIME-Version: 1.0
From: Antoine Durand <wanipof@gmail.com>
Date: Wed, 1 Jul 2015 17:56:25 +0200
Message-ID: <CAOL1OyMAYBfKQp0W1W+B_=438upRo-M-LepAh9biKXt=AqHZHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RTDM PCI drivers IRQ line conflict
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I've two PCI devices for which I'm making RTDM drivers.

I can load the first without any problem.

but when the second driver call rtdm_irq_request (passing the struct
pci_dev->irq field and flag RTDM_IRQTYPE_SHARED), it failed with EBUSY :
The IRQ line is already in use.

lspci before the insmod give that result :
I can see that IRQ for thoses devices are 11 and 11

04:08.0 Class 0680: Device 10b5:9080 (rev 03)
    Subsystem: Device 10b5:2402
    Flags: bus master, medium devsel, latency 64, IRQ 11
    Memory at e0801000 (32-bit, non-prefetchable) [size=256]
    I/O ports at d000 [size=256]
    Memory at e0800000 (32-bit, non-prefetchable) [size=256]

06:00.0 Class 0680: Device 10e3:0148 (rev 01)
    Subsystem: Device 1775:7866
    Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
    Memory at c0000000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [40] PCI-X non-bridge device

when I insmod the modules, the call to pci_enable_device print this for the
first device

pci 0000:05:00.0: using bridge 0000:00:1c.0 INT A to get IRQ 16
rtdm_tsi148 0000:06:00.0: PCI->APIC IRQ transform: INT A -> IRQ 16

and this for the second

rtdm_16aio 0000:02:08.0: using bridge 0000:01:00.0 INT A to get IRQ 16
rtdm_16aio 0000:02:08.0: PCI->APIC IRQ transform: INT A -> IRQ 16

If I understand, IRQ are remapped by APIC but sadly on the same IRQ again.

Is there any way to change affected IRQ lines ?
is it a hardware specific problem ?

The devices seem to not support MSI.
They seem to be unable to share interrupt too.

I run linux 3.16.7 with Xenomai 3 rc5

I'm not sure if it's a linux problem or xenomai specific ?

Thank You for your help.
