Message-ID: <5184483E.1050305@xenomai.org>
Date: Sat, 04 May 2013 01:29:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8AC37F92-E842-45E8-8583-9C1A7D8C9930@mah.priv.at>
In-Reply-To: <8AC37F92-E842-45E8-8583-9C1A7D8C9930@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.8.10 beaglebone failure: any clues I missed?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/03/2013 11:54 PM, Michael Haberler wrote:

> I've built a 3.8.10 beaglebone kernel using Stephane's patch and
> xenomai-2.6 master ; only config changes from default config were: 
> disable frequency scaling, and disable smp (but same symptoms as
> below without these changes)


> 
> - kernel boots fine - 'sudo xeno-regression-test -l
> "/usr/lib/xenomai/testsuite/dohell -m /tmp 100" -t 2' aborts like so:
> http://static.mah.priv.at/public/regression.txt


I can not reproduce these issues, so, I must assume it is either 
specific to beaglebone or 3.8.10. Could you try 3.8.0 to help narrow 
down the issue?

What arguments are passed to xenomai configure script?

> - starting the
> linuxcnc latency-test (which basically starts two userland threads)
> hangs the board
> 
> I'm a bit at wit's end - any suggestions?


Try:
- running a kernel with CONFIG_IPIPE_DEBUG_CONTEXT and 
CONFIG_IPIPE_DEBUG_INTERNAL enabled;
- booting a kernel without CONFIG_IPIPE and CONFIG_XENOMAI, run:

cat /proc/interrupts 

and check that all the interrupts controller you find 
mentioned here have been changed following the instructions on this 
page:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Interrupt_controller

-- 
                                                                Gilles.

