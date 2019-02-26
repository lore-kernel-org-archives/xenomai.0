Subject: Re: Fwd: Debugging system freeze, SIGXCPU
References: <CAJA_znn4P=_tmbcKCipcmYrhPUhFw4JrMWv2VAMVR0DYSx9iMA@mail.gmail.com>
 <CAJA_znnmCr7QSjsnSQbLRYTM+CyBex05sBV0gbOdVQgYuBK0Tw@mail.gmail.com>
 <0509ec7d-20b3-bc38-7a04-7516f24249a1@xenomai.org>
 <CAJA_znmGTe3C5-YoxYH1ufN7j8rrRgA_Pd8+7cYtP673C8Bhiw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <47f2a72c-829b-4924-4346-8d640b305172@xenomai.org>
Date: Tue, 26 Feb 2019 09:40:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAJA_znmGTe3C5-YoxYH1ufN7j8rrRgA_Pd8+7cYtP673C8Bhiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ari Mozes <arimozes@neocisinc.com>, xenomai@xenomai.org

On 2/25/19 5:57 PM, Ari Mozes via Xenomai wrote:
> Philippe,
> Thank you for the information and the URL.
> I read through the thread, and I agree with comments that it would be
> helpful to be able to identify/blacklist/etc problematic calls when
> porting over existing code to a true RT scenario.  In our case the
> original code was written with "RT-like" behavior in mind, but as
> there is a lot of code already in place, approaches to identify
> existing problematic calls would be helpful.
> I will continue to familiarize myself with the nitty-gritty details,
> but anything that makes the process easier is always welcome :-)
> 

User-oriented documentation is lacking for Xenomai, that is a fact.
Until somebody tackles the task of contributing it gradually, the
situation won't change. This being said, the following may help as a
survival kit for programming with Xenomai.

This is a dual kernel system, so we have two competing cores: the
regular kernel and cobalt. The latter can preempt the former for running
its own tasks at almost any point in time, including within its critical
sections.

With that in mind, it becomes clear that calling regular kernel routines
from the runtime context of the cobalt core may cause severe re-entry bugs.

To mitigate this issue, cobalt detects when one of its tasks issues a
regular kernel system call from a real-time context, transferring
control over it to the regular kernel when this happens. The cobalt task
is demoted to non real-time mode during this process, which incurs
unbounded latency down the road, but that is still better than breaking
the whole kernel system.

Because such detection happens when a task transitions between user and
kernel space due to a syscall, vDSO-based services and intra-kernel
function calls escape it, since there is no intervening syscall. In
these particular cases, the real-time core most often breaks basic
assumptions of the non real-time linux kernel with respect to locking
rules and interrupt-free sections by running code it should not, and
things start to fall apart.

C++ libraries may call into standard glibc services such as malloc/free,
POSIX mutex support, which in turn may issue regular linux syscalls in
some cases (e.g. access to a non-contended mutex won't, the contended
case will definitely ask the kernel for putting the caller to sleep
until the lock is available). This is going to be the major issue to
solve when porting a large C++ code base to a dual kernel system such as
Xenomai: figuring out which C++ abstraction is real-time safe in such
environment, which is not.

Typical solutions may involve overloading the new/delete operators so
that an allocator which does not rely on regular system calls is picked
instead of malloc/free, possibly staying away from C++ exception
handling too if it implicitly allocates memory the same way.

To help you in detecting the situations where your application is being
demoted to non real-time mode (aka "secondary" mode) by cobalt in order
to process a regular syscall, you can trap the SIGDEBUG signal. This is
a regular linux signal (SIGXCPU in disguise) which is sent to the thread
crossing the domain boundaries from rt to non-rt. For this to happen,
the thread should arm the "warn on mode switch" flag using a Xenomai
system call. The application should catch the SIGDEBUG signal, which
comes with some bits of information detailing which action specifically
triggered the mode switch.

With the "alchemy" API, rt_task_set_mode(0, T_WARNSW, NULL) can be used,
or the task can be created with such init flag as illustrated in
demo/alchemy/altency.c. With the POSIX API, one can use
pthread_setmode_np(0, PTHREAD_WARNSW, NULL) as illustrated in
testsuite/latency/latency.c.

These particular services are described there:

https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__alchemy__task.html#ga915e7edfb0aaddb643794d7abc7093bf
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__thread.html#gae3b7df7f77c04253ed19fb6346f0f9b2

In the Xenomai documentation, the "api-tags" information mentions
"switch-primary" for any call that forces the caller to switch to
real-time mode. Conversely, "switch-secondary" tags services which
demote the caller to non-rt mode.

As a rule of thumb, most calls from the glibc should be considered as
potentially rt-unsafe in a dual kernel environment, because they may
rely on regular system calls for performing their work. Specifically,
any service which in essence allocates memory, synchronizes threads,
does messaging, or affects the scheduling state of POSIX threads may
have to call into the regular kernel for doing so.

This is fine to use them during the initialization/cleanup stages of any
Xenomai application, but you certainly want to avoid them from the
time-critical work loop.

-- 
Philippe.

