From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200706071709.03430.ngustavson@domain.hid>
References: <200706071357.12212.ngustavson@domain.hid>
	<200706071446.10731.ngustavson@domain.hid>
	<1181247263.4998.149.camel@domain.hid>
	<200706071709.03430.ngustavson@domain.hid>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 00:44:12 +0200
Message-Id: <1181256253.4998.217.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] writing from NRT to a rt_pipe-> easy wait
	for	completion
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <ngustavson@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-06-07 at 17:09 -0500, NZG wrote:
> On Thursday 07 June 2007 3:14 pm, Philippe Gerum wrote:
> > On Thu, 2007-06-07 at 14:46 -0500, NZG wrote:
> > > > Yes, clearly.
> > >
> > > Ah, that in conjunction with the
> > > "can't use message pipe - Cannot allocate memory"
> > > thread resolves my issues then.
> > >
> > > My assumption was that data would exist in the pipe after the write until
> > > the pipe was destroyed, irrespective of the "openness" of the NRT side.
> >
> > Nope, as a general rule, the read-side of an endpoint is flushed when
> > the other end closes. Then, you have also to take into account the
> > priority of the thread waiting on the endpoint wrt the priority of the
> > one which closes the other side.
> So, if I wanted to use standard NRT calls in user space to wait for data to 
> actually be delivered through the rt pipe before closing the fd, what would 
> be the best method? Select? Or is there a simple call for this I'm missing?

select() is supported, but it won't allow you to wait for the output
queue from the NRT-side to drain, it will only allow you to wait for
messages sent from the RT endpoint.

There is no simple call, I'm afraid. One way would be to make your RT
side always wait on the read-side (and process the messages as they
arrive); since the RT receiver would always have precedence over the NRT
sender, you would have the guarantee that all the messages sent have
been consumed before the NRT side closes its endpoint.

Another simple way would be to extend the pipe driver in order to
provide a new ioctl() function, returning the status of the RT input
queue, in which case, you would just have to loop issuing this ioctl()
until it reports that the RT side has consumed all the pending messages.
Not pretty, but would work.

The best way would be to extend our support for select(), in the poll
method the message pipe driver provides.

> 
> thx,
> NZG
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



