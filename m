MIME-Version: 1.0
In-Reply-To: <530CFC27.5050700@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFRN56pZkzmYwBpyupYkbj+V1mgYUPHk4YfLshSs-zFGGw@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
 <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
 <530CFB0D.8040001@xenomai.org>
 <CAEbDrgkJCnbWu_J4svoXOU1x2rz=n95A5+3Ee=R_9CpMgx-JmA@mail.gmail.com>
 <530CFC27.5050700@xenomai.org>
Date: Tue, 25 Feb 2014 20:43:21 +0000
Message-ID: <CAEbDrgnmM_dD3WX42PYawhkW8zTaYczzfozEe1EX7Z5HnERz3g@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Here we go: http://pastebin.com/aDskYjnU

so line 47 is the call handle_irq_event_percpu
looking up of it there is one call to ipipe_unstall_root

I guess some more domain knowledge is needed in here than mine...

What does this tell us?


On 25 February 2014 20:25, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/25/2014 09:21 PM, Gregory Dymarek wrote:
> > I should have added more context.
> >
> > I'm sure I recompiled the kernel correctly with CONFIG_IPIPE_TRACE
> > Because, when I unplug my USB device i get the ipipe trace now instead of
> > default kernel panic.
> >
> > Adding ipipe_trace_freeze to irq/handle.c:146 does not seem to trigger
> the
> > trace. Even if I define it in the main code block (without if statement)
> > this prints nothing. Could this be that a early printk is needed or some
> > other similar ipipe respective routine?
>
> The tracer only dumps the trace in case of panic, because in case of
> panic, there is no way to dump the trace. But in the usual case, the
> frozen trace can be dumped (preferably to a file) with
>
> cat /proc/ipipe/frozen
>
> >
> > Is there another way of tracing the issue down?
>
> Really, the tracer is probably the best tool for the job.
>
>
> --
>                                                                 Gilles.
>
