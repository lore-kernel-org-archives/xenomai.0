MIME-Version: 1.0
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
 <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
 <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
In-Reply-To: <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 7 Jul 2020 13:48:02 -0400
Message-ID: <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <xenomai.list@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Tue, Jul 7, 2020 at 12:30 PM Robert Berger <xenomai.list@gmail.com> wrote:
>
> Hi Greg,
>
> I digged a bit deeper and it looks like although I tell Yocto/BitBake to
> use 4.19.x kernel headers it auto generates this:
>
> /unix/sysv/linux/arm/arch-syscall.h:#define __NR_clock_nanosleep_time64 407

I tested on the none cip branch 4.19.128 ipipe-arm (since i had that
on hand) and it passes with no issue.  I'll test again on the latest
cip 4.19.y ipipe-arm branch later tonight but I don't expect to get
the above error.  It looks like this syscall exists in the 5.4 kernel
but not the 4.19 one (as you mentioned before).  I haven't had a
chance to look into this too deeply but from the little bit I've
looked at, it seems that in the newer kernels there's been some
changes around clock_nanosleep. Yocto seems to be expecting that the
kernel you are using is going to be 5.4 and is generating headers
based on that.  So apps think that 407 is a valid system call but our
4.19 kernel doesn't know what system call that is.  I don't have a lot
of yocto experience but you could try moving to an older yocto branch
that supports 4.19 kernels and see what happens.

-Greg

>
> Will try something more drastic to see what happens.
>
> Regards,
>
> Robert

