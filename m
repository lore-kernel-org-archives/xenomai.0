MIME-Version: 1.0
In-Reply-To: <20141121090857.GK4545@sisyphus.hd.free.fr>
References: <20141121090857.GK4545@sisyphus.hd.free.fr>
Date: Sat, 22 Nov 2014 00:23:49 +0100
Message-ID: <CAPRPZsCmfh=OA55LBcnMcA_WcZRkDnvsLd88ES8Sdnyrrh9o3g@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RTnet in Xenomai 3, status and future
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: rtnet-developers@lists.sourceforge.net, rtnet-users@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

>
>
> - the NAPI will be implemented. The NAPI thread will run with the
> priority of the highest priority waiting thread, and will call
> rt_stack_deliver, in order not to increase the RX latency compared
> to the current solution.


Would you just poll this thread continuously, at high rate ? I'm asking
because I'd expect the poll method to be called only at moderate rates and
registers may be read or written.

Maybe the RTnet drivers contain some modifications for low latency
> like reducing the TX ring length, but I believe putting these
> modifications in the drivers is not a so good idea:
> - it means that the modification is to be made in each driver, and
> needs to be maintained;
> - in the particular case of the TX ring, reducing the number of
> queued packets in hardware is not a really precise way to guarantee
> a bounded latency, because the latency is proportional to the number
> of bytes queued, not on the number of packets, and ethernet packets
> have widely varying sizes.
>

I fully agree.


> Please feel free to send any reaction to this mail.
>

I've always been wondering if it would be possible to emulate the entire
Linux netdev system in realtime instead, essentially avoiding any driver
modification at all. However, this would also include the handling of the
various task registrations (INIT_WORK) a driver typically does (the e1000e
registers five). But these may still be handled by Linux, perhaps.

Though it could very well be a large undertaking, I'm not sure if modifying
the individual drivers (and often the various codepaths for different card
variants inside them) would entail less effort in the end.


Jeroen.
