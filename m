Message-ID: <43F5CAE8.9010905@domain.hid>
Date: Fri, 17 Feb 2006 14:08:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <43F447AF.4020604@domain.hid>	
	<000a01c63304$94ee5190$1e01a8c0@domain.hid>
	<fd6a47a90602170454q1cc93f23h@domain.hid>
In-Reply-To: <fd6a47a90602170454q1cc93f23h@domain.hid>
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
>     I tried this patch and it doesn't solve the issue I'm facing. With and
>     without this patch, my symptoms are the same. 
> 
> 
> I tested (and intended) the patch for MSI (w/o maskbits), not MSI-X. 
> What e1000 chip are you using exactly? Easiest way to tell is by using 
> '/sbin/lspci'. I may be able to help you out with MSI-X as well, but in 
> that case, I have no hardware platform to test on.
>

Could you post the patch you are successfully using to boot your box? TIA,

> You can check whether or not MSI is actually being used by doing 
> '/sbin/lspci -v' and look for the Capability: Message Signalled 
> Interrupt. When the driver is running in MSI mode, it should read 
> 'Enable+' instead of 'Enable-'.
> 
> Finally, verify how interrupts are dispatched. Have a look at 
> /proc/interrupts for this (cat /proc/interrupts').
> 
>     I'm running a Dell 2850, dual CPU machine.
> 
> 
> As it's a Dell, I assume there's two Intel Penium CPU's inside. Are you 
> running with SMP enabled ?
> 
>       When I build a kernel without
>     Adeos then things are fine.  When I build with Adeos and MSI enabled
>     the
>     following occurs:
> 
>     1) If BIOS has USB disabled then the system will hang without even a
>     num-lock respose (i.e. tapping the num-lock key doesn't toggle the
>     light).
>     The hang occurs just about the time the E1000 driver would load and
>     enable
>     an MSI interrupt.
> 
>     2) If BIOS has USB enabled then the system will run much longer but
>     may hang
>     during heavy interrupt load on the E1000 driver.
> 
> 
> Are you using the e1000 driver in NAPI mode ? It is recommended to do 
> this, especially on the preemptible kernel, as it may significantly 
> reduce the interrupt volume. In that case, I think it is doubtful if 
> using MSI would give you any benefit at all over normal, shared IRQs.
> 
>     My assumption based on past experience is that no num-lock response
>     means an
>     infinite interrupt loop. 
> 
> 
> The local (internal) CPU APIC hasn't been informed that the interrupt 
> has been dealt with and it will therefore allow no other interrupts 
> anymore to arrive in the CPU (including your keyboard's). In fact, your 
> CPU is idle.
> 
> [The original 8259 was designed to detect the IRET instruction bit 
> pattern on the databus and use that as an acknowledge signal. Upon 
> arrival of the second 8259 in the PC/AT, this could no longer be done. I 
> don't know if the APIC could do it today (it seems possible, 
> theoretically). ]
>  
> When I build a kernel with Adeos but disable MSI then the system works fine
> 
>     for the most part.  There is one scenario where the system will
>     still hang
>     doing disk and network accesses under a moderate load of I/O. 
> 
> 
> Hm. That may indicate another issue.

Indeed. This behaviour has not been reported yet with patches from the Adeos 
I-pipe series. Does it also happen with SMP disabled, or Hyperthreading disabled?

> 
>     Both of these tests are just to get a stable kernel before I really
>     start
>     using Adeos.  So Adeos is in its default configuration and I haven't
>     loaded
>     Xenomai modules when these hangs occur.
> 
>     I'm currently running the 2.6.14.4 <http://2.6.14.4> kernel with the
>     2.6.14-1.0-12 patch of
>     adeos and then I included your msi.c patch from the previous
>     e-mail.  If you
>     have any further hints or suggestions I'll try them.  Meanwhile I'm
>     trying
>     different versions of various drivers (e1000 and scsi) as well as
>     updating
>     the patch level of the kernel itself.
> 
> 
> Try upgrading the kernel. The kernel usually comes with updated drivers 
> as well. Currently I'm running 2.6.16-rc2, which I had to patch manually 
> for Adeos (about 3 'hunks' from the 2.6.15-i386-1.2-00 patch didn't 
> apply properly). By using 2.6.16-rc2, I got much better Intel 
> (especially i865 graphics) chipset support than 2.6.15. Note, however, 
> that I did the bug fixing in this thread on a plain 2.6.15, though (and 
> the msi.c code is nearly identical).
> 
> I would recommend upgrading to 2.6.15 with the latest Adeos patch and 
> try to get a stable system before enabling MSI.
> 
> Jeroen.
> 


-- 

Philippe.

