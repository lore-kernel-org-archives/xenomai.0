Subject: Re: [PATCH] y2038: replace timespec with timespec64 in clock_settime
References: <1600691577-12011-1-git-send-email-chensong@tj.kylinos.cn>
 <01014f7c-76ed-46ea-0c7c-920f6eb63b0e@siemens.com>
 <27465fc4-ab13-ffb7-eec4-21160fbeec8a@tj.kylinos.cn>
 <7e00b8e7-4029-00f0-38dc-6d9452b552e7@siemens.com>
 <5F72D3CF.7070200@tj.kylinos.cn>
 <8ab3d084-e9bc-de32-1095-403ac6e1a2c9@web.de>
 <5F8425BD.7090208@tj.kylinos.cn> <5F8E9B65.2050202@tj.kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <41f5641a-bc12-f5d3-6d87-7d5ce6c693a5@siemens.com>
Date: Wed, 21 Oct 2020 08:43:02 +0200
MIME-Version: 1.0
In-Reply-To: <5F8E9B65.2050202@tj.kylinos.cn>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: chensong <chensong@tj.kylinos.cn>, xenomai@xenomai.org

On 20.10.20 10:10, chensong wrote:
> Hi Jan;
> 
> i talked to arnd Bergmann about how to build a 32bit 2038-safe process, 
> he told me that neither gcc nor glibc can fully support 64bit timespec 
> yet, he suggested me to use musl(https://wiki.musl-libc.org/), and he 
> also suggested me to use kernel5.4.
> 
> I followed his suggestion, built a 32bit process with musl-gcc and ran 
> it in a armv7l device, and it's working fine, safe.
> 
> Then i turned to xenomai, it took a lot time to build libcobalt with 
> musl's toolchain(https://musl.cc/), it worked anyway, but i found it 
> called linux's clock_settime(kernel/time/posix-timers.c) instead of 
> cobalt's clock_settime, i'm stuck here.
> 
> what's more, to enable 64bit __kernel_timespec should enable 
> CONFIG_64BIT_TIME, it's off by default, i turned it on but system can't 
> bootup.
> 
> Ideally, if we could verify a 32bit process 2038-safe in both 32bit 
> system and 64bit system, we could continue to work on other syscalls, 
> but now, what can we do? shall we create a new branch specific for y2038 
> which we can apply out patches on and mainline them after gcc/glibs is 
> ready for verification?
> 
> Let me know your opinion about this case, many thanks.
> 

I'll try to have a look soon - currently deep into FPU debugging for 5.4 
(interrupts by other stuff, which doesn't make that easier).

Jan

> BR
> 
> chensong
> 
> On 2020年10月12日 17:45, chensong wrote:
>>
>>
>> On 2020年10月01日 03:19, Jan Kiszka wrote:
>>> On 29.09.20 08:27, chensong wrote:
>>>>
>>>>
>>>> On 2020年09月29日 00:52, Jan Kiszka wrote:
>>>>> On 23.09.20 03:40, song wrote:
>>>>>>
>>>>>>
>>>>>> On 2020/9/22 下午11:16, Jan Kiszka wrote:
>>>>>>> On 21.09.20 14:32, chensong wrote:
>>>>>>>> Upstream has used timespec64 to replace timespec inside kernel and
>>>>>>>> used __kernel_timespec to replace timespect in syscalls, therefore
>>>>>>>> we must keep aligned with upstream.
>>>>>>>>
>>>>>>>> clock_settime is a point to get started at, it involves 2 parts:
>>>>>>>> 1, syscall in ./include/trace/events/cobalt-posix.h for 64bits
>>>>>>>> 2, compat syscall in kernel/cobalt/posix/syscall32.c for 32bits
>>>>>>>>
>>>>>>>> some new functions are implemented to keep the compatibility with
>>>>>>>> other syscalls which haven't been handled yet and will be removed
>>>>>>>> in the end of the work.
>>>>>>>
>>>>>>> So, this switches also existing syscalls to 64-bit types, breaking
>>>>>>> the
>>>>>>> current ABI, no? How much effort would it be to keep the old ABI,
>>>>>>> adding a 64-bit one aside of it?
>>>>>>
>>>>>> Not breaking current ABI, i didn't add any new ABIs specific for
>>>>>> 64bits,
>>>>>> i added some new static functions, like ts2ns and ts2ns64,
>>>>>> sys32_put_timespec and sys64_put_timespec, specific for 
>>>>>> clock_settime.
>>>>>>
>>>>>
>>>>> clock_settime accepts struct timespec so far, you are changing that to
>>>>> struct __kernel_timespec. If I look at its definition in the 
>>>>> kernel, it
>>>>> uses __kernel_time64_t as tv_sec type. But our current 32-bit users
>>>>> still expects a 32-bit type here, no? Would that change already 
>>>>> require
>>>>> a new clock_settime64 syscall if we wanted to stay binary compatible?
>>>>
>>>> 32 bit user space processes go to
>>>> COBALT_SYSCALL32emu(clock_settime,current,(clockid_t clock_id,const
>>>> struct compat_timespec __user *u_ts)) defined in
>>>> ./kernel/cobalt/posix/syscall32.c. It uses compat_timespec which 
>>>> 32it is
>>>> compatible with.
>>>>
>>>> I tested 32bit application and 64bit application on 64bit system
>>>> respeactively
>>>> 32bit process -- clock_settime -- COBALT_SYSCALL32emu(clock_settime
>>>> 64bit process -- clock_settime -- COBALT_SYSCALL(clock_settime)
>>>>
>>>
>>> You also need to consider 32-bit kernels, not on x86 anymore (i386 is
>>> practically dead), but e.g. ARMv7. There we would have a breakage now,
>>> don't we?
>>>
>> i tested 32bit process on a 32bit kernel (raspberry 2, armv7), it seems
>> timespec64 is working fine.
>>
>> If this patch is acceptable for you, i will start clock_gettime.
>> meanwhile, i will email Arnd Bergmann <arnd@arndb.de> to see how to
>> enable 64bit timespec in userspace to see if 32bit process is 2038-safe
>> in both 32bit kernel and 64bit kernel.
>>
>>> Jan
>>>
> 
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

