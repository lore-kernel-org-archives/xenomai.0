Message-ID: <44428120.8080204@domain.hid>
Date: Sun, 16 Apr 2006 19:38:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problems running testsuite
References: <200604131149.40706.tmarscha@domain.hid>	<443E9FD2.6070807@domain.hid>	<200604141342.40129.tmarscha@domain.hid>	<17471.38482.617361.14216@domain.hid>
	<443FB0BA.5060404@domain.hid>
In-Reply-To: <443FB0BA.5060404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

Jim Cromie wrote:
> PS.  attached is an attempt to improve README.INSTALL along these and 
> other lines.
> Please feel free to cut out the false parts ;-)
>

I think we should simply add a link from README.INSTALL to the 
troubleshooting guide, where things are explained in length, for each 
platforms.

> 
> ------------------------------------------------------------------------
> 
> Index: README.INSTALL
> ===================================================================
> --- README.INSTALL	(revision 927)
> +++ README.INSTALL	(working copy)
> @@ -74,6 +74,19 @@
>  Once the target kernel has been prepared, all Xenomai configuration
>  options are available from the "Real-time subsystem" toplevel menu.
>  
> +When configuring, you should *disable* PM (power management), ACPI,
> +and CPU_FREQ.  The 1st 2 invoke uninterruptible BIOS routines, which
> +destroy the rt-determinism guarantees that you're presumably seeking.
> +If you're curious, build it, install it, and run xeno-test, you'll
> +likely see very large latencies.  If you see otherwise, please email
> +the evidence.
> +
> +CPU_FREQ is bad because it breaks some timing guarantees on some
> +chips, and these problems are too varied/unpredictable to accomodate.
> +For example, (my) Pentium-M laptop shows "cpu MHz : 600.000" at idle,
> +but 1700 when compiling.  Some TSCs also change frequency with the
> +processor, making them useless if the clock is changing.
> +
>  Once configured, the kernel should be built as usual.
>  
>  It might be a good idea to put all the output into a different build
> @@ -143,9 +156,11 @@
>  NAME                DESCRIPTION                      [BINDING,]DEFAULT(*)
>  
>  --enable-x86-sep    Enable x86 SEP instructions      strong,disabled
> -                    for issuing syscalls
> +                    for issuing syscalls.
> +		    You will also need NPTL
>  
>  --enable-x86-tsc    Enable x86 TSC for timings       strong,enabled
> +		    falls back to PIT if needed
>  

Nope, the user-space support could not fallback properly to PIT if TSC 
is activated using this switch. In the latter case, "rdtsc" insns will 
be wired into the code, making it invalid for using with CPUs lacking a 
timestamp counter.

-- 

Philippe.

