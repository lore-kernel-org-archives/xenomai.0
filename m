MIME-Version: 1.0
References: <CAFLxGvyr7f8bUxaEVpEwSGYEvX4FrkpGBV6qa2sR3SHq3wi_Yw@mail.gmail.com>
In-Reply-To: <CAFLxGvyr7f8bUxaEVpEwSGYEvX4FrkpGBV6qa2sR3SHq3wi_Yw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 29 Feb 2020 12:46:25 +0100
Message-ID: <CAFLxGvwo_gPu9EbMkcicjJ9tCP228oRXQ2XiCb11YBs11xDFJg@mail.gmail.com>
Subject: Re: 32bit compat mode for arm64
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Fri, Feb 28, 2020 at 10:01 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> Hi!
>
> I noticed that running 32bit arm EABI xenomai userspace is currently
> not possible
> on arm64 kernels.
>
> From a quick look I see the following tasks to make it happen:
> - syscall gate adaptations for cobalt arm32 syscalls (they are
> different from regular arm EABI)
> - teach ipipe_root_nr_syscalls() on arm64 about __NR_compat_syscalls
> - Don't use XENOMAI_ABI_REV for compat userspace on arm64
> - Implement a syscall32-table.h (for COBALT_SYSCALL32emu_DECL() and friends)

One more thing: TSC emulation is missing on arm64.

-- 
Thanks,
//richard

