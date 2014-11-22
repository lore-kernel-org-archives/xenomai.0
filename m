Date: Sat, 22 Nov 2014 10:17:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141122091706.GK6931@sisyphus.hd.free.fr>
References: <20141121090857.GK4545@sisyphus.hd.free.fr>
 <CAPRPZsCmfh=OA55LBcnMcA_WcZRkDnvsLd88ES8Sdnyrrh9o3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRPZsCmfh=OA55LBcnMcA_WcZRkDnvsLd88ES8Sdnyrrh9o3g@mail.gmail.com>
Subject: Re: [Xenomai] RTnet in Xenomai 3, status and future
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: rtnet-developers@lists.sourceforge.net, rtnet-users@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On Sat, Nov 22, 2014 at 12:23:49AM +0100, Jeroen Van den Keybus wrote:
> >
> >
> > - the NAPI will be implemented. The NAPI thread will run with the
> > priority of the highest priority waiting thread, and will call
> > rt_stack_deliver, in order not to increase the RX latency compared
> > to the current solution.
> 
> 
> Would you just poll this thread continuously, at high rate ? I'm asking
> because I'd expect the poll method to be called only at moderate rates and
> registers may be read or written.

You can not really guarantee low RX latency if the NAPI thread does
not poll hardware as soon as a packet is received. One thing to
understand though is that the NAPI thread will generally be
sleeping, and be just woken up on the reception of the first RX irq,
at which point RX irq will be disabled at the NIC level, all the
received packets will be processed, then the RX irq will be
re-enabled at NIC level, and the NAPI thread will go back to sleep.
> 
> Maybe the RTnet drivers contain some modifications for low latency
> > like reducing the TX ring length, but I believe putting these
> > modifications in the drivers is not a so good idea:
> > - it means that the modification is to be made in each driver, and
> > needs to be maintained;
> > - in the particular case of the TX ring, reducing the number of
> > queued packets in hardware is not a really precise way to guarantee
> > a bounded latency, because the latency is proportional to the number
> > of bytes queued, not on the number of packets, and ethernet packets
> > have widely varying sizes.
> >
> 
> I fully agree.
> 
> 
> > Please feel free to send any reaction to this mail.
> >
> 
> I've always been wondering if it would be possible to emulate the entire
> Linux netdev system in realtime instead, essentially avoiding any driver
> modification at all. 

The plan is to approach this goal. We have to rename the functions
to avoid the symbol names clashes, but I would like the conversion
to be really automatic. One thing I will not do, however, is spend
time trying and emulating the last 20% of the netdev API that would
cost me 80% of the development effort.

> However, this would also include the handling of the
> various task registrations (INIT_WORK) a driver typically does (the e1000e
> registers five). But these may still be handled by Linux, perhaps.

Actually, I have added the rtdm_schedule_nrt_work() service allowing
to trigger workqueues in Linux domain, from Xenomai domain:

http://git.xenomai.org/xenomai-gch.git/commit/?h=for-forge&id=ee703d9785f7e242057ef689bc500b965cd75294
 

> 
> Though it could very well be a large undertaking, I'm not sure if modifying
> the individual drivers (and often the various codepaths for different card
> variants inside them) would entail less effort in the end.

Well, part, if not majority of the maintenance work is to get the
drivers to follow mainline changes. We need this because it allows
supporting new hardware, and in case the mainline changes contain
fixes. To make that job easy, we need to modify them as little as
possible to integrate into RTnet, because every change we make will
have to be carried from one version to the next, and have chance to
get broken by the mainline changes.

-- 
					    Gilles.

