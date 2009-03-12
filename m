Message-ID: <49B99153.2010505@domain.hid>
Date: Thu, 12 Mar 2009 23:48:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1236892358.29394.296.camel@domain.hid>
In-Reply-To: <1236892358.29394.296.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Travis Stratman <tstratman@domain.hid>
Cc: Xenomai Help List <xenomai@xenomai.org>

Travis Stratman wrote:
> Hello,
> 
> I have an application that I'm trying to solve. I don't have a lot of
> experience programming in real-time under an OS, so I'm trying to
> determine if this is possible at all and what the best method of solving
> it is.
> 
> The target for this application would be an Atmel AT91SAM9260 processor
> or AT91SAM9G20 (9260 at 400 MHz essentially). The main constraint is
> that the ADC in the processor must be sampled at 200K samples/sec which
> gives a period of about 5 us. This sampling happens in bursts of 50 to
> several hundreds of samples (so at most 2 ms for this task). Once the
> data is analyzed, a value is set on a DAC. Once the value has been set
> 10s to 100s of ms go by before the cycle starts over again with sampling
> and analysis.
> 
> The timing on the sampling is pretty critical, though a little jitter
> might be acceptable at times. In general there shouldn't be much else
> going on in the background on the board. The ADC block is rated at a max
> 312K samples / second.
> 
> The 5 us sampling period is too fast to schedule the sampling as a
> periodic task. But, since the actual sample burst time is under 1 ms
> most of the time I was thinking that I might be able to schedule a
> thread to take a certain number of samples in one task, inserting delays
> between each sample to get the timing right.
> 
> Is this possible or is this an application that should be done on a much
> lower level? Am I on the right track at all?
> 
> Thanks in advance,

Polling during the time of the acquisition seems to be your best chance
on an ARM. However, one issue remain or maybe I did not understand
correctly your explanation: how do you wake up on time for the beginning
of this acquisition? Wake-up jitter is pretty high on ARM, even with
FCSE, you can count on something like 100us.

-- 
					    Gilles.

