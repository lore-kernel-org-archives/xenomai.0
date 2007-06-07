From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200706071446.10731.ngustavson@domain.hid>
References: <200706071357.12212.ngustavson@domain.hid>
	<200706071413.10635.ngustavson@domain.hid>
	<1181244856.4998.133.camel@domain.hid>
	<200706071446.10731.ngustavson@domain.hid>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 22:14:23 +0200
Message-Id: <1181247263.4998.149.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] writing from NRT to a rt_pipe
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

On Thu, 2007-06-07 at 14:46 -0500, NZG wrote:
> > Yes, clearly.
> Ah, that in conjunction with the
> "can't use message pipe - Cannot allocate memory"
> thread resolves my issues then.
> 
> My assumption was that data would exist in the pipe after the write until the 
> pipe was destroyed, irrespective of the "openness" of the NRT side.
> 

Nope, as a general rule, the read-side of an endpoint is flushed when
the other end closes. Then, you have also to take into account the
priority of the thread waiting on the endpoint wrt the priority of the
one which closes the other side.

For instance, if a RT thread is waiting for data (e.g. currently
sleeping on rt_pipe_read()) while the NRT side closes, then the RT
thread will be awaken, and a rescheduling will occur in the pipe release
routine before the input queue is eventually flushed, leaving the
opportunity for the RT side to consume the pending messages (since the
read-side has priority over the closing side in this situation).

What happened in your code is likely that the RT side was not actually
waiting for data, but maybe handling other duties while the NRT side
closed its endpoint. Yeah, that's a bit tricky, I agree, but in a
strictly prioritized system, this makes some sense.

> It's possible that this assumption is due to a lack of experience with pipes 
> in general, I don't know.
> 

Not really, fact is that we do have to deal with an asymmetric view of
the communication, i.e. RT / NRT, so there is room for specific
implementations. OTOH, regular Linux pipes won't give you more guarantee
on the read-side, you could just get a 0-bytes return from a read() to
notify the broken pipe condition.

Btw, do you happen to have CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ set to some
value in your .config?

> thank you for all you help,
> NZG
> 
-- 
Philippe.



