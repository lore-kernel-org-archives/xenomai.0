Message-ID: <4DB85C18.5020802@domain.hid>
Date: Wed, 27 Apr 2011 20:10:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid>	<4DB83CBE.5040007@domain.hid>
	<BANLkTikmzwturTQNB20eiaOkEYdhEnBmyw@domain.hid>
In-Reply-To: <BANLkTikmzwturTQNB20eiaOkEYdhEnBmyw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Alexey Galakhov <agalakhov@domain.hid>
Cc: adeos-main@gna.org

Alexey Galakhov wrote:
>> There was a bug some time ago, which was fixed for TIMER3, see commit:
>>
>> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=ebf2fac4298e25509ba47942b9fad408dcefce1e
>>
> 
> Oh, I know about this bug. That's the first thing I checked. I found that it
> is already fixed in my case. However, it is still unclear for me where the
> correct MUXes for timer4 and timer3 are initialized, seems to be kind of
> magic. I didn't checked TCFGs against the datasheet, going to do it now. I
> also think about making the free-running timer selectable from config since
> some machines may have something wired to timer3's PWM.
> 
> I forgot to say, it works with patched kernel if CONFIG_IPIPE=no. Timers are
> the same in both cases. I don't quite understand, however, how the
> non-working free-running timer may affect the system in that case.
> Interrupts from timer4 are still generated, so the system may boot with
> ipipe off even with broken free-running timer without any obvious problems,
> am I right?

I have absolutely no idea. Fabian Godehart sent the patch, saying that
it fixed an issue, I merged it. That is all.


-- 
                                                                Gilles.

