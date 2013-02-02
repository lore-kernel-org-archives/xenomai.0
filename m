Message-ID: <510D74EB.6070606@zultron.com>
Date: Sat, 02 Feb 2013 14:19:55 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <3B6652EE-A4C6-4819-B3BB-DB02EFA1B08B@mah.priv.at>
In-Reply-To: <3B6652EE-A4C6-4819-B3BB-DB02EFA1B08B@mah.priv.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kconfig CONFIG_XENO_OPT_TIMING_PERIODIC=y/n
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org



On 01/29/2013 06:54 AM, Michael Haberler wrote:
> I'm testing linuxcnc with John's 3.5.7 - 2.6.2.1 kernel and found an
> issue with the deprecated linuxcnc xenomai-kernel threads version
> (the userland threads version is fine; both using native skin). I
> traced that back to rt_timer_ticks2ns(30000) returning zero.
> 
> The config difference I see is: CONFIG_XENO_OPT_TIMING_PERIODIC=y on
> 3.5.7, unset on 3.2.21

The periodic timing option =y made it into my kernel
script-kiddie-style:  I copied it directly from Gilles's config without
trying to understand every option.

> 
> The way I read back messages I'd think that should be unset for
> native and Posix skins; these are compiled in:
> 
> CONFIG_XENO_SKIN_NATIVE=y
> CONFIG_XENO_SKIN_POSIX=y
> CONFIG_XENO_SKIN_PSOS=m
> CONFIG_XENO_SKIN_UITRON=m
> CONFIG_XENO_SKIN_VRTX=m
> CONFIG_XENO_SKIN_VXWORKS=m
> CONFIG_XENO_SKIN_RTDM=y

Now that I've gone back and read, I don't understand either.  Native and
posix styles need periodic timing unset.

At least the VXWorks skin needs periodic timing, so loading the VXWorks
skin module with periodic timing unset has no purpose, since RT programs
using the skin won't work.

> 
> (not that we're about to use the other skins soon, but I understand
> John is shooting for a most generic setup)

Yes, that's right, and of course with a preference to support the work
you did on LinuxCNC.  :)  Luckily, its interface with Xenomai is pretty
simple and uses the native skin, which I would have picked for a generic
kernel anyway.

> 
> Am I correct to assume the right thing to do is to set
> CONFIG_XENO_OPT_TIMING_PERIODIC=n for that purpose?

Still scratching my head on this.

	John


> 
> thanks in advance,
> 
> Michael
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


