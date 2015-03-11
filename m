MIME-Version: 1.0
In-Reply-To: <54FFEA11.5080806@xenomai.org>
References: <CAEMXjGyiUw52yB3SD1vZT5pwnmAR6Sh_qCgxbc_-RTu1kKRDdA@mail.gmail.com>
 <54F74016.7000400@xenomai.org>
 <CAEMXjGzBp69WdL=b1=-V9iyx6ZRd0WX+8JUJ7_9U=P+BQe9m4A@mail.gmail.com>
 <54FF695C.1030808@xenomai.org>
 <CAEMXjGwDy4U3nNT79dfuYr2VNhMv=R-v6dvWJRGY2Gxw+wKQEg@mail.gmail.com>
 <54FFEA11.5080806@xenomai.org>
Date: Wed, 11 Mar 2015 10:08:17 -0700
Message-ID: <CAEMXjGyJjTbfvJGKjzidNLr5zoSHN9kH5BP+o9weRW94qRehpw@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RTDM device driver interrupts over primary mode task?
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

On Wed, Mar 11, 2015 at 12:09 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/11/2015 03:22 AM, Steve B wrote:
> >
> >
> > On Tue, Mar 10, 2015 at 2:59 PM, Philippe Gerum <rpm@xenomai.org
> > <mailto:rpm@xenomai.org>> wrote:
> >
> >     On 03/09/2015 07:18 PM, Steve B wrote:
> >     >
> >     >
> >     > On Wed, Mar 4, 2015 at 9:25 AM, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>
> >     > <mailto:rpm@xenomai.org <mailto:rpm@xenomai.org>>> wrote:
> >     >
> >     >     On 03/04/2015 05:59 PM, Steve B wrote:
> >     >     > Hello,
> >     >     >
> >     >     > Is it possible that my hardware interrupts tied to RTDM
> device
> >     >     drivers are
> >     >     > able to pre-empt my high priority task running in primary
> >     mode, or
> >     >     do the
> >     >     > interrupts get serviced after the task yields the CPU?
> >     >     >
> >     >
> >     >     If taken by the CPU, IRQs hooked by a RTDM driver will preempt
> any
> >     >     real-time task code immediately (in kernel or userland). IRQs
> >     hooked by
> >     >     regular kernel drivers will be postponed until all rt activity
> has
> >     >     completed on the receiving CPU.
> >     >
> >     >     --
> >     >     Philippe.
> >     >
> >     >
> >     > A follow-up question. When this happens, does the execution return
> to
> >     > the primary-mode task that was running at the time the IRQ was
> >     received,
> >     > or does the scheduler let other runnable tasks have a shot at the
> >     CPU at
> >     > that time?
> >
> >     This return path is an opportunity for the real-time core to switch
> to a
> >     thread with higher priority that might have been resumed by the
> handler.
> >     Otherwise, the preempted thread resumes execution.
> >
> >     The priority rule enforced can be expressed as: "at any point in
> time,
> >     the oldest runnable thread from the highest priority level shall
> run".
> >
> >     --
> >     Philippe.
> >
> >
> > Thanks, makes sense! I was having an issue where my highest priority
> > thread was having occasional overruns, and just trying to cover all my
> > bases. There are a few threads of equal priority but none higher, and
> > none of them should take as long as the overruns that I'm having. In the
> > meantime I also found that I still get the overruns if I find a way to
> > feed spoofed data to the main work thread without the
> > hardware/peripherals generating those interrupts, so I think I've pinned
> > it down to being something in that thread itself.
> >
>
> You may want to have a look at /proc/xenomai/stat (or xenomai/sched/stat
> with 3.x), column MSW, when your application runs, to make sure the
> worker thread is not unexpectedly switching to relaxed/secondary mode,
> which would definitely cause some delays.
>
> --
> Philippe.
>

Yes, I did see that I eliminated switches to secondary mode in any of my
tasks (there are a couple at the beginning but no increments in normal
operation), so I was wondering if there was anything at all that could
still be pre-empting that task.
We are using some auto-generated code, and I have actually found that one
of the math functions is going haywire and taking hundreds of microseconds
in some cases so I'm pretty sure that's my culprit!

Steve
