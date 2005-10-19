Message-ID: <43565170.4030707@domain.hid>
Date: Wed, 19 Oct 2005 16:00:16 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Testing the adeos-ipipe-2.6.13-ppc-1.0-00.patch
References: <1CFEB358338412458B21FAA0D78FE86D4F0E32@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E32@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Philippe Gerum wrote:
> [..]
> 
>>The last significant change between -00 and -01 is actually the one related to 
>>the fork pressure (others are cosmetic ones aimed at better sharing stuff with 
>>the blackfin port). The patch below against -02 removes it.
> 
> 
> Here is the result of tests with version 1.0-02+ (entry.S patch) on e500:
>  
> load: ~1 minute ping -f, one run of calibrator chewing 64MiB.
> 
> SWITCH without load:
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|        3660|        3690|        8070|           0    1.0-00
> RTD|        4620|        4740|        8730|           0    1.0-01
> RTD|        4620|        4740|        8190|           0    1.0-02
> RTD|        4650|        4740|        7980|           0    1.0-02+
> 
> KLATENCY with load:
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|
> RTS|       -7350|       -5715|        6420|       0|    00:03:17 1.0-00
> RTS|       -6150|       -4384|       12180|       0|    00:03:13 1.0-01
> RTS|       -6150|       -4183|       12480|       0|    00:03:38 1.0-02
> RTS|       -6120|       -4447|        8370|       0|    00:03:47 1.0-02+
> 
> LATENCY with load:
> == Sampling period: 100 us
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|
> RTS|       -6930|       -4260|        8700|       0|    00:08:06 1.0-00
> RTS|       -5670|       -4620|       12930|       0|    00:12:39 1.0-01
> RTS|       -5700|       -3750|       11280|       0|    00:06:05 1.0-02
> RTS|       -5640|       -2250|       11310|       0|    00:10:31 1.0-02+
> 
> Load is still generated manually, so the pattern may vary: lat avg
> is not meaningful. The amplitude would be a much more interesting value.
> Anyway, are the generated load comparable?
> 
> The klatency is in better shape, however the latency test did not improve.
> The 1.0-00 patch should be rerun as a double check.
> I'm afraid we're already entering performance fine tuning, while we have

Actually no, such a high variation in latency is the sign of a serious 
regression, not just a fine tuning issue. Let's stop there, I'll remove the fork 
patch for -03 since it had no positive impact anyway. Thanks.


> IMO other higher priority tasks for now. At least, I do :-(
> 

-- 

Philippe.

