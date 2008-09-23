Message-ID: <48D8A7EC.7000502@domain.hid>
Date: Tue, 23 Sep 2008 10:25:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD38398@domain.hid>
	<1743f3b40809230122u177e9aaeyb0cbc53f81793929@domain.hid>
In-Reply-To: <1743f3b40809230122u177e9aaeyb0cbc53f81793929@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt latency questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antonio Del Cinque <adelcinque@domain.hid>
Cc: xenomai@xenomai.org

Antonio Del Cinque wrote:
> Thank you,
> I think your considerations are the right ones.
> 
> The DMA controller is not generating any interrupt, so I assume it is not
> actually working. I'm trying to verify that the jitter is caused by
> cache/TLB misses. I don't have much reference on how to lock the cache, so
> I'll just try to have the cache dirty in any other way to see if it causes
> the same jitter.

A good way to do this is to use the cache calibrator:
http://homepages.cwi.nl/~manegold/Calibrator/

-- 
                                                 Gilles.

