Message-ID: <5120A36E.9050509@xenomai.org>
Date: Sun, 17 Feb 2013 10:31:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <OF44D0F7ED.D0CBED6B-ON85257B15.00319BA4-85257B15.00319BA9@moog.com>
In-Reply-To: <OF44D0F7ED.D0CBED6B-ON85257B15.00319BA4-85257B15.00319BA9@moog.com>
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

On 02/17/2013 10:01 AM, George Broz wrote:
> Hello All,
>
> I'm using a kernel driver for which some calls cause the
> Xenomai kernel to crash with a message:
>      "Xenomai: stuck on nucleus lock..",
> but only when called from a Xenomai task with a non-zero priority.
>
>
> If I make the same calls from a Linux thread that is still part
> of the Xenomai application, no crash results. And it seems
> that when I make the same calls from a Xenomai task that has
> a priority of "0", it also does not crash the kernel.
>
>
> I knew these calls would put the task into secondary mode
> since they make a number of kmallocs/kfrees and other syscalls.

Xenomai won't switch to secondary mode automatically because a regular 
linux driver calls the regular kernel API, it simply does not know about 
this fact. It would switch only when a transition from userland to 
kernel context happens due to a regular linux system call, which 
includes the POSIX I/O calls one may invoke to reach such a driver.

However, if that driver is RTDM-based, the set of POSIX I/O calls 
becomes mode-sensitive, and a real-time task (i.e. non-zero prio) may 
well enter the driver code in primary mode, depending on how the driver 
is programmed to handle the request.

> I didn't expect there to be a difference in behavior between
> a Xenomai task in secondary mode versus a normal Linux thread
> versus a Xenomai task with priority of "0".
>

Xenomai assumes that 0-prio tasks it creates normally want to run in 
secondary mode, except when they invoke primary mode-only services. For 
this reason, Xenomai switches them back to secondary mode automatically 
when they are done with such kernel services. This does not happen with 
non-zero priority tasks, which are left in the current mode.

So the difference could be that some kernel API is called from primary 
mode, leading to unexpected results in the latter case, which would mean 
that a RTDM-based driver is doing the wrong thing.

>
> I'm running Linux 2.6.37.6 w/Xenomai 2.6.1, native API on x86
> (Atom, SMP, 32-bit).
>
>
> Is it possible that a (well-written) driver can cause such
> behavior?  (If not I can post the crashdump details).
>
>
> I would like to use rt_event_ / rt_mutex_ at other times
> which I cannot do if I need to make this a Linux thread.
> Is there a rational explanation that would allow me to use
> these calls and the driver calls if I simply set the task
> to priority "0"?
>

Is this driver a RTDM driver, or a regular linux one?

-- 
Philippe.

