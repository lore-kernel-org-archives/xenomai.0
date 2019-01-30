Subject: Re: bad syscall <0x15b> on x86_64
References: <CAFLxGvwZ6=4cKsDF68MA2Whv-HVwOVmcFSb0UtupbDyshUYM6w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <686b3ecd-e06d-afba-20d9-e6b54fdb0f28@siemens.com>
Date: Wed, 30 Jan 2019 08:34:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwZ6=4cKsDF68MA2Whv-HVwOVmcFSb0UtupbDyshUYM6w@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 29.01.19 23:14, Richard Weinberger via Xenomai wrote:
> Hi!
> 
> When running a ia32 application on x86_64 I get bad syscall errors.
> This happens with ipipe-core-4.14.89-x86-2.patch and xenomai 3.0.8.
> 
> The problem seems to be that both ipipe_handle_syscall() and
> handle_head_syscall()
> check for syscall-nr being >= NR_syscalls.
> On ia32 the syscall table is larger and therefore the check is wrong.

Hmm, the kernel's tracer also only checks for NR_syscalls. Strange.

> 
> So the code has to check the TS_COMPAT flag and then compare either to
> NR_syscalls or IA32_NR_syscalls.
> I gave this already a short try and things seem to work better.
> 

There are more places where we check for NR_syscalls, some in ipipe itself. 
Problem is that IA32_NR_syscalls is, well, IA32-specific while we are testing in 
generic code. We need to abstract that first, in ipipe. Then we can fix also 
Xenomai.

Philippe, any better idea?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

