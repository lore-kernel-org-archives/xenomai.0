Date: Thu, 13 Aug 2015 21:11:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150813191157.GG28709@hermes.click-hack.org>
References: <CAKC9m6f5Yc7MZHZQO2MRCf+y2nOM7P1psX4fLTeqgE4tsnv+RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC9m6f5Yc7MZHZQO2MRCf+y2nOM7P1psX4fLTeqgE4tsnv+RA@mail.gmail.com>
Subject: Re: [Xenomai] I-pipe's determinism in handling hardware interrupts
 when GIC implements "Security Extensions"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On Thu, Aug 13, 2015 at 11:51:59AM -0700, Hongfei Cheng wrote:
> Hi All,
> 
> I am wondering (aloud) if anyone has experience running I-pipe on
> ARMv7 platform which supports ARM's Security Extensions (TrustZone).

I think we have that on some omap3/omap4 boards.

> 
> I believe, starting in ARMv7-A/R architecture, ARM added the
> (optional) Security Extensions (TrustZone) to provide hardware
> security features. Some of the ARM SoCs on the supported list by
> Xenomai, such as Freescale QorIQ LS1 and Xilinx Zynq, appear to have
> implemented such extensions.
> 
> On an ARM SoC platform implementing the Security Extensions -
> 1). How does the I-pipe/Adeos deal with both the interrupt sources in
> "Normal world" (non-secure interrupt) and "Secure world" (secure
> interrupt)?

Correct me if I am wrong, I do not know which is which, but I
believe the Linux code only lives in one of the two worlds. The
other world is the one of a monitor, or whatever you call it, and
inaccessible to Linux (that is the aim of "securing the processor").
So, by definition I-pipe being a modification of Linux and not of
the monitor can not access the privileged operations.

> 2). What would happen if a Xenomai real-time thread is taking on a
> non-secure interrupt while a secure interrupt with higher priviledge
> arrives which must be routed to a Linux thread?
> 3). Since a secure interrupt can take an unbounded amount of time to
> complete its task, such as downloading firmware, will it break
> I-pipe's determinism in serving non-secure interrupt on behalf of
> Xenomai real-time threads?

I am not sure this case can exist. Are not these privileged
interrupt only handled by the monitor? Anyway, if when this
interrupt is masked at the interrupt controller level, non
privileged interrupts can be handled, then there is no problem. If
such an interrupt has to be handled before any more interrupt can be
taken, even if masked, then you have a problem. If, like I believe,
such a "privileged interrupt" is handled by the monitor behind
Linux/I-pipe's back, then yes, it will break determinism.

-- 
					    Gilles.
https://click-hack.org

