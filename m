Message-ID: <4600F78F.4060001@domain.hid>
Date: Wed, 21 Mar 2007 10:14:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai support for ARM926EJ
References: <fdba73240703151522l3aa73a81v84661caf17f489ae@domain.hid>	<17914.63535.18893.207257@domain.hid>	<fdba73240703201122w447cce8bl186ba32df55665c7@domain.hid>	<17920.13832.789072.876398@domain.hid>	<b647ffbd0703201721g1752e0falbe3fed8df405b3f8@domain.hid>
	<17920.60301.400005.135175@domain.hid>
In-Reply-To: <17920.60301.400005.135175@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Dmitry Adamushko wrote:
>  > On 20/03/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>  > > Muruganandam Ganapathy wrote:
>  > >  > The board is based on the Fujitsu SOC which has the ARM926EJ processor
>  > core.
>  > >  >
>  > >  > This board has SPI, I2C and 10/100 ethernet interfaces and it can
>  > support
>  > >  > 16/32MB SDRAM
>  > >  > and 4/8MB flash memory.
>  > >
>  > > You still do not tell us the name of the board, but it is probably not
>  > > supported.
>  > >
>  > >  >
>  > >  >
>  > >  > In addition, I would like to know the interrupt reponse  mesaured with
>  > >  > Xenomai in ARM9
>  > >  > processor based platforms, if any.
>  > >  > The interrupt response expected is around 40 -50 microseconds in our
>  > case.
>  > >  > The interrupt response I mean, it is the time between the generation of
>  > the
>  > >  > interrupt and the actual ISR invocation.
>  > >  >
>  > >  >
>  > >  > Whether use of Xenomai will enable us meet this timing reqirement.
>  > >
>  > > The latencies I have observed so far on ARM are usually larger than 150
>  > > microseconds, but these are userspace dispatch latencies.
>  > >
>  > > So, you could improve situation if you stay in interrupt handlers.
>  > >
>  > > Another way to improve the situation a bit more is to use ucLinux, if
>  > > your platform is supported.
>  > >
>  > > Still, IMHO, 40-50 microseconds is too ambitious.
>  > 
>  > Gilles, as I understood the question was about the interrupt latency, not
>  > the scheduling one.
>  > 
>  > I guess, the vitually tagged cache is an additional component of high
>  > scheduling latencies on ARM.
>  > 
>  > The interrupt latency should be ok though.
> 
> Interrupt handler reside in cached memory as well. And a source of high
> latencies on ARM is the fact that the TLB is flushed with interrupts
> off. So, even if the interrupt handler was in TCM to avoid latencies
> induced by the cache, interrupts off sections would still cause high
> latencies. So, the only chance of success is to use uCLinux with the
> interrupt handler in TCM.
> 

I checked latency -t 2 on an Intel Xscale with the cache calibrator
running, and I get latencies around 70 us.

-- 
                                                 Gilles Chanteperdrix

