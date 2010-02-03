Message-ID: <4B69C169.6070203@domain.hid>
Date: Wed, 03 Feb 2010 19:33:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <bcc5a9cc1001220555k2b75490r332f8f73ae425ffd@domain.hid>
In-Reply-To: <bcc5a9cc1001220555k2b75490r332f8f73ae425ffd@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Latency test results
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jaryn Sepesi <jaryn.sepesi@domain.hid>
Cc: xenomai@xenomai.org

Jaryn Sepesi wrote:
> Hi guys!
> 
> I've just managed to get Xenomai up and running. I've performed two latency
> tests. The first one - just ran xeno-test and the second one - running
> latency test while compiling two kernels at the same time (using "make -j 8"
> so 8 compiling threads per kernel). Both tests gave similar results - the
> worst latency of aprox. 25 us (user-space task, period 100 us).
> 
> I'd like to ask you, whether is here anyone to tell me, if this result
> matches my hardaware:
> 
> cpu: Intel Core2 Quad CPU   Q9400  @ 2.66GHz
> mem: 2GiB
> chipset: Intel ICH10
> 
> The rest is in attached lshw output - if somebody is interested :)

Well, it looks a bit high, but then it is an SMP system. Do you have
some messages about SMI in the logs?

-- 
					    Gilles.

