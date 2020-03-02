Subject: Re: 32bit compat mode for arm64
References: <CAFLxGvyr7f8bUxaEVpEwSGYEvX4FrkpGBV6qa2sR3SHq3wi_Yw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <40a67d93-847a-d67f-bbc7-a6494591e97e@siemens.com>
Date: Mon, 2 Mar 2020 13:16:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyr7f8bUxaEVpEwSGYEvX4FrkpGBV6qa2sR3SHq3wi_Yw@mail.gmail.com>
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

On 28.02.20 22:01, Richard Weinberger via Xenomai wrote:
> Hi!
> 
> I noticed that running 32bit arm EABI xenomai userspace is currently
> not possible
> on arm64 kernels.
> 
>  From a quick look I see the following tasks to make it happen:
> - syscall gate adaptations for cobalt arm32 syscalls (they are
> different from regular arm EABI)
> - teach ipipe_root_nr_syscalls() on arm64 about __NR_compat_syscalls
> - Don't use XENOMAI_ABI_REV for compat userspace on arm64
> - Implement a syscall32-table.h (for COBALT_SYSCALL32emu_DECL() and friends)
> 
> Is this something which will be supported sooner or later?
> ...or is there a massive show-stopper I didn't notice so far?
> 

Well, if there is a strong use case, usually proprietary legacy software 
that refuses to be ported to 64-bit, I would not refuse such a contribution.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

