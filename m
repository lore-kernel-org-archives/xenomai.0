MIME-Version: 1.0
In-Reply-To: <20171103182307.6qdafqdlfge2cmmp@csclub.uwaterloo.ca>
References: <CAOocw5vJ_nz41_vqqV0e=+BgE+6u-6hYhXVpCFPuzqCh4QPp9Q@mail.gmail.com>
 <20171103175950.lixjbhqp4op4jm6j@csclub.uwaterloo.ca>
 <CAOocw5uQAOwo-3GMWoPCh8jn8rdj+Z+xhN2rC+gFGBFJnwe6YA@mail.gmail.com>
 <20171103182307.6qdafqdlfge2cmmp@csclub.uwaterloo.ca>
From: Danrae Pray <danrae.pray@metecs.com>
Date: Fri, 3 Nov 2017 13:45:02 -0500
Message-ID: <CAOocw5v+j-+=EDpo8Qx+xjRDb-DTKkMhfkMAqh9DQ-fEGfhK3w@mail.gmail.com>
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

Oh OK I'm starting to understand now.  Thanks so much for clearing that up!

Sorry for being dense - but I just want to make sure I understand fully -
the end result of the COBALT kernel build process (following instructions
here:
https://xenomai.org//installing-xenomai-3-x/#Configuring_and_compiling_the_Cobalt_kernel)
is that the original distro kernel (Ubuntu kernel in my case) is actually
replaced by the vanilla kernel?

I see that they say something to that effect here (mention of replacing the
distro kernel with a vanilla kernel):
https://xenomai.org/2014/06/running-xenomai-on-virtualbox/#Host_Compiling_kernel_and_Xenomai

If this is the case, what step during build / installation is the distro
kernel image actually replaced?  The last step I see in the build process
for x86 arch is "make bzImage modules"... Does this step actually swap out
the kernel image?  Is a reboot necessary then to load the new kernel?  I
don't see a reboot mentioned in the docs.

On Fri, Nov 3, 2017 at 1:23 PM, Lennart Sorensen <
lsorense@csclub.uwaterloo.ca> wrote:

> On Fri, Nov 03, 2017 at 01:16:38PM -0500, Danrae Pray wrote:
> > Ok great - my followup question then is, if the COBALT kernel is itself a
> > modified linux kernel and it's the COBALT kernel that's patched with
> ipipe
> > (no patch is applied to the host kernel), how do POSIX API calls in
> > user-space code get mapped to the appropriate system call in the COBALT
> > kernel instead of the host linux kernel (in my case Ubuntu distro
> kernel)?
> > Does this magic happen at compile-time for the xenomai applications?
>
> When using xenomai, you are not in any way using your distribution kernel.
> You could uninstall it and have no problem.
>
> Xenomai in dual kernel mode (cobalt) requires running a kernel that is
> patched with xenomai/ipipe support.  That is a linux kernel with extra
> features added.  The dual doesn't mean it is running your distribution
> kernel and a cobalt kernel at the same time.  It means you are running a
> kernel that supports running normal linux applications at the same time
> as it can run real time domain applications (using different process
> scheduling and system call interfaces).
>
> In theory, someone could try to convince the main linux kernel to accept
> the ipipe and xenomai patches to get mainlined and always included,
> but I don't think anyone is trying to do that at this time.  If that ever
> happened (no idea if it would have a chance of ever being accepted),
> then you would be able to run xenomai on a default kernel, if it was
> built with the right config items enabled.
>
> --
> Len Sorensen
>
