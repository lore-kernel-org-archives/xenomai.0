From: Sinisa Denic <sinisa.denic@domain.hid>
Date: Tue, 2 Mar 2010 16:31:31 +0100
References: <201003021527.30130.sinisa.denic@domain.hid>
	<4B8D2166.7080704@domain.hid>
In-Reply-To: <4B8D2166.7080704@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201003021631.32165.sinisa.denic@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org.

On Tuesday 02 March 2010 15:32:06 you wrote:
> Sinisa Denic wrote:
> > Hi, last year working with xenomai 2.4.2-3 we met problem (BUG) with
> > memory caching on ARM AT91sam9260 arch.
> > Then we were advised using non-cached memory and we've used it till
> > now,but in our next application it has big performace slow down effect
> > and I'm interested is this BUG solved in latest 2.4.10 - xenomai
> > Regards,Sinisa
>
> No, this is not a BUG in Xenomai. It is an architectural BUG^H^Hehaviour
> of ARMv5, they have a VIVT cache, which is the cause of these issues.
> Alternatively to using non-cached memory, you can use cached memory, and
> flush cache when needed. Beware however defining "when needed", may be
> complicated.
>
> A note: Xenomai 2.4.10 is not the latest, the latest is Xenomai 2.5.1
> and it has a lot of performance improvements for ARM.

Ok,sorry for my mistake I thought it is due to the xenomai.
Of course we know new xeno 2.5.1 and all about ARM improvements, 
but we are afraid of switching to new kernel(current 2.6.21) and thus to new 
xenomai, because we have short time to deliver product and thus to well test 
all new components. 
Apart from memory caching 2.4 works well for us.
We work on critical relay protection device and new potential bug isn't  
desirable at all.
I hope that xenomai 2.5.1 is heavily tested and stable for ARM arch,despite of 
some problems on the mailing list eg. native skin etc.
Al in all thank you very much we hope to see you in Belgrade soon.
Sinisa

