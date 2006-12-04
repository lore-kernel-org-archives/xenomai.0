From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] [PATCH] Fix ipipe_tsc2ns for ARM
Date: Mon, 4 Dec 2006 11:29:48 +0100
References: <E1GpRBe-0001FR-Mq@domain.hid>
	<E1GpiKm-0003ul-LY@mailer.emlix.com> <456EE5BA.8080106@domain.hid>
In-Reply-To: <456EE5BA.8080106@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1GrB4y-0006gX-JS@mailer.emlix.com>
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

Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
> > Ok, see my attached patch. But can we assume in all cases that
> > ipipe_tsc2ns is used with a value smaller than a long long variable? The
> > only usage of this macro so far is in __ipipe_print_delay() which calls
> > it with a substraction of two unsigned long long variables.
>
> The patch using do_div also assumes that t * 1000 will never overflow 64
> bits. But I agree, it is less restrictive.
>
> >>What value is a 64 bits when it fails,
> >>__ipipe_mach_ticks_per_jiffy or t ?
> >
> > Sorry, I'm not really sure what you mean here.
>
> Forget it, I got the answer, it is t that is a 64 bits value.

So which patch are you going to check in?

--
Sebastian

