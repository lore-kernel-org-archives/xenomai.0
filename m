Message-ID: <4C765EF8.50500@domain.hid>
Date: Thu, 26 Aug 2010 14:32:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikjB1vF+0Ldnc_80_+TJeG2MKo5i42hE5Ah3nj9@domain.hid>	<4C6BD747.1090304@domain.hid>	<AANLkTimiofme9duMMyiqe3snHmGxWFxGf7AJDaaAGE6b@domain.hid>	<AANLkTinYt1Gj+Vsm1NXCXyDPa92KS+DMFVhpNcVvYjgw@domain.hid>	<4C6D4BDE.1050605@domain.hid>	<AANLkTi=-7yEyDLn1tBmzkxMK+=Tr4F-7XNGdtzoespod@domain.hid>	<4C7260B4.4070100@domain.hid>
	<4C726911.6050201@domain.hid>	<AANLkTik4KoHd9ni1DYuUej01uh8c7X8Tb0vgqf8ou93=@mail.gmail.com>	<4C72749A.5000506@domain.hid>	<AANLkTinAp-kyQ9DLqhaMoc9nML7PF4yOmYDXF2850d5G@mail.gmail.com>	<AANLkTin5X6wk2L2Kuk7c4EeiDo2_bk3nZspq0QJovv_L@mail.gmail.com>
	<AANLkTik9uyyJdPOA8uHn0pD52MqKKt1Az-i5zyuMpvQX@mail.gmail.com>
In-Reply-To: <AANLkTik9uyyJdPOA8uHn0pD52MqKKt1Az-i5zyuMpvQX@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel compilation problem with a Cortex A8,
 AM3517 EVM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: marc doz <doz.marc@domain.hid>
Cc: xenomai@xenomai.org

marc doz wrote:
> Actualy, I have got 2 versions :
> 1) TI SDK : OMAP35x-PSP-SDK-03.00.00.05 with a kernel 2.6.32 which
> comes from linux-omap-2.6.git with specific TI patch for EVM of AM3517
> 2) TI SDK : OMAP35x-PSP-SDK-03.00.00.02 with a kernel 2.6.31-rc7 which
> comes from linux-omap-2.6.git with specific TI patch for EVM of AM3517
> 
> I am testing solution 2 with software examples for native skin.
> 
> ./trivial-periodic
> Time since last turn: 1000.024230 ms
> Time since last turn: 999.991461 ms
> Time since last turn: 999.991999 ms
> Time since last turn: 999.999384 ms
> Time since last turn: 999.998538 ms
> Time since last turn: 1000.005999 ms
> Time since last turn: 999.993538 ms
> 
> ./rtprint
> This triggers auto-init of rt_print for the calling thread.
> A last switch to secondary mode can occure here, but future invocations of rt_pr
> 401f0470: #1 Yet another RT printer - but to stderr.
> 400221e0 Task 1: #1 Hello RT world!
> 401f0470: #2 Yet another RT printer - but to stderr.
> 401f0470: #3 Yet another RT printer - but to stderr.
> 
> What do you think about this test ?
> can you recommend me  some measure points  ?

You want to run the latency test. But the latency on a system without
load is meaningless. As part of validating Xenomai, we use a test called
"dohell" to load the system. We provide a system to build a root
filesystem for running these tests called mkrootfs, available through git:
http://git.xenomai.org/?p=mkrootfs.git;a=summary

It has a README which should help you generate the root filesystem.

The procedure to run the test is:
- in a telnet session connected to the board, run the latency test
- in another telnet session, launch "dohell"
- when this scripts displays "Listening on any address 5566"
  run netcat target 5566 > /dev/null

Now wait a few hours.

-- 
					    Gilles.

