Message-ID: <4DB594A6.9080603@domain.hid>
Date: Mon, 25 Apr 2011 17:35:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTim3Z6v5Jr+O8197WZZAOpHsPwjwPA@mail.gmail.com>	<4DB3479B.20609@domain.hid>
	<BANLkTik0RVY7wtUSekBT-x4t-4qCWrFawA@mail.gmail.com>
In-Reply-To: <BANLkTik0RVY7wtUSekBT-x4t-4qCWrFawA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] FAQ, context switch latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

Eric Eric wrote:
> On Sat, Apr 23, 2011 at 5:41 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> Eric Eric wrote:
>>> Hello, I've asked a lot of questions here and gotten very prompt and
>> helpful
>>> responses, so I summarized them in a FAQ since I figure others may have
>>> similar questions.  See http://ericrebates.zzl.org/xen_faq.txt .  If
>> this
>>> seems useful maybe someone can append them to the end of the wiki FAQ.
>> I am not sure all questions really are really that frequent, but yes, we
>> should add some to the FAQ. Would you be willing to do it? If yes, I
>> will give you write access to the wiki.
>>
> 
> Sure.  Maybe the best approach is to create a link from the FAQ to an LFAQ
> (less frequently asked questions) so as not to add a bunch of questions that
> don't apply to most people.
> 
> 
>>> On another note, I have been comparing Xenomai's context switch latency
>> to
>>> GHS Integrity.  I found that on average Xenomai seems to take three times
>> as
>>> long to context switch versus Integrity (12uS vs. 4uS) running almost
>>> identical test code.  Does anyone know why this may be or how to reduce
>> this
>>> latency in Xenomai?  Since it appears Gilles helped implement the fast
>>> context switching extension for the Linux kernel, I'm assuming Xenomai is
>>> also taking advantage of this extension.
>> I assume you are measuring context switch times in kernel-space, then
>> FCSE will not help you, FCSE helps for MMU context switches.
> 
> 
> Right, didn't think about that.  I suppose FCSE will also not help with
> context switches between threads of the same process either.
> 
> 
>> And if you
>> are testing on omap3, FCSE is not implemented for omap3. Do you have
>> unlocked context switch enabled ?
>>
> 
> Unlocked context switch is enabled.

Disabling it will reduce the context switch time.

> 
> 
>> What I-pipe patch version are you using?
>>
> 
> 2.6.33-arm-1.18-00

There was no big changes for omap, but you should use the latest (1.18-02).

> 
> 
>> You can probably reduce a bit the time by using rt_timer_tsc() or even
>> xnarch_get_cpu_tsc() to do the measurements, then rt_timer_tsc2ns after
>> the second measurement, but I am afraid you will not go as low as 4us.
>>
> 
> I will try this although I doubt it will have much impact.  I say that
> because I also used rtdm_clock_read_monotonic to benchmark mutex lock/unlock
> cycles, and got down to 2uS in that measurement, which seems to imply that
> the overhead of rtdm_clock_read_monotonic is small compared to 12uS.

Well, I would not call 2us small compared to 12us. But yes 12 - 2 is
still far from 4us.

> 
> 
>> You can also try and enable the I-pipe tracer to see where the time is
>> spent, but beware of the time dilation...
>>
> 
> This seems like an interesting idea.  What is the time dilation issue?

The tracer introduces a sizeable overhead especially on ARM.

-- 
                                                                Gilles.

