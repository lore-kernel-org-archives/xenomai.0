MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18026.55679.462222.299910@domain.hid>
Date: Sat, 9 Jun 2007 18:46:55 +0200
In-Reply-To: <305035a40706090703nec5b027v30cacf6f05490774@domain.hid>
References: <403B28AE6257B548B66BB88414AC78330174BC39@domain.hid>
	<18025.36632.58092.902029@domain.hid>
	<18026.40413.897633.663619@domain.hid>
	<305035a40706090703nec5b027v30cacf6f05490774@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Adeos-main] periodic mode in adeos-ipipe for
	arm at91 ...
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

Gregory CLEMENT wrote:
 > 2007/6/9, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
 > > Gilles Chanteperdrix wrote:
 > >  > BOUIN Alexandre wrote:
 > >  >  >           We (Adeneo) are working on a ARM AT91 RTAI. We encountered some difficulties such tsc one : in periodic mode, we reload our timer automatically in order to avoid reprogramming it. TC timer increments a 16 byte register, which is not enough for a tsc (64 bytes). tsc need to be emulated on ARM.
 > >  >  >           With oneshot mode, tsc is updating the 4 least significant bytes and then increments other bytes each time counter go back to zero value.
 > >  >  >
 > >  >  >           With our periodic mode, timer reloads himself so we need to change tsc emulation by incrementing tsc like this : tsc += period.
 > >  >  >           We made some evolutions on ipipe which will be applied to a hal patch.
 > >  >
 > >  > I intend to rework I-pipe tsc emulation for arms with a free-running
 > >  > counter. In order to reduce the tsc read operations:
 > >  > - it should use the (uninterruptible) ldm instruction to load the 64
 > >  >   bits counter without masking interrupts;
 > >  > - the 64 bits counter should not be updated at each read, but only from
 > >  >   time to time, the best place to do this is Linux timer interrupt.
 > >
 > > I never did the calculation before, but the TC free-running counter
 > > wraps every 40 milliseconds, so Linux timer interrupt is not often
 > 
 > How do you get this 40 ms ?
 > For me TC free-running counter wraps every (2^16)/(MCK/32)
 > For AT91RM9200-EK  MCK=59904000 so we get 35ms
 > For AT91SMA926x-EK MCK=99328000 so we get 21ms
 > I am wrong?

It was a rough estimation.

 > > enough to update the 64 bits counter. The only safe place to update the
 > > 64 bits counter seems to be __ipipe_mach_acktimer.
 > 
 > As Linux timer period is 10ms why do you think is not often enough ?

Because when Linux has a lot of work to do, or when Xenomai has a lot of
work to do, Linux timer may be delayed for more than 4 ticks. 

 > 
 > For AT91SAM926x what do you think of using PIT for emulating tsc,
 > (with PIT we can have a 32 bit counter) ?

Good, if it helps reducing the overhead of ipipe_read_tsc.

-- 


					    Gilles Chanteperdrix.

