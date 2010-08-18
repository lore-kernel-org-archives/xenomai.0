From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C6BCDE5.6050607@domain.hid>
References: <4C45539B.70204@domain.hid> <4C6932E8.7050701@domain.hid>
	<4C694AB3.8050407@domain.hid> <4C698E16.5050806@domain.hid>
	<1282040830.1730.232.camel@domain.hid>
	<4C6ACA50.3080108@domain.hid>
	<1282120049.1730.304.camel@domain.hid>
	<4C6BCDE5.6050607@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Aug 2010 16:53:39 +0200
Message-ID: <1282143219.1730.326.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-08-18 at 14:11 +0200, Stefan Kisdaroczi wrote:
> On 18.08.2010 10:27, Philippe Gerum wrote:
> > On Tue, 2010-08-17 at 19:43 +0200, Stefan Kisdaroczi wrote:
> >   
> >> On 17.08.2010 12:27, Philippe Gerum wrote:
> >>     
> >>> On Mon, 2010-08-16 at 21:14 +0200, Theo Veenker wrote:
> >>>   
> >>>       
> >>>> On 08/16/2010 04:26 PM, Theo Veenker wrote:
> >>>>     
> >>>>         
> >>>>> Gilles Chanteperdrix wrote:
> >>>>>       
> >>>>>           
> >>>>>> Theo Veenker wrote:
> >>>>>>         
> >>>>>>             
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> I want to upgrade all our PC's from Ubuntu hardy to lucid and in the
> >>>>>>> process
> >>>>>>> I'm also going from kernel 2.6.29.5 with Xenomai 2.4.8 to kernel
> >>>>>>> 2.6.32.11
> >>>>>>> with Xenomai 2.5.3.
> >>>>>>>
> >>>>>>> I first built and tested the 2.6.32.11 kernel with 2.5.3 on my hardy
> >>>>>>> system
> >>>>>>> and all went fine. But the problem is it just doesn't run on the
> >>>>>>> lucid distro.
> >>>>>>>           
> >>>>>>>               
> >>>>>> This, I do not understand, the kernel does not need any support from the
> >>>>>> distribution for booting, how can the same kernel boot with one
> >>>>>> distribution, and not with the other? When you say the "same kernel", do
> >>>>>> you mean the exact same zImage or bzImage, or do you mean the kernel
> >>>>>> with the same configuration, but with a different compiler, or only the
> >>>>>> version is identical?
> >>>>>>
> >>>>>>         
> >>>>>>             
> >>>>> It is a complete mystery to me either. I compiled my kernel into a deb
> >>>>> package
> >>>>> and installed the very same deb package on three machines:
> >>>>> MSI p45 neo3 with Hardy on it -> works OK
> >>>>> MSI p45 neo3 with Ludid on it -> nothing (works fine with regular kernel)
> >>>>> MSI 945P with Lucid on it: -> nothing (works fine with regular kernel)
> >>>>>
> >>>>> I'll try the suggestions posted and keep you informed.
> >>>>>       
> >>>>>           
> >>>> OK. Connected a terminal to catch early kernel messages. Still no output
> >>>> unfortunately (with the regular kernel I do get output on the terminal,
> >>>> so the connection works).
> >>>>
> >>>> Meanwhile also built and tested kernel 2.6.32.15 + xenomai 2.5.4. Still nothing.
> >>>> I'm clueless. I'm running Xenomai for years on dozens of systems and I've
> >>>> never run into problems like this. I think I'll have to sit down and take a
> >>>> close look at what I'm doing. I've always built my kernels using make-kpkg,
> >>>> maybe that somehow introduces a problem here. I'll try without it.
> >>>>
> >>>> (unfortunately/luckily I have to work from home for a few days so I can't
> >>>> get to the test system until later this week)
> >>>>     
> >>>>         
> >>> I failed to reproduce the issue yet, but it very much looks like an
> >>> I-pipe bug. Could you try the following config variants when time
> >>> allows:
> >>>   
> >>>       
> >> I installed the kernel (2.6.32.15 2.5.4 x86 32bit) which is working on
> >> my laptop in a kvm machine.
> >> In the virtual machine the kernel never starts and hangs.
> >> I attached gdb to kvm and according to the cpu registers and system.map
> >> it hangs in 'doublefault_fn'. As I'm not really familiar with gdb i'm
> >> thankful if someone has a hint how to proceed. Thanks
> >>     
> > If you could ask for a backtrace ("bt" command) in gdb once attached to
> > the hanged kernel, and post the output there, that would be great.
> >   
> 
> hi philippe, hope this helps:

