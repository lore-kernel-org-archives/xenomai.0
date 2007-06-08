From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18025.36632.58092.902029@domain.hid>
Date: Fri, 8 Jun 2007 19:17:12 +0200
In-Reply-To: <403B28AE6257B548B66BB88414AC78330174BC39@domain.hid>
References: <403B28AE6257B548B66BB88414AC78330174BC39@domain.hid>
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
To: BOUIN Alexandre <abouin@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org

BOUIN Alexandre wrote:
 > 		We (Adeneo) are working on a ARM AT91 RTAI. We encountered some difficulties such tsc one : in periodic mode, we reload our timer automatically in order to avoid reprogramming it. TC timer increments a 16 byte register, which is not enough for a tsc (64 bytes). tsc need to be emulated on ARM.
 > 		With oneshot mode, tsc is updating the 4 least significant bytes and then increments other bytes each time counter go back to zero value.
 > 
 > 		With our periodic mode, timer reloads himself so we need to change tsc emulation by incrementing tsc like this : tsc += period.
 > 		We made some evolutions on ipipe which will be applied to a hal patch.

I intend to rework I-pipe tsc emulation for arms with a free-running
counter. In order to reduce the tsc read operations:
- it should use the (uninterruptible) ldm instruction to load the 64
  bits counter without masking interrupts;
- the 64 bits counter should not be updated at each read, but only from
  time to time, the best place to do this is Linux timer interrupt.

So, if you are ready to do these modifications, I will be glad to merge
your patch.

-- 


					    Gilles Chanteperdrix.

