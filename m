Message-ID: <4ADC5A77.1060708@domain.hid>
Date: Mon, 19 Oct 2009 14:24:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580910190417p67796a2k8d9db0253bd59033@domain.hid>
In-Reply-To: <1f3e02580910190417p67796a2k8d9db0253bd59033@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Tests (WHAT and HOW)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org, mohamad.sharifi@domain.hid

Didenko Sergey wrote:
> Dear Xenomai Experts
> 
> We have ported Xenomai to the ARM Platform.

To be more accurate, Xenomai was ported to the ARM Platform long ago by
Stelian Pop, the thing that you could claim is that you ported Xenomai
to your platform, but as far as I understood, Philippe did that job.

> To make sure that we have ported Linux + Xenomai correctly, we are
> running the tests from the testsuite the Xenomai has.
> clocktest
> cyclick
> latency
> 
> Do you have any documentation or explanation of WHAT and HOW these tests
> are actually testing?

No.

clocktest tests how much the Xenomai clock is drifting from Linux clock.

cyclictest and latency are both measuring latencies. cyclictest and
latency with no argument are measuring the user-space scheduling
latency, latency -T 1 is measuring the kernel-space scheduling latency,
and latency -T 2 is measuring the (kernel-space) interrupt latency. In
order to get meaningful results with these tests, you should apply some
load to the system, and let the test run a few hours.

There is also the klatency test, which measures the kernel-space
latencies without any user-space thread running (it makes a difference
on ARM).

There is also the "switchtest" test, which indicates whether context
switches are running correctly.

-- 
                                          Gilles


