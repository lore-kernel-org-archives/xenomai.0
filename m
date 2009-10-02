Message-ID: <4AC60C71.4050404@domain.hid>
Date: Fri, 02 Oct 2009 16:21:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid>
In-Reply-To: <4AC5E895.8010107@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Freeze on SMP x86-64
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

Roman Pisl wrote:
> Hello,
> I just tried x86-64 SMP Linux/Xenomai on my workstation (Intel Core2
> Quad) but it freezes immediately after latency test or clocktest is
> started. It freezes even during the boot, when Xenomai debbuging is
> enabled.
> 
> The same kernel binary runs seamlessly in KVM on the same machine.

Did you run kvm (qemu) with -smp 2 (or even 4)?

> 
> When I completely disable ACPI, the kernel recognizes only one CPU and
> the latency test works.
> 
> The same configuration but for 32bit x86 also runs without freeze.
> 
> Do you have any ideas?

You could try playing with the NMI watchdog support (enable related
Xenomai feature, pass nmi_watchdog=2 as kernel option). That may be able
to generate some backtrace after the box is bricked - maybe...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

