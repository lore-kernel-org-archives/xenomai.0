Message-ID: <51A88783.100@xenomai.org>
Date: Fri, 31 May 2013 13:20:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAN0BPY_SzMoNrgOF2fBwrMA=7scopqTKPC+pxkk12wtGMsWdGQ@mail.gmail.com>
	<CAN0BPY_gK3-_qLZVpq1hgoGWqqRRH++fRAcTdReo3ojf6U8Hfg@mail.gmail.com>
In-Reply-To: <CAN0BPY_gK3-_qLZVpq1hgoGWqqRRH++fRAcTdReo3ojf6U8Hfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fwd: SMI problems with 2.6.2.1 and last weekends git
 version
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
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

