Message-ID: <4C777B3C.7090203@domain.hid>
Date: Fri, 27 Aug 2010 10:45:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>	<4C6BD747.1090304@domain.hid>	<AANLkTimiofme9duMMyiqe3snHmGxWFxGf7AJDaaAGE6b@domain.hid>	<AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>	<4C6D4BDE.1050605@domain.hid>	<AANLkTi=-7yEyDLn1tBmzkxMK+=Tr4F-7XNGdtzoespod@domain.hid>	<4C7260B4.4070100@domain.hid>	<4C726911.6050201@domain.hid>	<AANLkTik4KoHd9ni1DYuUej01uh8c7X8Tb0vgqf8ou93=@mail.gmail.com>	<4C72749A.5000506@domain.hid>	<AANLkTinAp-kyQ9DLqhaMoc9nML7PF4yOmYDXF2850d5G@mail.gmail.com>	<AANLkTin5X6wk2L2Kuk7c4EeiDo2_bk3nZspq0QJovv_L@mail.gmail.com>	<AANLkTik9uyyJdPOA8uHn0pD52MqKKt1Az-i5zyuMpvQX@mail.gmail.com>	<4C765EF8.50500@domain.hid>
	<AANLkTinWX2q41qgKgPGbYKiaTQ3rNYZCHA+E=UFT9fFh@domain.hid>
In-Reply-To: <AANLkTinWX2q41qgKgPGbYKiaTQ3rNYZCHA+E=UFT9fFh@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel compilation problem with a Cortex A8,
 AM3517 EVM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marc doz <doz.marc@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

marc doz wrote:
> Hi,
> Your script runs since yesterday.
> I don't see "Listening on any address 5566"
> 

Ah. Could you send me your mkrootfs configuration file (should be named
.config at the top of your build tree).

> with latency test :
> RTT|  16:17:55  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|     14.230|     15.307|     27.307|       0|     0|      3.692|     58.538
> To day, I will learn to understand latency logs

The lat min, lat avg, lat max are the minimum, average and maximum
latencies on one second, overruns and msw should be zero if everything
is fine, lat best and lat worst are the best case and worst case
latencies for the whole run-time of the program.


-- 
					    Gilles.


