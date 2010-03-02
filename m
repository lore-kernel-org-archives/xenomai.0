Message-ID: <4B8D5C2F.6060005@domain.hid>
Date: Tue, 02 Mar 2010 19:42:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201003021527.30130.sinisa.denic@domain.hid>
	<4B8D2166.7080704@domain.hid>
	<201003021631.32165.sinisa.denic@domain.hid>
In-Reply-To: <201003021631.32165.sinisa.denic@domain.hid>
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
> On Tuesday 02 March 2010 15:32:06 you wrote:
>> Sinisa Denic wrote:
>>> Hi, last year working with xenomai 2.4.2-3 we met problem (BUG) with
>>> memory caching on ARM AT91sam9260 arch.
>>> Then we were advised using non-cached memory and we've used it till
>>> now,but in our next application it has big performace slow down effect
>>> and I'm interested is this BUG solved in latest 2.4.10 - xenomai
>>> Regards,Sinisa
>> No, this is not a BUG in Xenomai. It is an architectural BUG^H^Hehaviour
>> of ARMv5, they have a VIVT cache, which is the cause of these issues.
>> Alternatively to using non-cached memory, you can use cached memory, and
>> flush cache when needed. Beware however defining "when needed", may be
>> complicated.
>>
>> A note: Xenomai 2.4.10 is not the latest, the latest is Xenomai 2.5.1
>> and it has a lot of performance improvements for ARM.
> 
> Ok,sorry for my mistake I thought it is due to the xenomai.
> Of course we know new xeno 2.5.1 and all about ARM improvements, 
> but we are afraid of switching to new kernel(current 2.6.21) and thus to new 
> xenomai, because we have short time to deliver product and thus to well test 
> all new components. 
> Apart from memory caching 2.4 works well for us.

Ok. Understood.


> We work on critical relay protection device and new potential bug isn't  
> desirable at all.
> I hope that xenomai 2.5.1 is heavily tested and stable for ARM arch,despite of 
> some problems on the mailing list eg. native skin etc.

There is no such thing as bug-free software, as you probably know, but
we do our best to have the best stability possible. We have recently
fixed Xenomai for running on AT91SAM9263, and got good results over a
long testing period, the hardware support looks stable. The issue we
have such as with the native API are plain deterministic stupid bugs,
nothing which has any influence on stability.

> Al in all thank you very much we hope to see you in Belgrade soon.
> Sinisa

That could be arranged :-)

-- 
					    Gilles.

