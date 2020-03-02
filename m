Subject: Re: 32bit compat mode for arm64
References: <CAFLxGvyr7f8bUxaEVpEwSGYEvX4FrkpGBV6qa2sR3SHq3wi_Yw@mail.gmail.com>
 <CAFLxGvwo_gPu9EbMkcicjJ9tCP228oRXQ2XiCb11YBs11xDFJg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3c8788a1-be5b-c424-b16c-1d1903b9e045@siemens.com>
Date: Mon, 2 Mar 2020 13:21:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwo_gPu9EbMkcicjJ9tCP228oRXQ2XiCb11YBs11xDFJg@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org

On 29.02.20 12:46, Richard Weinberger via Xenomai wrote:
> On Fri, Feb 28, 2020 at 10:01 PM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>>
>> Hi!
>>
>> I noticed that running 32bit arm EABI xenomai userspace is currently
>> not possible
>> on arm64 kernels.
>>
>>  From a quick look I see the following tasks to make it happen:
>> - syscall gate adaptations for cobalt arm32 syscalls (they are
>> different from regular arm EABI)
>> - teach ipipe_root_nr_syscalls() on arm64 about __NR_compat_syscalls
>> - Don't use XENOMAI_ABI_REV for compat userspace on arm64
>> - Implement a syscall32-table.h (for COBALT_SYSCALL32emu_DECL() and friends)
> 
> One more thing: TSC emulation is missing on arm64.
> 

What exactly are you referring to?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

