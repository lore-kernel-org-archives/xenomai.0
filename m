Message-ID: <498035D1.2090905@domain.hid>
Date: Wed, 28 Jan 2009 10:39:13 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <D6F368154C2B1043938B495AE13F245B06F76F41@domain.hid>
In-Reply-To: <D6F368154C2B1043938B495AE13F245B06F76F41@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stability problems with Xenomai install
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Edward Robbins <Edward.Robbins@domain.hid>
Cc: xenomai@xenomai.org

Edward Robbins wrote:
> Hi,
> 
> I have installed version 2.4.6.1 of Xenomai with kernel 2.6.27.2
> compiled for x86_64 on a Core2Duo Ubuntu 8.10 system. Having tried many
> different options I still cannot get a system running that does not hang
> when running xeno-test. I have disabled graphics (X) completely as I
> thought it could be related, and this appears to stop the system
> hanging, but if I generate some load, by e.g. doing a kernel compile in
> another VT, the system hangs after a short time while running latency or
> switches tests, and sometimes hangs anyway, always at a seemingly random
> point during the test. Latencies themselves seem reasonable (max 10uS).
> 
> One thing: previously xeno-test was not running and instead displaying
> 'something died a xxxx or' (xxxx is a pid I believe) so I edited the
> line 'if test 0 -eq $withBusybox ; then' to read 'if test 1 -eq
> $withBusybox; then'. I am not sure if this has adverse effects? I saw
> this same issue reported a couple of times in the mailing list, but not
> resolved - advice was to read TROUBLESHOOTING which I have done and
> tried several things to no avail.
> 
> The kernel is compiled with the following possibly relevant options:
> 
> Processor type & features
> 	SMP support enabled, 
> 	low latency pre-emption model enabled, 
> 	SMT (Hyperthreading) scheduler support disabled,
> 	Interrupt pipeline enabled,
> Power
> 	Processor ACPI disabled,

About ACPI. Is ACPI globally disabled? If yes, you should try enabling
ACPI, only disabling the "processor" and "thermal" modules.

> 	CPU frequency scaling disabled,
> Real-time
> 	Interrupt shield support enabled
> 	Statistics collection enabled
> 	Watchdog support enabled
> 	SMI globally disabled (I am using an ICH7 chipset and wanted to
> be sure this wasn't the problem)

This may be a bad idea, your bios may rely on SMI being enabled for your
machine to work correctly.

> 	All interfaces/APIs enabled
> 	All drivers enabled
> 
> 'dmesg | grep enom' looks reasonably normal as far as I can tell. I can
> provide any logs, command outputs, kernel config or other details that
> may be needed.

Please send us your .config.

-- 
                                                 Gilles.

