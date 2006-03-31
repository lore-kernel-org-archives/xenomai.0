Message-ID: <442CFCA3.4070704@domain.hid>
Date: Fri, 31 Mar 2006 11:55:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
References: <1143612388.32703.257789950@domain.hid>
	<442A7D19.2000009@domain.hid>
	<1143694058.30209.257882137@domain.hid>
	<442C46EC.6000605@domain.hid>
	<1143790982.14016.257982746@domain.hid>
In-Reply-To: <1143790982.14016.257982746@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saul <xeno@domain.hid>
Cc: xenomai@xenomai.org

Saul wrote:
> Philippe Gerum wrote:
> 
>>Mm, this really looks like some firmware/BIOS cyclic activity, that 
>>would hit the busy loop more or less frequently, depending on the 
>>internal timing of the outer loop. This reminds me that some recent 
>>Intel chipset are known to prevent global SMI disabling actually, maybe 
>>this is the case here, so our work-around would be basically useless. 
>>Another usual suspect is NMI handling (which the Adeos layer does not 
>>pipeline but rather delivers immediately), but I guess that you did not 
>>activate the NMI watchdog anyway, so back to square #1, I guess.
> 
> 
> No, I never enabled the NMI watchdog.
> 
> Yeah, that doesn't sound good for me. I just tried, for the first time,
> allowing SMI to remain enabled. Behaves exactly the same :(  A failure
> to disable SMI would also explain why none of my peripherals were ever
> affected.
> 
> I thought SMI was supposed to increase latencies, but I only see
> latencies < 60us at any load, unless I start video capture. Does the
> latency test absolutely rule out SMI as the cause?

Not really, e.g. if the video capture device is USB-attached, then SMI 
could possibly remain in the picture.

  Is there any way to
> check whether SMI is actually disabled?
> 

Gilles will likely have more clue here, but I guess that reading back 
the  state of the GBL_SMI_EN_BIT from the SMI's MMIO space would 
probably tell us if a previous request to disable SMI globally did 
succeed or not. The code in question is in ksrc/arch/i386/smi.c.

Another option to cross-check that we might have an SMI issue would be 
to find a box with an ICH4 chipset which is known to be reasonably 
controllable by our SMI work-around, and try to do video capture using 
it after Xenomai has globally disabled SMI sources.

> Thanks,
> Saul.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

