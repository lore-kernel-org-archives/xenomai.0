Message-ID: <4F96652D.1080401@domain.hid>
Date: Tue, 24 Apr 2012 10:32:45 +0200
From: Michael Trimarchi <michael@domain.hid>
MIME-Version: 1.0
References: <4F965FA6.2070009@domain.hid>
	<4F966094.9070709@domain.hid>
In-Reply-To: <4F966094.9070709@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 3/3] Fix imx time reprogramming issue
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, b.morelli@domain.hid

On 04/24/2012 10:13 AM, Gilles Chanteperdrix wrote:
> On 04/24/2012 10:09 AM, Michael Trimarchi wrote:
>> This patch includes:
>>
>> * Fix invalid virtual address base of MX1_2_TCM
>> * Fix the minimum delay below which the hardware timer can not be reprogrammed.
>>   The value is the same of that one that is used to calculate the min_delta_ns
>>
>> arch/arm/plat-mxc/time.c
>> 414: clockevent_mxc.min_delta_ns = clockevent_delta2ns(0xff, &clockevent_mxc);
> 
> I do not think we can use this value, it is way to high for xenomai
> needs. In latest releases we use 2us instead of 1us, and according to
> what a user posted recently, this should be enough, could you test with
> 2us? And 2us is already what we have in the 3.2 repository.
> 
As I understood the min delays is in tick and not depend on the clock rate. 

This is from atmel at91_ipipe_time

min_delta_ticks = ((unsigned long long) clkevt.min_delta_ns
                           * clkevt.mult) >> clkevt.shift;

this is exaclty the reverse calculation of clockevent_mxc.min_delta_ns

I have already the result in the previous calculation: 0xff is the minimun in ticks

Michael

