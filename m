From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Adeos-main] [PATCH] Fix ipipe_tsc2ns for ARM
Date: Thu, 30 Nov 2006 10:35:59 +0100
References: <E1GpRBe-0001FR-Mq@domain.hid> <456DC2F5.5020005@domain.hid>
In-Reply-To: <456DC2F5.5020005@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AYqbFaNgCi95rsx"
Message-Id: <E1GpiKm-0003ul-LY@mailer.emlix.com>
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

--Boundary-00=_AYqbFaNgCi95rsx
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Gilles Chanteperdrix wrote:
> Sebastian Smolorz wrote:
> > Hi,
> >
> > the current implementation of ipipe_tsc2ns for ARM does not compile
> > (undefined reference to `__udivdi3'). The attached patch fixes that.
>
> the point of using ((t) * 1000) / (freq / 1000000) is to avoid using the
> 64 bits division. I would rather think a simple cast to unsigned is
> missing.

Ok, see my attached patch. But can we assume in all cases that ipipe_tsc2ns is 
used with a value smaller than a long long variable? The only usage of this 
macro so far is in __ipipe_print_delay() which calls it with a substraction 
of two unsigned long long variables.

> What value is a 64 bits when it fails, 
> __ipipe_mach_ticks_per_jiffy or t ?

Sorry, I'm not really sure what you mean here.

--
Sebastian

--Boundary-00=_AYqbFaNgCi95rsx
Content-Type: text/x-diff; charset="iso-8859-15"; name="ipipe-arm_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ipipe-arm_v2.patch"

--- ipipe/v2.6/common/include/asm-arm/ipipe.h	2006-11-12 20:33:33.000000000 +0100
+++ ipipe.work/v2.6/common/include/asm-arm/ipipe.h	2006-11-30 10:16:00.000000000 +0100
@@ -124,7 +124,7 @@ extern void __ipipe_mach_demux_irq(unsig
 #define __ipipe_read_timebase()		__ipipe_mach_get_tsc()
 
 #define ipipe_cpu_freq()	(HZ * __ipipe_mach_ticks_per_jiffy)
-#define ipipe_tsc2ns(t)		(((t) * 1000) / (ipipe_cpu_freq() / 1000000))
+#define ipipe_tsc2ns(t)		(((unsigned long)(t) * 1000) / (ipipe_cpu_freq() / 1000000))
 
 /* Private interface -- Internal use only */
 

--Boundary-00=_AYqbFaNgCi95rsx--

