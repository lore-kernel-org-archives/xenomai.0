Message-ID: <44454FB1.4090304@domain.hid>
Date: Tue, 18 Apr 2006 16:44:33 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010006050006000307050806"
Subject: [Xenomai-core] [patch] readme.install & troubleshooting
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

This is a multi-part message in MIME format.
--------------010006050006000307050806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


heres another try, adjusting per Rodrigo's, Gilles' feedback,
and filling in from linux Kconfig and wikipedia on ACPI.
FYI, the latter is quite informative, esp on sleep states.

The speculative content continues - I dont mind being wrong,
esp when its temporary / corrected :-)


I held back a bit on one wild conjecture,
which connects to the xeno-stats effort / discussion.

Ill start with a Q, and see where it goes:
(feel free to change subject when replying ;-)

Ive seen idle=poll boot-arg fix the Geode SC-1100's buggy TSC
by preventing it from entering C1 state (conjecture-1 ? ;).
Might this also 'fix' the latency problems caused by ACPI_PROCESSOR ?

If so, it improves flexibility by a little, allowing some latency
decisions to be made at boot time rather than compile time.
Not quite as flexible as toggling linux-scheduler-idle behavior via sysctl,
but it doesnt introduce new code either.

I'll be testing this notion on my laptop (which has an ACPI BIOS)
when time permits, but would appreciate guesses as to probability
of useful results, tips, etc.

--------------010006050006000307050806
Content-Type: text/plain;
 name="patch-readme-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-readme-3"

Index: TROUBLESHOOTING
===================================================================
--- TROUBLESHOOTING	(revision 946)
+++ TROUBLESHOOTING	(working copy)
@@ -6,6 +6,57 @@
                            GENERIC
 ===================================================================
 
+Q: Which CONFIG_* items are latency killers, and should be avoided ?
+
+A: Heres an enumeration.  Several of these are discussed in greater
+detail in following sections.
+
+CONFIG_CPU_FREQ: This allows the CPU frequency to be modulated with
+workload, but many CPUs change the TSC counting frequency also, which
+makes it useless for accurate timing when the CPU clock can change.
+Also some CPUs can take several milliseconds to ramp up to full speed.
+
+APM: The APM model assigns power management control to the BIOS, and
+BIOS code is never written with RT-latency in mind.  If configured,
+APM routines are invoked with SMI priority, which breaks the rule that
+adeos-ipipe must be in charge of such things.  DISABLE_SMI doesnt help
+here (more later).
+
+ACPI_PROCESSOR: For systems with ACPI support in the BIOS, this ACPI
+sub-option installs an 'idle' handler that uses ACPI C2 and C3
+processor states to save power.  The CPU must 'warm-up' from these
+sleep states, increasing latency in ways dependent upon both the
+BIOS's ACPI tables and code.  You may be able to suppress the sleeping
+with 'idle=poll' boot-arg, test to find out
+
+Summarizing, the latencies incurred here are dependent upon CPU, BIOS,
+and motherboard; ie they're hard to predict, so we are conservative.
+Feel free to test on your platform, (xeno-test runs testsuite/latency
+in 3 modes), but keep in mind that before you rely on the numbers, you
+must test with workloads that will exercise all the hardware used for
+your RT application.
+
+______________________________________________________________________
+
+Q: How do I adequately stress-test ?
+
+A: xeno-test has a very basic workload generator, whose main virtue is
+that its nearly universally available.
+
+    dd if=/dev/zero of=/dev/null
+
+You can change the input device (-d /dev/hda1) to get real device
+activity and interrupts, and/or -w 4 to run more workload tasks.  For
+more thorough testing, use -W <your-script>.
+
+If you are looking for real heavy loads, cache benchmarks tend to
+stress your system the most, http://www.cwi.nl/~manegold/Calibrator
+for example. Combine them with heavy i/o load (flood ping etc.) to
+generate device interrupts.  Also consider benchmarking software, such
+as bonnie++, cpuburn, lmbench.
+
+______________________________________________________________________
+
 Q: My user-space application has unexpected latencies which seem to
 appear when transitioning from primary (Xenomai) to secondary (native
 Linux) real-time modes. Why?
Index: README.INSTALL
===================================================================
--- README.INSTALL	(revision 946)
+++ README.INSTALL	(working copy)
@@ -74,12 +74,14 @@
 Once the target kernel has been prepared, all Xenomai configuration
 options are available from the "Real-time subsystem" toplevel menu.
 
-Once configured, the kernel should be built as usual.
+There are several configure options that cause large latencies; they
+should be avoided.  The TROUBLESHOOTING file identifies them and
+explains the issues with their use.  Once configured, the kernel
+should be built as usual.
 
-It might be a good idea to put all the output into a different build
-directory as to build from from linux source several targets. For each
-target add O=../build-<target> to each make invocation. See section 2.2 
-for an example.
+If you want several different configs/builds at hand, you can reuse
+the same source by adding O=../build-<target> to each make
+invocation. See section 2.2 for an example.
 
 In order to cross-compile the Linux kernel, pass an ARCH and
 CROSS_COMPILE variable on make command line. See sections 2.2, 2.3 and
@@ -105,7 +107,9 @@
 albeit the kernel has been compiled with CONFIG_X86_TSC disabled would
 certainly lead to runtime problems if uncaught, since Xenomai and the
 application would not agree on the high precision clock to use for
-their timings.
+their timings.  Furthermore, most of these issues cannot be probed for
+during compilation, because the target generally has different
+features than the host, even when theyre the same arch (ex 386 vs 686)
 
 In order to solve those potential issues, each Xenomai architecture
 port defines a set of critical features which is tested for
@@ -126,8 +130,8 @@
 kernel built with CONFIG_X86_TSC set, since the x86-tsc option's
 binding is strong.
 
-1.3.2 Generic options
----------------------
+1.3.2 Generic configure options
+-------------------------------
 
 NAME                 DESCRIPTION                     [BINDING,]DEFAULT(*)
 
@@ -137,15 +141,17 @@
 --enable-debug       Enable debug symbols (-g)       disabled
 --enable-smp         Enable SMP support              weak,disabled
 
-1.3.3 Arch-specific options
----------------------------
+1.3.3 Arch-specific configure options
+-------------------------------------
 
 NAME                DESCRIPTION                      [BINDING,]DEFAULT(*)
 
 --enable-x86-sep    Enable x86 SEP instructions      strong,disabled
-                    for issuing syscalls
+                    for issuing syscalls.
+		    You will also need NPTL
 
 --enable-x86-tsc    Enable x86 TSC for timings       strong,enabled
+		    You must have TSC for this.
 
 --enable-arm-arch   Define version of the target     strong,"4"
                     ARM core architecture
@@ -254,7 +260,7 @@
 2.4 Building for the Blackfin
 -----------------------------
 
-The Blackfin is a MMU-less, DSP-type architecture running
+The Blackfin is an MMU-less, DSP-type architecture running
 uClinux.
 
 $ $xenomai_root/scripts/prepare-kernel.sh --arch=blackfin \

--------------010006050006000307050806--

