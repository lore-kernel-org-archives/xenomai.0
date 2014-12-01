Date: Mon, 1 Dec 2014 12:16:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141201111610.GC23220@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C4FD8A@SINTEFEXMBX05.sintef.no>
 <20141201073433.GR2964@hermes>
 <314E5ECDAA86314791309FA670550F89C9C5006D@SINTEFEXMBX05.sintef.no>
 <20141201085028.GA21004@hermes>
 <314E5ECDAA86314791309FA670550F89C9C50321@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C50321@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] WARNING: at arch/arm/kernel/ipipe.c:157
 ipipe_set_irq_affinity+0x47/0x70()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 01, 2014 at 11:06:58AM +0000, Terje Frøysa wrote:
> Thanks Gilles,
> 
> The Debian/Xenomai was solely chosen as a start-up scenario since I found a good recipe on the net.
> I am heading for Yocto and LFS (Linux From Scratch) for future embedded systems.
> 
> By the way.. When compiling kernel for Xenomai, I am advised to
> turn off CPU Frequency scaling "as it is known to cause trouble".

Yes, for two reasons: 

- because Xenomai timing system is counting on a fixed tsc (and
hardware timer) frequency. In the case of beaglebone, the tsc is
based on the gptimer, so if the gptimer frequency does not change
when changing the processor OPP, this is probably not an issue 

- because the execution time of real-time tasks change, this remains
an issue.


> When enabled I could inspect and set the CPU clock frequency by
> the "cpufreq-info" and "cpufreq-set". These tools are no longer
> available and I don't find any settings in the menuconfig.

These are part of the cpufreq-utils package.

> 
> What is the default BBB CPU frequency when frequency scaling is turned off?

All bets are off. This depends on the kernel implementation. On
OMAP3 (which is closed to BBB, normally), last time I checked (and
that was a long time ago), the kernel does not touch whatever PLL
settings U-boot did, with regard to cpu frequency.

If the kernel provides an access to the PLL settings in /proc, you
can check the various PLL frequencies and look-up in the processor
reference manual to what OPP this corresponds.

-- 
					    Gilles.

