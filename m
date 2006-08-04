Subject: Re: [Xenomai-core] Xenomai on PXA
From: Bart Jonkers <jonkersbart@domain.hid>
In-Reply-To: <17618.12042.631648.702921@domain.hid>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
	<1153153788.11603.2.camel@domain.hid>
	<17595.49478.157044.654500@domain.hid>
	<1154334859.9569.12.camel@domain.hid>
	<44CDCB61.2DEDCBFF@vollmann.ch>
	<1154342029.9569.27.camel@domain.hid>
	<44CDE4C2.77465253@domain.hid>
	<17616.42011.663899.554796@domain.hid>
	<1154525585.9559.22.camel@domain.hid>
	<17616.59841.283196.201008@domain.hid>
	<1154596354.9835.28.camel@domain.hid>
	<17617.63387.138316.343123@domain.hid>
	<1154617014.5010.29.camel@domain.hid>
	<17618.12042.631648.702921@domain.hid>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 16:52:56 +0200
Message-Id: <1154703176.9602.26.camel@domain.hid>
Mime-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, 2006-08-03 at 19:14 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Thu, 2006-08-03 at 15:18 +0200, Gilles Chanteperdrix wrote:
>  > > Bart Jonkers wrote:
>  > >  > > Here is a new version of the ipipe-sa1100-pxa patch that unmaks
>  > >  > > interrupts at the end of the demux handlers, and that attempt to fix the
>  > >  > > gettimeoffset issue. I have run 20 minutes (time for OSCR to wrap) latency
>  > >  > > with a test program verifying that time returned by gettimeofday is
>  > >  > > never going backward.
>  > >  > > 
>  > >  > > The patch and the test program are attached, it would be nice if you
>  > >  > > could test them.
>  > >  > I have tested the patch and ran the test program.
>  > >  > The test program give no problems.
>  > >  > 
>  > >  > The interrupt problem in Linux is also solved. But I have another one.
>  > >  > I have created a small real-time kernel module which uses the native
>  > >  > interface to handle an GPIO interrupt. The problem is that Xenomai
>  > >  > doesn't see the interrupt. When I use GPIO0 (which doesn't use the
>  > >  > chained handler) to receive the interrupt everything works as it should.
>  > >  > 
>  > >  > So it seems to be that xenomai have a problem with the chained handler.
>  > >  > Does someone have an idea to solve this problem?
>  > > 
>  > > The problem is that the demux handler is a root domain handler, and
>  > > directly call the cascaded interrupts root domain handlers through
>  > > desc_handle_irq, whereas in order for the I-pipe to intercept the
>  > > interrupt for any domain, the demux handler should be run for any
>  > > domain, and invoke __ipipe_grab_irq, __ipipe_handle_irq or
>  > > ipipe_trigger_irq so that the cascaded interrupts are pipelined.
>  > > 
>  > > So, there are two possible fixes:
>  > > - either fix the I-pipe patch so that the demux handler is invoked when
>  > >   the multiplexed interrupt is received for any domain, and triggers
>  > >   interrupts through ipipe_trigger_irq;
>  > 
>  > Fixing the I-pipe is the way to go, definitely. If I understand this
>  > correctly, the best way to handle the demux case is to implement an
>  > I-pipe variant of the demultiplexing code currently available in
>  > pxa_gpio_demux_handler(), which would be called from __ipipe_grab_irq()
>  > when processing the multiplexed interrupt channel.
>  > 
>  > The I-pipe-specific demux code would then log the decoded IRQ by a call
>  > to __ipipe_handle_irq() instead of running the root handler directly
>  > (i.e. desc_handle_irq), which would in turn preserve the ability to
>  > "wire" GPIO interrupts and also handle IRQ stickiness issues.
>  > 
>  > This would resemble what we are doing right now on the powerpc arch,
>  > pulling the received IRQ number from a request to the machine-dependent
>  > layer. I'd see no issue in duplicating such handling since this is a
>  > rather short piece of invariant, hw-specific code which would not depend
>  > on Linux internals, but rather on the I-pipe's.
> 
> Ok, here is an implementation of this idea for integrator_cp, sa1100 and
> pxa as a patch that should be applied after the ipipe patch. As usual,
> Bart, could you test it ?
> 

I'm testing the interrupt system a little bit more and have encountered
a problem.
I use a OS timer match register of the PXA to generate interrupts on a
regular base. In the interrupt handler I reprogram the match register so
the interrupt fires hole the time. In the interrupt handler happens
nothing special (no special calls or something, just toggling of GPIO).
When the interrupt stops (after 1000 times) everything still hangs.

When I does this in the xenomai domain (native skin) Linux get stuck.
User-space doesn't react anymore and some parts of the kernel also
doesn't react. Pinging the system still works but a timer that toggles a
LED doesn't do anything .

When I does the same in the linux domain everything still works.

Has somebody an idea?

Bart




