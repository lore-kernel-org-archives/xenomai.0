Message-ID: <4AC5F49E.3070608@domain.hid>
Date: Fri, 02 Oct 2009 14:39:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4AC5E895.8010107@domain.hid>
In-Reply-To: <4AC5E895.8010107@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
> 
> When I completely disable ACPI, the kernel recognizes only one CPU and
> the latency test works.
> 
> The same configuration but for 32bit x86 also runs without freeze.
> 
> Do you have any ideas?

Yes. As we repeated many times.
Tell us the versions of Xenomai and of the I-pipe patch you use.
Send us your .config
Manage to get the kernel console output (using a serial cable connected
to another PC, or the netconsole, some people even used to send us
photos about kernel crashes).

-- 
					    Gilles.

