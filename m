Message-ID: <443FB0BA.5060404@domain.hid>
Date: Fri, 14 Apr 2006 10:24:58 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems running testsuite
References: <200604131149.40706.tmarscha@domain.hid>	<443E9FD2.6070807@domain.hid>	<200604141342.40129.tmarscha@domain.hid>
	<17471.38482.617361.14216@domain.hid>
In-Reply-To: <17471.38482.617361.14216@domain.hid>
Content-Type: multipart/mixed; boundary="------------040100040903020300010508"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040100040903020300010508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Tobias Marschall wrote:
>  > Hello,
>  > 
>  > On Thursday 13 April 2006 21:00, you wrote:
>  > > I saw a similar error when using --enable-x86-sep and not having NPTL
>  > > enabled in glibc.
>  > > Try configuring without --enable-x86-sep (used in the README.INSTALL
>  > > Pentium x86 example, the default is disabled).
>  > that did the trick, thank you for the hint! I did check that the cpu supported 
>  > the sep instruction, but I wasn't aware that NPTL is required in this case.
>  > 
>  > Mentioning this in README.INSTALL would be helpful. I wonder if that mistake 
>  > could be caught by configure. 
>
> It could be caught by configure, at least if not cross-compiling, by
> running getconf GNU_LIBPTHREAD_VERSION.
>
>   
ie:
[jimc@domain.hid xenomai]$ getconf GNU_LIBPTHREAD_VERSION
NPTL 2.3.6

doesnt /proc/cpuinfo, flags entry, indicate whether the cpu supports SEP ?

flags           : fpu vme de pse tsc msr mce cx8 apic mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2


what x86 processors support --enable-x86-sep ?   
Pentium-4 ?  Xeon ? Athlon ?
my Pentium-M apparently doesnt.



WRT inferring more stuff from the build/host machine, I have some concerns;
I build on my 686 laptop for a smaller/different 586 target.  This is 
not 'cross-compilation',
and could be compromised by too many automatic optimizations.
So, ideally, Id like the potentially troublesome optimizations to be
identified and gated by a prompt.

Maybe we need a script thats run on the target box, that collects
the needed configuration factors; presumably including:
CPUFLAGS=`grep flags /proc/cpuinfo`
NPTL_AVAIL=`getconf GNU_LIBPTHREAD_VERSION`


Somewhat related: 
prepare-kernel asks me for target architecture, I started by entering 
i586 explicitly,
but after a while, just took the i686 default.  Ive not noticed anything 
different/wrong,
but would appreciate confirmation/explanation.

thanks
jimc


PS.  attached is an attempt to improve README.INSTALL along these and 
other lines.
Please feel free to cut out the false parts ;-)

--------------040100040903020300010508
Content-Type: text/plain;
 name="patch-readme"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-readme"

Index: README.INSTALL
===================================================================
--- README.INSTALL	(revision 927)
+++ README.INSTALL	(working copy)
@@ -74,6 +74,19 @@
 Once the target kernel has been prepared, all Xenomai configuration
 options are available from the "Real-time subsystem" toplevel menu.
 
+When configuring, you should *disable* PM (power management), ACPI,
+and CPU_FREQ.  The 1st 2 invoke uninterruptible BIOS routines, which
+destroy the rt-determinism guarantees that you're presumably seeking.
+If you're curious, build it, install it, and run xeno-test, you'll
+likely see very large latencies.  If you see otherwise, please email
+the evidence.
+
+CPU_FREQ is bad because it breaks some timing guarantees on some
+chips, and these problems are too varied/unpredictable to accomodate.
+For example, (my) Pentium-M laptop shows "cpu MHz : 600.000" at idle,
+but 1700 when compiling.  Some TSCs also change frequency with the
+processor, making them useless if the clock is changing.
+
 Once configured, the kernel should be built as usual.
 
 It might be a good idea to put all the output into a different build
@@ -143,9 +156,11 @@
 NAME                DESCRIPTION                      [BINDING,]DEFAULT(*)
 
 --enable-x86-sep    Enable x86 SEP instructions      strong,disabled
-                    for issuing syscalls
+                    for issuing syscalls.
+		    You will also need NPTL
 
 --enable-x86-tsc    Enable x86 TSC for timings       strong,enabled
+		    falls back to PIT if needed
 
 --enable-arm-arch   Define version of the target     strong,"4"
                     ARM core architecture

--------------040100040903020300010508--

