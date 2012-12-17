Message-ID: <50CF007B.4010904@xenomai.org>
Date: Mon, 17 Dec 2012 12:22:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1355499196.2190.23.camel@herbert.er.corscience.de>	
	<50CC6730.6060308@xenomai.org>
	<1355732053.2205.38.camel@herbert.er.corscience.de>
In-Reply-To: <1355732053.2205.38.camel@herbert.er.corscience.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Question about IPIPE_IRQF_NOSYNC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tim Niemeyer <tim.niemeyer@corscience.de>
Cc: xenomai <xenomai@xenomai.org>

On 12/17/2012 09:14 AM, Tim Niemeyer wrote:
> Am Samstag, den 15.12.2012, 13:04 +0100 schrieb Gilles Chanteperdrix:
>> The latest Adeos is the core-3.4 branch from the git.denx.de/ipipe.git
>> repository, not the 'for-core-3.4' branch from the
>> git.xenomai.org/ipipe-gch.git.
> Ah, thanks for clearing up.
>
>> Anyway, you can not use Xenomai 2.6.1 with linux 3.4, you also have to
>> use xenomai from its git repository git.xenomai.og/xenomai-2.6.git
> It's working here fine. Why do you expect, that Xenomai 2.6.1 and linux
> 3.4 won't work together?

You could run into subtle bugs, but the only things which were fixed 
probably only mattered if you enable the posix select syscall, and on 
ARM multi-processor machines. So, if it compiles, it should run...
However, with the current xenomai git, you can build both kernel and 
user-space in thumb mode and get lower latencies.

>
> I'm using 'for-core-3.4' branch from git.xenomai.org/ipipe-gch.git with
> Linux 3.4.14. I just build a big diff from 'for-core-3.4' against 3.4.6
> and applied this on my 3.4.14. Then i took all the kernel-src files and
> Kconfig changes from xenomai-2.6.1.tar.bz2 and build again a patch.
> I use simple patches as they are easier for me to maintain in ptxdist.
>
>>> While hunting a gpio-irq latency i tried to understand the adeos chained
>>
>> How high a latency are we talking about?
> The latency was about ~11µs. I then found out, that the cpu clock wasn't
> the full 600MHz. I changed this and now the gpio-irq latency is about
> ~7µs. In contrast, the timer-irq latency is less than 3µs.
> But when i use IPIPE_IRQF_NOSYNC the gpio-irq latency rises to ~14µs.
> But on the other hand the switch between gpio-irq and timer-irq is
> faster with IRQF_NOSYNC. It takes ~3µs and without IRQF_NOSYNC is takes
> ~7µs.

Yes IRQF_NOSYNC adds a bit to the latency, but the "immediate 
dispatching" may leave the parent irq line masked for a whole 
multiplexed gpio bank, and induce latencies in the millisecond range. 
After several iteration, the current solutions seems the simplest which 
actually work. Demultiplexed GPIO already have a high latency anyway 
(and I doubt you really get a 3us, 7us or 11us latency on an omap, under 
load, you probably get something more like 20 or 30us).


-- 
					    Gilles.

