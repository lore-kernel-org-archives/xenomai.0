Message-ID: <5120ED91.2070800@xenomai.org>
Date: Sun, 17 Feb 2013 15:47:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5120A36E.9050509@xenomai.org>,
	<OF44D0F7ED.D0CBED6B-ON85257B15.00319BA4-85257B15.00319BA9@moog.com>
	<OF5D712584.D7829A38-ON85257B15.003F8547-85257B15.003F854D@moog.com>
In-Reply-To: <OF5D712584.D7829A38-ON85257B15.003F8547-85257B15.003F854D@moog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] properties of task at priority 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <GBroz@moog.com>
Cc: Xenomai@xenomai.org

On 02/17/2013 12:33 PM, George Broz wrote:
>
>
> -----Philippe Gerum <rpm@xenomai.org> wrote: -----
>
>  >On 02/17/2013 10:01 AM, George Broz wrote:
>  >> Hello All,
>  >>
>  >> I'm using a kernel driver for which some calls cause the
>  >> Xenomai kernel to crash with a message:
>  >>      "Xenomai: stuck on nucleus lock..",
>  >> but only when called from a Xenomai task with a non-zero priority.
>  >>
>  >>
>  >> If I make the same calls from a Linux thread that is still part
>  >> of the Xenomai application, no crash results. And it seems
>  >> that when I make the same calls from a Xenomai task that has
>  >> a priority of "0", it also does not crash the kernel.
>  >>
>  >>
>  >> I knew these calls would put the task into secondary mode
>  >> since they make a number of kmallocs/kfrees and other syscalls.
>  >
>  >Xenomai won't switch to secondary mode automatically because a
>  >regular
>  >linux driver calls the regular kernel API, it simply does not know
>  >about
>  >this fact. It would switch only when a transition from userland to
>  >kernel context happens due to a regular linux system call, which
>  >includes the POSIX I/O calls one may invoke to reach such a driver.
>  >
>  >However, if that driver is RTDM-based, the set of POSIX I/O calls
>  >becomes mode-sensitive, and a real-time task (i.e. non-zero prio) may
>  >
>  >well enter the driver code in primary mode, depending on how the
>  >driver
>  >is programmed to handle the request.
>  >
>  >> I didn't expect there to be a difference in behavior between
>  >> a Xenomai task in secondary mode versus a normal Linux thread
>  >> versus a Xenomai task with priority of "0".
>  >>
>  >
>  >Xenomai assumes that 0-prio tasks it creates normally want to run in
>  >
>  >secondary mode, except when they invoke primary mode-only services.
>  >For
>  >this reason, Xenomai switches them back to secondary mode
>  >automatically
>  >when they are done with such kernel services. This does not happen
>  >with
>  >non-zero priority tasks, which are left in the current mode.
>  >
>  >So the difference could be that some kernel API is called from
>  >primary
>  >mode, leading to unexpected results in the latter case, which would
>  >mean
>  >that a RTDM-based driver is doing the wrong thing.
>  >
>  >>
>  >> I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API on x86
>  >> (Atom, SMP, 32-bit).
>  >>
>  >>
>  >> Is it possible that a (well-written) driver can cause such
>  >> behavior?  (If not I can post the crashdump details).
>  >>
>  >>
>  >> I would like to use rt_event_ / rt_mutex_ at other times
>  >> which I cannot do if I need to make this a Linux thread.
>  >> Is there a rational explanation that would allow me to use
>  >> these calls and the driver calls if I simply set the task
>  >> to priority "0"?
>  >>
>  >
>  >Is this driver a RTDM driver, or a regular linux one?
> It is a complex driver - its "runtime" calls are through RTDM,
> its "setup/teardown" calls are not. The "runtime" calls (called
> from a different, non-zero prio task) cause no problems and
> are never called at the same time as the "setup/td" set.
> The ones causing a problem are the "setup/td" set which are
> probably calling the kernel in primary mode as you suggest
> above.

A simple way to check this is to enable CONFIG_IPIPE_DEBUG_CONTEXT. You 
would get debug assertions triggering, and related messages to your 
kernel console when/if this happens.

> If they are called from a task that remains in secondary mode
> (except to service calls to rt_mutex_, rt_event_ which force
> a temporary switch to primary) would those calls be as stable
> as calling them out of a pure Linux thread?

RTDM-wise, what makes these calls stable is when you ensure that only 
non-rt routines may call into the regular kernel API within your driver.
Non-rt routines are those assigned to the *_nrt handlers in your 
driver's device description structure, i.e. struct rtdm_device.
Typically, open_nrt should be the entry point for setup duties.
Therefore, what you need to make sure of, is that absolutely no _rt type 
handler calls into the regular kernel API.

> Is this a valid/typical application of a 0-prio task?

0-prio tasks are aimed at running most of the time in secondary mode, 
because they most of the time require regular kernel services only, 
except when they have to synchronize with the real-time stuff in some 
ways, and therefore have to be able to switch temporarily to primary 
mode for this.

A typical use case is when you want such a task to deplete a real-time 
semaphore, to sync with a real-time activity running in parallel: when 
that happens, the 0-prio task might have to be blocked by the real-time 
scheduler until a semaphore resources is released by the real-time 
activity. This is only possible if that task has a Xenomai task control 
block associated, in addition to the regular Linux's task stuct 
descriptor, which allows it to switch to primary mode when needed, i.e. 
to be controlled by the Xenomai scheduler.

To sum up, 0-prio tasks allow non-rt code to synchronize on real-time 
objects, although real-time processing is not their main purpose. The 
motivation is different from having to call regular linux setup code 
once during the task's lifetime: in that case, automatic mode switching 
controlled by Xenomai is enough, and such switching happens with 
non-zero prio tasks as well.

But, how Xenomai switches mode is defined on a per-syscall basis: some 
Xenomai syscalls may lead to switch to primary immediately prior to 
running the syscall (typically when the caller might block as a result 
of such call, or do some introspection of its own TCB), others may lead 
to switch to secondary mode. Regular linux syscalls will always cause 
the latter, regardless of the Xenomai task priority.

> Thanks for your help, Philippe. It's much appreciated!
> --George


-- 
Philippe.

