Message-ID: <4D6D0AEF.8070100@domain.hid>
Date: Tue, 01 Mar 2011 16:04:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimQBPGtBysVt7UHeBgaNiU045nWCBDSaHuEDJk6@domain.hid>
In-Reply-To: <AANLkTimQBPGtBysVt7UHeBgaNiU045nWCBDSaHuEDJk6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SMP load balancing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

Jeff Weber wrote:
> I am looking for guidance on how much I can rely upon the Linux kernel and
> Xenomai schedulers to perform automatic load balancing, vs. how much I must
> load balance manually.  My config:
> 
> x86 SMP system with 2 CPUs
> Linux 2.6.35.10 + xenomai-2.5.5.2
> ISA hardware device with 1 IRQ
> Xenomai kernel module driver using old-style native API (may be ported to
> RTDM in the future)
> user space application with multiple Linux and Xenomai threads
> no effort [yet] to explicitly set CPU affinities for either Xenomai, nor
> Linux
> cat /proc/xenomai/affinity output = 000000ff
> 
> question:  From /proc/xenomai/stat , I see all Xenomai kernel driver and
> userspace threads running on only CPU0, though my IRQ handler is being
> balanced on both CPUs.  Will Xenomai ever "balance" or "migrate" threads to
> other CPUs if the affinity mask allows this?

Xenomai does not make any load balancing, because a migration introduces
a huge latency, so, what you have to do is to set an affinity with just
one bit set. And changing affinity during a thread's life is not
recommended.

> 
> question: Does the Linux scheduler assume it owns 100% of the cycles on CPU0
> (where all the Xenomai threads happen to be running), and thus make
> incorrect scheduling decisions for Linux threads on CPU0?

I am not sure, what does top say ?

-- 
					    Gilles.

