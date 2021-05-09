References: <cover.1620233588.git.jan.kiszka@siemens.com>
 <ed990049-2320-aaa1-2ab7-e99895be1c5c@siemens.com>
 <87y2csqr8q.fsf@xenomai.org>
 <29e3091830a483dd2ad141a098baed259a1f0832.camel@siemens.com>
 <ea033a1e-fee1-a9b3-8482-92edf44a7678@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2 0/9] y2038 groundwork and first steps
In-reply-to: <ea033a1e-fee1-a9b3-8482-92edf44a7678@siemens.com>
Date: Sun, 09 May 2021 11:37:18 +0200
Message-ID: <875yzsqmcx.fsf@xenomai.org>
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

Ok, forget about the other options I mentioned which - although they
could produce SIGILL the same way - do not apply in this case (I only
figured out lately that you were specifically talking about the new
y2038 smokey test you just introduced). The actual reason for SIGILL
being received in that case is that we indeed have a specific calling
convention for Xenomai, esp. on ARM.

Basically, we use a syscall multiplexer, loading a special value into
register r7 which normally contains the syscall number; this is the job
of the XENOMAI_SYSCALLx() macros. This special value introduces a range
of 'foreign' syscalls (e.g. to cover Xenomai syscalls). When seen by the
kernel early on in the syscall path, it feeds the request to the
real-time core instead of passing it to the regular kernel handler.

By using syscall(__xn_syscode(foo), ...) directly, the multiplexer tag
is not present in r7, the latter contains the syscall number which is
above NR_syscalls, as it was encoded by the __xn_syscode() macro
(i.e. nr | __COBALT_SYSCALL_BIT which is 0x10000000). Because the tag is
not seen, Dovetail does not intercept that syscall, but leaves it
flowing down to the regular handler, which in turn notices that r7 is
not a valid regular syscall either.

On many/most architectures, the process would stop there, leading to
ENOSYS. But ARM has a few arch-specific internal syscalls above
__ARM_NR_BASE (EABI convention), and because any value produced by
__xn_syscode() may qualify as such, the secondary handler for ARM
syscalls runs for it. However, __xn_syscode(sc_cobalt_sem_timedwait64)
does not match any ARM-specific syscall, so the kernel eventually raises
SIGILL for the caller, instead of gracefully returning ENOSYS (see
arch/arm/kernel/traps.c, bad_syscall).

So bottom_line is: if you feed a Xenomai syscall code to the kernel, you
have to use XENOMAI_SYSCALLx().

-- 
Philippe.

