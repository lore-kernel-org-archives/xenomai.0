Message-ID: <4DB3479B.20609@domain.hid>
Date: Sat, 23 Apr 2011 23:41:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTim3Z6v5Jr+O8197WZZAOpHsPwjwPA@mail.gmail.com>
In-Reply-To: <BANLkTim3Z6v5Jr+O8197WZZAOpHsPwjwPA@mail.gmail.com>
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
> Hello, I've asked a lot of questions here and gotten very prompt and helpful
> responses, so I summarized them in a FAQ since I figure others may have
> similar questions.  See http://ericrebates.zzl.org/xen_faq.txt .  If this
> seems useful maybe someone can append them to the end of the wiki FAQ.

I am not sure all questions really are really that frequent, but yes, we
should add some to the FAQ. Would you be willing to do it? If yes, I
will give you write access to the wiki.

> 
> On another note, I have been comparing Xenomai's context switch latency to
> GHS Integrity.  I found that on average Xenomai seems to take three times as
> long to context switch versus Integrity (12uS vs. 4uS) running almost
> identical test code.  Does anyone know why this may be or how to reduce this
> latency in Xenomai?  Since it appears Gilles helped implement the fast
> context switching extension for the Linux kernel, I'm assuming Xenomai is
> also taking advantage of this extension.

I assume you are measuring context switch times in kernel-space, then
FCSE will not help you, FCSE helps for MMU context switches. And if you
are testing on omap3, FCSE is not implemented for omap3. Do you have
unlocked context switch enabled ?
What I-pipe patch version are you using?

You can probably reduce a bit the time by using rt_timer_tsc() or even
xnarch_get_cpu_tsc() to do the measurements, then rt_timer_tsc2ns after
the second measurement, but I am afraid you will not go as low as 4us.
You can also try and enable the I-pipe tracer to see where the time is
spent, but beware of the time dilation...

-- 
                                                                Gilles.

