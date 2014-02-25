Resent-To: Xenomai <xenomai@xenomai.org>
Resent-Message-ID: <530CFD50.9070409@xenomai.org>
Message-ID: <530CFC27.5050700@xenomai.org>
Date: Tue, 25 Feb 2014 21:25:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
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
In-Reply-To: <CAEbDrgkJCnbWu_J4svoXOU1x2rz=n95A5+3Ee=R_9CpMgx-JmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>

On 02/25/2014 09:21 PM, Gregory Dymarek wrote:
> I should have added more context.
> 
> I'm sure I recompiled the kernel correctly with CONFIG_IPIPE_TRACE
> Because, when I unplug my USB device i get the ipipe trace now instead of
> default kernel panic.
> 
> Adding ipipe_trace_freeze to irq/handle.c:146 does not seem to trigger the
> trace. Even if I define it in the main code block (without if statement)
> this prints nothing. Could this be that a early printk is needed or some
> other similar ipipe respective routine?

The tracer only dumps the trace in case of panic, because in case of
panic, there is no way to dump the trace. But in the usual case, the
frozen trace can be dumped (preferably to a file) with

cat /proc/ipipe/frozen

> 
> Is there another way of tracing the issue down?

Really, the tracer is probably the best tool for the job.


-- 
                                                                Gilles.

