From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <bb8f24a9-17fb-7230-1371-35085882cc6f@xenomai.org>
Date: Fri, 30 Mar 2018 20:01:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai / UDOO x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?0KjQtdCy0YfQtdC90LrQviDQotCw0YDQsNGBINCT0YDQuNCz0L7RgNGM0LU=?= =?UTF-8?B?0LLQuNGH?= <shevchenko.taras@triolcorp.com.ua>, Olej <o.tsiliuric@yandex.ru>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


> Hi all,
> I finished some experiments to figure out what is going on
> so  again
> I have udoo board x86 ultra
> 
> 1) Use ubuntu with vanile kernel 4.10.0-28 or 4.13.0-37 or 4.9.51   no problem with sd card , all work perfectly
> 2) Use 4.9.51 with ipipe patch   -pipe-core -4.9.51-x86-4.patch  guide to system no responce
>  when i insert sd-card or insert own rtdm module for gpio test  and gpio interrupt occured
> 3) I use xenomai from git branch  stable-3.0.y (download yesterday)
> 4) there is options from menuconfig that I enable/disable

Interrupt issues are most likely an I-pipe problem with your hardware.
There are several interrupt controllers on the board, each controller
driver has to be fixed up for supporting interrupt pipelining.

On x86, this work has already been done for the common APIC and IO-APIC
chips, I suspect that some GPIO pin controller driver has not been fixed
up in your case.

To find out which one, boot your vanilla kernel ensuring that all the
drivers you need are loaded, then have a look at the label column of
/proc/interrupts. The name of the controller is mentioned there:

$ cat /proc/interrupts

e.g.
           CPU0       CPU1       CPU2       CPU3
   0:         74          0          0          0   IO-APIC    2-edge
                                                    ^^^^^^^
timer
 122:          0          0          0          0   PCI-MSI 294912-edge

                                                    ^^^^^^^
ahci[0000:00:12.0]

Find the corresponding driver in the kernel source, for anything which
is different from IO-APIC, and PCI-*. You may exclude all IRQs with
symbolic names from the list (e.g. LOC, SPU, PMI), only care for
numbered IRQs.

The string you should be looking for is defined in the .name field of
the irqchip descriptor advertised by those drivers.

static struct irq_chip ioapic_chip __read_mostly = {
	.name			= "IO-APIC",

defined in arch/x86/kernel/apic/io_apic.c

This process of elimination should give you the name of an interrupt
controller driver which has not been fixed up, i.e. not bearing any
CONFIG_IPIPE changes. This one (or maybe several of them) may break the
kernel when CONFIG_IPIPE is enabled for that very reason.

PS: please no private mails, use the mailing list for technical matters.

-- 
Philippe.