Yes, it does a lot. Actually, I thought I fixed it months ago:
http://git.denx.de/?p=ipipe-2.6.git;a=commit;h=a250e984a76fd327a0d8cfada5290b27e99f1e4d

As a matter of fact, I did not. Oh well, ...

> 
> (gdb) bt
> #0  doublefault_fn () at arch/x86/kernel/doublefault_32.c:47
> #1  0x00000000 in ?? ()
> 
> I set two breakpoints:
> 1) do_test_wp_bit()
> 2) zap_low_mappings()
> 
> The second breakpoint is never reached, the fault seems to happen in
> do_test_wp_bit().
> arch/x86/mm/init_32.c : mem_init() -> test_wp_bit() -> do_test_wp_bit()
> 
> Breakpoint 1, do_test_wp_bit () at arch/x86/mm/init_32.c:981
> 981             __asm__ __volatile__(
> (gdb) info registers
> eax            0xffdff000       -2101248
> ecx            0x7fc    2044
> edx            0x13e8025        20873253
> ebx            0xff7fe000       -8396800
> esp            0xc1345fc0       0xc1345fc0
> ebp            0x3830   0x3830
> esi            0x160    352
> edi            0x48d    1165
> eip            0xc101a308       0xc101a308 <do_test_wp_bit>
> eflags         0x2      [ ]
> cs             0x60     96
> ss             0x68     104
> ds             0x7b     123
> es             0x7b     123
> fs             0xd8     216
> gs             0x0      0
> 
> > Meanwhile, I tried to reproduce the issue in kvm with no luck so far.
> > Aside of timing issues making the boot over kvm quite shaky and most of
> > the time impossible with the APIC enabled, using a legacy 8254 mode
> > boots but never hangs. Pure emulation with -no-kvm or enabling kvm on
> > the host does not make a difference. I've been trying with a 32bit guest
> > over a 64bit host, and both host and guest in 32bit mode to no avail so
> > far (QEMU PC emulator version 0.12.3 (qemu-kvm-0.12.3)).
> >
> > I had a bit more luck on real hw though; a m65 Dell workstation (core2
> > duo) seems to be kind enough to break during early boot. The failure
> > ratio is variable, but 1 crash over 3-5 boots is common; sometimes it
> > even crashes several times in a row. The bad news is that no rs232 is
> > available from this machine, and the crash happens way to early to count
> > on any usb<->serial converter to get any debug output; so this is going
> > to take some time to nail down the bug on this hw. I don't expect
> > netconsole to help me in any way either, for the same reason. Here are
> > some more information I could get though:
> >
> > - CONFIG_SMP, CONFIG_*_APIC/IO_APIC do not make any difference. I still
> > have a kernel crashing against the wall in plain, basic uniprocessor
> > mode (i.e. 8254 legacy IRQ and timing).
> >
> > - The very same kernel image does not break when booted via tftp here.
> > It really seems to need a boot of the kernel image from the hard drive
> > to get the issue. However, having the rootfs over NFS or on the hdd does
> > not seem to make any difference. This could be the sign of a mishandled
> > early access fault, which would be confirmed by your trace showing that
> > the double fault handler is called.
> >
> > - CONFIG_IPIPE introduces the issue alone; no need for CONFIG_XENOMAI.
> >
> > Since you are lucky enough to reproduce the bug over kvm, could you
> > confirm my findings on your setup? i.e. that CONFIG_SMP, CONFIG_*APIC*
> > and CONFIG_XENOMAI are not involved in this?
> >
> > PS: At this point, I think this bug only occurs in 32bit mode, but this
> > has to be verified.
> >
> > TIA,
> >
> >   
> 
> 

-- 
Philippe.



