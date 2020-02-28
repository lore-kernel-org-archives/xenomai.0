MIME-Version: 1.0
References: <CAFLxGvyr7f8bUxaEVpEwSGYEvX4FrkpGBV6qa2sR3SHq3wi_Yw@mail.gmail.com>
 <20200228221131.hvtpjrjm42ocbxjo@csclub.uwaterloo.ca>
In-Reply-To: <20200228221131.hvtpjrjm42ocbxjo@csclub.uwaterloo.ca>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 28 Feb 2020 23:16:41 +0100
Message-ID: <CAFLxGvyzQ4FdHx1_YyeYKTfj76KC487BvDkGPfu6wVs3oqhVLA@mail.gmail.com>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Fri, Feb 28, 2020 at 11:11 PM Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
>
> On Fri, Feb 28, 2020 at 10:01:04PM +0100, Richard Weinberger via Xenomai wrote:
> > I noticed that running 32bit arm EABI xenomai userspace is currently
> > not possible
> > on arm64 kernels.
> >
> > From a quick look I see the following tasks to make it happen:
> > - syscall gate adaptations for cobalt arm32 syscalls (they are
> > different from regular arm EABI)
> > - teach ipipe_root_nr_syscalls() on arm64 about __NR_compat_syscalls
> > - Don't use XENOMAI_ABI_REV for compat userspace on arm64
> > - Implement a syscall32-table.h (for COBALT_SYSCALL32emu_DECL() and friends)
> >
> > Is this something which will be supported sooner or later?
> > ...or is there a massive show-stopper I didn't notice so far?
>
> Even x86 doesn't allow 32 bit userspace xenomai to run on a 64 bit kernel.
> I suspect the use case is just so insignificant that noone wants to
> bother working on such support.

Huh?
I currently do so...
It was broken but got fixed.

-- 
Thanks,
//richard

