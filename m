MIME-Version: 1.0
In-Reply-To: <5120A36E.9050509@xenomai.org>
References: <5120A36E.9050509@xenomai.org>,
	<OF44D0F7ED.D0CBED6B-ON85257B15.00319BA4-85257B15.00319BA9@moog.com>
From: George Broz <GBroz@moog.com>
Message-ID: <OF5D712584.D7829A38-ON85257B15.003F8547-85257B15.003F854D@moog.com>
Date: Sun, 17 Feb 2013 06:33:49 -0500
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

>On 02/17/2013 10:01 AM, George Broz wrote:
>> Hello All,
>>
>> I'm using a kernel driver for which some calls cause the
>> Xenomai kernel to crash with a message:
>>      "Xenomai: stuck on nucleus lock..",
>> but only when called from a Xenomai task with a non-zero priority.
>>
>>
>> If I make the same calls from a Linux thread that is still part
>> of the Xenomai application, no crash results. And it seems
>> that when I make the same calls from a Xenomai task that has
>> a priority of "0", it also does not crash the kernel.
>>
>>
>> I knew these calls would put the task into secondary mode
>> since they make a number of kmallocs/kfrees and other syscalls.
>
>Xenomai won't switch to secondary mode automatically because a
>regular=20
>linux driver calls the regular kernel API, it simply does not know
>about=20
>this fact. It would switch only when a transition from userland to=20
>kernel context happens due to a regular linux system call, which=20
>includes the POSIX I/O calls one may invoke to reach such a driver.
>
>However, if that driver is RTDM-based, the set of POSIX I/O calls=20
>becomes mode-sensitive, and a real-time task (i.e. non-zero prio) may
>
>well enter the driver code in primary mode, depending on how the
>driver=20
>is programmed to handle the request.
>
>> I didn't expect there to be a difference in behavior between
>> a Xenomai task in secondary mode versus a normal Linux thread
>> versus a Xenomai task with priority of "0".
>>
>
>Xenomai assumes that 0-prio tasks it creates normally want to run in
>
>secondary mode, except when they invoke primary mode-only services.
>For=20
>this reason, Xenomai switches them back to secondary mode
>automatically=20
>when they are done with such kernel services. This does not happen
>with=20
>non-zero priority tasks, which are left in the current mode.
>
>So the difference could be that some kernel API is called from
>primary=20
>mode, leading to unexpected results in the latter case, which would
>mean=20
>that a RTDM-based driver is doing the wrong thing.
>
>>
>> I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API on x86
>> (Atom, SMP, 32-bit).
>>
>>
>> Is it possible that a (well-written) driver can cause such
>> behavior?  (If not I can post the crashdump details).
>>
>>
>> I would like to use rt=5Fevent=5F / rt=5Fmutex=5F at other times
>> which I cannot do if I need to make this a Linux thread.
>> Is there a rational explanation that would allow me to use
>> these calls and the driver calls if I simply set the task
>> to priority "0"?
>>
>
>Is this driver a RTDM driver, or a regular linux one?

It is a complex driver - its "runtime" calls are through RTDM,=20
its "setup/teardown" calls are not. The "runtime" calls (called=20
from a different, non-zero prio task) cause no problems and=20
are never called at the same time as the "setup/td" set.=20

The ones causing a problem are the "setup/td" set which are
probably calling the kernel in primary mode as you suggest
above.=20

If they are called from a task that remains in secondary mode
(except to service calls to rt=5Fmutex=5F, rt=5Fevent=5F which force=20
a temporary switch to primary) would those calls be as stable=20
as calling them out of a pure Linux thread?=20

Is this a valid/typical application of a 0-prio task?


Thanks for your help, Philippe. It's much appreciated!

--George
