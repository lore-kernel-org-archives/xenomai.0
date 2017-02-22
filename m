References: <CADYdroOG6RaLGmcpwFiHjJt-cU3f9vaCQw+vJ=tFdx3sg4nvhg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <4cc7cdeb-a83d-dd78-372b-9eef06f44aaf@xenomai.org>
Date: Wed, 22 Feb 2017 09:59:50 +0100
MIME-Version: 1.0
In-Reply-To: <CADYdroOG6RaLGmcpwFiHjJt-cU3f9vaCQw+vJ=tFdx3sg4nvhg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] latency test and mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Lange <nolange79@gmail.com>, Xenomai <xenomai@xenomai.org>

On 02/21/2017 07:37 PM, Norbert Lange wrote:
> Hi,
> 
> I got some really big variations on the latency test (up to 4ms), but
> I am not exactly sure if this supposed the realtime portion.

This means that the underlying native kernel Mercury depends on has a
latency issue for sure.

> I am unable to run kernel or irq tests.

That is expected, since a kernel module implementing those tests is
required, but only Cobalt provides it so far. Such module is based on
Xenomai's RTDM kernel interface, which we don't have for Mercury (to be
precise, we have a 10-years old POC for it which would need significant
update).

> 
> For a user thread, this is probably like expected since this is a full
> debian desktop with RT kernel.
> 
> If I understood the mercury model right, I could create kernel modules
> with realtime behaviour, Is there any test for latency amongst those?
> (Documentation is rather light on mercury)
> 

Mercury is basically providing a way to run the non-POSIX Xenomai APIs
over a native kernel, nothing more than this. Said differently, this is
a purely user-space thing, which does not introduce any kernel support.

The idea behind Mercury is to allow running the RTOS emulators Xenomai
provides (e.g. vxworks and psos) without dragging in the co-kernel
support Cobalt introduces, which may not be required by some legacy
applications ported to Linux, for which real-time performances are not
actually critical. If one wants to go for the POSIX interface
exclusively, then Mercury brings no value at all.

So Mercury fully depends on the real-time capabilities of the "regular"
Linux kernel underneath for that matter, whether it includes the
PREEMPT_RT patch or not.

> PS.
> I can rule out SMI interaction, the count of those is not increasing.
> 

The latency test code (testsuite/latency/latency.c) is shared between
Mercury and Cobalt cores, the major difference is that POSIX services
this code invokes are obtained from the glibc or libcolbalt - which
contains the syscall interface to the Cobalt co-kernel, respectively.

You may want to check for issues which are specific to running real-time
code over native kernels, like SCHED_FIFO throttling (although I doubt
it would trigger with the latency test).

-- 
Philippe.

