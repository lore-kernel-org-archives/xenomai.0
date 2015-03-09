MIME-Version: 1.0
In-Reply-To: <54F74016.7000400@xenomai.org>
References: <CAEMXjGyiUw52yB3SD1vZT5pwnmAR6Sh_qCgxbc_-RTu1kKRDdA@mail.gmail.com>
 <54F74016.7000400@xenomai.org>
Date: Mon, 9 Mar 2015 11:18:58 -0700
Message-ID: <CAEMXjGzBp69WdL=b1=-V9iyx6ZRd0WX+8JUJ7_9U=P+BQe9m4A@mail.gmail.com>
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

On Wed, Mar 4, 2015 at 9:25 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/04/2015 05:59 PM, Steve B wrote:
> > Hello,
> >
> > Is it possible that my hardware interrupts tied to RTDM device drivers
> are
> > able to pre-empt my high priority task running in primary mode, or do the
> > interrupts get serviced after the task yields the CPU?
> >
>
> If taken by the CPU, IRQs hooked by a RTDM driver will preempt any
> real-time task code immediately (in kernel or userland). IRQs hooked by
> regular kernel drivers will be postponed until all rt activity has
> completed on the receiving CPU.
>
> --
> Philippe.
>

A follow-up question. When this happens, does the execution return to the
primary-mode task that was running at the time the IRQ was received, or
does the scheduler let other runnable tasks have a shot at the CPU at that
time?

Steve
