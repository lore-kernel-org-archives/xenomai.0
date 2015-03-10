Message-ID: <54FF695C.1030808@xenomai.org>
Date: Tue, 10 Mar 2015 22:59:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAEMXjGyiUw52yB3SD1vZT5pwnmAR6Sh_qCgxbc_-RTu1kKRDdA@mail.gmail.com>	<54F74016.7000400@xenomai.org>
 <CAEMXjGzBp69WdL=b1=-V9iyx6ZRd0WX+8JUJ7_9U=P+BQe9m4A@mail.gmail.com>
In-Reply-To: <CAEMXjGzBp69WdL=b1=-V9iyx6ZRd0WX+8JUJ7_9U=P+BQe9m4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM device driver interrupts over primary mode task?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 03/09/2015 07:18 PM, Steve B wrote:
> 
> 
> On Wed, Mar 4, 2015 at 9:25 AM, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
> 
>     On 03/04/2015 05:59 PM, Steve B wrote:
>     > Hello,
>     >
>     > Is it possible that my hardware interrupts tied to RTDM device
>     drivers are
>     > able to pre-empt my high priority task running in primary mode, or
>     do the
>     > interrupts get serviced after the task yields the CPU?
>     >
> 
>     If taken by the CPU, IRQs hooked by a RTDM driver will preempt any
>     real-time task code immediately (in kernel or userland). IRQs hooked by
>     regular kernel drivers will be postponed until all rt activity has
>     completed on the receiving CPU.
> 
>     --
>     Philippe.
> 
> 
> A follow-up question. When this happens, does the execution return to
> the primary-mode task that was running at the time the IRQ was received,
> or does the scheduler let other runnable tasks have a shot at the CPU at
> that time?

This return path is an opportunity for the real-time core to switch to a
thread with higher priority that might have been resumed by the handler.
Otherwise, the preempted thread resumes execution.

The priority rule enforced can be expressed as: "at any point in time,
the oldest runnable thread from the highest priority level shall run".

-- 
Philippe.

