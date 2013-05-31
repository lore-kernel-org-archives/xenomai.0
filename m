MIME-Version: 1.0
Sender: johncandlish@gmail.com
In-Reply-To: <51A88783.100@xenomai.org>
References: <CAN0BPY_SzMoNrgOF2fBwrMA=7scopqTKPC+pxkk12wtGMsWdGQ@mail.gmail.com>
	<CAN0BPY_gK3-_qLZVpq1hgoGWqqRRH++fRAcTdReo3ojf6U8Hfg@mail.gmail.com>
	<51A88783.100@xenomai.org>
Date: Fri, 31 May 2013 16:03:54 +0200
Message-ID: <CAN0BPY_Gicv-2em8mqbjupC=9VFTgTLgP-djQrjvi1c8PcM1yA@mail.gmail.com>
From: John Candlish <john.candlish@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Fwd: Fwd: SMI problems with 2.6.2.1 and last weekends git
	version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Thank you for you timely reply.  I'll check again with another of the same
computer+bios as well as a core2 ICH7 machine.

I should mention that the particular machine tested does respond to the
rtai_smi.ko module, in that the presence of that module significantly
reduces (eliminates actually) the periodic smi latencies.

It is curious.  I'll look again.

Thanks
jCandlish
.

---------- Forwarded message ----------
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri, May 31, 2013 at 1:20 PM
Subject: Re: [Xenomai] Fwd: SMI problems with 2.6.2.1 and last weekends git
version
To: John Candlish <john.candlish@gmail.com>
Cc: xenomai@xenomai.org


On 05/31/2013 12:00 PM, John Candlish wrote:

> Resent, because it bounced the first time.
>
> ---------- Forwarded message ----------
> From: John Candlish <john.candlish@gmail.com>
> Date: Tue, May 28, 2013 at 9:08 PM
> Subject: SMI problems with 2.6.2.1 and last weekends git version
> To: xenomai@xenomai.org
>
>
> Hello
>
> This was originally about linuxCNC, but was reminded to post my SMI
> findings here.
>
> from the emc-developers list:
> http://thread.gmane.org/gmane.linux.distributions.emc.devel/9863
>
> <quote>
>
> What I found out about RTAI and Xenomai?
>
> Xenomai 2.6.2.1 stable or GIT do not handle SMI masking correctly for my
> ICH7 chipsets.  In the case of the stable download the chipset is detected
> but the SMI workaround fails to apply.
>
> ---
> May 25 07:42:05 sixis kernel: Xenomai: real-time nucleus v2.6.2.1 (Day At
> The Beach) loaded.
> May 25 07:42:05 sixis kernel: Xenomai: debug mode enabled.
> May 25 07:42:05 sixis kernel: Xenomai: SMI-enabled chipset found
> May 25 07:42:05 sixis kernel: Xenomai: SMI workaround failed!


This usually means that your BIOS vendor disabled the "global SMI" bit,
there is not much Xenomai can do about that. You may try other bits,
though, maybe that works (I never tried actuallly, because I never had a
computer where accessing the global SMI bit failed).

> ---
>
> In the case of the GIT version the kernel command line parameter
> 'xeno_hal.smi=1' is not respected.


Makefile bug, this should be fixed now. But it will probably not change
the fact that your BIOS vendor may prevent you from writing to the SMI
disable bit.


--
                                                                Gilles.
