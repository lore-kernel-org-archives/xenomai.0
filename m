From: Paul <paul_c@tuxcnc.org>
Date: Mon, 28 Jan 2013 12:29:49 +0000
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<201301241712.21645.paul_c@tuxcnc.org>
	<51024A62.8020206@xenomai.org>
In-Reply-To: <51024A62.8020206@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201301281229.49771.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Friday 25 January 2013, Gilles Chanteperdrix wrote:
> On 01/24/2013 06:12 PM, Paul wrote:
> > On Thursday 24 January 2013, Christophe Blaess wrote:
> >> On 22/01/2013 04:06, Paul wrote:
> >>> On Sunday 20 January 2013, Gilles Chanteperdrix wrote:
> >>>> Yes, this patch is based on 3.5.7 and is used with and without
> >>>> GENERIC_CLOCKEVENTS.
> >>>
> >>> Short version: Updated my kernel to 3.5.7 and backported the
> >>> Raspberry Pi changes from 3.6.11 and added in the ipipe support.
> >>> Interrupts are not being recognised unless irq_set_irq_type() is
> >>> called. Digging through the rtdm, nucleus, and ipipe code, at no
> >>> point is
> >>> irq_chip->irq_set_type() called - Also have a problem that none
> >>> of the ipipe_pic_muter fields are set, so
> >>> __ipipe_enable_irqdesc() & friends do nothing.
> >>
> >> I'm trying to follow the same steps as you but I still have some
> >> compilation errors while porting
> >> R-Pi modifications to 3.5.7. (especially arm timer code).
> >>
> >> Do you have any available patch against 3.5.7 vanilla kernel ?
> >
> > Funny that you should ask - I am in the middle of generating a
> > patch set against 3.5.7 with the Raspberry Pi additions. This will
> > include the ipipe modifications along with a fix to the gpio
> > interrupt handler.
>
> If you generate this patch as a diff agains the I-pipe kernel, the
> patch could be shipped with Xenomai, or even merged in the I-pipe
> kernel.

Generated three patches which Christophe is trying out. At some 91,000 
lines, it touches on several core kernel sources including mmc, dma, 
and skbuff as well as adding a dwc_otg driver on top of the 
BCM2835/2708 support. Not sure that you'd want to merge the changes 
that affect some (estimated) sixty 3.5.7 files. Shipping as an optional 
add-on patch is possible, but it currently generates a couple of 
rejects when applied to a vanilla 3.5.7-stable.

Work is under way by the Raspberry Pi team to get the required support 
integrated with the mainline kernel. By the time 3.10.y gets released, 
we might see it in stable.


Regards, Paul.

