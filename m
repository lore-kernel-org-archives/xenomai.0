Subject: Re: [PATCH] y2038: replace timespec with timespec64 in clock_settime
References: <1600691577-12011-1-git-send-email-chensong@tj.kylinos.cn>
 <01014f7c-76ed-46ea-0c7c-920f6eb63b0e@siemens.com>
 <27465fc4-ab13-ffb7-eec4-21160fbeec8a@tj.kylinos.cn>
 <7e00b8e7-4029-00f0-38dc-6d9452b552e7@siemens.com>
 <5F72D3CF.7070200@tj.kylinos.cn>
 <8ab3d084-e9bc-de32-1095-403ac6e1a2c9@web.de>
From: song <chensong@tj.kylinos.cn>
Message-ID: <d290cd61-b8be-57d1-6914-949f213e54fc@tj.kylinos.cn>+556476C6DAD61E96
Date: Sun, 4 Oct 2020 11:09:27 +0800
MIME-Version: 1.0
In-Reply-To: <8ab3d084-e9bc-de32-1095-403ac6e1a2c9@web.de>
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
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@xenomai.org



On 2020/10/1 上午3:19, Jan Kiszka wrote:
> On 29.09.20 08:27, chensong wrote:
>>
>>
>> On 2020年09月29日 00:52, Jan Kiszka wrote:
>>> On 23.09.20 03:40, song wrote:
>>>>
>>>>
>>>> On 2020/9/22 下午11:16, Jan Kiszka wrote:
>>>>> On 21.09.20 14:32, chensong wrote:
>>>>>> Upstream has used timespec64 to replace timespec inside kernel and
>>>>>> used __kernel_timespec to replace timespect in syscalls, therefore
>>>>>> we must keep aligned with upstream.
>>>>>>
>>>>>> clock_settime is a point to get started at, it involves 2 parts:
>>>>>> 1, syscall in ./include/trace/events/cobalt-posix.h for 64bits
>>>>>> 2, compat syscall in kernel/cobalt/posix/syscall32.c for 32bits
>>>>>>
>>>>>> some new functions are implemented to keep the compatibility with
>>>>>> other syscalls which haven't been handled yet and will be removed
>>>>>> in the end of the work.
>>>>>
>>>>> So, this switches also existing syscalls to 64-bit types, breaking the
>>>>> current ABI, no? How much effort would it be to keep the old ABI,
>>>>> adding a 64-bit one aside of it?
>>>>
>>>> Not breaking current ABI, i didn't add any new ABIs specific for 64bits,
>>>> i added some new static functions, like ts2ns and ts2ns64,
>>>> sys32_put_timespec and sys64_put_timespec, specific for clock_settime.
>>>>
>>>
>>> clock_settime accepts struct timespec so far, you are changing that to
>>> struct __kernel_timespec. If I look at its definition in the kernel, it
>>> uses __kernel_time64_t as tv_sec type. But our current 32-bit users
>>> still expects a 32-bit type here, no? Would that change already require
>>> a new clock_settime64 syscall if we wanted to stay binary compatible?
>>
>> 32 bit user space processes go to
>> COBALT_SYSCALL32emu(clock_settime,current,(clockid_t clock_id,const
>> struct compat_timespec __user *u_ts)) defined in
>> ./kernel/cobalt/posix/syscall32.c. It uses compat_timespec which 32it is
>> compatible with.
>>
>> I tested 32bit application and 64bit application on 64bit system
>> respeactively
>> 32bit process -- clock_settime -- COBALT_SYSCALL32emu(clock_settime
>> 64bit process -- clock_settime -- COBALT_SYSCALL(clock_settime)
>>
> 
> You also need to consider 32-bit kernels, not on x86 anymore (i386 is
> practically dead), but e.g. ARMv7. There we would have a breakage now,
> don't we?
if we still take 32-bit kernel into account, i will try to build one and 
give it a run to see how it goes, and get it back to you.

> 
> Jan
> 



