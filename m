References: <cover.1620233588.git.jan.kiszka@siemens.com>
 <ed990049-2320-aaa1-2ab7-e99895be1c5c@siemens.com>
 <87y2csqr8q.fsf@xenomai.org>
 <29e3091830a483dd2ad141a098baed259a1f0832.camel@siemens.com>
 <ea033a1e-fee1-a9b3-8482-92edf44a7678@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2 0/9] y2038 groundwork and first steps
In-reply-to: <ea033a1e-fee1-a9b3-8482-92edf44a7678@siemens.com>
Date: Fri, 07 May 2021 13:49:37 +0200
Message-ID: <87h7jercfi.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On 06.05.21 09:08, Bezdeka, Florian via Xenomai wrote:
>> On Thu, 2021-05-06 at 09:02 +0200, Philippe Gerum wrote:
>>> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
>>>
>>>> On 05.05.21 18:52, Jan Kiszka via Xenomai wrote:
>>>>> Picking up from Philippe's queue:
>>>>>
>>>>> This patch series prepares the tree for the upcoming y2038 work,
>>>>> converting obsolete/ambiguous time specification types to the proper
>>>>> ones introduced upstream by the v5.x kernel series.
>>>>>
>>>>> In v2, feedback on the first round has been addressed, primarily
>>>>> regarding folding fixing into the patches that need them.
>>>>>
>>>>> In addition, this includes 3 patches from Florian that add
>>>>> sem_timedwait64 system call and a test suite for it.
>>>>>
>>>>
>>>> Seems we have some issue on ARM ("Illegal instruction" in smokey):
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.denx.de%2FXenomai%2Fxenomai-images%2F-%2Fjobs%2F264219&amp;data=04%7C01%7Cflorian.bezdeka%40siemens.com%7C4809653e590745bc77b008d9105dbc19%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637558817063489934%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eH%2FvAfRIX8ORSkqcvjrmd%2BD0s6N%2FcpKD66Ptm0c0pbc%3D&amp;reserved=0
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.denx.de%2FXenomai%2Fxenomai-images%2F-%2Fjobs%2F264225&amp;data=04%7C01%7Cflorian.bezdeka%40siemens.com%7C4809653e590745bc77b008d9105dbc19%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C637558817063489934%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=HWAdg9KpJhevXa97ziRGDwLzyHq5%2Fj1Yv7IBcH3uTsY%3D&amp;reserved=0
>>>
>>> That one may be related to the code directing clock_gettime() either to
>>> the vDSO with Dovetail, or TSC readouts via a memory mapping with the
>>> I-pipe, all in libcobalt.
>> 
>> Thanks for the hint! I will check that and report back.
>
> I was able to find the root cause. It's glibc syscall() vs.
> XENOMAI_SYSCALLx(). I have a fix around that was already tested on some
> qemu targets (arm as well as x86). I will provide it soon.
>
> There is still one open question to me: Why is there a special syscall
> handling (userland) implemented in Xenomai? I did not fully understand
> why we end up with an invalid instruction on arm, but I guess it's
> because of different registers being used.
>
> IOW: syscall() is fine as long as you are calling Linux syscalls, but
> you might run into problems (at least on arm) when trying to call
> Xenomai specific ones.
>

I may know this one, there is an ABI change in recent glibc,
specifically in the glue code for the arm unwinder, which may cause
this. Turning off -fasynchronous-unwind-tables should paper over that
particular issue.

-- 
Philippe.

