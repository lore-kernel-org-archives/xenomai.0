Subject: Re: bad syscall <0x15b> on x86_64
References: <CAFLxGvwZ6=4cKsDF68MA2Whv-HVwOVmcFSb0UtupbDyshUYM6w@mail.gmail.com>
 <686b3ecd-e06d-afba-20d9-e6b54fdb0f28@siemens.com>
 <CAFLxGvzfh_1cRPJwZ8QoxQ6Lg2dq5XHEczDmgUC+hDJkjy3KdA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6a29ef27-bb41-e706-ca7f-6be3b1a34e8d@siemens.com>
Date: Wed, 30 Jan 2019 09:59:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzfh_1cRPJwZ8QoxQ6Lg2dq5XHEczDmgUC+hDJkjy3KdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 30.01.19 09:29, Richard Weinberger wrote:
> On Wed, Jan 30, 2019 at 8:34 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 29.01.19 23:14, Richard Weinberger via Xenomai wrote:
>>> Hi!
>>>
>>> When running a ia32 application on x86_64 I get bad syscall errors.
>>> This happens with ipipe-core-4.14.89-x86-2.patch and xenomai 3.0.8.
>>>
>>> The problem seems to be that both ipipe_handle_syscall() and
>>> handle_head_syscall()
>>> check for syscall-nr being >= NR_syscalls.
>>> On ia32 the syscall table is larger and therefore the check is wrong.
>>
>> Hmm, the kernel's tracer also only checks for NR_syscalls. Strange.
> 
> Well, the kernel tracer is in this matter a little lazy and sets
> ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
> for x86.
> 

Oh, wow...

Well, we can't be that lazy.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

