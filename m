Message-ID: <43F5EF88.1080400@domain.hid>
Date: Fri, 17 Feb 2006 16:45:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <001d01c633d0$7a5a7300$1e01a8c0@domain.hid>
In-Reply-To: <001d01c633d0$7a5a7300$1e01a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Russell Johnson <rjohnson@domain.hid>
Cc: 'xenomai-core' <xenomai@xenomai.org>

Russell Johnson wrote:
>>>I tested (and intended) the patch for MSI (w/o maskbits), not MSI-X.
>>>What e1000 chip are you using exactly? Easiest way to tell is by using 
>>>'/sbin/lspci'. I may be able to help you out with MSI-X as well, but in 
>>>that case, I have no hardware platform to test on.
> 
> 
>>>You can check whether or not MSI is actually being used by doing 
>>>'/sbin/lspci -v' and look for the Capability: Message Signalled 
>>>Interrupt. When the driver is running in MSI mode, it should read 
>>>'Enable+' instead of 'Enable-'.
> 
> 
> This e1000 chip actually doesn't have MSI support.  I had assumed that since
> the e1000 driver caused the hanging and disabling MSI in the kernel caused
> the hang to go away that the problem was MSI in the e1000.  The e1000 driver
> only enables MSI on newer chips than what are in the Dell 28xx machines.
>

Same problem here actually; the e1000 driver attempts to enable MSI routing for 
recent adapters (i82547 rev. #2, if I read this code correctly) due to bugs in 
older revisions. Unfortunately, the dual Xeon I've been using to check for 
CONFIG_PCI_MSI has an older adapter, so the routing is still done by the IO-APIC, 
and the bug does not trigger.

> 
>>>As it's a Dell, I assume there's two Intel Penium CPU's 
>>>inside. Are you running with SMP enabled ?
> 
> 
> SMP is enabled.
> 
> 
>>>The local (internal) CPU APIC hasn't been informed that the interrupt 
>>>has been dealt with and it will therefore allow no other interrupts 
>>>anymore to arrive in the CPU (including your keyboard's). 
>>>In fact, your CPU is idle.
> 
> 
> I have used a PCI analyzer to see infinite loops on this machine for past
> similar kernel issues and assumed it would be the same due to the symptoms.
> 
> 
>>>    When I build a kernel with Adeos but disable MSI then the 
>>>    system works fine for the most part.  There is one scenario 
>>>    where the system will still hang
>>>    doing disk and network accesses under a moderate load of I/O. 
>>>
>>>Hm. That may indicate another issue.
>>
>>Indeed. This behaviour has not been reported yet with patches 
>>from the Adeos I-pipe series. Does it also happen with SMP 
>>disabled, or Hyperthreading disabled?
> 
> 
> It did happen with SMP disabled and I have always left hyperthreading
> disabled because it is my understanding that hyperthreading is not supported
> by the adeos patch.

Adeos should not have any problem with HT; actually it has no impact on the 
interrupt sub-system it deals with, we just happen to see multiple CPUs, which is 
common case handled by the SMP support.

> 
> 
>>>Try upgrading the kernel. The kernel usually comes with updated drivers 
>>>as well. Currently I'm running 2.6.16-rc2, which I had to patch manually
> 
> 
>>>for Adeos (about 3 'hunks' from the 2.6.15-i386-1.2-00 patch didn't 
>>>apply properly). By using 2.6.16-rc2, I got much better Intel 
>>>(especially i865 graphics) chipset support than 2.6.15. Note, however, 
>>>that I did the bug fixing in this thread on a plain 2.6.15, though (and 
>>>the msi.c code is nearly identical).
>>>
>>>I would recommend upgrading to 2.6.15 with the latest Adeos patch and 
>>>try to get a stable system before enabling MSI.
> 
> 
> In short, MSI doesn't seem to have been my issue.  I now have a more stable
> kernel.  Apparently this system had some other faults with the specific
> configuration options I was using.  I had to patch to the 2.6.14.7 level
> (was at .4) and change some of the options in my .config.  Specifically, I
> had to leave ACPI enabled (I had disabled as a test a while back).  With
> ACPI disabled, the machine would still hang if the USB was disabled in the
> BIOS.

You might want to try booting with acpi=ht, so that the ACPI kitchen sink is 
warmed up far enough to enumerate LAPICs but not more.

> 
> After learning how to check for MSI, no devices in my system seem to
> actually be using MSI.  The code patches you provided were never actually
> executed.  Time will tell if my system is stable.
> 
> Thanks for your help!

You are welcome.

> Russ
> 
> 
> 


-- 

Philippe.

