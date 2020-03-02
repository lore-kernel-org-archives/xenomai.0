MIME-Version: 1.0
References: <CAFLxGvyr7f8bUxaEVpEwSGYEvX4FrkpGBV6qa2sR3SHq3wi_Yw@mail.gmail.com>
 <CAFLxGvwo_gPu9EbMkcicjJ9tCP228oRXQ2XiCb11YBs11xDFJg@mail.gmail.com>
 <3c8788a1-be5b-c424-b16c-1d1903b9e045@siemens.com>
In-Reply-To: <3c8788a1-be5b-c424-b16c-1d1903b9e045@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 2 Mar 2020 13:34:56 +0100
Message-ID: <CAFLxGvxGmuCPp7ReWWcvrSaLsqs5xupR=Ljzg0T6-QS1M46GSw@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Mon, Mar 2, 2020 at 1:21 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 29.02.20 12:46, Richard Weinberger via Xenomai wrote:
> > On Fri, Feb 28, 2020 at 10:01 PM Richard Weinberger
> > <richard.weinberger@gmail.com> wrote:
> >>
> >> Hi!
> >>
> >> I noticed that running 32bit arm EABI xenomai userspace is currently
> >> not possible
> >> on arm64 kernels.
> >>
> >>  From a quick look I see the following tasks to make it happen:
> >> - syscall gate adaptations for cobalt arm32 syscalls (they are
> >> different from regular arm EABI)
> >> - teach ipipe_root_nr_syscalls() on arm64 about __NR_compat_syscalls
> >> - Don't use XENOMAI_ABI_REV for compat userspace on arm64
> >> - Implement a syscall32-table.h (for COBALT_SYSCALL32emu_DECL() and friends)
> >
> > One more thing: TSC emulation is missing on arm64.
> >
>
> What exactly are you referring to?

I think CONFIG_IPIPE_ARM_KUSER_TSC.

In lib/cobalt/arch/arm/features.c cobalt_check_features() sets a
function pointer:
        __xn_tscinfo.kuser_tsc_get =
                (__xn_rdtsc_t *)(0xffff1004 -
                                ((*(unsigned *)(0xffff0ffc) + 3) << 5));

On arm64 this pointer is invalid.

Anyway, I did already some prototyping and managed to run 32bit
Xenomai applications on
arm64.
As soon I have something to show I'll send patches. :-)

-- 
Thanks,
//richard

