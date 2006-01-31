Message-ID: <43DF381E.5020709@domain.hid>
Date: Tue, 31 Jan 2006 11:12:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Dual Xeon, 2.6.10, adeos-r13
References: <200601251105.k0PB5uPK028509@domain.hid>
	<43D7CD2F.9030709@domain.hid>
In-Reply-To: <43D7CD2F.9030709@domain.hid>
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
To: Nathaniel Villaume <villaume@domain.hid>
Cc: xenomai@xenomai.org


Hi Nate,

Nathaniel Villaume wrote:
> Hi all,
> 
> I can't seem to find any info about Dual Xeon and Xenomai (well, ADEOS, 
> really). Is this a configuration that is expected to work?  What about 
> smp Athlon? or DualCore Athlon? (I think Opteron is not in the picture 
> yet, right?)
> 
> For the dual Xeon, I'm able to patch and build fine, but boot stalls 
> after the hardware has been initialized by the init process.
> (i.e. The last line I get from Fedora Core 3 Init 2.85 booting says: 
> Initializing hardware... storage network, audio done [ok])
> 
> I've done what I think are correct:
> - turned off HyperThreading in both bios and in kernel config
> - disabled REGPARM
> 
> The Processor family  is set to Pentium 4 and sub arch is set to Generic 
> architecture (X86_GENERICARCH), but I've also tried Pc Compatible (X86) 
> to  the same effect.
> I used an adeos-r9 patch that came with RTAI,

Old Adeos series (i.e. "oldgen") had a design issue that caused such kind of 
behaviour, especially on high-end systems with recent PCI hardware. This has been 
fixed with the Adeos "I-pipe" series, so you should definitely boot your box with 
one of those patches instead (1.1-03 is a good candidate).

I don't know if you are actually meaning RTAI, or Xenomai here, but in case it's 
about Xenomai, you should stick with official Adeos patches [1] which are also 
shipped with Xenomai distros unmodified. The RTAI project provides its own kernel 
patches for working with their codebase since 3.2, but internally, Adeos as an 
interrupt pipeline is not active in those actually.

  and I at least got the
> system to boot. But RTAI puked when loading the SMP scheduler....
> 
> Is there anything else I might do to make this work?  What is the 
> confidence level in SMP support?
> 

SMP support is fully maintained for both Adeos and Xeno, at the same level than UP 
is. If you find something wrong there, we are going to fix it.

[1] http://download.gna.org/adeos/patches/v2.6/i386/

> Thanks,
> -Nate
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

