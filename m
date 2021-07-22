References: <CAJte2PC6cFhYMqY9-XGbrkmiw+U5_hQW0S03iCjDWuLKtDW8OA@mail.gmail.com>
 <87o8b27ku5.fsf@xenomai.org>
 <CAJte2PA=Q+OVYgPaV-P3qh-urFLxLoZXwR3RZmu=3ZxJh0MJXw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Taking first steps with EVL
In-reply-to: <CAJte2PA=Q+OVYgPaV-P3qh-urFLxLoZXwR3RZmu=3ZxJh0MJXw@mail.gmail.com>
Date: Thu, 22 Jul 2021 12:37:37 +0200
Message-ID: <87y29y63da.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Byron Jacquot <bjacquot@cardinalpeak.com>
Cc: xenomai@xenomai.org


Byron Jacquot <bjacquot@cardinalpeak.com> writes:

> Hello Philippe,
>
> Thank you for the response!  I've had a chance to put your advice into a
> practical form.
>
> As my ultimate application doesn't need Alsa, I'm moving forward with
> porting the RTDM driver.  I've got a crudely hacked version working, and
> I'm working on getting some nontrivial application code to stand on top of
> it.
>

Ok.

> A first question I've got: is there a way to tell if my DMA IRQs are IB or
> OOB?  /proc/interrupts seems to be counting them regardless of the flag
> setting, and the performance appears to be very good either way.
>

I pushed a change to display the "oob" label before the IRQ action field
when an interrupt is routed to the out-of-band stage. This is on top of
v5.13, but should apply cleanly to v5.12 as well. [1]

note: the dovetail/evl branches on top of v5.12 do not receive any fix
at the moment: in order to keep the maintenance effort tractable for me,
I'm maintaining the rebase branches for Dovetail and EVL for arm, arm64
and x86_64 on top of the current LTS (v5.10.y ATM) and the latest kernel
release (until superseded) only. Jan is maintaining a merge branch for
v5.10.y, picking fixes from the corresponding rebase branch.

> I've seen the recommendations for isolcpus & thread affinity - would you
> recommend that for the IRQs, also?

If the execution of all real-time threads on this CPU are paced by such
IRQ, and the IRQ handler is fairly simple code (granted, as it should
be) then running both on the same CPU may be the best option, saving
remote wake ups.

If non-related real-time threads are sharing the CPU, then picking the
right placement depends on whether it is acceptable to temporarily
preempt the execution of these threads for handling these IRQs. If not,
then moving the IRQ out of the way, at the expense of mere local wake
ups would make sense. In that case, an inter-processor IRQ would be
involved in resuming a thread sitting on a different CPU.

You can determine the number of IPIs EVL sent for waking up remote
threads as follows, looking at the 'RWA' field:

$ evl ps -s
/root # evl ps -s
CPU   PID   ISW     CTXSW     SYS       RWA       STAT     NAME
  0   212   0       4789399   4789400   0          Wt      timer-responder:207
  0   214   1       2         1         0          W       test-sitter:207

>
> Similarly, I'm watching the numbers in
> /sys/devices/virtual/thread/*/stats.  The in-band switch count is constant
> after init, but the CPU % utilization number (last number in the row)
> doesn't seem to be reflective of the load.  I'm doing trivial work in my
> application (catching the return of the OOB ioctl, copying input buffers to
> output), and it's showing numbers in the 200 to 300 range.

%CPU in the 200-300 range? Houston, we have a problem.

> Does that seem
> right?  Looking at the nanoseconds consumed field, it looks like it might
> be a count of milliseconds consumed per second?
>

What does this command say?

$ evl ps -t


> Thank you,
>
> Byron Jacquot

[1] https://xenomai.org/pipermail/xenomai/2021-July/045938.html

-- 
Philippe.

