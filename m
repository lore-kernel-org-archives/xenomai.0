Message-ID: <50FDCB83.4060707@xenomai.org>
Date: Tue, 22 Jan 2013 00:13:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1358809464.75419.YahooMailNeo@web140601.mail.bf1.yahoo.com>
In-Reply-To: <1358809464.75419.YahooMailNeo@web140601.mail.bf1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86 Linux with xenomai and i915 graphics stall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: A User <t02446@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/22/2013 12:04 AM, A User wrote:

> I'm trying to run a Linux/Xenomai system with Ubuntu 12.04 LTS
> distro including X Window System on an Intel x86 board.
> 
> linux: 3.2.21
> xenomai: 2.6.1
> i-pipe Patch: 3.2.21-x86-1
> 
> When I run with CONFIG_PCI_MSI turned off, I get good Xenomai latency,
> but the X Window System is unusable.  With MSI turned on, graphics is
> solid, but latency jumps to about 450 usec when I run glxgears
> (instead of avg 10 usec, max 50 usec).
> 
> I believe that if I want to use X Window system in a recent x86 system
> with motherboard graphics, the most popular choice (the only choice?)
> is i915.
> 
> Do you have any advice on how I can run with i915 and Xenomai with
> this hardware and software?


That is strange, I have tested xenomai on my workstation which is a core
i5 and also has an i915, I have been playing video and running other
opengl apps (including glxgears) and dit not observe high latencies. I
was using Linux 3.5.7 patched with Xenomai 2.6.2, but I guess it should
not make any difference. My core i5 is a "sandy bridge" though, so
should have an intel graphics HD3000 not 4000.

I would suggest enabling the I-pipe tracer in the kernel configuration
in order to find what is taking so long.

Anyway, turning on CONFIG_PCI_MSI is recommended these days. Also, have
you read the troubleshooting guide about SMIs?

If you can not run an accelerated X server, there is always the solution
to revert to disable the acceleration in the server configuration, as is
documented in the troubleshooting guide as well.

-- 
                                                                Gilles.

