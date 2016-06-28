References: <20160628083404.GI18662@hermes.click-hack.org>
 <57724022.8010904@sigmatek.at> <20160628091747.GK18662@hermes.click-hack.org>
 <57724333.6010608@sigmatek.at> <20160628092955.GL18662@hermes.click-hack.org>
 <577248AB.5070601@sigmatek.at> <20160628095543.GM18662@hermes.click-hack.org>
 <57724CFE.2050401@sigmatek.at> <20160628101957.GO18662@hermes.click-hack.org>
 <5772520E.8010407@sigmatek.at> <20160628103925.GP18662@hermes.click-hack.org>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <57726377.2060409@sigmatek.at>
Date: Tue, 28 Jun 2016 13:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <20160628103925.GP18662@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Am 2016-06-28 um 12:39 schrieb Gilles Chanteperdrix:
> On Tue, Jun 28, 2016 at 12:31:42PM +0200, Wolfgang Netbal wrote:
>>
>> Am 2016-06-28 um 12:19 schrieb Gilles Chanteperdrix:
>> min: 10, max: 677, avg: 10.5048 -> 0.0265273 us
>>
>> Here are the output for Kernel 3.0.43 and Xenomai 2.6.2.1
>>
>> #> ./tsc
>> min: 10, max: 667, avg: 11.5755 -> 0.029231 us
> Ok. So, first it confirms that the two configurations are running
> the processor at the same frequency. But we seem to see a pattern,
> the maxima in the case of the new kernel seems consistently higher.
> Which would suggest that there is some difference in the cache. What
> is the status of the two configurations with regard to the L2 cache
> write allocate policy? Could you show us the tsc results of Xenomai
> 2.6.4 with the 3.0 kernel ?
As requested I created a Kernel 3.0.43 with Xenomai 2.6.4
#> dmesg | grep "Linux version"
Linux version 3.0.43 (netwol@DSWUB001) (gcc version 4.7.2 (GCC) ) #186 
SMP PREEMPT Tue Jun 28 13:28:40 CEST 2016

#> dmesg | grep "Xenomai"
[    0.844697] I-pipe: Domain Xenomai registered.
[    0.849188] Xenomai: hal/arm started.
[    0.853189] Xenomai: scheduling class idle registered.
[    0.858350] Xenomai: scheduling class rt registered.
[    0.882246] Xenomai: real-time nucleus v2.6.4 (Jumpin' Out) loaded.
[    0.888926] Xenomai: starting native API services.
[    0.893811] Xenomai: starting RTDM services.

#> dmesg | grep I-pipe
[    0.000000] I-pipe 1.18-13: pipeline enabled.
[    0.331174] I-pipe, 396.000 MHz timer
[    0.334900] I-pipe, 396.000 MHz clocksource
[    0.844697] I-pipe: Domain Xenomai registered.


Here the output of tsc
#> ./tsc
Checking tsc for 1 minute(s)
min: 10, max: 24, avg: 10.5
min: 10, max: 24, avg: 10.5
min: 10, max: 26, avg: 10.5
min: 10, max: 22, avg: 10.5
min: 10, max: 26, avg: 10.5
min: 10, max: 18, avg: 10.5
min: 10, max: 51, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 22, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 32, avg: 10.5
min: 10, max: 23, avg: 10.5
min: 10, max: 47, avg: 10.5
min: 10, max: 35, avg: 10.5
min: 10, max: 29, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 345, avg: 10.5
min: 10, max: 23, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 23, avg: 10.5
min: 10, max: 42, avg: 10.5
min: 10, max: 25, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 23, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 38, avg: 10.5
min: 10, max: 35, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 28, avg: 10.5
min: 10, max: 25, avg: 10.5
min: 10, max: 22, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 26, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 24, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 19, avg: 10.5
min: 10, max: 23, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 35, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 25, avg: 10.5
min: 10, max: 24, avg: 10.5
min: 10, max: 36, avg: 10.5
min: 10, max: 35, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 34, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 36, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 26, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 26, avg: 10.5
min: 10, max: 40, avg: 10.5
min: 10, max: 23, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 21, avg: 10.5
min: 10, max: 345, avg: 10.5 -> 0.0265152 us


