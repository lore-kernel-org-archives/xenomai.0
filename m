Date: Wed, 25 Mar 2015 15:57:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150325145730.GJ15125@hermes.click-hack.org>
References: <CACreCVLijm5Wup7aTrRTq=SHBmEUQY5D2pYpXThWXSrGqpcuqw@mail.gmail.com>
 <20150318142119.GF24525@hermes.click-hack.org>
 <CACreCV+WajHg9wKp3HpxZ4uVdva5ADAWtOH6DDjPfWzcyNk2YQ@mail.gmail.com>
 <20150318145611.GG24525@hermes.click-hack.org>
 <CACreCV+VoYvYQbejhJ2RzU9ZJDUBExwZyRv-DFs3TzWtQvzZkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACreCV+VoYvYQbejhJ2RzU9ZJDUBExwZyRv-DFs3TzWtQvzZkg@mail.gmail.com>
Subject: Re: [Xenomai] Boot failure when CONFIG_XENOMAI is enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Mar 25, 2015 at 10:48:45PM +0800, GP Orcullo wrote:
> On Wed, Mar 18, 2015 at 10:56 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Wed, Mar 18, 2015 at 10:48:10PM +0800, GP Orcullo wrote:
> >> On Wed, Mar 18, 2015 at 10:21 PM, Gilles Chanteperdrix
> >> <gilles.chanteperdrix@xenomai.org> wrote:
> >> > On Wed, Mar 18, 2015 at 10:11:06PM +0800, GP Orcullo wrote:
> >> >> Hi,
> >> >>
> >> >> I'm trying to port xenomai 2.6.4 on an Amlogic S805 board running  a
> >> >> 3.10.33 non-mainlined kernel.
> >> >>
> >> >> The kernel boots with CONFIG_IPIPE enabled but without CONFIG_XENOMAI.
> >> >> Once CONFIG_XENOMAI is set, the boot fails.
> >> >>
> >> >> Attached are the .config and the bootlog files. Turning
> >> >> CONFIG_SMP_ON_UP off gives a different result.
> >> >>
> >> >> Any pointers on where to start looking?
> >> >
> >> > here:
> >> > https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/
> >> >
> >> > Your diagnostic is not consistent with the kernel messages: the only
> >> > difference between CONFIG_XENOMAI and !CONFIG_XENOMAI is when
> >> > xenomai starts, however your kernel crashes before xenomai starts.
> >> >
> >> > Your problem is probably, as usual, in the timer handling code, or
> >> > tsc emulation.
> >> >
> >> > Other than that, I would disable the usually not recommended kernel
> >> > options.
> >> >
> >> > --
> >> >                                             Gilles.
> >>
> >> I think there's a problem with the vendor supplied kernel source.
> >>
> >> On the xenomai patched kernel, disabling CONFIG_IPIPE and enabling
> >> CONFIG_SMP_ON_UP gives the following error during compilation:
> >>
> >> In file included from arch/arm/include/generated/asm/irq_regs.h:1:0,
> >>                  from include/linux/irq.h:26,
> >>                  from include/linux/ipipe.h:28,
> >>                  from include/linux/sched.h:25,
> >>                  from arch/arm/kernel/asm-offsets.c:13:
> >> include/asm-generic/irq_regs.h: In function ‘get_irq_regs’:
> >> include/asm-generic/irq_regs.h:25:2: error: implicit declaration of
> >> function ‘ipipe_processor_id’ [-Werror=implicit-function-declaration]
> >>
> >> I traced the error to this file:
> >> http://git.xenomai.org/ipipe-gch.git/tree/arch/arm/include/asm/percpu.h?h=for-ipipe-3.10
> >
> > That is very much likely a bug in the I-pipe patch itself, a case we
> > did not handle (CONFIG_SMP_ON_UP and !CONFIG_IPIPE), nothing very
> > serious, and probably unrelated to the issues you have.
> >
> > --
> >                                             Gilles.
> 
> I've stripped the kernel to its bare minimum and I was able to boot
> xenomai on a single cpu and pass the xeno-regression-test with no
> problems.
> 
> Once CONFIG_SMP is enabled, the boot is stuck at "Switching to
> clocksource ipipe_tsc". There are no additional messages after that.
> 
> This processor has no per-cpu local timers; it has eight timers total
> and I've allocated four timers for ipipe use. Sharing timers with
> Linux gives the same results.

Check that the tsc is working by calling ipipe_tsc_get() and
printing the result in a loop right after tsc registration. If this
freezes, the address you passed when registering the tsc is invalid.
If it always print the same value, you are using a timer that is
not started.

-- 
					    Gilles.

