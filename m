MIME-Version: 1.0
In-Reply-To: <5120ED91.2070800@xenomai.org>
References: <5120ED91.2070800@xenomai.org>, <5120A36E.9050509@xenomai.org>,
	<OF44D0F7ED.D0CBED6B-ON85257B15.00319BA4-85257B15.00319BA9@moog.com>
	<OF5D712584.D7829A38-ON85257B15.003F8547-85257B15.003F854D@moog.com>
From: George Broz <GBroz@moog.com>
Message-ID: <OF6C5EC1F2.4F6E9358-ON85257B16.003EE2D7-85257B16.003EE2DD@moog.com>
Date: Mon, 18 Feb 2013 06:26:53 -0500
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] properties of task at priority 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org
Cc: Xenomai@xenomai.org


-----Philippe Gerum <rpm@xenomai.org> wrote: -----
>
>
>On 02/17/2013 12:33 PM, George Broz wrote:
>>
>>
>> -----Philippe Gerum <rpm@xenomai.org> wrote: -----
>>
>>  >On 02/17/2013 10:01 AM, George Broz wrote:
>>  >> Hello All,
>>  >>
>>  >> I'm using a kernel driver for which some calls cause the
>>  >> Xenomai kernel to crash with a message:
>>  >>      "Xenomai: stuck on nucleus lock..",
>>  >> but only when called from a Xenomai task with a non-zero
>priority.
>>  >>
>>  >>
>>  >> If I make the same calls from a Linux thread that is still
>part
>>  >> of the Xenomai application, no crash results. And it seems
>>  >> that when I make the same calls from a Xenomai task that has
>>  >> a priority of "0", it also does not crash the kernel.
>>  >>
>>  >>
>>  >> I knew these calls would put the task into secondary mode
>>  >> since they make a number of kmallocs/kfrees and other
>syscalls.
>>  >
>>  >Xenomai won't switch to secondary mode automatically because a
>>  >regular
>>  >linux driver calls the regular kernel API, it simply does not
>know
>>  >about
>>  >this fact. It would switch only when a transition from userland
>to
>>  >kernel context happens due to a regular linux system call, which
>>  >includes the POSIX I/O calls one may invoke to reach such a
>driver.
>>  >
>>  >However, if that driver is RTDM-based, the set of POSIX I/O
>calls
>>  >becomes mode-sensitive, and a real-time task (i.e. non-zero prio)
>may
>>  >
>>  >well enter the driver code in primary mode, depending on how the
>>  >driver
>>  >is programmed to handle the request.
>>  >
>>  >> I didn't expect there to be a difference in behavior between
>>  >> a Xenomai task in secondary mode versus a normal Linux thread
>>  >> versus a Xenomai task with priority of "0".
>>  >>
>>  >
>>  >Xenomai assumes that 0-prio tasks it creates normally want to run
>in
>>  >
>>  >secondary mode, except when they invoke primary mode-only
>services.
>>  >For
>>  >this reason, Xenomai switches them back to secondary mode
>>  >automatically
>>  >when they are done with such kernel services. This does not
>happen
>>  >with
>>  >non-zero priority tasks, which are left in the current mode.
>>  >
>>  >So the difference could be that some kernel API is called from
>>  >primary
>>  >mode, leading to unexpected results in the latter case, which
>would
>>  >mean
>>  >that a RTDM-based driver is doing the wrong thing.
>>  >
>>  >>
>>  >> I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API on x86
>>  >> (Atom, SMP, 32-bit).
>>  >>
>>  >>
>>  >> Is it possible that a (well-written) driver can cause such
>>  >> behavior?  (If not I can post the crashdump details).
>>  >>
>>  >>
>>  >> I would like to use rt=5Fevent=5F / rt=5Fmutex=5F at other times
>>  >> which I cannot do if I need to make this a Linux thread.
>>  >> Is there a rational explanation that would allow me to use
>>  >> these calls and the driver calls if I simply set the task
>>  >> to priority "0"?
>>  >>
>>  >
>>  >Is this driver a RTDM driver, or a regular linux one?
>> It is a complex driver - its "runtime" calls are through RTDM,
>> its "setup/teardown" calls are not. The "runtime" calls (called
>> from a different, non-zero prio task) cause no problems and
>> are never called at the same time as the "setup/td" set.
>> The ones causing a problem are the "setup/td" set which are
>> probably calling the kernel in primary mode as you suggest
>> above.
>
>A simple way to check this is to enable=20
>CONFIG=5FIPIPE=5FDEBUG=5FCONTEXT. You would get debug=20
>assertions triggering, and related messages to your kernel=20
>console when/if this happens.

