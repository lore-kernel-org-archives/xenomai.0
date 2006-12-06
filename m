Subject: Re: [Adeos-main] [PATCH] Fix ipipe_tsc2ns for ARM
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45740364.4060404@domain.hid>
References: <E1GpRBe-0001FR-Mq@domain.hid>
	<E1GpiKm-0003ul-LY@mailer.emlix.com> <456EE5BA.8080106@domain.hid>
	<E1GrB4y-0006gX-JS@mailer.emlix.com>  <45740364.4060404@domain.hid>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 12:57:37 +0100
Message-Id: <1165406258.7218.116.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

On Mon, 2006-12-04 at 12:15 +0100, Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
> > Gilles Chanteperdrix wrote:
> > 
> >>Sebastian Smolorz wrote:
> >>
> >>>Ok, see my attached patch. But can we assume in all cases that
> >>>ipipe_tsc2ns is used with a value smaller than a long long variable? The
> >>>only usage of this macro so far is in __ipipe_print_delay() which calls
> >>>it with a substraction of two unsigned long long variables.
> >>
> >>The patch using do_div also assumes that t * 1000 will never overflow 64
> >>bits. But I agree, it is less restrictive.
> >>
> >>
> >>>>What value is a 64 bits when it fails,
> >>>>__ipipe_mach_ticks_per_jiffy or t ?
> >>>
> >>>Sorry, I'm not really sure what you mean here.
> >>
> >>Forget it, I got the answer, it is t that is a 64 bits value.
> > 
> > 
> > So which patch are you going to check in?
> 
> I have no preference, maybe Philippe has one ?
> 

It's a detail, but ipipe_tsc2ns() was once designed as a helper for
implementing the now defunct I-pipe stats support, which has been
replaced by the tracer. The values (time delta between -normally- short
events) were guaranteed to be small enough to fit in 32bits, so other
ports just cast the input data within the macro. No other I-pipe code
should rely on better precision.

This said, in this case, my preferred option is the one of the Adeos
maintainer for ARM, who is... oh, yeah! you are. So, I hereby agree with
the choice you are going to make next.

-- 
Philippe.



