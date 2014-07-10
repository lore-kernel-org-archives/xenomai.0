Message-ID: <53BEDBC6.6040809@xenomai.org>
Date: Thu, 10 Jul 2014 20:30:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1404210421-17081-1-git-send-email-maxime.ripard@free-electrons.com>	<53B294A7.5010803@xenomai.org>	<20140701141536.GN28647@lukather>	<53B30D96.60500@xenomai.org>	<20140704092736.GC13487@lukather>	<53B7B3BF.3090807@xenomai.org>	<20140707160239.GF13423@lukather>	<53BAC5C4.5060704@xenomai.org>	<20140708125505.GN13423@lukather>	<53BC2AB5.4050801@xenomai.org>	<20140710150540.GE27469@lukather>
 <20140710172702.5ba6511c@free-electrons.com>
In-Reply-To: <20140710172702.5ba6511c@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] AT91: SAMA5D3: Adapt Ipipe for AIC5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thomas Petazzoni <thomas@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org

On 07/10/2014 05:27 PM, Thomas Petazzoni wrote:
> Gilles, Maxime,
> 
> On Thu, 10 Jul 2014 17:05:40 +0200, Maxime Ripard wrote:
> 
>>> As a general rule, we prefer Xenomai users to use the latency test,
>>> because this is the one we collectively spent time debugging, so it
>>> has more chances to be correct, and if you find a bug, everyone
>>> benefits from the fix.
>>
>> Yes, I don't doubt that latency is much more tested and reliable.
>>
>> The thing is, as you probably know, we're also a training company, and
>> we're using this script in our training to give an idea of the latency
>> on a regular linux kernel, and then on xenomai. It also have the
>> benefit of being simple enough for the trainees to be able to
>> understand it rather quickly.
>>
>> I don't think latency fits both these criterias, that are quite
>> essential for us. But if you have any better solution that might,
>> we're definitely open to suggestions :)
> 
> I should also add that we have been using rttest.c successfully since
> quite some time, including against the mainline kernel, PREEMPT_RT
> patched kernel, and Xenomai 2.6.2.1 running on a 3.5 kernel on an OMAP3
> based platform. Each time with good results.

You were simply lucky that the tested platforms were correctly
calibrated and you did not experience negative latencies. Have you
calibrated correctly the sama5 board timer?

-- 
                                                                Gilles.

