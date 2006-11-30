Message-ID: <456EE120.5060003@domain.hid>
Date: Thu, 30 Nov 2006 14:48:16 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] measuring context switch primary<->secondary mode
References: <456D5075.1060905@domain.hid>
	<200611301119.01173.schwab@domain.hid>
In-Reply-To: <200611301119.01173.schwab@domain.hid>
Content-Type: multipart/mixed; boundary="------------080601060802090508070506"
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ulrich Schwab <schwab@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080601060802090508070506
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ulrich Schwab wrote:
> I think that CONFIG_PREEMPT should reduce the jitter of Your measurement, most 
> importantly the worst case switch time, for wich You need a long test run 
> under heavy load.
> CONFIG_PREEMPT is there to provide more determinism, which usually has a price 
> in performance.
> Realtime is about determinism not performance (or speed).
> Its not maximum speed but guaranteed minimum speed.

You are absolutely right. I put my system under some load (dd) and made
two tests. One was with CONFIG_PREEMPT and one without. The worst case
switch time jitter was about 30% lower in the CONFIG_PREEMPT case, so
your prediction was right.

> Since the probability of a preemption during the mode switch without 
> CONFIG_PREEMPT is lower, it might take a long time until the worst case mode 
> switch time is observed.

Sorry but I don't understand what you are meaning. Let me explain my
point of view. When a realtime task in the Xenomai-Domain makes a
linux-systemcall the task is migrated fully automatically to the
Linux-Domain as soon as we reach the next preemption point in the
Linux-Kernel. Due to the fact that preemptability of the linux-kernel
increase when using CONFIG_PREEMPT, the time to the next preemption
point should decrease, right? I don't get the point of your last sentence.

Thanks for help,
Markus Franke


-- 
Nichts ist so praktisch wie eine gute Theorie!

--------------080601060802090508070506
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

YmVnaW46dmNhcmQNCmZuOk1hcmt1cyBGcmFua2UNCm46RnJhbmtlO01hcmt1cw0KYWRyO3F1
b3RlZC1wcmludGFibGU6OztWZXR0ZXJzc3RyYT1DMz05RmUgNjQvNzIyO0NoZW1uaXR6O1Nh
eG9ueTswOTEyNjtHZXJtYW55DQplbWFpbDtpbnRlcm5ldDpNYXJrdXMuRnJhbmtlQGluZm9y
bWF0aWsudHUtY2hlbW5pdHouZGUNCngtbW96aWxsYS1odG1sOkZBTFNFDQp1cmw6aHR0cDov
L3d3dy50dS1jaGVtbml0ei5kZS9+ZnJhbm0NCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K

--------------080601060802090508070506--

