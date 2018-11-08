Subject: Re: [PATCH] cobalt/kernel: Simplify mayday processing
References: <3e868e4f-7bd5-2874-d72b-fc2449ef4b65@siemens.com>
 <111becaa-9e0f-f8ad-4802-62f51379fc07@xenomai.org>
 <efcd107e-d48d-6dac-96e0-890203c072ba@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5c1fae9d-3098-1f5b-bc51-fa7f9a798f1e@xenomai.org>
Date: Thu, 8 Nov 2018 14:24:18 +0100
MIME-Version: 1.0
In-Reply-To: <efcd107e-d48d-6dac-96e0-890203c072ba@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>, Dmitriy Cherkasov <dmitriy@oss-tech.org>

On 11/8/18 2:14 PM, Jan Kiszka wrote:
> On 08.11.18 14:05, Philippe Gerum wrote:
>> On 11/5/18 1:20 PM, Jan Kiszka wrote:
>>> The mayday mechanism exists in order to kick a xenomai userspace task
>>> into secondary mode while it is running userspace code. For that, we ask
>>> I-pipe to call us back when the task was interrupted and is about to
>>> return to userspace.
>>>
>>> So far we defer the relaxation from that callback via a VDSO-like
>>> mechanism that triggers a special syscall to the return path of that
>>> very same syscall. However, that is not desirable because it is a
>>> complex, arch-specific mechanism that can easily break and,
>>> specifically, that destroys the backtrace of ptraced tasks.
>>>
>>> Fortunately, we can fulfill the needs of mayday also by relaxing
>>> the task directly from the mayday callback. Tested successfully on
>>> x86-64 and ARM.
>>
>> ARM-wise, this change requires ipipe-core-4.14.71-arm-3 or later to work
>> properly. This method would cause an interrupt state breakage with any
>> older ARM patch.
> 
> That would be a change compared to my past ARM experiments (4.x, if not
> 3.x based). Can you point me to the problem in more details?
> 

Calling	__ipipe_notify_trap(IPIPE_TRAP_MAYDAY, regs) may result in
re-enabling IRQs unexpectedly for the caller, due to the callee
relaxing. AFAIR, a core debug level assertion should trip when that happens.

-- 
Philippe.

