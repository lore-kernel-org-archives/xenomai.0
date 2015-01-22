Date: Thu, 22 Jan 2015 16:53:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150122155344.GA29604@hermes.click-hack.org>
References: <1537147.Wm9AbiuW5D@soho>
 <20150122075429.GI16075@hermes.click-hack.org>
 <2769633.cTWk055Sma@soho>
 <20150122144224.GK30245@csclub.uwaterloo.ca>
 <54C1127A.4020208@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54C1127A.4020208@siemens.com>
Subject: Re: [Xenomai] Xenomai-3 booting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Thu, Jan 22, 2015 at 04:08:42PM +0100, Jan Kiszka wrote:
> On 2015-01-22 15:42, Lennart Sorensen wrote:
> > On Thu, Jan 22, 2015 at 09:34:11AM +0100, Leopold Palomo-Avellaneda wrote:
> >> El Dijous, 22 de gener de 2015, a les 08:54:29, Gilles Chanteperdrix va 
> >> escriure:
> >>> On Thu, Jan 22, 2015 at 08:47:24AM +0100, Leopold Palomo-Avellaneda wrote:
> >>>> Hi,
> >>>>
> >>>>
> >>>> I have compiling a Cobalt kernel. I have followed the web "wikipress"
> >>>> [1];-) recommendations. However, my box (a normal desktop computer - Dell
> >>>> Optiplex 7010 -) doesn't boot. It throws a message like:
> >>>> ....
> >>>> timer doesn't work through interrup-remapped IO-apic
> >>>>
> >>>> ...
> >>>>
> >>>> enabling noapic in the boot options I'm able to boot. But, I have not make
> >>>> any test by now. Some interesting messages:
> >>>>
> >>>> $ dmesg | grep -i xenomai
> >>>> [    0.000000] Linux version 3.16.0-xenomai-3.0.0 (root@soho) (gcc version
> >>>> 4.9.1 (Debian 4.9.1-19) ) #1 SMP Wed Jan 21 16:29:36 UTC 2015
> >>>> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.16.0-xenomai-3.0.0
> >>>> root=UUID=15cfac82-1127-421f-9aed-eaf48247ed4e ro quiet noapic
> >>>> [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.16.0-
> >>>> xenomai-3.0.0 root=UUID=15cfac82-1127-421f-9aed-eaf48247ed4e ro quiet
> >>>> noapic [    0.705071] [Xenomai] scheduling class idle registered.
> >>>> [    0.705072] [Xenomai] scheduling class rt registered.
> >>>> [    0.705090] [Xenomai] disabling automatic C1E state promotion on Intel
> >>>> processor
> >>>> [    0.705104] [Xenomai] SMI-enabled chipset found, but SMI workaround
> >>>> disabled
> >>>>
> >>>>           (see xenomai.smi parameter). You might encounter
> >>>>
> >>>> [    0.705284] I-pipe: head domain Xenomai registered.
> >>>> [    0.717986] [Xenomai] Cobalt v3.0-rc2 (Exact Zero) [DEBUG]
> >>>> [    0.897726] usb usb1: Manufacturer: Linux 3.16.0-xenomai-3.0.0 xhci_hcd
> >>>> [    0.898617] usb usb2: Manufacturer: Linux 3.16.0-xenomai-3.0.0 xhci_hcd
> >>>> [    0.914114] usb usb3: Manufacturer: Linux 3.16.0-xenomai-3.0.0 ehci_hcd
> >>>> [    0.930109] usb usb4: Manufacturer: Linux 3.16.0-xenomai-3.0.0 ehci_hcd
> >>>> *** RTnet for Xenomai v3.0-rc2 ***
> >>>>
> >>>>
> >>>> So, can avoid to pass the noapic parameter to the kernel to boot?
> >>>
> >>> Please post the full boot logs, and the kernel configuration. 
> >>
> >> Attached.
> >>
> >>
> >>> Does the
> >>> kernel work with exactly the same .config but without Xenomai? 
> >>
> >> I don't know. It's a similar kernel configuration than debian ships with 
> >> jessie.
> >>
> >>> Is
> >>> CONFIG_SMP enabled? Because if CONFIG_SMP is enabled, Xenomai will
> >>> not work without an APIC.
> >>
> >> Yes, CONFIG_SMP=y and CONFIG_X86_IO_APIC=y
> > 
> > But your kernel commandline included 'quiet noapic' in the above, which
> > would turn of apic use even if the config could use it.
> 
> To make it clearer: NEVER use noapic on a modern x86 system. It neither
> makes sense anymore nor will it work on many of them. It just routes the
> system into rarely tested paths, both in the kernel and possibly also
> the hardware and firmware.

It is worse than that, Xenomai without APIC does not work on SMP
systems. The only case where it could run would be if the system has
enough HPET timers, but I have never run Xenomai on a system where
this is true, except qemu-kvm where you can have as many hpet timers
as you want.

-- 
					    Gilles.

