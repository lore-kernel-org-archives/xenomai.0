Message-ID: <4D55AB6C.6090406@domain.hid>
Date: Fri, 11 Feb 2011 22:34:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikj+m-orgz_HgQ=-u4PLtS+eAXuMxLWbV6ZmR5m@domain.hid>
In-Reply-To: <AANLkTikj+m-orgz_HgQ=-u4PLtS+eAXuMxLWbV6ZmR5m@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Clocksource tsc unstable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> As soon as I start our Xenomai application we get a Linux kernel
> message "Clocksource tsc unstable (delta = 305181188 ns)", after which
> it switches to the pit clock.
> 
> Will this have impact on Xenomai threads running in relaxed mode?
> 
> Is this normal behavior? Is this because primary domain interrupted
> the Linux clocksource watchdog for 305 ms? Should we disable the Linux
> clocksource wathdog so it keeps using the tsc?

Yes this is bad. But what you should do is that your application should
never interrupt linux for more than a clock tick, so, typically 10ms or
1ms, and it will not happen.

-- 
                                                                Gilles.

