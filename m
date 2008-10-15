Message-ID: <48F601EA.4090500@domain.hid>
Date: Wed, 15 Oct 2008 16:44:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081015121228.M34584@domain.hid>
In-Reply-To: <20081015121228.M34584@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Pc-freeze with kernel 2.6.26.5 under Ubuntu
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rick.Fritschek@domain.hid
Cc: xenomai@xenomai.org

Fritschek Rick wrote:
> Hello
> 
> Like the topic, i am using Kernel 2.6.26.5(vanilla kernel) with the patch: 
> adeos-ipipe-2.6.26-x86-2.0-13 and xenomai version 2.4.5.
> I followed the HowTo : http://www.xenomai.org/index.php/Xenomai_quick_build_quide .
> Os is Ubuntu 8.04.
> 
> i've disabled this in .config
> 
>     * CONFIG_CPU_FREQ: This allows the CPU frequency to be modulated with
>       workload, but many CPUs change the TSC counting frequency also, which
>       makes it useless for accurate timing when the CPU clock can change. Also
>       some CPUs can take several milliseconds to ramp up to full speed.
>     * CONFIG_APM: The APM model assigns power management control to the BIOS,
>       and BIOS code is never written with RT-latency in mind. If configured, APM
>       routines are invoked with SMI priority, which breaks the rule that
>       adeos-ipipe must be in charge of such things.
>       CONFIG_XENO_HW_SMI_WORKAROUND_* doesn't help here.
>     * CONFIG_ACPI_PROCESSOR: For systems with ACPI support in the BIOS, this
>       ACPI sub-option installs an 'idle' handler that uses ACPI C2 and C3
>       processor states to save power. The CPU must 'warm-up' from these sleep
>       states, increasing latency in ways dependent upon both the BIOS's ACPI
>       tables and code. You may be able to suppress the sleeping with 'idle=poll'
>       boot-arg, test to find out. With recents versions of Linux (probably
>       starting around Linux 2.6.21), the acpi processor module disables the
>       local APIC when loaded. This will cause Xenomai timer initialization to
>       fail. This makes a second reason for disabling this option.
>     * CONFIG_INPUT_PCSPKR (/only/ if i386 && kernel 2.6 && no TSC available):
>       Collides with Xenomai's TSC emulation on oldish x86 systems.
> 
> I've tried it with and without mtrr. (because i found something about freezes in 
> xenomai with mtrr and xserver)
> but there are no changes.
> My PC boot correct, but freezes randomly when the x-server ist started .
> Sometimes in GDM when i want to login, sometimes in browser or when i just 
> compile a new kernel.
> It seems that there is no specific action , that causes the freeze.
> And i dont know, how i can find out.
> kern.log messages gave me no hint about the problem.
> 
> My question ist now, if there is any known problem, that causes such freezes 
> with my configuration(kernel-xenomai-adeos versions).
> And if anybody maybe had something similar and knows already a solution for the 
> problem.
> Maybe ubuntu makes problems associated with vanilla kernel and xenomai.
> 
> I can post dmesg or .config  if you want.

Both would help, ideally also a kernel log captured via serial console
(in case there is some oops around the lock-up). Also, can you confirm
that your system is not tained, only GPL drivers are involved? I'm
specifically thinking of graphic drivers...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

