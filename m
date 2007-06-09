From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18026.40413.897633.663619@domain.hid>
Date: Sat, 9 Jun 2007 14:32:29 +0200
In-Reply-To: <18025.36632.58092.902029@domain.hid>
References: <403B28AE6257B548B66BB88414AC78330174BC39@domain.hid>
	<18025.36632.58092.902029@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] periodic mode in adeos-ipipe
	for	arm at91 ...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: BOUIN Alexandre <abouin@domain.hid>, adeos-main@gna.org, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > BOUIN Alexandre wrote:
 >  > 		We (Adeneo) are working on a ARM AT91 RTAI. We encountered some difficulties such tsc one : in periodic mode, we reload our timer automatically in order to avoid reprogramming it. TC timer increments a 16 byte register, which is not enough for a tsc (64 bytes). tsc need to be emulated on ARM.
 >  > 		With oneshot mode, tsc is updating the 4 least significant bytes and then increments other bytes each time counter go back to zero value.
 >  > 
 >  > 		With our periodic mode, timer reloads himself so we need to change tsc emulation by incrementing tsc like this : tsc += period.
 >  > 		We made some evolutions on ipipe which will be applied to a hal patch.
 > 
 > I intend to rework I-pipe tsc emulation for arms with a free-running
 > counter. In order to reduce the tsc read operations:
 > - it should use the (uninterruptible) ldm instruction to load the 64
 >   bits counter without masking interrupts;
 > - the 64 bits counter should not be updated at each read, but only from
 >   time to time, the best place to do this is Linux timer interrupt.

I never did the calculation before, but the TC free-running counter
wraps every 40 milliseconds, so Linux timer interrupt is not often
enough to update the 64 bits counter. The only safe place to update the
64 bits counter seems to be __ipipe_mach_acktimer.

-- 


					    Gilles Chanteperdrix.

