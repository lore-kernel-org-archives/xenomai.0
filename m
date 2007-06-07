From: NZG <ngustavson@domain.hid>
Date: Thu, 7 Jun 2007 17:09:03 -0500
References: <200706071357.12212.ngustavson@domain.hid>
	<200706071446.10731.ngustavson@domain.hid>
	<1181247263.4998.149.camel@domain.hid>
In-Reply-To: <1181247263.4998.149.camel@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706071709.03430.ngustavson@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] writing from NRT to a rt_pipe-> easy wait for
	completion
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Thursday 07 June 2007 3:14 pm, Philippe Gerum wrote:
> On Thu, 2007-06-07 at 14:46 -0500, NZG wrote:
> > > Yes, clearly.
> >
> > Ah, that in conjunction with the
> > "can't use message pipe - Cannot allocate memory"
> > thread resolves my issues then.
> >
> > My assumption was that data would exist in the pipe after the write until
> > the pipe was destroyed, irrespective of the "openness" of the NRT side.
>
> Nope, as a general rule, the read-side of an endpoint is flushed when
> the other end closes. Then, you have also to take into account the
> priority of the thread waiting on the endpoint wrt the priority of the
> one which closes the other side.
So, if I wanted to use standard NRT calls in user space to wait for data to 
actually be delivered through the rt pipe before closing the fd, what would 
be the best method? Select? Or is there a simple call for this I'm missing?

thx,
NZG



