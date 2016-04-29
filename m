Date: Fri, 29 Apr 2016 21:38:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160429193850.GN1881@hermes.click-hack.org>
References: <CAJ2oMhLB8Mm7go7-K2D3LKA8uiuHum2GV08FNg9Bqp9WrLmFag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhLB8Mm7go7-K2D3LKA8uiuHum2GV08FNg9Bqp9WrLmFag@mail.gmail.com>
Subject: Re: [Xenomai] Communication between RT-kernel to non-RT kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Apr 28, 2016 at 03:45:09PM +0300, Ran Shalit wrote:
> On Thu, Apr 28, 2016 at 1:52 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Thu, Apr 28, 2016 at 08:37:17AM +0300, Ran Shalit wrote:
> >> On Thu, Apr 28, 2016 at 7:44 AM, Ran Shalit <ranshalit@gmail.com> wrote:
> >> > Hello,
> >> >
> >> > I am new with xenomai.
> >> >
> >> > I've made a lot of reading in the documentation which is very helpful.
> >> > But I haven't found how to communicate between rt kernel to non-rt
> >> > kernel on same machine,
> >> > Is there any example or documantation which explains this ?
> >> >
> >> > Best Regards,
> >> > Ran
> >>
> >> I guess that there is actually no need for such example or documentation.
> >> In userland 2 applications, one using xenomai kernel and the other
> >> linux kernel can commuicate
> >> in any method available in Linux between processes (pipes, shared
> >> memeory, etc) . Right?
> >
> > Not quite. Accessing a pipe from a xenomai thread will cause it to
> > switch to secondary mode, IOW to migrate to the Linux kernel.
> >
> > The IPC adapted to communicated between Xenomai threads and plain
> > Linux threads is XDDP, see the API documentation here:
> > https://xenomai.org/api-reference/
> >
> 
> Thank you for the feedback,
> I did eventually see that there is good introduction documentation for
> this "A tour of the native API ".
> 1. In this document I see that there are others mechanism which can be used :
> message Queues and shared memory.

Well, you misread, message queues are for communications between two
xenomai tasks (as opposed to communications between a xenomai task
and a Linux task), and shared memories are for sharing memories
between different processes, or between kernel and user-space (a use
that is no longer possible in 3.x, as having application code
running in kernel space has always been a bad design anyway). Linux
and Xenomai tasks can be threads running in the same address-space
(process), so no particular mechanism is needed to shared memory
between them. The problem, however, is protecting this data with a
mutual exclusion device working both for Xenomai and Linux tasks:
this was never implemented, so, sharing memory between Xenomai and
Linux tasks can only work for lockless access.

> 2. Other thing I've noticed is that it seems that in xenomai 3.x pdf
> folder this document is missing. Is the native api not relevant with
> xenomai 3.x anymore ?

The native API changed name in Xenomai 3, it is now called alchemy,
it still exists. However, we have almost abandoned the PDF documents
generation toolchain in Xenomai 3, and moved most of the content to
the web site, which is easier to maintain, and especially can be
updated more rapidly.

> 3. We do a kind of simple "Linux RT POC project", in order to
> understand how xenomai is RT (so that we can later choose between
> vxWorks or Linux according to the results),
> all we need to do is something simple as following:
>   3.1 application running on Zynq will get periodic interrupt from fpga.
>   3.2 on receiving interrupt it shall do some known mathematic
> calculation and continue to wait for next interrupt
>   3.3 we need to measure the time of received interrupt in application
> and to measure jitter if exist.
>   3.4 we also need to write simple standard Linux application which
> shall read the statistics from the RT application.

Ok, seeing how a beginner you are with Xenomai, this approach has
many pitfalls, which may result in getting the wrong results for
Xenomai. So, if you want to do a benchmark I suggest:
- either to use the "latency" tool provided by the Xenomai project,
which has been polished over a long time and is expected not to have
such issues, following for instance the procedure outlined on this
page:
https://xenomai.org/2014/07/benchmarking-with-xeno-test/
- or read Xenomai documentation more carefully, in order to
understand better what using a co-kernel implies (and by the way,
note that Xenomai 3 is also able to use Linux native preemption
patch, so it may make sense to benchmark this alternative too),
starting here:
https://xenomai.org/start-here/

> 4. Can rtdm_clock_read  be used for reading time of interrupt ?

Yes.

> 5. If a userspace wait for interrupt on rt_intr_wait, which is
> synchronizaed on clock, is it better to CONFIG_HZ a larger number in
> order to get smaller lateny ?

CONFIG_HZ has meaning only for Linux, not for Xenomai. This question
shows that you have not really understood how Xenomai co-kernel
works (and not very much how Linux timing sub-system works either),
and I urge you to read more documentation.

Regards.

-- 
					    Gilles.
https://click-hack.org

