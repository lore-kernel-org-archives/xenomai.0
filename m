Message-ID: <50F7E992.4030106@xenomai.org>
Date: Thu, 17 Jan 2013 13:07:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>	<50F7AF53.2090800@xs4all.nl>
	<50F7BC13.50009@xenomai.org>
	<5AD691AE-9A31-49FE-994C-A0CA884817DA@mah.priv.at>
In-Reply-To: <5AD691AE-9A31-49FE-994C-A0CA884817DA@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Emc-developers] "new RTOS" status:
 Scheduler	(?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 01/17/2013 12:34 PM, Michael Haberler wrote:

> Gilles,
> 
> Am 17.01.2013 um 09:53 schrieb Gilles Chanteperdrix:
> 
>> On 01/17/2013 08:59 AM, Bas Laarhoven wrote:
>>
>>> On 16-1-2013 20:36, Michael Haberler wrote:
>>>>>
>>>>>
>>>>> Are you saying you don't have seen these 'sudden stops' yourself?
> 
> ...
>> This is typical of a tsc emulation or timer issue. On a system without
>> anything running, please let the "tsc -w" command run. It will take some
>> time to run (the wrap time of the hardware timer used for tsc
>> emulation), if it runs correctly, then you need to check whether the
>> timer is still running when the bug happens (cat /proc/xenomai/irq
>> should continue increasing when for instance the latency test is
>> running). If the timer is stopped, it may have been programmed for a too
>> short delay, to avoid that, you can try:
>> - increasing the ipipe_timer min_delay_ticks member (by default, it uses
>> a value corresponding to the min_delta_ns member in the clockevent
>> structure);
>> - checking after programming the timer (in the set_next_event method) if
>> the timer counter is already 0, in which case you can return a negative
>> value, usually -ETIME.


Actually, the hardware counter will be 0xffffffff when the timer has
reached delay.

-- 
                                                                Gilles.

