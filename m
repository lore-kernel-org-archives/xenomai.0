References: <CAHz_r8CzA4cC1ny7f99CV2Nnt57Mr4=yb1cVF1r8NOBMkHD39Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <acd10e96-894d-9015-dea6-15515e035def@xenomai.org>
Date: Mon, 12 Jun 2017 12:01:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAHz_r8CzA4cC1ny7f99CV2Nnt57Mr4=yb1cVF1r8NOBMkHD39Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Destroy rtdm task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Benjamin Alix <alixbenjamin53@gmail.com>, xenomai@xenomai.org

On 06/12/2017 11:28 AM, Benjamin Alix wrote:
> Hi,
> 
> I'm writing rtdm modules under Xenomai 2.6.4 and Linux 3.18.13.
> 

The _architecture_ is important too.

On a more general note, is it a design requirement to run with a
software release which is known to have issues? such as:

{rpm@cobalt} git log --oneline v2.6.4..v2.6.5
...
d4e755b hal/arm: fix VFP support
90f306b nucleus/shadow: fix crash with debugs enabled
94903a4 nucleus/shadow: avoid tasklist_lock for find_task_by_pid
cd1c762 posix: fix pthread_once
8c2deef posix: avoid dereferencing user-space address
2f997bd posix/clock_host_realtime: fix error handling
8e1e2e3 nucleus/timers: fix the timers situation
51af62d cobalt/x86: fix missing early clobber in asm
a994262 posix: fix pthread_mutex_timedlock for recursive mutexes.
701cb2d rtipc/bufp: fix wrong TX timeout
1994454 can/flexcan: avoid dereferencing clocks twice
b03e3d0 nucleus/pod: fix missed rescheduling in SMP
544899f nucleus/pipe: care for spurious wakeups waiting for events
57881af posix: fix user-space interrupt syscalls
d818ed7 native: fix user-space interrupt syscalls
a7b94fc drivers/can: Properly initialize bittime
...

I can understand the oldish and (too) well-established reasoning behind
the Pavlovian reluctance of the project management to switch version for
a core component. However, when such core component is known to have
scary bugs, sticking to it instead of upgrading to the next maintenance
release is neither smart nor prudent, but fundamentally masochistic.

> I'm trying to understand how to destroy a rtdm task. In my close
> function I simply destroy all tasks and then destroy the events. But
> it seems that one of the tasks isn't destroyed and the call to
> rt_dev_close in the Xenomai application I'm running is pending.
> 
> This task is waiting on an event but even when I'm sending a signal to
> this event and then try to destroy the task I get the same results.

Maybe the task receives the event, does some processing and loops back
immediately waiting for the next event, before the close() handler had a
chance to notice any state change? Keep in mind that the close() handler
context in 2.6 may have a lower priority (linux mode, always the case in
3.x) than any rtdm task.

> 
> So I was wondering if there was a better way to destroy a rtdm task
> which is waiting an avent signal ?
> 

rtdm_task_unblock() comes to mind, assuming you do check the return code
of your wait routine. You should receive -EINTR upon the unblocking
request, exiting the real-time work loop as a response to that.

-- 
Philippe.

