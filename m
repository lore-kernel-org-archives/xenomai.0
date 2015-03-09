Date: Mon, 9 Mar 2015 08:37:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150309073722.GC17373@hermes.click-hack.org>
References: <54FD3DB7.7080301@jonasplatte.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54FD3DB7.7080301@jonasplatte.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtnet in Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jonas Platte <mail@jonasplatte.de>
Cc: xenomai@xenomai.org

On Mon, Mar 09, 2015 at 07:29:11AM +0100, Jonas Platte wrote:
> Hi,

Hi Jonas,

> 
> as the title suggests, I am trying to set up rtnet with Xenomai 3.0.
> 
> I already partly got rtnet to work with Xenomai 2.6 on a debian
> machine with linux 3.4; I will try to get a linux 3.14.x or 3.16
> kernel running there tomorrow [when I am at work again], because
> cobalt requires at least 3.10 and the rtnet stuff wasn't installed
> when I built Xenomai 3.0 for the 3.4 kernel with the mercury core so I
> assumed for the moment that mercury core + rtnet isn't supported.
> 
> On my arch linux system at home I already tried the same thing though,
> where installing a new kernel was simpler, but I wasn't successful.
> Apparently, the rtnet tools (the programs rtnet, rtcfg, rtping and so
> on) were installed but the kernel modules didn't even get built.
> 
> So I have two main questions:
> 
> * Is it true that rtnet is only available for the cobalt core?
>   [I like to think that it isn't, and if I'm right about that
>   I'd be happy to help fixing it. I have a fair amount of experience
>   with the GNU build system / autotools.]

rtnet currently exists over cobalt only. It is planned to have RTnet
over mercury by first porting RTDM over native Linux, and in fact a
partial port of RTDM over native Linux exists, but the pieces have
not been tested together.


> * How to build the rtnet kernel module and the rt_* ethernet drivers?
>   I feel like I am missing a "make modules" (and "make modules_install")
>   somewhere, but I only found automake-generated Makefiles that didn't
>   have these targets and the Makefiles in kernel/, which look like they
>   should be part of a recursive make call, but I didn't find that
>   directory referenced anywhere but in EXTRA_DIST.

Rtnet has been integrated into Xenomai kernel-space support, so you
configure RTnet like xenomai kernel support: using the kernel
configuration menu. You will find RTnet configuration under the sub-menus

Xenomai/cobalt
Drivers
RTnet

Note that even though RTnet modules can be selected as built-in, they
currently only work when built as modules.

> 
> Also, a small thing that I might write dedicated email for if whoever
> reads until here tells me that would be a good idea to make the right
> people notice it:
> 
> I'm writing a C++11 (downwards compatibility currently not planned)
> wrapper for the Xenomai / rtnet RTDM API. It will be released under
> LGPL v3, unless xeno-- project is not as dead as it seems or someone
> is willing to revive it (in which case I would love to integrate this
> functionality there instead of making it a seperate library); or
> someone gives me a good reason to release it under a different license.

Can not answer about that.

> 
> Thanks to everyone who worked on porting rtnet to Xenomai 3.0 and
> integrating it into the repository!
> 
> P.S.: The next email(s) from me will probably not come from this email
> address, but from jonas.platte@iwes.fraunhofer.de. In case you want to
> contact me directly, please use that address.

Please note that the xenomai mailing list is subscriber only, so you
will need to subscribe with that second mail address to be able to
post.

Regards.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150309/eecaca41/attachment.sig>
