Subject: Re: [ANNOUNCE] Xenomai v3.2-rc2 available
References: <b975707c-61a7-4859-0291-accc7c6a04de@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <00bee36d-d0be-abd3-8c76-bb97a9e52868@siemens.com>
Date: Tue, 19 Oct 2021 18:33:12 +0200
MIME-Version: 1.0
In-Reply-To: <b975707c-61a7-4859-0291-accc7c6a04de@siemens.com>
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
To: Xenomai <xenomai@xenomai.org>

On 19.10.21 18:26, Jan Kiszka via Xenomai wrote:
> Hi all,
> 
> a second release candidate for 3.2 is available now.
> 
> https://source.denx.de/Xenomai/xenomai/-/archive/v3.1-rc2/xenomai-v3.1-rc2.tar.bz2
> https://source.denx.de/Xenomai/xenomai/commits/v3.1-rc2

Gmbl, this should have become

https://source.denx.de/Xenomai/xenomai/-/archive/v3.2-rc2/xenomai-v3.2-rc2.tar.bz2
https://source.denx.de/Xenomai/xenomai/commits/v3.2-rc2

after copy&pasting.

Jan

> 
> It primarily consists of bug fixes (as it should be) but also includes 
> another y2038 conversion that is orthogonal to existing APIs, thus 
> harmless, as we well as most compile fixes to build against 5.15 
> kernels. You just need to turn off CONFIG_XENO_OPT_DEBUG_TRACE_RELAX for 
> the time being if you want to try that combination (still experimental). 
> rc2 also brings the ABI revision bump that was forgotten for rc1 
> (actually even much earlier).
> 
> All changes since 3.2-rc1:
> 
> Jan Kiszka (24):
>       cobalt/posix/io: Privatize some select helpers
>       doc: Fix copy&paste mistake in corectl man page
>       cobalt/arch/arm: fptest: Add missing SIMD register clobbering
>       Bump ABI revisions
>       cobalt/posix/thread: Properly discard xnthread on registration error
>       drivers/testing/switchtest: Properly clean up xnthread on error
>       cobalt/sched: Save one cpumask stack variable in affinity_vfile_store
>       lib/alchemy: Fix rt_pipe_read* with timeouts
>       lib/alchemy/testsuite: Fix pipe-1 test case
>       lib/alchemy/testsuite: Extend pipe-1 test by timeout checks
>       lib/alchemy: Fix/clarify documentation of *_timed functions regarding abs_timeout
>       cobalt/dovetail: Use IRQ_WORK_INIT to please 5.11+
>       cobalt: Use close_fd for kernel 5.14+
>       cobalt: Use linux/stdarg.h
>       cobalt/posix: Add required FORCE makefile rule
>       cobalt/thread: Switch to MAX_RT_PRIO
>       cobalt: Use fallthrough key word rather than comments
>       drivers/can: Drop MODULE_SUPPORTED_DEVICE
>       drivers/net/e1000e: Add missing ethtool.h include
>       lib/{cobalt,copperplate}: Use valid addresses for pthread_setspecific
>       testsuite/latency: Use corresponding pclose for popen
>       lib/boilerplate: Convert pthread_mutexattr_setrobust_np stub into inline function
>       lib: Switch to pthread_mutexattr_setrobust
>       config: Bump version number
> 
> Song Chen (3):
>       y2038: cobalt/posix/io: Adding recvmmsg64
>       y2038: lib/cobalt/rtdm: dispatch recvmmg
>       y2038: testsuite/smokey/y2038: testcase for recvmmsg64
> 
> Please continue with testing and reporting, then we can soon finalize 
> this major release!
> 
> Jan
> 

