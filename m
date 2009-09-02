From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A9E4022.7050705@domain.hid>
References: <4A9E4022.7050705@domain.hid>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 11:03:22 +0200
Message-Id: <1251882202.3205.116.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Any example freezes immediately
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: dev.chmeie@domain.hid
Cc: xenomai@xenomai.org

On Wed, 2009-09-02 at 10:51 +0100, dev.chmeie@domain.hid wrote:
> Hi,
> My current state is as follows:
> -2.6.30.5 with ipipe running, apm + cpufreq disabled
> -xenomai userland compiled and installed
> 
> When I try to run any of the examples I get 2 nice blinking leds on the 
> keyboard
> and additionally a kernel stack corruption message and a freezed pc.
> 

Disable CONFIG_CC_STACKPROTECTOR.

> What could be wrong? Maybe any other kernel options I missed?
> 
> By the way, I get some index out of bounds warnings when compiling the 
> kernel.
> When I recall it correctly it was in a file asm/include/io.h or similar 
> of xenomai).

This is a vanilla header, not a Xenomai one.

> But I still hadn't enough time to look into it.
> 
> Thanks
> 
> Chris
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



