Subject: Re: RTDM open, open_rt, and open_nrt
References: <1498070335.5810731.1568637405044.JavaMail.zimbra@wolfram.com>
 <606820185.5820958.1568637688860.JavaMail.zimbra@wolfram.com>
 <11d341ef-47a4-0dd6-62f7-7fc30cd1796e@siemens.com>
 <1295125104.5915666.1568647990243.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <83a935d5-70ed-2802-a1b1-452c3c23eb8d@siemens.com>
Date: Mon, 16 Sep 2019 19:01:26 +0200
MIME-Version: 1.0
In-Reply-To: <1295125104.5915666.1568647990243.JavaMail.zimbra@wolfram.com>
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
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

On 16.09.19 17:33, Per Oberg wrote:
> 
> ----- Den 16 sep 2019, på kl 16:59, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>> On 16.09.19 14:41, Per Oberg via Xenomai wrote:
>>> ----- Den 16 sep 2019, på kl 14:36, Per Öberg pero@wolfram.com skrev:
> 
>>>> ----- Den 16 sep 2019, på kl 11:34, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>>>>> On 16.09.19 09:32, Per Oberg via Xenomai wrote:
>>>>>> Hello list
> 
>>>>>> I am trying to understand how rtdm works, and possibly why out of a historical
>>>>>> context. Perhaps there is a good place to read up on this stuff, then please
>>>>>> let me know.
> 
>>>>>> It seems like in the rtdm-api there is only open, but no open_rt or open_nrt.
>>>>>> More specifically we have:
>>>>>> - read_rt / read_nrt
>>>>>> - recvmsg_rt / recvmsg_nrt
>>>>>> - ioctl_rt / ioctl_nrt
>>>>>> - .. etc.
> 
>>>>>> However, when studying an old xenomai2->3 ported driver it seems like there used
>>>>>> to be open_rt and open_nrt. The problem I was having before (see my background
>>>>>> comment below) was because the open had been mapped to the old open_nrt code,
>>>>>> which in turned used a rt-lock, thus a mix of the two. When switching to a
>>>>>> regular mutex it "worked", as in it didn't complain.
> 
>>>>>> In a short discussion Jan Kiszka gave me the impression that open could possibly
>>>>>> end up being rt or nrt depending on situation.
> 
>>>>>> PÖ: I'm guessing that open is always non-rt and therefore a rtdm_lock should be
>>>>>> used? ...
> 
>>>>>> JK: This depends. If the open code needs to synchronize only with other non-RT
>>>>>> JK: paths, normal Linux locks are fine. If there is the need to sync with the
>>>>>> JK: interrupt handler or some of the _rt callbacks, rtdm_lock & Co. is needed.
> 
>>>>>> So, how does this work? And why was (if it was) open_nrt and open_rt replaced
>>>>>> with a common open?
> 
>>>>> The original RTDM design was foreseeing the use case of creating and destroying
>>>>> resources like file descriptors for devices in RT context. That idea was dropped
>>>>> as also the trend for the core was clearly making this less realistic.
>>>>> Therefore, we removed open/socket_rt from Xenomai 3.
> 
>>>>> If you have a driver that exploited open_rt, you need to remove all rt-sleeping
>>>>> operations from its open function. If rtdm_lock is an appropriate alternative
>>>>> depends on the driver locking structure and the code run under the lock.
>>>>> rtdm_lock_get makes the lock holder unpreemptible. So, if rtdm_mutex was chosen
>>>>> because of lengthy code under the lock, that would not be a good alternative.
>>>>> Then we would have to discuss what exactly is run there, and why.
> 
>>>> Ok, can I read up on this somewhere? I found [1], is that still valid in this
>>>> context? ( Oh, and can we expect a third edition perhaps ? =) )
> 
>>>> [1] Building Embedded Linux Systems: Concepts, Techniques, Tricks, and Traps 2nd
>>>> Edition, Kindle Edition
> 
>> Basic locking principles should be covered there, not sure if it had a
>> Xenomai/RTDM section. If so, check if it was written/updated after 2015.
> 
> It has, but it's written in 2008. With references for a paper you wrote. ( "The Real-Time Driver Model and First Applications" )
> 
>>>>>> Background
>>>>>> ----------------
>>>>>> I recently wrote about a driver which warned about "drvlib.c:1349
>>>>>> rtdm_mutex_timedlock". I got good answers which led me to some more general
>>>>>> questions, but instead of continuing in the old tread I thought it better to
>>>>>> start a new one since it's not about the initial problem. The driver in case is
>>>>>> the Peak Linux Driver for their CAN hardware, see [1]
> 
>>>>>> [1] https://www.peak-system.com/fileadmin/media/linux/index.htm
> 
>>>>> Did you inform them about their problem already? Maybe they are willing to fix
>>>>> it. We can't, it's not upstream code.
> 
>>>> No, I haven't, but I will. The reason I haven't yet is because I was under the
>>>> impression that this didn't happen to them. I'm trying to compile everything
>>>> (driver, lib, and application) in a Yocto based SDK setup and it seems like
>>>> compilation flags and environment variables are getting squashed in interesting
>>>> ways. My reasoning so far was that I got this wrong somehow.
> 
>>> Forget that, I did actually ask them and they answered in a manner that
>>> suggested that I was doing something wrong (wrong compilation flags or user
>>> privileges ). I never got rid of the warning though and it fell into the dark
>>> corners of the backlog.
> 
> 
>> If they argued about "compilation flags" when a kernel bug was thrown, they may
>> not have gotten the point yet. These flags reveal architectural issues of the
>> implementation. Of course they disappear when you turn debugging off. But then
>> the get replaced by deadlock or real crashed later.
> 
> I think I mislead you somehow. I'm not saying that this is the argument they made, and while talking to you I revisited the issue and brought it up with them again. They have been friendly so far afaik so perhaps it will be sorted.
> 
> I will try to get my point/question more clear. What I was trying to explain is that they have multiple drivers in the same driver code base covering Xenomai2 +3 , RTAI, and regular Linux (and perhaps more).
> 
> I am therefore trying to understand
> 
> 1) whether the driver is fundamentally broken
> 

