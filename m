Message-ID: <4586B489.1060206@domain.hid>
Date: Mon, 18 Dec 2006 16:32:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: Aw: Re: Aw: Re: [RTnet-users] [Xenomai-help] rtnet / Xenomai:
	Kernel
References: <4586A5AE.6020002@domain.hid>
	<10606813.1166451623805.JavaMail.ngmail@domain.hid>
	<32751131.1166455208340.JavaMail.ngmail@domain.hid>
In-Reply-To: <32751131.1166455208340.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

M. Koehrer wrote:
> O.k,
> 
> I tried once more with the  NMI watchdog stuff.
> However, it looks as if I do not understand the NMI watchdog correctly...
> I passed nmi_watchdog=1 as kernel parameter.
> Now, the NMI watchdog seems to be o.k.
> I have set the kernel parameter "NMI watchdog latency threshold (us)" to 1000000 (1 second).
> Now I do a modprobe xeno_nucleus.
> This is o.k.
> Then I do a modprobe xeno_native.
> This leads to a watchdog NMI on the console after 1s.
> "NMI watchdog detected timer latency above 100000us"
> CPU 1
> EIP is at mwait_idle 0x23/0x37
> 
> When I compile the Xenomai functionality directly into the kernel (no modules), I never reach
> the login prompt at my PC as the NMI watchdog from above came first...
> 
> Well, somehow the NMI stuff seems to work. However, I am not able to start my application
> as my systems gets the NMI before I have the chance to start the application...
> What is wrong here? I think, I miss one piece in the puzzle...
> 
> Thanks for any support on that strange behaviour.

1 second is probably way to much and overflow a 32 bits value when
converted to a processor ticks count. The defaults of 100 us is more
reasonable.

-- 
                                                 Gilles Chanteperdrix

