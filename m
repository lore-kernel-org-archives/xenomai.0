References: <20170125150837.14161-1-henning.schild@siemens.com>
 <20170125150837.14161-3-henning.schild@siemens.com>
 <20170302105601.4b7d6214@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <aa57407e-6064-eebf-6d9f-be2ba864d633@xenomai.org>
Date: Thu, 2 Mar 2017 11:21:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170302105601.4b7d6214@md1em3qc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 3/3] lib/cobalt: wrap CXXABI One-time
 Constructor functions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, xenomai@xenomai.org

On 03/02/2017 10:56 AM, Henning Schild wrote:
> Am Wed, 25 Jan 2017 16:08:37 +0100
> schrieb Henning Schild <henning.schild@siemens.com>:
> 
>> The implementation of these functions uses locks and has the potential
>> to trigger a SIGXCPU when contended. Wrap them with assert_nrt so they
>> reliably cause a switch when used in the rt context.
>>
>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>> ---
>>  lib/cobalt/assert.wrappers  |  3 +++
>>  lib/cobalt/assert_context.c | 19 +++++++++++++++++++
>>  lib/cobalt/internal.h       | 12 ++++++++++++
>>  lib/cobalt/wrappers.c       | 37
>> +++++++++++++++++++++++++++++++++++++ 4 files changed, 71
>> insertions(+)
>>
>> diff --git a/lib/cobalt/assert.wrappers b/lib/cobalt/assert.wrappers
>> index 7164858..65320ab 100644
>> --- a/lib/cobalt/assert.wrappers
>> +++ b/lib/cobalt/assert.wrappers
>> @@ -1,2 +1,5 @@
>>  --wrap malloc
>>  --wrap free
>> +--wrap __cxa_guard_acquire
>> +--wrap __cxa_guard_release
>> +--wrap __cxa_guard_abort
>> diff --git a/lib/cobalt/assert_context.c b/lib/cobalt/assert_context.c
>> index 2085953..fd18d6b 100644
>> --- a/lib/cobalt/assert_context.c
>> +++ b/lib/cobalt/assert_context.c
>> @@ -66,3 +66,22 @@ COBALT_IMPL(void, free, (void *ptr))
>>  	assert_nrt();
>>  	__STD(free(ptr));
>>  }
>> +
>> +/* CXXABI 3.3.2 One-time Construction API */
>> +COBALT_IMPL(int, __cxa_guard_acquire, (__guard *g))
>> +{
>> +	assert_nrt();
>> +	return __STD(__cxa_guard_acquire(g));
>> +}
>> +
>> +COBALT_IMPL(void, __cxa_guard_release, (__guard *g))
>> +{
>> +	assert_nrt();
>> +	__STD(__cxa_guard_release(g));
>> +}
>> +
>> +COBALT_IMPL(void, __cxa_guard_abort, (__guard *g))
>> +{
>> +	assert_nrt();
>> +	__STD(__cxa_guard_abort(g));
>> +}
>> diff --git a/lib/cobalt/internal.h b/lib/cobalt/internal.h
>> index 1531901..8874f71 100644
>> --- a/lib/cobalt/internal.h
>> +++ b/lib/cobalt/internal.h
>> @@ -93,4 +93,16 @@ extern int __cobalt_std_fifo_minpri,
>>  extern int __cobalt_std_rr_minpri,
>>  	   __cobalt_std_rr_maxpri;
>>  
>> +#ifdef __ARM_EABI__
>> +typedef uint32_t __guard;
>> +#else
>> +typedef uint64_t __guard;
>> +#endif
>> +int __real___cxa_guard_acquire(__guard*);
>> +void __real___cxa_guard_release(__guard*);
>> +void __real___cxa_guard_abort(__guard*);
>> +int __cxa_guard_acquire(__guard*);
>> +void __cxa_guard_release(__guard*);
>> +void __cxa_guard_abort(__guard*);
>> +
>>  #endif /* _LIB_COBALT_INTERNAL_H */
>> diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
>> index 43ca630..fa7fbcb 100644
>> --- a/lib/cobalt/wrappers.c
>> +++ b/lib/cobalt/wrappers.c
>> @@ -43,6 +43,7 @@
>>  #include <unistd.h>
>>  #include <malloc.h>
>>  #include <boilerplate/compiler.h>
>> +#include <internal.h>
>>  
>>  /* sched */
>>  __weak
>> @@ -544,3 +545,39 @@ int __real_usleep(useconds_t usec)
>>  {
>>  	return usleep(usec);
>>  }
>> +
>> +__weak
>> +int __real___cxa_guard_acquire(__guard *g)
>> +{
>> +	return __cxa_guard_acquire(g);
>> +}
>> +
>> +__weak
>> +void __real___cxa_guard_release(__guard *g)
>> +{
>> +	return __cxa_guard_release(g);
>> +}
>> +
>> +__weak
>> +void __real___cxa_guard_abort(__guard *g)
>> +{
>> +	return __cxa_guard_abort(g);
>> +}
> 
> The following weak symbols are not always replaced by the strong ones
> from libstdc++. They are just here for C-code and can now break C++.
> 
>> +__weak
>> +int __cxa_guard_acquire(__guard *g)
>> +{
>> +	return 0;
>> +}
>> +
>> +__weak
>> +void __cxa_guard_release(__guard *g)
>> +{
>> +	return;
>> +}
>> +
>> +__weak
>> +void __cxa_guard_abort(__guard *g)
>> +{
>> +	return;
>> +}
> 
> For dynamically linked executables you do need "LD_DYNAMIC_WEAK" in
> your env and for static linking "--whole-archive". Otherwise you might
> end up using these weak dummies.
> 
> This patch introduced a critical bug! I will come up with a fix but
> wanted to report the problem first.
> 

Ok, thanks. I'm holding 3.0.4 until this is fixed.

-- 
Philippe.

