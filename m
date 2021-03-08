Subject: Re: [PATCH 2/5] cobalt/kernel: y2038: convert struct timespec to
 timespec64
References: <20210220151840.409745-1-rpm@xenomai.org>
 <20210220151840.409745-2-rpm@xenomai.org>
 <f369db49a43257fc7e7ae3f800dc1dbaed79f624.camel@siemens.com>
 <878s731csg.fsf@xenomai.org>
 <3867420a5cd0e2fd37a8036865f53a0881aef236.camel@siemens.com>
 <8735xb1bvl.fsf@xenomai.org> <87v9a7z0xh.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <82a42c65-2789-e17d-bfe9-83f0068970fa@siemens.com>
Date: Mon, 8 Mar 2021 13:59:39 +0100
MIME-Version: 1.0
In-Reply-To: <87v9a7z0xh.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong@kylinos.cn" <chensong@kylinos.cn>

On 04.03.21 11:08, Philippe Gerum wrote:
> 
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:
>>
>>> On Thu, 2021-03-04 at 10:35 +0100, Philippe Gerum wrote:
>>>> florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:
>>>>
>>>>> On Sat, 2021-02-20 at 16:18 +0100, Philippe Gerum via Xenomai wrote:
>>>>> [snip]
>>>>>> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
>>>>>> index 05a861dfe..467a9b7dd 100644
>>>>>> --- a/kernel/cobalt/posix/sem.c
>>>>>> +++ b/kernel/cobalt/posix/sem.c
>>>>>> @@ -267,7 +267,7 @@ out:
>>>>>>  	return ret;
>>>>>>  }
>>>>>>  
>>>>>>
>>>>>>
>>>>>>
>>>>>> -static inline int sem_fetch_timeout(struct timespec *ts,
>>>>>> +static inline int sem_fetch_timeout(struct timespec64 *ts,
>>>>>>  				    const void __user *u_ts)
>>>>>
>>>>> Handle the following with care, maybe my understanding of
>>>>> CONFIG_XENO_ARCH_SYS3264 is wrong. See below...
>>>>>
>>>>> My understanding is that this is a breaking change for 32 bit kernels.
>>>>> The broken part is hidden here, but sem_fetch_timeout() now assumes
>>>>> that the user provided timespec64, which is not be the case for 32 bit
>>>>> applications running on a 32 bit kernel.
>>>>>
>>>>
>>>> The user-provided memory is referred to by u_ts, not ts, which receives
>>>> the timestamp fetch_timeout() is supposed to return. The change should
>>>> only affect the return type, not the source one. sys32_fetch_timeout()
>>>> should still do the right thing via sys32_get_timespec().
>>>
>>> Adding the full code:
>>>
>>> static inline int sem_fetch_timeout(struct timespec64 *ts,
>>> 				    const void __user *u_ts)
>>> {
>>> 	return u_ts == NULL ? -EFAULT :
>>> 		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
>>> }
>>>
>>> Copying sizeof(*ts) is to much if the application provided
>>> "__old_time_t" (sizeof(time_t) =4) only. Isn't it? I would expect the
>>> result (in ts) to be garbage. Due to different padding the "sec" field
>>> (in ts) would now contain the nsec value from u_ts as well.
>>>
>>
>> Ah, I was looking at the wrong path (32emu). Yes, this is broken for
>> mere 32bit now (i.e. natively 32bit platform).
> 
> We could simply use cobalt_get_u_timespec() instead of open coding the
> call to cobalt_copy_from_user(). Condvars have this right already,
> mutex, mq and sema4s have their fetch_timeout() helper broken
> indeed. Good spot.
> 

Oops, missed this. Patch is in next (all 5, in fact, and all built
find), but I will revert things back to patch 1 only.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

