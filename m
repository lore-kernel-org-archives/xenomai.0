Message-ID: <530B13CF.2040901@siemens.com>
Date: Mon, 24 Feb 2014 10:41:35 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <530A9265.80706@xenomai.org> <530B0933.5010307@siemens.com>
In-Reply-To: <530B0933.5010307@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] pull request for the ipipe-3.10 branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-02-24 09:56, Jan Kiszka wrote:
> On 2014-02-24 01:29, Gilles Chanteperdrix wrote:
>> Hi,
>>
>> The following changes since commit ce5bfa8a3282c8f97d5ec4b36802333b29e8c241:
>>
>>   ipipe: fix wrong assumption in startup code of rt-timers (SMP) (2014-02-13 15:22:15 +0100)
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/ipipe-gch.git for-ipipe-3.10
>>
>> for you to fetch changes up to da6384562ba94d28ffa7931e016a26b7db0b8ef5:
>>
>>   ipipe/omap4: use the L2 cache write-allocate option (2014-02-24 01:26:47 +0100)
>>
>> ----------------------------------------------------------------
>> Charles Steinkuehler (1):
>>       arm/ipipe: fix compilation error with THUMB2
>>
>> Gilles Chanteperdrix (6):
>>       arm/ipipe: fetch processor id from threadinfo in non-legacy mode
>>       ipipe: introduce the ipipe_smp_p predicate
>>       ipipe/spinlocks: use ipipe_smp_p to optimize-out spinlocks code
>>       ipipe/arm: optimize the SMP_ON_UP case
>>       ipipe/arm: add an option to disable L2 cache write-allocate
>>       ipipe/omap4: use the L2 cache write-allocate option
>>
>>  arch/arm/include/asm/barrier.h             |   44 +++++++++++++++++++++++++------
>>  arch/arm/include/asm/hardware/cache-l2x0.h |    2 ++
>>  arch/arm/include/asm/ipipe.h               |    6 +++++
>>  arch/arm/include/asm/ipipe_base.h          |   32 +++++++++++++++++++++-
>>  arch/arm/include/asm/percpu.h              |    4 +--
>>  arch/arm/kernel/entry-armv.S               |    2 ++
>>  arch/arm/kernel/ipipe.c                    |   22 +++++++++++++++-
>>  arch/arm/mach-omap2/omap4-common.c         |    3 ++-
>>  arch/arm/mm/cache-l2x0.c                   |   13 +++++++++
>>  include/linux/ipipe.h                      |    6 +++++
>>  kernel/ipipe/core.c                        |   20 ++++++++------
>>  11 files changed, 133 insertions(+), 21 deletions(-)
>>
> 
> Could we do a stable update at this chance? There is a trivial conflict
> in generic code and one in ARM in order to use recent 3.10. Maybe you
> can have a look at the latter, Gilles:
> 
> http://git.xenomai.org/ipipe-jki.git/commit/?h=for-upstream/3.10&id=63866844101456d3f2f2405620eee7c4ad0bd88d

Better this one:

http://git.xenomai.org/ipipe-jki.git/commit/?h=for-upstream/3.10&id=57769beb86c4d45c83b9a0859a37bb15d73266e3

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

