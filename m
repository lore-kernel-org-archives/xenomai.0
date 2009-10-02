From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AC5E895.8010107@domain.hid>
References: <4AC5E895.8010107@domain.hid>
Content-Type: text/plain
Date: Fri, 02 Oct 2009 15:40:22 +0200
Message-Id: <1254490822.2703.310.camel@domain.hid>
Mime-Version: 1.0
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

On Fri, 2009-10-02 at 13:48 +0200, Roman Pisl wrote:
> Hello,
> I just tried x86-64 SMP Linux/Xenomai on my workstation (Intel Core2
> Quad) but it freezes immediately after latency test or clocktest is
> started. It freezes even during the boot, when Xenomai debbuging is
> enabled.
> 
> The same kernel binary runs seamlessly in KVM on the same machine.
> 
> When I completely disable ACPI, the kernel recognizes only one CPU and
> the latency test works.
> 
> The same configuration but for 32bit x86 also runs without freeze.
> 
> Do you have any ideas?
> 

Try disabling PM_TIMER.

> Roman
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



