Message-ID: <4378BB28.8080804@domain.hid>
Date: Mon, 14 Nov 2005 17:28:24 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xn_pipe_create [minor]
References: <OFEDEE04A0.61E312DA-ONC12570B9.0044844D-C12570B9.004C5251@domain.hid>
In-Reply-To: <OFEDEE04A0.61E312DA-ONC12570B9.0044844D-C12570B9.004C5251@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:

> xenomai-help-bounces@domain.hid wrote on 14.11.2005 13:15:07:
>
> > Hi,
> >
> > The registry system is great, allows to forget about agreeing about an
> > arbitrary minor number for pipes. But as far as I ca see, you still have
> > to pass an unique "minor" number to rt_pipe_create.
> >
> > What if you have several rt modules?... you must make sure you assign
> > different minor numbers to each pipe!.
> >
> > Wouldn't be useful to have a way to let the rt_pipe_create decide which
> > minor to use? (a free one, of course)
>
> It can be done and that would work if both sides of the communication
> channel are real-time threads so a rt_pipe_create/bind() pair may be
> used to establish a connection.
>
> But what should be done if another side is a linux task and uses a
> mere open() call?
>
> Currently, a naming convention is a "/dev/rtpN", N - is a minor being
> used by rt_pipe_create() and both sides of the channel must be aware
> of it.
>
> Moreover, a client side of the connection may be open even in case
> there is no server side yet (the one that calls rt_pipe_create) at the
> mement. In that case, the client is blocked in open().
>
> So the only convention between both sides can be a minor number +
> pre-created /dev/rtp[0, OPT_PIPE_NRDEV] character devices.
>
Um... I think you are wrong. When the rt task creates a pipe, a symbolik
link appears at /proc/xenomai/registry/pipes. Its name is the fifo name,
and points to the /dev/rtpN device. That's what I was talking about when
I said "clever procfs usage of xenomai".

Using this scheme, user mode programs just need to open()
/proc/xenomai/registry/pipes/whatever to access a named pipe, without
having to know the minor number.

Under these circumstances, it would be *very* useful to have
rt_pipe_create choose an unused minor automagically (for example passing
-1 as the minor).

Currently, I'm emulating this by calling rt_pipe_create for minor =
0,1,2... until it succeeds or returns any error different than -EBUSY.

Nacho.

