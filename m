From: Paul <paul_c@tuxcnc.org>
Date: Wed, 13 Feb 2013 12:40:39 +0000
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301310211.44277.paul_c@tuxcnc.org>
	<510AC9D2.5050008@xenomai.org>
In-Reply-To: <510AC9D2.5050008@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201302131240.39173.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Thursday 31 January 2013, Gilles Chanteperdrix wrote:
> On 01/31/2013 03:11 AM, Paul wrote:
> > Booting with "dwc_otg.fiq_fix_enable=0" in cmdline.txt improves
> > matters considerably - The problem is in the FIQ handler and/or the
> > dwc_otg driver.

Hvaving spent some time going over some of the code, the FIQ handler is 
not at the root of the problem.

> > This will have to wait until the weekend and hopefully I can get
> > time to dig further. One option is to route the timer through the
> > FIQ which may improve latency a little, another is to disable it
> > altogether.
> You can not really execute the timer irq handler in FIQ mode, if that
> is what you mean.

I had indeed thought the timer irq handler could be run in FIQ mode. 
Didn't take long to rule that idea out as a nonstarter.

Upshot of the last couple of weeks is I finally have GPIO interrupt 
latencies down to a more respectable 12-30uS delay - This is with the 
ipipe tracer enabled, so there is scope to reduce it further.

Once I've cleaned up my hacks and run on a fully loaded box with the 
tracer disabled, I'll generate a patch for the Raspberry Pi and post it 
somewhere.


Regards, Paul.


