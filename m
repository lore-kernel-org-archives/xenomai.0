Message-ID: <2ff1a98a0708140316xcd981b2hcc2e6e8a11199fff@domain.hid>
Date: Tue, 14 Aug 2007 12:16:17 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80708140310i22fabe68w5d8d6670c8cc0226@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80708130403v62b21fd5va7b5919bd996dbaf@domain.hid>
	<18112.16815.606280.878902@domain.hid>
	<2862c2c80708140310i22fabe68w5d8d6670c8cc0226@domain.hid>
Subject: Re: [Xenomai-help] System Timer Interrupt Sharing?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 8/14/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
>  On 8/13/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org > wrote:
> > Yeoh Chun Yeow wrote:
> > > Dear all,
> > >
> > > Is that possible to share the system timer interrupt used for xenomai
> kernel
> > > scheduling for any other purposes?
> > >
> > > Please advice. Thanks
> >
> > I guess you are talking about Xenomai on AT91. Xenomai on AT91 does not
> > use the system timer interrupt, it uses the timer counter interrupt
> > instead. So, yes, you can use system timer interrupt for any other non
> > real-time activity.
> >
> > Now, if your question is to know if it is possible to share an interrupt
> > between real-time and not real-time activity, the answer is that it is
> > not easy. If you want to do this, you will have to move the hardware
> > acknowledgement part of the non real-time interrupt handler to a
> > real-time interrupt handler, and, when an event is pending for the non
> > real-time domain, propagate the irq.
> >
> Dear Gilles,
>
> Thanks for your response. Yes, I know that AT91 uses the TC instead of
> system timer interrupt.
>
> FYI, I also doing development using Intel M Processor.

Then, if you need a function to be called upon timer interrupt use a
timer, either a Xenomai timer (posix timer, or native alarm), or a
Linux timer

-- 
                                               Gilles Chanteperdrix

