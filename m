Subject: Re: [PATCH 2/5] cobalt/kernel: y2038: convert struct timespec to
 timespec64
References: <20210220151840.409745-1-rpm@xenomai.org>
 <20210220151840.409745-2-rpm@xenomai.org> <6031C2CF.3050202@kylinos.cn>
 <87h7m54f1i.fsf@xenomai.org>
 <612b2ca09cb05c5cf641b35359205b905caf2a5c.camel@siemens.com>
 <87v9ak31w8.fsf@xenomai.org>
 <03f66bd4-904f-7ed9-c93b-626e1f87dfd5@siemens.com>
 <877dmhkamu.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7a96cbeb-8965-d73a-aa88-e13e2b6ae2fb@siemens.com>
Date: Mon, 8 Mar 2021 15:03:49 +0100
MIME-Version: 1.0
In-Reply-To: <877dmhkamu.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08.03.21 15:01, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 22.02.21 10:08, Philippe Gerum via Xenomai wrote:
>>>
>>> florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:
>>>
>>>> On Sun, 2021-02-21 at 16:27 +0100, Philippe Gerum via Xenomai wrote:
>>>>> chensong via Xenomai <xenomai@xenomai.org> writes:
>>>>>
>>>>>>> +/*
>>>>>>> + * Our representation of time at the kernel<->user interface boundary
>>>>>>> + * at the moment, until we have fully transitioned to a y2038-safe
>>>>>>> + * implementation in libcobalt.
>>>>>>> + */
>>>>>>> +struct __user_old_timespec {
>>>>>>> +	long  tv_sec;
>>>>>>> +	long  tv_nsec;
>>>>>>> +};
>>>>>>
>>>>>> why not use old_timespec32, which is timespec32 representation defined
>>>>>> in include/linux/time32?
>>>>>>
>>>>>
>>>>> Using old_timespec32 in this context would mean that any time value
>>>>> received from userland by the core should be restricted to 32bit time_t,
>>>>> which is not what we want, at least for 64bit platforms:
>>>>>
>>>>> include/vdso/time32.h:
>>>>>
>>>>> struct old_timespec32 {
>>>>> 	old_time32_t	tv_sec;
>>>>> 	s32		tv_nsec;
>>>>> };
>>>>>
>>>>> __user_old_timespec conveys the notion that we are generically talking
>>>>> about "the old timespec type which has a y2038 problem"; this is not
>>>>> specifically about the legacy timespec type on 32bit machines.
>>>>>
>>>>> Since v5.4-rc6, we do have __kernel_old_timespec though, which could
>>>>> have been used instead of __user_old_timespec:
>>>>
>>>> According to my information (based on
>>>> https://elixir.bootlin.com/linux/v5.5-rc1/A/ident/__kernel_old_timespec
>>>> ) this is available since v5.5-rc1.
>>>>
>>>
>>> This disagrees with the git history then:
>>>
>>> commit 94c467ddb273dc9a6a4fb09aef392c119b151edb
>>> Author: Arnd Bergmann <arnd@arndb.de>
>>>
>>>     y2038: add __kernel_old_timespec and __kernel_old_time_t
>>>
>>> $ git describe 94c467ddb273dc9a6a4fb09aef392c119b151edb
>>> v5.4-rc6-2-g94c467ddb273dc9
>>>
>>
>> This tells you *after* which tag it was applied, not when it was in and
>> tagged there.
> 
> That's right. My mistake.
> 
>> That was indeed v5.5-rc1 (seen via gitk, still looking for
>> a handy git command line to explore that).
>>
> 
> $ git describe --contains
> 

Ah, that is worth to remember!

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

