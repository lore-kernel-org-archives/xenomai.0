From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16242.41287.468595.601469@domain.hid>
Date: Thu, 25 Sep 2003 10:03:19 +0200
Subject: Re: [Adeos-main] 2.6.0-test1
In-Reply-To: <200309250507.h8P57DN17280@domain.hid>
References: <200309250507.h8P57DN17280@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Der Herr Hofrat <der.herr@domain.hid>
Cc: adeos-main@gna.org


Hi Nicholas,

Der Herr Hofrat wrote:
 > 
 > Hi !
 > 
 >  2.6.0-test1 on AMD Duron stops with no further
 >  comment after
 > 
 >  Uncompressing Linux... Ok, booting the kernel.
 > 
 >  As <CNTRL><ALT><DEL> does not reboot the box  - I guess that could mean
 >  interrupts are disabled and not reenabled...
 > 
 > RH9.0
 > GCC-3.2.2
 > adeos-linux-2.6.0-test1-r1.diff
 > 
 >  The patched kernel with the config options for adeos disabled works fine
 >  
 >  how can I proceed on to find the problem ??
 > 

Adeos takes over the box much later (i.e. after init_IRQ in
init/main.c), so it is unlikely to interfere right after the primary
bootstrap.

There have been a number of issues with 2.5 concerning this kind of
behaviour, maybe it's still biting in early 2.6 (not sure, but...)?
http://www.zytor.com/pipermail/syslinux/2003-March/001716.html

In any case, you should at least see the boot messages up to the Adeos
startup. Here is a typical boot log from my box:

---
Linux version 2.6.0-test1-adeos (rpm@xenomai.org) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Tue Aug 19 18:21:51 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000effffc0 (ACPI data)
 BIOS-e820: 000000000effffc0 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
239MB LOWMEM available.
On node 0 totalpages: 61424
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57328 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: ro
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
>>ADEOS 2.6r2c1/x86: Root domain Linux registered.
>>ADEOS: Pipelining started.
---

Just to convince yourself, you could also try to build Adeos as a
module or even configure it out totally, so that no IRQ pipelining
occur during the boot phase. If I'm right, your kernel should not boot
either. In any case, the Adeos patch does not "statically" change the
way IRQs are initially routed to the kernel, but rather dynamically
re-program the IDT, only when the pipelining is started.

Philippe.


