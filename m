Message-ID: <50F3F4BF.4050501@siemens.com>
Date: Mon, 14 Jan 2013 13:06:23 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
In-Reply-To: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] universal application binary: how to auto-detect
 Xenomai/RT-PREEMPT/vanilla kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 2013-01-14 09:29, Michael Haberler wrote:
> Hi,
> 
> thanks to patience on this list we were able to build linuxcnc such that it runs on Xenomai, besides RT-PREEMPT, vanilla kernels (in a simulator/non-RT mode) and RTAI
> 
> 
> I'm planning to adapt linuxcnc such that a universal binary can be built which runs under Xenomai, RT-PREEMPT and vanilla kernels as this will simplify logistics quite a bit; what I'd like have is reliable auto-detection of the kernel type and 'do the right thing' (RTAI will remain a separate build).
> 
> Autodetection could be one of several things - digging around with a shell script, using system calls, digging in /proc - unsure how to best do this, in particular I'm unsure how to tell an RT-PREEMPT kernel from a vanilla kernel 
> 
> I know it's a bit OT - still I'd be thankful for suggestions
> 
> any other low-lying cliffs I might hit?

I do not see why you application should have to tell -RT from vanilla
apart (syscalls are identical).

To handle the existence of Xenomai dynamically, you could push all
Xenomai API calls into a separate library, some abstraction layer (I
suppose you already have one in LinuxCNC), link that one against the
Xenomai libs, have a "vanilla" version as well that builds against
standard Linux, and then pull in the right version via dlopen (enable
support for this via --enable-dlopen-skins during Xenomai configure).
You could test in /proc for the existence of Xenomai before that, e.g.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

