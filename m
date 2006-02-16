Date: Thu, 16 Feb 2006 11:48:31 -0800
Subject: Re: [Xenomai-help] no-brainer realtime issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C01A170F.241B%steve@domain.hid>
In-Reply-To: <43F4D077.10003@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> Which framebuffer support did you select at kernel level?
> 
> What is the output of testsuite/latency while using the VT console?
> 

I'm using the gx1fb framebuffer for the geode. However, since this problem
occurs even when the VT outputting the text is not active, I don't think
it's fb related.

The latency output is just a bunch of numbers. :P

Here is some output with the latency -p 500 command, and halfway through it
I put a 100% load on the cpu.


== Sampling period: 500 us
== Test mode: periodic user-mode task
warming up...
RTT|  00:00:01  (periodic user-mode task, 500 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|    -2327277|    -1766041|    -1196976|       0|    -2327277|
-1196976
RTD|    -3443424|    -2882532|    -2293218|       0|    -3443424|
-1196976
RTD|    -4558603|     3176566|    -3412343|       0|    -4558603|
-1196976
RTD|    -5663780|     2061495|    -4522950|       0|    -5663780|
-1196976
RTD|    -6764019|      976449|    -5637527|       0|    -6764019|
-1196976
RTD|    -7885937|     -137963|    -6750223|       0|    -7885937|
-1196976
RTD|    -8993661|    -1254331|    -7868111|       0|    -8993661|
-1196976
RTD|   -10141655|    -2395933|    -8979941|       0|   -10141655|
-1196976
---|------------|------------|------------|--------|------------------------
-
RTS|   -10141655|     -277784|    -1196976|       0|    00:00:08/00:00:08


