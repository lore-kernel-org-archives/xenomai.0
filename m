MIME-Version: 1.0
In-Reply-To: <5519149C.4030505@xenomai.org>
References: <CADvZd9aaGmA38b+zx-jFB-0S6yn7KPEzy58kXEdX4HoyKxe=Cg@mail.gmail.com>
 <CADvZd9af58_fHQYDMpQ+g3caew0_W144kCKGeCpFi7uGP3FD1A@mail.gmail.com>
 <5519149C.4030505@xenomai.org>
Date: Mon, 30 Mar 2015 11:51:21 +0200
Message-ID: <CADvZd9YfYVnYQhpsS933kZ_XyG+1G0W4qYWn04weQDm3TCOZHg@mail.gmail.com>
From: Michael Haberler <haberlerm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Q: LTTNG & xenomai status
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

2015-03-30 11:17 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:

> On 03/30/2015 10:58 AM, Michael Haberler wrote:
> > 2015-03-26 23:37 GMT+01:00 Michael Haberler <haberlerm@gmail.com>:
> >
> >> what is the status on using LTTNG tracepoints in an RT thread? the last
> >> discussion has been a while back, like 2010ish
> >>
> >> LTTNG 2.5.1 is in the debian jessie stream. Can I use that as-is?
> >>
> >> Any special precautions I need to take, or do the stock instructions for
> >> LTTNG apply?
> >>
> >
> > noting that CONFIG_FTRACE was disabled for performance reasons:
> > http://www.xenomai.org/pipermail/xenomai/2013-January/027272.html
> >
> > that would suggest *functionally* it is not an issue, and LTTng layers
> > ontop of CONFIG_FTRACE for kernel tracing
> >
> > or am I overlooking something?
> >
>
> Functionally it is not an issue, but the LTT core for any given LTT
> version might not be entirely safe for running over a kernel with
> pipelined interrupts. Fixing this is part of the usual process of
> merging LTTng and the I-pipe.
>

given that there is no code pertaining to LTTng in xenomai-2.6, I assume
you consider this the responsibility of the LTTng maintainers?

I will inquire on the lttng-dev list, but does "usual" imply they usually
take care of this?

- Michael



> --
> Philippe.
>
