Date: Tue, 27 Mar 2018 13:47:27 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180327134727.2954e6f7@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <7fa34e01-0b44-c276-d048-5f638e73de1d@frank-benkert.de>
References: <52bd261d-07c2-80d1-77f4-fb501795dea7@frank-benkert.de>
 <cd4214b0-078b-f02b-66c1-f81c4b078ac4@xenomai.org>
 <7fa34e01-0b44-c276-d048-5f638e73de1d@frank-benkert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Regression posix/mprotect failed on Xenomai 2.6.5 on
 powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frank Benkert <xenomai@frank-benkert.de>
Cc: xenomai@xenomai.org

Am Tue, 27 Mar 2018 13:12:15 +0200
schrieb Frank Benkert <xenomai@frank-benkert.de>:

> Thanks Philippe for cross-checking.
> In the meantime I've figured out, that this test was added with 
> 787f3aea43a6f8be68e3d41de78825b6e2c59469 by Jan; the checkin comment
> is interesting:
> 
> commit 787f3aea43a6f8be68e3d41de78825b6e2c59469
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Mon Jan 7 18:36:19 2013 +0100
> 
>      testsuite: Enhance mprotect regression test with r/w after
> access enable
> 
>      This triggers the I-pipe bug where a region is first
> inaccessible, thus no page directory entries are reserved, and then
> made accessible via mprotect. I-pipe tend to make the zero page
> writable on the access pattern read-before-write.
> 
>      Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> It looks like the problem is triggered by my old ipipe version.
> I'll try to update my ipipe patch, but this might not be as easy as
> it sounds. We've made many checkins on top of it.

You saved a lot of money back in the day, i hope you still have it to
pay the technical debt today ;).

I would look for ipipe patches from Jan around that time. It is very
likely that you will find a fix for that specific issue, and that might
be easier to backport than lifting your patches to another kernel.

Henning

> Thanks for your help!
> 
> 
> Am 27.03.2018 um 13:01 schrieb Philippe Gerum:
> > On 03/27/2018 09:59 AM, Frank Benkert wrote:  
> >> Hello,
> >>
> >> we have to maintain an old productive system.
> >> It's based on a powerpc MPC5200.
> >> After updating Xenomai from 2.6.1 to 2.6.5 the Xenomai regression
> >> test suite failed on posix/mprotect:
> >>
> >> + /usr/bin/regression/posix/mprotect
> >> memory read
> >> memory write after exec enable
> >> memory write after write enable
> >> memory read/write after access enable
> >> FAILURE main:102: read zero returned 255 instead of 0
> >>  
> > This does not look good given how trivial the failing test is. I
> > can't tell for kernel 3.5.x, and I won't try it because this would
> > require to downgrade to a legacy ppc toolchain for building such an
> > old kernel, which would require more time than I can invest in this
> > case.
> > 
> > Luckily, I still have an ancient 3.10.32 kernel image in my tftpboot
> > area for some ppc52xx (*), which I tried: it does not exhibit the
> > issue with a stock Xenomai 2.6.5 release.
> > 
> > (*) Hw is a venerable motorola Icecube, but I would assume that any
> > 6xx core would do just as well:
> > 
> > CPU:   MPC5200 v1.0, Core v1.1 at 396 MHz
> >   
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


