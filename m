MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17453.19513.723459.198259@domain.hid>
Date: Fri, 31 Mar 2006 17:35:21 +0200
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
In-Reply-To: <442CFCA3.4070704@domain.hid>
References: <1143612388.32703.257789950@domain.hid>
	<442A7D19.2000009@domain.hid>
	<1143694058.30209.257882137@domain.hid>
	<442C46EC.6000605@domain.hid>
	<1143790982.14016.257982746@domain.hid>
	<442CFCA3.4070704@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Saul wrote:
 > > Philippe Gerum wrote:
 > > 
 > >>Mm, this really looks like some firmware/BIOS cyclic activity, that 
 > >>would hit the busy loop more or less frequently, depending on the 
 > >>internal timing of the outer loop. This reminds me that some recent 
 > >>Intel chipset are known to prevent global SMI disabling actually, maybe 
 > >>this is the case here, so our work-around would be basically useless. 
 > >>Another usual suspect is NMI handling (which the Adeos layer does not 
 > >>pipeline but rather delivers immediately), but I guess that you did not 
 > >>activate the NMI watchdog anyway, so back to square #1, I guess.
 > > 
 > > 
 > > No, I never enabled the NMI watchdog.
 > > 
 > > Yeah, that doesn't sound good for me. I just tried, for the first time,
 > > allowing SMI to remain enabled. Behaves exactly the same :(  A failure
 > > to disable SMI would also explain why none of my peripherals were ever
 > > affected.
 > > 
 > > I thought SMI was supposed to increase latencies, but I only see
 > > latencies < 60us at any load, unless I start video capture. Does the
 > > latency test absolutely rule out SMI as the cause?
 > 
 > Not really, e.g. if the video capture device is USB-attached, then SMI 
 > could possibly remain in the picture.

I have used the bttv driver with xawtv or mythtv and nvidia proprietary
drivers on a dual pIII machine running latency and the maximum latency
was far less than 100 us. What produces large spots, however, is
switching virtual terminals or changing resolution. Doesn't xawtv change
resolution for full screen mode ? Did not you use the 768x576 modeline
hack ?

 > 
 >   Is there any way to
 > > check whether SMI is actually disabled?
 > > 
 > 
 > Gilles will likely have more clue here, but I guess that reading back 
 > the  state of the GBL_SMI_EN_BIT from the SMI's MMIO space would 
 > probably tell us if a previous request to disable SMI globally did 
 > succeed or not. The code in question is in ksrc/arch/i386/smi.c.

That is a good idea. Another idea would also be to read the state of the
lock bit (named SMI_LOCK).

-- 


					    Gilles Chanteperdrix.

