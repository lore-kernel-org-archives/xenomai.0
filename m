Message-ID: <4DB484C4.6040204@domain.hid>
Date: Sun, 24 Apr 2011 22:15:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20110409184122.GA11908@domain.hid>	<20110409185503.GB11908@domain.hid>	<4DA0B580.4070602@domain.hid>	<4DA0B878.9010106@domain.hid>	<20110410065250.GA28869@domain.hid>	<4DA192E0.2090802@domain.hid>	<20110414164248.GA4725@domain.hid>	<4DA846FF.5040204@domain.hid>
	<4DB11857.4030604@domain.hid>
In-Reply-To: <4DB11857.4030604@domain.hid>
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

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Richard Cochran wrote:
>>> On Sun, Apr 10, 2011 at 01:22:08PM +0200, Gilles Chanteperdrix wrote:
>>>> To help debugging this, please run the kernel which crashes with I-pipe
>>>> enabled, without Xenomai, and the attached test, in order to see if the
>>>> tsc behaves correctly.
>>> Getting back to this, I did try the test program with ipipe 2.6.35 but
>>> without xenomai. It seems to run fine. But I only ran it for a few
>>> minutes.  The exact version was ipipe-2.6.35.9-arm-1.18-01 plus endian
>>> fix, and I attached the config.
>>>
>>> I enabled the *third* #if-elif-else case thinking it to be the correct
>>> one to test. (see below)
>>> (...)
>> Yes, that was the correct thing to do. I assumed that when you enabled
>> Xenomai, the system was running, and that it frozen when you started a
>> Xenomai application. Which is not your case at all.
>>> So, assuming I got that right, then the new tsc code passes the test.
>>> Next I'll try to get some better information about the freeze. Any
>>> other ideas?
>> We have only one commit to inspect, that should not be so hard. Next
>> thing to try is to see what changed in the other parts of this commit.
>> We should look at the interrupt handler, ipipe_mach_set_dec,
>> ipipe_mach_release_timer to see what change had such an effect. I will
>> try to reorder the functions to have a more readable diff. You can also
>> check if we pass the rthal_calibrate_timer function.
> 
> Hi Richard,
> 
> I am currently running some benchmarks on an AT91SAM9263 board, to see
> whether we have some performance regression.

Hi Richard,

some temporary results on the benchmark here:
http://www.xenomai.org/~gch/latency-at91sam9263.png

The worst case latency seems not to vary much over time, it looks like
it is decreasing a bit, but the differences may well be in the
measurement noise. Unlocked context switch actually improves the latency.

I will update the png as I get new results.

Regards.

-- 
                                                                Gilles.

