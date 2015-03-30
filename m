MIME-Version: 1.0
In-Reply-To: <CADvZd9aaGmA38b+zx-jFB-0S6yn7KPEzy58kXEdX4HoyKxe=Cg@mail.gmail.com>
References: <CADvZd9aaGmA38b+zx-jFB-0S6yn7KPEzy58kXEdX4HoyKxe=Cg@mail.gmail.com>
Date: Mon, 30 Mar 2015 10:58:52 +0200
Message-ID: <CADvZd9af58_fHQYDMpQ+g3caew0_W144kCKGeCpFi7uGP3FD1A@mail.gmail.com>
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
To: xenomai <xenomai@xenomai.org>

2015-03-26 23:37 GMT+01:00 Michael Haberler <haberlerm@gmail.com>:

> what is the status on using LTTNG tracepoints in an RT thread? the last
> discussion has been a while back, like 2010ish
>
> LTTNG 2.5.1 is in the debian jessie stream. Can I use that as-is?
>
> Any special precautions I need to take, or do the stock instructions for
> LTTNG apply?
>

noting that CONFIG_FTRACE was disabled for performance reasons:
http://www.xenomai.org/pipermail/xenomai/2013-January/027272.html

that would suggest *functionally* it is not an issue, and LTTng layers
ontop of CONFIG_FTRACE for kernel tracing

or am I overlooking something?


- Michael

(I know it is cramped style to follow up oneself, but I need to figure this
out for good so I'm not stuck later on)

> thanks in advance,
>
> Michael
>
