From: Travis Stratman <tstratman@domain.hid>
In-Reply-To: <49B99153.2010505@domain.hid>
References: <1236892358.29394.296.camel@domain.hid>
	<49B99153.2010505@domain.hid>
Date: Thu, 12 Mar 2009 18:30:17 -0500
Message-Id: <1236900617.29394.346.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Application question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai Help List <xenomai@xenomai.org>

Thanks Gilles.

On Thu, 2009-03-12 at 23:48 +0100, Gilles Chanteperdrix wrote:

> > 
> > The target for this application would be an Atmel AT91SAM9260 processor
> > or AT91SAM9G20 (9260 at 400 MHz essentially). The main constraint is
> > that the ADC in the processor must be sampled at 200K samples/sec which
> > gives a period of about 5 us. This sampling happens in bursts of 50 to
> > several hundreds of samples (so at most 2 ms for this task). Once the
> > data is analyzed, a value is set on a DAC. Once the value has been set
> > 10s to 100s of ms go by before the cycle starts over again with sampling
> > and analysis.
> > 
> > The timing on the sampling is pretty critical, though a little jitter
> > might be acceptable at times. In general there shouldn't be much else
> > going on in the background on the board. The ADC block is rated at a max
> > 312K samples / second.
> > 
> > The 5 us sampling period is too fast to schedule the sampling as a
> > periodic task. But, since the actual sample burst time is under 1 ms
> > most of the time I was thinking that I might be able to schedule a
> > thread to take a certain number of samples in one task, inserting delays
> > between each sample to get the timing right.
> > 
> 
> Polling during the time of the acquisition seems to be your best chance
> on an ARM. However, one issue remain or maybe I did not understand
> correctly your explanation: how do you wake up on time for the beginning
> of this acquisition? Wake-up jitter is pretty high on ARM, even with
> FCSE, you can count on something like 100us.
> 

I'm not completely sure at this point... a customer has presented this
problem and I'm looking at the feasibility of it for now. I think that
an external flag will be read (some PIO line, possibly an interrupt)
that signals when a motor has settled down at which point calibration
begins again. I don't think that this timing is nearly as critical as
the sampling rate. I asked him to provide further information on it just
in case.

At this point I think the best thing for me to do at this point would be
to do some testing. I also noticed that the ADC seems to support
scheduling triggers using a timer/counter output and transferring
samples to a DMA buffer... this would be ideal if I can get it to work
right.

Thanks,

TAS


