From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17476.1481.90501.387014@domain.hid>
Date: Mon, 17 Apr 2006 23:16:57 +0200
Subject: Re: [Xenomai-core] [patch]  TROUBLESHOOTING additions, README tweaks
In-Reply-To: <4443C1B6.1080802@domain.hid>
References: <4443C1B6.1080802@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
 > 
 > heres another try.
 > 
 > contains some speculative explanations that perhaps warrant rewording.
 > 
 > The regular reader will also detect some prose poached from this ML ;-)
 > Index: TROUBLESHOOTING
 > ===================================================================
 > --- TROUBLESHOOTING	(revision 935)
 > +++ TROUBLESHOOTING	(working copy)
 > @@ -6,6 +6,46 @@
 >                             GENERIC
 >  ===================================================================
 >  
 > +Q: Which CONFIG_* items are latency killers, and should be avoided ?
 > +
 > +A: Heres an enumeration.  Several of these are discussed in greater
 > +detail later.  Feel free to verify that these cause latencies to
 > +explode (xeno-test runs testsuite/latency 3 different ways), but keep
 > +in mind that before you rely on the numbers, you must create workloads
 > +that will excersize all the hardware used for your RT application.
 > +
 > +CONFIG_CPU_FREQ: This allows the CPU frequency to be modulated with
 > +workload, but many CPUs change the TSC counting frequency also, which
 > +makes it useless for accurate timing when the CPU clock can change.
 > +
 > +ACPI_PROCESSOR: ACPI is a complex BIOS functionality, and BIOS code is
 > +never written with RT-latency in mind.  If enabled, this BIOS code can
 > +be invoked at a pseudo-SMI priority, which breaks the rule that
 > +adeos-ipipe must be in charge of such things.  DISABLE_SMI doesnt help
 > +here (more later).

I think this description better fits APM than ACPI. The way I understand
ACPI, BIOS only provides tables, which are a kind of bytecode
interpreted by the OS. So, ACPI code is not executed at SMI priority.
On the other hand APM really uses SMIs. As part of ACPI initialization,
legacy power management is disabled, so enabling ACPI may actually be a
good idea with regard to SMIs.

The reason why ACPI_PROCESSOR is a latency killer is because when the
"processor" module is loaded, Linux idle task use the processor "C"
states, which are states equivalent to 'hlt' where the CPU consume less
power, but needs more time to wake up in case of interrupt. You can even
read the wake-up latency in /proc/acpi/processor/CPU*/power.


-- 


					    Gilles Chanteperdrix.

