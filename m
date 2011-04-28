Message-ID: <4DB96DB1.3010907@domain.hid>
Date: Thu, 28 Apr 2011 19:37:53 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
In-Reply-To: <4DB94C9C.7080904@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

On 04/28/2011 05:16 PM, Gilles Chanteperdrix wrote:
> Ok. Better try without this patch first, then try reapplying the patch
> when you are certain that everything else works correctly. The patch
> enables some assembly code that was never actually tested. On my side, I
> will try and test it separately.
>
I just got a couple of stack traces via JTAG (just stopped and restarted
the "hanging" processor multiple times and doing backtrace). It runs all
the time somewhere inside __ipipe_handle_irq or __ipipe_grab_irq():

#0  0xc00281b8 in __gnu_mcount_nc ()
#1  0xc002f7ec in __ipipe_handle_irq ()
#2  0xc002fb40 in __ipipe_grab_irq ()
#3  0xc0027b8c in __irq_svc ()
#4  0xc0027b8c in __irq_svc ()
#5  0xc0027b8c in __irq_svc ()
(a lot of __irq_svc() follows)

#0  0xc0092ba4 in __ipipe_trace ()
#1  0xc00937d4 in ipipe_trace_begin ()
#2  0xc002fb34 in __ipipe_grab_irq ()
#3  0xc0027b8c in __irq_svc ()
#4  0xc0027b8c in __irq_svc ()
(etc)

#0  0xc002fae0 in __ipipe_grab_irq ()
#1  0xc0027b8c in __irq_svc ()
#2  0xc0027b8c in __irq_svc ()
(etc)

#0  0xc0092948 in __ipipe_trace ()
#1  0xc0093448 in ipipe_trace_function ()
#2  0xc0094a90 in ftrace_test_stop_func ()
#3  0xc00281ec in gnu_trace ()
#4  0xc00281ec in gnu_trace ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

and so on. Hope that helps.