Thanks - I will give this a try.

>
>> If they are called from a task that remains in secondary mode
>> (except to service calls to rt=5Fmutex=5F, rt=5Fevent=5F which force
>> a temporary switch to primary) would those calls be as stable
>> as calling them out of a pure Linux thread?
>
>RTDM-wise, what makes these calls stable is when you ensure that only
>non-rt routines may call into the regular kernel API within your
>driver. Non-rt routines are those assigned to the *=5Fnrt handlers in your=
=20
>driver's device description structure, i.e. struct rtdm=5Fdevice.
>Typically, open=5Fnrt should be the entry point for setup duties.
>Therefore, what you need to make sure of, is that absolutely no =5Frt
>type handler calls into the regular kernel API.
>
I will consult the driver author. It may take some time. If =5Frt calls are=
=20
being made into the kernel wouldn't problems show up even when the=20
"setup/td" calls were made on the Linux thread?=20

An important clarification: when I refer to the "setup/td" calls, it is=20
not the setup/teardown calls for the driver itself, but rather the objects =
it=20
manages. So both the "runtime" calls and "setup/td" calls are through=20
ioctl=5Fnrt / ioctl=5Frt at this point. The calls are made several times=20
throughout the lifetime of the application.


>> Is this a valid/typical application of a 0-prio task?
>
>0-prio tasks are aimed at running most of the time in secondary mode,
>because they most of the time require regular kernel services only,=20
>except when they have to synchronize with the real-time stuff in some
>ways, and therefore have to be able to switch temporarily to primary
>mode for this.
>
>A typical use case is when you want such a task to deplete a
>real-time semaphore, to sync with a real-time activity running in parallel:
>when that happens, the 0-prio task might have to be blocked by the
>real-time scheduler until a semaphore resources is released by the=20
>real-time activity. This is only possible if that task has a Xenomai task
>control block associated, in addition to the regular Linux's task stuct=20
>descriptor, which allows it to switch to primary mode when needed,
>i.e. to be controlled by the Xenomai scheduler.

That is the use case we are trying to achieve - trying to coordinate
when the "setup/td" calls are made from the 0-prio task with a
state machine in another task and also mutex protect data shared=20
between the two. So a 0-prio task is a good fit!

So... am I correct to interpret your responses so far that it is not enough
that the driver code runs successfully when accessed from a Linux thread
to guarantee that it will also work when those same calls are made
from a 0-prio task?

>
>To sum up, 0-prio tasks allow non-rt code to synchronize on real-time
>objects, although real-time processing is not their main purpose. The
>motivation is different from having to call regular linux setup code
>once during the task's lifetime: in that case, automatic mode
>switching controlled by Xenomai is enough, and such switching=20
>happens with non-zero prio tasks as well.
>
>But, how Xenomai switches mode is defined on a per-syscall basis:
>some Xenomai syscalls may lead to switch to primary immediately prior to=20
>running the syscall (typically when the caller might block as a
>result of such call, or do some introspection of its own TCB), others may
>lead to switch to secondary mode. Regular linux syscalls will always cause
>the latter, regardless of the Xenomai task priority.
>

Thanks again, Philippe, for the wealth of info you're sharing!

Best regards,
--George
