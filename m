Message-ID: <4DB2EED1.8010104@domain.hid>
Date: Sat, 23 Apr 2011 17:22:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA192E0.2090802@domain.hid>
	<20110414164248.GA4725@domain.hid>
	<4DA846FF.5040204@domain.hid> <4DB11857.4030604@domain.hid>
	<20110423142109.GA332@domain.hid>
In-Reply-To: <20110423142109.GA332@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> On Fri, Apr 22, 2011 at 07:55:35AM +0200, Gilles Chanteperdrix wrote:
>> I also had a look at the culprit patch, reducing it to the bare minimum
>> (no useless whitespace changes and no function moves), and it boils down
>> to only two differences:
>> 1- the fact that we use the "generic" clocksource created by
>> ipipe_tsc_register, which probably has a shift of 25 or 26 bits instead
>> of the 20 bits shift of the original clocksource, and returns a 64 bits
>> value instead of 32 bits.
>> 2- the fact that the tsc update is done with hardware irqs off in the
>> original patch.
> 
> Thanks for looking into this for me. I tried the patch, but the
> result is the same as before:
> 
> - Kernel freezes immediately if xenomai is not a module.
> 
> - If xenomai is a module, the nucleus loads, but the first skin module
>   freezes the machine.
> 
> I will take a closer look next week to see if I can find out at least
> where the freeze happens.

Ok. It means that rthal_calibrate_timer works, the system freezes when
Xenomai steals the timer. However, since the ipipe_mach_set_dec,
ipipe_mach_release_timer code did not change, it does not really make
sense. But in order to trace the issue, you should probably trace the
calls to ipipe_mach_set_dec/ipipe_mach_acktimer to see which one is the
last before the freeze.

On my side, I have run benches on at91sam9263, but am not done yet,
though yet I have not found a lot of differences in latencies between
2.4.10 and 2.5.6.

Which version of the I-pipe patch were you running with 2.4.10?

-- 
                                                                Gilles.

