Message-ID: <451C586A.7020309@domain.hid>
Date: Thu, 28 Sep 2006 17:19:06 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] possible future conflict w LOCAL_APIC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

hi guys,

I encountered this error building 18-mm2 with a .config Ive been
using with xenomai since I started.  


> arch/i386/kernel/built-in.o(.text+0x34f1): In function `do_nmi':
> arch/i386/kernel/traps.c:752: undefined reference to 
> `panic_on_unrecovered_nmi'
> arch/i386/kernel/built-in.o(.text+0x3564):arch/i386/kernel/traps.c:712: 
> undefined reference to `panic_on_unrecovered_nmi'
> 
> 
> $ grep nmi arch/i386/kernel/Makefile
> obj-$(CONFIG_X86_LOCAL_APIC)    += apic.o nmi.o
> 
> which I dont have enabled.


Will fix.

BTW I was planning to make LOCAL_APIC unconditional on i386 too like on x86-64.
There is basically no reason ever to disable it, and the bug work around
for buggy BIOS one can be done at runtime. Overall the #ifdef / compile breakage
ratio vs saved code on disabled APIC code is definitely unbalanced.

-Andi



This looks like it may become a problem:

Q: The kernel message log says:
   "Xenomai: Local APIC absent or disabled!
    Disable APIC support or pass "lapic" as bootparam."

A: Xenomai sends this message if the kernel configuration Xenomai was
   compiled against enables the local APIC support
   (CONFIG_X86_LOCAL_APIC), but the processor status gathered at boot
   time by the kernel says that no local APIC support is available.
   There are two options for fixing this issue:

   o either your CPU really has _no_ local APIC hw, then you need to
     rebuild a kernel with LAPIC support disabled, before rebuilding
     Xenomai against the latter;



Is this something fundamental or merely inconvenient ?




