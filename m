MIME-Version: 1.0
Date: Wed, 20 Jun 2012 17:20:54 +0530
Message-ID: <CAM1yFZ_+KHJ6BaWf_mxMHteROa1=PEsW5a5Mnpb7hRnNgzig+w@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] No options visible in the "Real-time sub-system" tab in
 the "make menuconfig" screen of kernel-2.6.38.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Greetings,

Since my PCI card wasn't too compatible with the RTnet's real time
experimental driver, I fetched RTL-8139 card, and put it on another
machine with older version of openSUSE.

anisha@linux-2gbt:~> uname -a && cat /etc/issue
Linux linux-2gbt 2.6.22.5-31-default #1 SMP 2007/09/21 22:29:00 UTC
i686 i686 i386 GNU/Linux
Welcome to openSUSE 10.3 (i586) - Kernel \r (\l).

--------------------------------------------

Now,
- I installed xenomai-2.6.0
- downloaded kernel version "linux-2.6.38.8".

Ran:
linux-2gbt:/usr/src/xenomai-2.6.0 # scripts/prepare-kernel.sh
--linux=/usr/src/linux-2.6.38.8/
--adeos=ksrc/arch/x86/patches/adeos-ipipe-2.6.38.8-x86-2.10-01.patch

This went on smoothly.

--------------------------------------------

Then I did a make menuconfig in the source tree of 2.6.38.8 and jumped
on the tab "Real-time sub-system".

That resulted in a screen containing ___"nothing more than"___ the follows:

*** WARNING! You enabled APM, CPU Frequency scaling, ACPI 'processor' ***
*** or Intel cpuidle option. These options are known to cause troubles ***
*** with Xenomai, disable them. ***
*** NOTE: Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER
disabled. ***
*** (menu Processor type and features) ***

There are "not" any options present in that screen. It is blank.

What could have gone wrong? Please help,

-- 
Anisha Kaul

