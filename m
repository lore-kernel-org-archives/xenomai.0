Message-ID: <4F4FBC3C.3070600@domain.hid>
Date: Thu, 01 Mar 2012 19:13:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F3146AA.5070902@domain.hid> <4F41144E.1020004@domain.hid>
	<4F4FB9F3.8030806@domain.hid>
In-Reply-To: <4F4FB9F3.8030806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] high duration of __ipipe_handle_irq
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 03/01/2012 07:03 PM, Roberto Bielli wrote:
> Hi,
> 
> i have this problem with xenomai ( 2.5.6 - arm freescale imx25 ):
> 
> I have a xenomai application that uses more rt_tasks, and i have a 
> strange behaviour.
> When i run my application the period of *__ipipe_handle_irq* is very 
> long ( ~3ms in some cases ) in the moment
> that come the *__ipipe_mach_timerint *interrupt and so the other 
> interrupts are very late.
> 
> Do you know something about this ?

I am sorry, but I do not understand your mail. __ipiep_handle_irq is not
periodic and this sentence:

When i run my application the period of *__ipipe_handle_irq* is very
long ( ~3ms in some cases ) in the moment
that come the *__ipipe_mach_timerint *interrupt and so the other

is not understandable.

Please try to describe your problem more clearly, or better, use the
I-pipe tracer and record a trace of the problem, and post the relevant
part of the trace here.

-- 
					    Gilles.

