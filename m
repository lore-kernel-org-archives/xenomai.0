Message-ID: <53108F8C.20000@xenomai.org>
Date: Fri, 28 Feb 2014 14:30:52 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKc2HpZ+zHoF22BjPKj_x0V+oOX9ZcLpU-N1jNv1pjq6sQhsqQ@mail.gmail.com>	<52F7B36C.5010905@xenomai.org>	<CAKc2HpaFwremV-pUgYez_O5gAvg_f=NeMihnFMZ0vgf3GJWG8Q@mail.gmail.com>
 <CAKc2Hpaus4Vryt5LdDexzRTyYr16Ux-bbVz2c6WoWdgX6j7D5Q@mail.gmail.com>
In-Reply-To: <CAKc2Hpaus4Vryt5LdDexzRTyYr16Ux-bbVz2c6WoWdgX6j7D5Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-forge pSOS t_start followed by t_suspend does
 not work
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>
Cc: xenomai@xenomai.org

On 02/26/2014 09:54 AM, Kim De Mey wrote:
> 2014-02-10 12:23 GMT+01:00 Kim De Mey <kim.demey@gmail.com>:
>> 2014-02-09 17:57 GMT+01:00 Philippe Gerum <rpm@xenomai.org>:
>>> On 02/06/2014 02:36 PM, Kim De Mey wrote:
>>>>
>>>> Hi,
>>>>
>>>> I believe there is a problem in Xenomai-forge when doing a pSOS
>>>> t_suspend() call right after a t_start() call.
>>>> It looks like the task does not get suspended in some cases. The
>>>> return value of t_suspend() is 0 however.
>>>>
>>>> I suspect that this happens when the threadobj_prologue() is not
>>>> finished yet at the moment that the notifier_sighandler() is called.
>>>> In this case it could be that the notifier_init() did not run yet. If
>>>> this is the case, then the notifier_sighandler() will not do any
>>>> notifier callback and thus the task will not be suspended. Additional
>>>> t_suspend() calls will not work as the "notified" flag has been set
>>>> already.
>>>> Is this possible?
>>>>
>>>
>>> Unfortunately, yes.
>>>
>>> This is a general issue in the current implementation, as any child thread
>>> created by the emulation sub-system might not have fully registered before
>>> the parent refers to it due to priority/wait state issues.
>>>
>>> We definitely need stronger handshaking there, could you please check again
>>> with this changes in?
>>> http://git.xenomai.org/xenomai-forge.git/commit/?h=next&id=a48b8f640cad510a1101e380cc54ef2bf29afcd6
>>>
>>> TIA,
>>>
>>
>> I tested the new revision and the problems no longer occur. So it looks good!
>>
>> Many thanks for fixing this so quickly.
>>
>
> Hi Philippe,
>
> I'm afraid the new handshaking mechanism introduced to fix the
> problems I was having created an actually worse problem.
>
> If now a parent task with high priority creates a child task with low
> priority while there is another task with medium priority creating a
> high load on the CPU then the parent task gets stuck in the creation
> of the child. This while the parent task has a higher priority than
> the task creating the load.
>
> I believe it is due to the fact that the parent task now waits for a
> sem_post of the child, which in this case has a too low priority to
> get this done.
>
> Should the child priority be temporary increased to the one of the
> parent during the creation or would that be a bad idea?
>

I don't see any other option for preventing this priority inversion 
anyway, since the child prologue is logically part of the parent context 
actually. IOW, the child has to fully inherit the scheduling parameters 
of the parent until its prologue is over. Ok, will do this.

-- 
Philippe.

