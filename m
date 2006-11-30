Message-ID: <456EE5BA.8080106@domain.hid>
Date: Thu, 30 Nov 2006 15:07:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] Fix ipipe_tsc2ns for ARM
References: <E1GpRBe-0001FR-Mq@domain.hid> <456DC2F5.5020005@domain.hid>
	<E1GpiKm-0003ul-LY@mailer.emlix.com>
In-Reply-To: <E1GpiKm-0003ul-LY@mailer.emlix.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

Sebastian Smolorz wrote:
> Ok, see my attached patch. But can we assume in all cases that ipipe_tsc2ns is 
> used with a value smaller than a long long variable? The only usage of this 
> macro so far is in __ipipe_print_delay() which calls it with a substraction 
> of two unsigned long long variables.

The patch using do_div also assumes that t * 1000 will never overflow 64
bits. But I agree, it is less restrictive.

>>What value is a 64 bits when it fails, 
>>__ipipe_mach_ticks_per_jiffy or t ?
> 
> 
> Sorry, I'm not really sure what you mean here.

Forget it, I got the answer, it is t that is a 64 bits value.

-- 
                                                 Gilles Chanteperdrix

