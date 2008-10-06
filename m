Message-ID: <1743f3b40810060744v7d55f706m62b46a1e27498524@domain.hid>
Date: Mon, 6 Oct 2008 16:44:39 +0200
From: "Antonio Del Cinque" <adelcinque@domain.hid>
In-Reply-To: <48D8A7EC.7000502@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_59792_28338549.1223304279062"
References: <0B45E93C5FF65740AEAE690BF3848B7AD38398@domain.hid>
	<1743f3b40809230122u177e9aaeyb0cbc53f81793929@domain.hid>
	<48D8A7EC.7000502@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_59792_28338549.1223304279062
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
sorry, I needed time to implement your suggestions, but finally I got some
results. I checked for cache related issues, and found that latency is
highly related to cache misses.

I found the way to disable the instruction cache (the e300 powerpc core has
a 32 KB i-cache and a 32 KB d-cache, but I couldn't disable the d-cache
because of segmentation faults), and I changed the test to measure interrupt
latency.

Now I have a Xenomai real time task. The task is periodic (I used
rt_task_set_periodic() and rt_task_wait_period()) and, at every period, it
toggles a GPIO pin configured as an output, by calling the GPIO rtdm driver
ioctl command. The pin is short circuited with another pin which is
configured as an input, generating an interrupt in the powerpc. The
interrupt routine, registerd via rtdm_irq_request() in the same GPIO rtdm
driver, toggles another GPIO pin configured as an output, so I see the two
IO pins on the oscilloscope, the first generating the interrupt, and the
second indicating that the interrupt routine has been executed.

When the cache is enabled I see a latency between 2 and 5 uS with no load,
but if I create a non real time load the latency raises (for example to 12
uS with the cache calibrator running), and this is non deterministic, since
it dependes on the cache use.

When I disable the i-cache the latency goes to 16 uS with no load, this is
11 to 14 uS over latency! Non real time task now only sligthly affect the
latency, but I have the following problem: if I start real time tasks (for
example I run /usr/local/xenomai/share/xenomai/testsuite/cyclic/run) the
GPIO interrupt latency is not commonly affected, but occasionally it gets to
50 uS. I can't explain this. Could you help me?

The delay is not continuos, it jumps from 16-20 to 38-50 uS. Now the i-cache
is disabled, so it seems another interrupt routine, running in Xenomai
domain, gets interleaved with the GPIO interrupt rountine.

Is there any way to track these kind of latency in the ipipe, a kind of
worst latency case tracker? I see only "virtual" IRQs 512 and 515 running in
Xenomai domain. I cannot see where they are set up. I guess one of them is
the system timer, and I know this is commonly driven by the powerpc
decrementer. Is the GPIO interrupt latency due to the system timer
interrupt? If this is the case, where can I disable the system timer in
Xenomai, or modify the interrupt routine? I must run in interrupt context
because of latency requirements (they asked me for deterministic latencies
under 20 uS).

Thank you, very much
Antonio





On Tue, Sep 23, 2008 at 10:25 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Antonio Del Cinque wrote:
> > Thank you,
> > I think your considerations are the right ones.
> >
> > The DMA controller is not generating any interrupt, so I assume it is not
> > actually working. I'm trying to verify that the jitter is caused by
> > cache/TLB misses. I don't have much reference on how to lock the cache,
> so
> > I'll just try to have the cache dirty in any other way to see if it
> causes
> > the same jitter.
>
> A good way to do this is to use the cache calibrator:
> http://homepages.cwi.nl/~manegold/Calibrator/<http://homepages.cwi.nl/%7Emanegold/Calibrator/>
>
> --
>                                                  Gilles.
>

------=_Part_59792_28338549.1223304279062
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi,<br>sorry, I needed time to implement your suggestions, but finally I got some results. I checked for cache related issues, and found that latency is highly related to cache misses.<br><br>I found the way to disable the instruction cache (the e300 powerpc core has a 32 KB i-cache and a 32 KB d-cache, but I couldn&#39;t disable the d-cache because of segmentation faults), and I changed the test to measure interrupt latency.<br>
<br>Now I have a Xenomai real time task. The task is periodic (I used rt_task_set_periodic() and rt_task_wait_period()) and, at every period, it toggles a GPIO pin configured as an output, by calling the GPIO rtdm driver ioctl command. The pin is short circuited with another pin which is configured as an input, generating an interrupt in the powerpc. The interrupt routine, registerd via rtdm_irq_request() in the same GPIO rtdm driver, toggles another GPIO pin configured as an output, so I see the two IO pins on the oscilloscope, the first generating the interrupt, and the second indicating that the interrupt routine has been executed.<br>
<br>When the cache is enabled I see a latency between 2 and 5 uS with no load, but if I create a non real time load the latency raises (for example to 12 uS with the cache calibrator running), and this is non deterministic, since it dependes on the cache use.<br>
<br>When I disable the i-cache the latency goes to 16 uS with no load, this is 11 to 14 uS over latency! Non real time task now only sligthly affect the latency, but I have the following problem: if I start real time tasks (for example I run /usr/local/xenomai/share/xenomai/testsuite/cyclic/run) the GPIO interrupt latency is not commonly affected, but occasionally it gets to 50 uS. I can&#39;t explain this. Could you help me?<br>
<br>The delay is not continuos, it jumps from 16-20 to 38-50 uS. Now the i-cache is disabled, so it seems another interrupt routine, running in Xenomai domain, gets interleaved with the GPIO interrupt rountine. <br><br>Is there any way to track these kind of latency in the ipipe, a kind of worst latency case tracker? I see only &quot;virtual&quot; IRQs 512 and 515 running in Xenomai domain. I cannot see where they are set up. I guess one of them is the system timer, and I know this is commonly driven by the powerpc decrementer. Is the GPIO interrupt latency due to the system timer interrupt? If this is the case, where can I disable the system timer in Xenomai, or modify the interrupt routine? I must run in interrupt context because of latency requirements (they asked me for deterministic latencies under 20 uS).<br>
<br>Thank you, very much<br>Antonio<br><br><br><br><br><br><div class="gmail_quote">On Tue, Sep 23, 2008 at 10:25 AM, Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d">Antonio Del Cinque wrote:<br>
&gt; Thank you,<br>
&gt; I think your considerations are the right ones.<br>
&gt;<br>
&gt; The DMA controller is not generating any interrupt, so I assume it is not<br>
&gt; actually working. I&#39;m trying to verify that the jitter is caused by<br>
&gt; cache/TLB misses. I don&#39;t have much reference on how to lock the cache, so<br>
&gt; I&#39;ll just try to have the cache dirty in any other way to see if it causes<br>
&gt; the same jitter.<br>
<br>
</div>A good way to do this is to use the cache calibrator:<br>
<a href="http://homepages.cwi.nl/%7Emanegold/Calibrator/" target="_blank">http://homepages.cwi.nl/~manegold/Calibrator/</a><br>
<br>
--<br>
<font color="#888888"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.<br>
</font></blockquote></div><br></div>

------=_Part_59792_28338549.1223304279062--

