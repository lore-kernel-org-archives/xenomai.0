Date: Wed, 10 Dec 2014 12:03:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141210110345.GD1524@hermes.click-hack.org>
References: <CALe7ZU07e_Pi4=jbV9y1zuVd4RAKZGRsuUdQrVqWCjPcmjTkgg@mail.gmail.com>
 <20141210103829.GA1524@hermes.click-hack.org>
 <CALe7ZU0xG7Z1oCfV3uoWV=V1u03P71fSqpnso0B0X9t+eF9Axw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALe7ZU0xG7Z1oCfV3uoWV=V1u03P71fSqpnso0B0X9t+eF9Axw@mail.gmail.com>
Subject: Re: [Xenomai] /asm/ipipe.h not found
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Wed, Dec 10, 2014 at 04:24:53PM +0530, JAY KOTHARI wrote:
> On 12/10/14, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > On Wed, Dec 10, 2014 at 03:57:44PM +0530, JAY KOTHARI wrote:
> >> Hello,
> >>     I am porting linux-3.2.21(xenomai-2.6.2 patched to it) on
> >> BeagleBoard-XM.
> >
> > You do not need to port it, it is already supported.
> >
> > Also, why using such old versions ? The latest version of Xenomai is
> > 2.6.4 and will work with the I-pipe patch for Linux 3.2.21.
> >
> >
> >> zImage is successfully made. But when I am building
> >> the modules with following command
> >>
> >>  $make -j 8 ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi modules
> >>
> >>  It shows error:
> >>   make CONFIG_DEBUG_SECTION_MISMATCH=y
> >
> > Yes, this has been reported, and fixed in later patches. That is
> > what you get by using old patches. Simply turn that off.
> >
> I turn it off by this command
> $make CONFIG_DEBUG_SECTION_MISMATCH=n
> 
> >>
> >> After this I ran
> >>  $make CONFIG_DEBUG_SECTION_MISMATCH=y
> >>
> >> This lets to another error
> >> include/linux/ipipe.h :33:23: fatal error:asm/ipipe.h: No such file or
> >> directory.
> >> compilation terminated.
> >>
> >>       Actually ipipe.h is there in /asm/ipipe.h:I tried to set CFLAG
> >> and export it but it is not working.Help would be appreciated.
> >
> > You do not provide enough information for us to answer that
> > question. Sorry.
> >
> > --
> > 					
> >
> After doing that I got following error
> make[1]: Nothing to be done for `relocs'.
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from include/linux/sched.h:65:0,
>                  from arch/x86/kernel/asm-offsets.c:9:
> include/linux/ipipe.h:33:23: fatal error: asm/ipipe.h: No such file or
> directory
> compilation terminated.
> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
> make: *** [prepare0] Error 2

Interesting information, but maybe not sufficient to solve your
issue, you want to compile for beaglebone, but you are compiling a
kernel for the x86 architecture ? I am afraid it will not work.

-- 
					    Gilles.

