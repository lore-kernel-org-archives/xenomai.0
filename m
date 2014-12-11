Date: Thu, 11 Dec 2014 15:47:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141211144711.GD21808@hermes.click-hack.org>
References: <8119909587ec45d1ba5696722a1b0945@EX132MBOX1A.de2.local>
 <20141210190114.GQ1524@hermes.click-hack.org>
 <6f637a6b60964c49bbc08e3204c8eae3@EX132MBOX1A.de2.local>
 <20141211100520.GA21808@hermes.click-hack.org>
 <88cb5162a0ca44fb8251aa8161a8d8d8@EX132MBOX1A.de2.local>
 <20141211102249.GB21808@hermes.click-hack.org>
 <14309ee2cb7e45c9a01e6e1504c5bed5@EX132MBOX1A.de2.local>
 <20141211104713.GC21808@hermes.click-hack.org>
 <67263b7a47034e2fba906d0b68b3277f@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67263b7a47034e2fba906d0b68b3277f@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Dec 11, 2014 at 11:17:42AM +0000, Stoidner, Christoph wrote:
> >>
> >> In this application the switchback syscalls are used rather often.
> >
> >Two things to note:
> >
> >- mode switches do not go without some overhead, it is almost never
> >a good idea to force the switchback, since the nucleus will switch
> >the target thread to secondary mode when needed anyway, all that you
> >risk is to introduce useless mode switches, so, if you do it, you
> >must have a good reason for it;
> 
> Yes I know. However we need to assure that the task switches back
> to secondary domain after using skin's call, since otherwise it
> would affect other linux tasks which actual have a higher
> linux-priority. In general we try to simulate something like
> "priority coupling" since this is marked as deprecated.

I understand, I guess this is the reason why xenomai-3 introduced
the XNWEAK scheduling class (which does the same thing by the way,
automatically switches back to secondary mode). I am not sure this
can compare to priority coupling though, since priority coupling
does the reverse: a task running in secondary mode may prevent other
tasks running in primary mode from running.

> 
> >- there is a risk of overflowing the nucleus queue for relax
> >requests, you will see a message in the kernel logs when this
> >happens if you enable debugging of the nucleus
> >(CONFIG_XENO_OPT_DEBUG_NUCLEUS).
> 
> I have enabled CONFIG_XENO_OPT_DEBUG_NUCLEUS now but I do not see
> any according message.

Ok, maybe we have some hope with the tracer though. What should
trigger a trace is the fact that a relax request has been sent, but
that the next linux scheduling point does not wake up the said task.
This is all debug code, so it does not need to be clean. You can
define a per-cpu variable (if running on SMP systems, otherwise a
global variable will do) with the last request posted. And when a
linux scheduling happens, test that the newly scheduled task is the
task that was passed to the relax, if that is not the case, trigger
a trace freeze. The point where the nucleus is informed of a Linux
task switch is do_schedule_event(). The trick is that if you have
some tasks with a higher priority than the relaxed task, it is
normal that the relaxed task is not scheduled immediately, so if you
want the condition to hold, you need to run the xenomai tasks which
relax with the highest priority. Also, obviously, after the test,
the pointer should be reset to NULL, because there are several task
queued, and with a global variable you have no way of knowing which
is next.

-- 
					    Gilles.

