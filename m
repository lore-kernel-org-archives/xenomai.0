MIME-Version: 1.0
In-Reply-To: <20171103175950.lixjbhqp4op4jm6j@csclub.uwaterloo.ca>
References: <CAOocw5vJ_nz41_vqqV0e=+BgE+6u-6hYhXVpCFPuzqCh4QPp9Q@mail.gmail.com>
 <20171103175950.lixjbhqp4op4jm6j@csclub.uwaterloo.ca>
From: Danrae Pray <danrae.pray@metecs.com>
Date: Fri, 3 Nov 2017 13:16:38 -0500
Message-ID: <CAOocw5uQAOwo-3GMWoPCh8jn8rdj+Z+xhN2rC+gFGBFJnwe6YA@mail.gmail.com>
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

Ok great - my followup question then is, if the COBALT kernel is itself a
modified linux kernel and it's the COBALT kernel that's patched with ipipe
(no patch is applied to the host kernel), how do POSIX API calls in
user-space code get mapped to the appropriate system call in the COBALT
kernel instead of the host linux kernel (in my case Ubuntu distro kernel)?
Does this magic happen at compile-time for the xenomai applications?



On Fri, Nov 3, 2017 at 12:59 PM, Lennart Sorensen <
lsorense@csclub.uwaterloo.ca> wrote:

> On Fri, Nov 03, 2017 at 12:24:36PM -0500, Danrae Pray wrote:
> > I am trying to understand how the COBALT kernel is designed and how it
> can
> > be installed side-by-side various linux distro kernels (Gentoo, Ubuntu,
> > etc).
> >
> > During the COBALT kernel build process on Ubuntu, for example, we
> actually
> > pull a kernel version (based on your Ubuntu version) and build it:
> >
> > https://stackoverflow.com/questions/41949678/installation-steps-for-
> xenomai-3-on-ubuntu-16-04
> > https://xenomai.org//installing-xenomai-3-x/#
> Configuring_and_compiling_the_Cobalt_kernel
> >
> > So, I guess my questions are:
> >
> > 1) At the end of the COBALT build / installation procedure as well as
> > installing the Xenomai libs/tools, can I actually use Xenomai in the
> > dual-kernel config on Ubuntu on my desktop PC for testing application
> > logic?  i.e. I don't need to actually boot my machine using the newly
> built
> > image or something...
>
> You have to be running that kernel.
>
> > 2) Why are we building a linux kernel during the COBALT build process?
> Is
> > COBALT actually a modified linux kernel itself?
>
> Yes it is.  The kernel is patched with ipipe and xenomai extensions to
> provide the required features.
>
> --
> Len Sorensen
>
