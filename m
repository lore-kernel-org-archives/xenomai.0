From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1181235786.4998.108.camel@domain.hid>
References: <200706071049.32906.ngustavson@domain.hid>
	<1181235786.4998.108.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 19:19:06 +0200
Message-Id: <1181236746.4998.122.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Fwd: can't use message pipe - Cannot
	allocate	memory
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

On Thu, 2007-06-07 at 19:03 +0200, Philippe Gerum wrote:
> On Thu, 2007-06-07 at 10:49 -0500, NZG wrote:
> > I'm trying to pass a message from user space to Xenomai and it doesn't seem
> >  to be working. I keep getting an error when attempting to write to the pipe
> >  in user space.
> > 
> > rt_pipe_write error
> > 
> > : Cannot allocate memory
> > 
> 
> Issue confirmed here when passing a non-zero poolsize. Passing 0 does
> not seem to exhibit the problem. Could you re-check that both cases
> actually fail on your side?
> 
> I have crafted a quick and dirty demo showing the problem. Until a
> non-zero value is passed to rt_pipe_create() to specify a local pool,
> everything is ok. (note: we could have used rt_pipe_write/rt_pipe_read
> indifferently, they both end up calling rt_pipe_send/receive).
> 
> I'll have a look at this asap.

This is "normal" behaviour, albeit peculiar. Local pools for pipes are
created on the fly, when the poolsize argument is non-zero, in which
case, a real-time heap is created to manage the message pool behind the
curtains. The init routine for real-time heaps will bail out when the
required size is lower than two times the VM page size, plus some
overhead induced by the meta-data, all rounded to the VM page size for
your achitecture.

In other words, on x86 for instance, you cannot create heaps smaller
than ((4096 * 2) + align(overhead,4096)) bytes, which also apply to
local message pools for pipes. Try passing 16384 to the poolsize
argument to see if things get better.

Obviously, if passing 0 still bugs for you, then we would still have
another problem to solve.

-- 
Philippe.



