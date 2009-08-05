From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.2.00.0908052231200.4877@domain.hid>
References: <Pine.LNX.4.62.0907241731170.11473@domain.hid>
	<1248453047.3998.168.camel@domain.hid>
	<alpine.DEB.2.00.0907241917480.4343@domain.hid>
	<1248461458.3998.183.camel@domain.hid>
	<alpine.DEB.2.00.0907242259430.4343@domain.hid>
	<1248517986.4438.1.camel@domain.hid>
	<alpine.DEB.2.00.0907281859210.4673@domain.hid>
	<1248855797.3247.16.camel@domain.hid>
	<Pine.LNX.4.62.0907291210470.20869@domain.hid>
	<Pine.LNX.4.62.0907291226390.20869@domain.hid>
	<1248883517.3532.7.camel@domain.hid>
	<alpine.DEB.2.00.0907292209410.5958@domain.hid>
	<1249287753.4803.10.camel@domain.hid>
	<Pine.LNX.4.62.0908031850580.29886@domain.hid>
	<1249473495.3809.22.camel@domain.hid>
	<alpine.DEB.2.00.0908052231200.4877@domain.hid>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 00:12:27 +0200
Message-Id: <1249510347.3809.138.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stack sizes etc. (Re: POSIX skin/Blackfin:
 SIGSEGV when stracing or gdb'ing)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2009-08-05 at 22:37 +0200, Waschk,Kolja wrote:
> Hi,
> 
> > Does this help?
> > diff --git a/ksrc/arch/blackfin/switch.S b/ksrc/arch/blackfin/switch.S
> 
> Yes! Great - it doesn't just help to step 'next' over the small example, it
> also allows me to actually use GDB with my larger app in use cases that
> previously always ended with the xnshadow_relax failure. Is it a bugfix or
> workaround

It is an official bug fix, for a blackfin-specific issue.

>  and how did you actually find it out?

Your test case helped reproducing it in a very reliable manner, thanks
for this. The rest was about remembering a wacky aspect of the blackfin
architecture when it comes to implement rescheduling among supervisor
mode tasks: specifically, you just can't do context switching anytime
your OS sees fit, but only when the CPU is not nesting interrupts. This
issue implies a deferral of the Xenomai rescheduling procedure in some
circumstances (uClinux suffers the same pain), and the related piece of
my assembly code ended up being as wacky as the original blackfin issue.
This is what this patch fixes.

>  - Kolja
> 
-- 
Philippe.



