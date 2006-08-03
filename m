MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17617.63387.138316.343123@domain.hid>
Date: Thu, 3 Aug 2006 15:18:19 +0200
Subject: Re: [Xenomai-core] Xenomai on PXA
In-Reply-To: <1154596354.9835.28.camel@domain.hid>
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
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bart Jonkers <jonkersbart@domain.hid>
Cc: xenomai@xenomai.org

Bart Jonkers wrote:
 > > Here is a new version of the ipipe-sa1100-pxa patch that unmaks
 > > interrupts at the end of the demux handlers, and that attempt to fix the
 > > gettimeoffset issue. I have run 20 minutes (time for OSCR to wrap) latency
 > > with a test program verifying that time returned by gettimeofday is
 > > never going backward.
 > > 
 > > The patch and the test program are attached, it would be nice if you
 > > could test them.
 > I have tested the patch and ran the test program.
 > The test program give no problems.
 > 
 > The interrupt problem in Linux is also solved. But I have another one.
 > I have created a small real-time kernel module which uses the native
 > interface to handle an GPIO interrupt. The problem is that Xenomai
 > doesn't see the interrupt. When I use GPIO0 (which doesn't use the
 > chained handler) to receive the interrupt everything works as it should.
 > 
 > So it seems to be that xenomai have a problem with the chained handler.
 > Does someone have an idea to solve this problem?

The problem is that the demux handler is a root domain handler, and
directly call the cascaded interrupts root domain handlers through
desc_handle_irq, whereas in order for the I-pipe to intercept the
interrupt for any domain, the demux handler should be run for any
domain, and invoke __ipipe_grab_irq, __ipipe_handle_irq or
ipipe_trigger_irq so that the cascaded interrupts are pipelined.

So, there are two possible fixes:
- either fix the I-pipe patch so that the demux handler is invoked when
  the multiplexed interrupt is received for any domain, and triggers
  interrupts through ipipe_trigger_irq;
- or you may fix the issue locally by registering a demux handler in
  Xenomai domain through ipipe_virtualize_irq_from, and in this demux
  handler only clear the interrupt you want and call ipipe_trigger_irq 
  for them, and ipipe_propagate_irq the multiplexing interrupt to let
  other irqs be handled in the root domain.

Philippe, is there a way to tell the I-ipipe that an interrupt handler
should be executed for any domain? Is this what a "wired" handler is?

-- 


					    Gilles Chanteperdrix.

