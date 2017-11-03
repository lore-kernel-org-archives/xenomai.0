MIME-Version: 1.0
In-Reply-To: <20171103212644.lkanrbyc5ii3qjq5@csclub.uwaterloo.ca>
References: <CAOocw5vJ_nz41_vqqV0e=+BgE+6u-6hYhXVpCFPuzqCh4QPp9Q@mail.gmail.com>
 <20171103175950.lixjbhqp4op4jm6j@csclub.uwaterloo.ca>
 <CAOocw5uQAOwo-3GMWoPCh8jn8rdj+Z+xhN2rC+gFGBFJnwe6YA@mail.gmail.com>
 <20171103182307.6qdafqdlfge2cmmp@csclub.uwaterloo.ca>
 <CAOocw5v+j-+=EDpo8Qx+xjRDb-DTKkMhfkMAqh9DQ-fEGfhK3w@mail.gmail.com>
 <20171103212644.lkanrbyc5ii3qjq5@csclub.uwaterloo.ca>
From: Danrae Pray <danrae.pray@metecs.com>
Date: Fri, 3 Nov 2017 18:21:15 -0500
Message-ID: <CAOocw5vNn74a9gKFgQ=-xaVW0CQeE7bGj-FEDEmnMzrON7Vvdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Running COBALT on Ubuntu 14/16
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

Ah ok - I understand now.  Yeah, this is my first time ever building the
linux kernel (or Xenomai) from source, so I was struggling a bit w/ what
was Xenomai specific & what was linux kernel build-related... but after
speaking w/ you guys here, it's all making sense now (:

I found some docs on installing a linux kernel & updating the boot loader,
so I think I'm good now.  Thanks so much for all the help with this!

Cheers,
Danrae

On Fri, Nov 3, 2017 at 4:26 PM, Lennart Sorensen <
lsorense@csclub.uwaterloo.ca> wrote:

> On Fri, Nov 03, 2017 at 01:45:02PM -0500, Danrae Pray wrote:
> > Oh OK I'm starting to understand now.  Thanks so much for clearing that
> up!
> >
> > Sorry for being dense - but I just want to make sure I understand fully -
> > the end result of the COBALT kernel build process (following instructions
> > here:
> > https://xenomai.org//installing-xenomai-3-x/#
> Configuring_and_compiling_the_Cobalt_kernel)
> > is that the original distro kernel (Ubuntu kernel in my case) is actually
> > replaced by the vanilla kernel?
> >
> > I see that they say something to that effect here (mention of replacing
> the
> > distro kernel with a vanilla kernel):
> > https://xenomai.org/2014/06/running-xenomai-on-virtualbox/
> #Host_Compiling_kernel_and_Xenomai
> >
> > If this is the case, what step during build / installation is the distro
> > kernel image actually replaced?  The last step I see in the build process
> > for x86 arch is "make bzImage modules"... Does this step actually swap
> out
> > the kernel image?  Is a reboot necessary then to load the new kernel?  I
> > don't see a reboot mentioned in the docs.
>
> It's hard for people to write documentation, because the person writing
> it has done the thing being documented before.  Hence steps get left out
> that are considered totally obvious to someone that has already done it.
> The only way one could use a new kernel that was built, is to install
> it and reboot to it.
>
> That particular make step does not replace the kernel or install it.
> It just compiles it.  Placing it in the right place, updating boot loader,
> etc, is not covered by that.
>
> --
> Len Sorensen
>
