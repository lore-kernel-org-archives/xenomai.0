Message-ID: <4B8D2166.7080704@domain.hid>
Date: Tue, 02 Mar 2010 15:32:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201003021527.30130.sinisa.denic@domain.hid>
In-Reply-To: <201003021527.30130.sinisa.denic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM cached,non-cached memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sinisa Denic <sinisa.denic@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Sinisa Denic wrote:
> Hi, last year working with xenomai 2.4.2-3 we met problem (BUG) with memory 
> caching on ARM AT91sam9260 arch. 
> Then we were advised using non-cached memory and we've used it till now,but in 
> our next application it has big performace slow down effect and I'm 
> interested is this BUG solved in latest 2.4.10 - xenomai 
> Regards,Sinisa

No, this is not a BUG in Xenomai. It is an architectural BUG^H^Hehaviour
of ARMv5, they have a VIVT cache, which is the cause of these issues.
Alternatively to using non-cached memory, you can use cached memory, and
flush cache when needed. Beware however defining "when needed", may be
complicated.

A note: Xenomai 2.4.10 is not the latest, the latest is Xenomai 2.5.1
and it has a lot of performance improvements for ARM.

-- 
					    Gilles.

