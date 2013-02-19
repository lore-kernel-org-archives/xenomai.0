Message-ID: <51234003.4030609@xenomai.org>
Date: Tue, 19 Feb 2013 10:04:03 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5120ED91.2070800@xenomai.org>, <5120A36E.9050509@xenomai.org>,
	<OF44D0F7ED.D0CBED6B-ON85257B15.00319BA4-85257B15.00319BA9@moog.com>
	<OF5D712584.D7829A38-ON85257B15.003F8547-85257B15.003F854D@moog.com>
	<OF6C5EC1F2.4F6E9358-ON85257B16.003EE2D7-85257B16.003EE2DD@moog.com>
In-Reply-To: <OF6C5EC1F2.4F6E9358-ON85257B16.003EE2D7-85257B16.003EE2DD@moog.com>
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

On 02/18/2013 12:26 PM, George Broz wrote:
>
> -----Philippe Gerum <rpm@xenomai.org> wrote: -----
>  >RTDM-wise, what makes these calls stable is when you ensure that only
>  >non-rt routines may call into the regular kernel API within your
>  >driver. Non-rt routines are those assigned to the *_nrt handlers in your
>  >driver's device description structure, i.e. struct rtdm_device.
>  >Typically, open_nrt should be the entry point for setup duties.
>  >Therefore, what you need to make sure of, is that absolutely no _rt
>  >type handler calls into the regular kernel API.
>  >
> I will consult the driver author. It may take some time. If _rt calls are
> being made into the kernel wouldn't problems show up even when the
> "setup/td" calls were made on the Linux thread?

In short, it depends. RTDM deals with exec mode management in its own 
way, see below.

>  >A typical use case is when you want such a task to deplete a
>  >real-time semaphore, to sync with a real-time activity running in
> parallel:
>  >when that happens, the 0-prio task might have to be blocked by the
>  >real-time scheduler until a semaphore resources is released by the
>  >real-time activity. This is only possible if that task has a Xenomai task
>  >control block associated, in addition to the regular Linux's task stuct
>  >descriptor, which allows it to switch to primary mode when needed,
>  >i.e. to be controlled by the Xenomai scheduler.
> That is the use case we are trying to achieve - trying to coordinate
> when the "setup/td" calls are made from the 0-prio task with a
> state machine in another task and also mutex protect data shared
> between the two. So a 0-prio task is a good fit!

Seems so, however one should keep in mind that allowing a xenomai-nrt 
thread (i.e. 0-prio) to hold a mutex for serializing with xenomai-rt 
threads introduces a priority inversion. Xenomai will keep the -nrt 
thread in primary mode until it drops the lock though, avoiding further 
damage due to competing with plain linux activities. I would suggest to 
enable CONFIG_XENO_OPT_DEBUG_SYNCH_RELAX in your development setup, to 
be notified when/if the -nrt thread attempts to switch to secondary mode 
while holding a Xenomai mutex.

> So... am I correct to interpret your responses so far that it is not enough
> that the driver code runs successfully when accessed from a Linux thread
> to guarantee that it will also work when those same calls are made
> from a 0-prio task?

When a regular linux syscall is invoked to reach that kernel code, there 
won't be any difference between both kind of threads, and the guarantee 
will be there. This is based on the assumption that regular linux 
syscalls will always depend on running the regular kernel API.

If a Xenomai syscall is invoked, then in theory, there could be a 
difference. The runtime mode from which the kernel code is entered would 
be different for Xenomai syscalls tagged as "__xn_exec_conforming", 
depending on whether the caller is Xenomai-enabled. That flag tells the 
Xenomai core to switch the caller to its "natural" exec mode, prior to 
running the Xenomai syscall handler. For plain linux threads, this mode 
can only be the secondary one since it could not switch to primary 
anyway (no Xenomai TCB attached). On the other hand, xenomai-nrt and 
xenomai-rt threads would be switched to primary mode.

However I don't think this is related to the issue at hand, since the 
RTDM syscall interface does not define conforming syscalls by design. 
The rationale behind this is that dealing with callers exec mode should 
be left to the RTDM driver code. With RTDM, a Xenomai caller always 
enter the kernel over its current exec mode, and the _nrt or _rt handler 
is picked by RTDM depending on this current mode. Then, such handler may 
accept or reject the syscall request, possibly asking RTDM to switch the 
caller to the opposite exec mode before retrying the request with the 
converse handler. E.g.

1. caller runs in primary mode, issues Xenomai's ioctl() implementation
2. ioctl_rt in the relevant RTDM driver is called, returns -ENOSYS to 
reject (because it can't handle the call in primary mode, but knows how 
to do that from primary mode)
3. caller is switched to secondary mode internally by RTDM (because of 
-ENOSYS)
4. caller is sent to ioctl_nrt (if defined by the same driver).

_nrt handlers over RTDM may run the regular kernel API exactly as any 
regular kernel driver may do, with the same set of rules applying.
_rt handlers may only call into the Xenomai/RTDM API.

>
>  >
>  >To sum up, 0-prio tasks allow non-rt code to synchronize on real-time
>  >objects, although real-time processing is not their main purpose. The
>  >motivation is different from having to call regular linux setup code
>  >once during the task's lifetime: in that case, automatic mode
>  >switching controlled by Xenomai is enough, and such switching
>  >happens with non-zero prio tasks as well.
>  >
>  >But, how Xenomai switches mode is defined on a per-syscall basis:
>  >some Xenomai syscalls may lead to switch to primary immediately prior to
>  >running the syscall (typically when the caller might block as a
>  >result of such call, or do some introspection of its own TCB), others may
>  >lead to switch to secondary mode. Regular linux syscalls will always cause
>  >the latter, regardless of the Xenomai task priority.
>  >
> Thanks again, Philippe, for the wealth of info you're sharing!

You are welcome. I would suggest to send us the backtrace from the 
crashdump output, maybe that would ring a bell.

-- 
Philippe.