At least /wrt pcan_mutex - just quickly scanned their code. And that bug is 
independent of "XENOMAI3". You should report that back.

I'm also happy to discuss with their engineers possible architectures when using 
RTDM, here in the community. That is a value when working upstream: support on 
generic topics. But also the chance of providing feedback when something is 
unclear or could be improved in upstream. And the value of upstreaming is 
getting full reviews, thus higher quality. And possibly fixes/updates in the future.

> 2) whether I somehow got a mix of the Xenomai3 and regular Linux driver code by screwing up the build process. I agree that if this can happen there are stuff that can be improved in the build process, but cross-compiling stuff is a real mess...
> 
> 3) whether there may be other ways to get this result without there being an "actual" issue with the driver. Now, with my limited knowledge, I could think of ways where the driver implemented one "correct" way of opening the device, but failed detecting if the user somehow opened it the wrong way. I agree that for this case the driver is flawed in not telling the user what is actually wrong and just go along with what is at hand.
> 
> Given your reactions it seems like 3) is out of the question, which leaves 1) and 2).
> 
> You also, implicitly, say that Xenomai cannot help with fixing their driver because it's not upstream which I accept. The driver is open sourced, so parts of it could eventually be adopted into xenomai (perhaps by me sometime, who knows). I am, however, not trying to argue about that.
> 
> I tried steering the discussion away from the particular issues in this driver because I to believe that they are not your / Xenomai communitys problem. I simply want to understand how things are supposed to fit together so that I can eventually write my own drivers for other stuff in the future.
> 

The locking constraints we are discussing in this concrete example are 
documented in Xenomai manual. So if you look up rtdm_mutex_lock, e.g.

https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm__sync__mutex.html#ga67c8f85c844df1aeed806e343a1b6437

you see the tag "primary-only, might-switch". That translates to "no-no for 
non-RT context" and "no-no for interrupts". If you look at rtdm_lock_get_irqsave

https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm__sync__spinlock.html#ga24e0b97e35b976fbabd52f4213dc222a

it states "unrestricted". It also states "disable preemption", and that implied 
"cannot sleep on something to happen" and "should better not take a long time". 
While the primitives used here are RTDM-specific, the concepts are generic and 
can be found in any modern OS, including Linux.

BTW, execution constraints also exists for other RTDM services. E.g., you should 
not try to request an IRQ from an RT context and only do that in _nrt or even 
driver init.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

