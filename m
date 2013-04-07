Message-ID: <5161A51C.8050606@xenomai.org>
Date: Sun, 07 Apr 2013 18:55:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515DE96F.7080508@xenomai.org> <515FEF85.5010801@web.de>
In-Reply-To: <515FEF85.5010801@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe on ARM platform.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 04/06/2013 11:48 AM, Jan Kiszka wrote:

> On 2013-04-04 22:58, Gilles Chanteperdrix wrote:
>>
>> Hi,
>>
>> The for-core-3.5.7 and for-core-3.8.2 branches in ipipe_gch.git 
>> repository contain new versions of the I-pipe kernel for the ARM 
>> architecture. 
>>
>> The for-core-3.5.7 branch contains an important fix for SMP platforms, 
>> and the fix for mx28 posted by Martin Krause. 
>>
>> The for-core-3.8.2 branch is the newest port. Known issues are:
>> - it has been rebased on v3.8.2, so it will not merge with the branch 
>> it started from, if preferred, I can push a merged version;
>> - ftrace is broken, so I wonder if it would not be simpler to have a 
>> tracer not relying on ftrace, as we did at the beginning of the I-pipe 
>> tracer;
>> - threaded fasteoi irqs are broken, the branch contains the latest 
>> patch posted on this list, but since I received no comment, I am not 
>> sure it is the right fix.
>>
>> The pull requests follow.
>> The following changes since commit 946ca3977e75316751caecc7182f4e64af6499d5:
>>
>>   ipipe-core-3.5.7-blackfin-3 (2013-01-22 11:41:34 +0100)
>>
>> are available in the git repository at:
>>   git://git.xenomai.org/ipipe-gch.git for-core-3.5.7
>>
>> Gilles Chanteperdrix (2):
>>       arm/ipipe: fix off-by-one error in IPI virqs allocation
>>       mx28/ipipe: allow building kernel for both mx28 and mx23
>>
>> Martin Krause (1):
>>       mx28/ipipe: fix the timer selected with I-pipe
>>
>>  arch/arm/kernel/smp.c       |    2 +-
>>  arch/arm/mach-mxs/timer.c   |   40 ++++++++++++++++------------------------
>>  drivers/clk/mxs/clk-imx28.c |    4 ++++
>>  3 files changed, 21 insertions(+), 25 deletions(-)
>>
>>
>> The following changes since commit 5a16a5a4dd127afcb2446afa057b55a60cffe7f9:
>>
>>   blackfin/ipipe: import arch-dep bits based on 3.5.7-blackfin-3 (2013-04-04 21:37:51 +0200)
>>
>> are available in the git repository at:
>>   git://git.xenomai.org/ipipe-gch.git for-core-3.8.2
>>
>> Gilles Chanteperdrix (18):
>>       avoid kernel fault upon coredump on arm with vivt cache
>>       FCSE: pid life cycle
>>       FCSE: Conversions between VA and MVA
>>       FCSE: Address-space limits
>>       FCSE: Make the shared mappings uncacheable
>>       FCSE: do not flush cache during context switch
>>       "Best-effort" FCSE: choose whether to flush cache at run-time
>>       "Best-effort" FCSE: Allow PID re-use
>>       "Best-effort" FCSE: Handle mappings above 32 MB
>>       "Best effort" FCSE: Reserve address-space for stack
>>       "Best-effort" FCSE: Handle shared mappings
>>       FCSE: add Makefile and compilation option
>>       noarch/ipipe: fix ipipe_update_hostrt
>>       noarch/ipipe: fix one-shot fasteoi irq
>>       noarch/ipipe: introduce IPIPE_NR_ROOT_IRQS
>         ^^^^^^
> I'm tagging generic patches just with "ipipe:". IIRC, this is what
> Philippe requested.
> 
>>       arm/ipipe: import arch-dep bits based on 3.5.7-arm-3
>>       arm/ipipe: avoid calling might_fault() with non-root domains
> 
> I think ipipe_uaccess_might_fault could become a generic service in case
> other archs need it as well. And it has to map directly to might_fault
> in case CONFIG_IPIPE_DEBUG_CONTEXT is disabled (thus zero overhead).


Hi,

I have just pushed a new version of the for-core-3.8.2 branch with all
the comments addressed.

I also had tested a merge of the previous version with your next-x86
branch, and except a few merge conflicts and a build error without SMP,
adressed by this commit:
http://git.xenomai.org/ipipe-gch.git/?p=ipipe-gch.git;a=commitdiff;h=fae81444a0bfe12de514ac039f866c0f66abfb3c;hp=1198253580e0d5610ee886e1ff3771461a06f414

It seemed to work fine on my x86 boxes.

Regards.

-- 
                                                                Gilles.

