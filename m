From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4715C70F.4040501@domain.hid>
References: <4705ED3B.4070600@domain.hid>
	<2ff1a98a0710050130j7e0db84dq838aab0417c8bd3f@domain.hid>
	<4705FE04.7000909@domain.hid> <1191576011.20623.114.camel@domain.hid>
	<470611FA.30103@domain.hid> <1191592977.20623.142.camel@domain.hid>
	<470A26BC.506@domain.hid> <1192015852.22917.197.camel@domain.hid>
	<470F7F2E.3020206@domain.hid>  <470F82FF.9020701@domain.hid>
	<1192203284.6499.135.camel@domain.hid>  <470F978B.1000005@domain.hid>
	<1192207431.6499.161.camel@domain.hid>  <4715C70F.4040501@domain.hid>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 10:43:11 +0200
Message-Id: <1192610591.5973.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] awful latencies (~110us)
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-10-17 at 10:25 +0200, CHABAL David wrote:
> 2.KSYM_SYMBOL_LEN
> ==================
>    CC      kernel/ipipe/tracer.o
> kernel/ipipe/tracer.c: In function ?__ipipe_rd_trigger?:
> kernel/ipipe/tracer.c:1209: warning: implicit declaration of function 
> ?sprint_symbol?
> kernel/ipipe/tracer.c: In function ?__ipipe_wr_trigger?:
> kernel/ipipe/tracer.c:1227: error: ?KSYM_SYMBOL_LEN? undeclared (first 
> use in this function)
> kernel/ipipe/tracer.c:1227: error: (Each undeclared identifier is 
> reported only once
> kernel/ipipe/tracer.c:1227: error: for each function it appears in.)
> kernel/ipipe/tracer.c:1227: warning: unused variable ?buf?
> make[2]: *** [kernel/ipipe/tracer.o] Error 1
> 

This one is a tracer issue. Will fix.

> Analysis:
> KSYM_SYMBOL_LEN only defined on 2.6.22 ?
> 
> Solution:
> I replace it by 128 (don't ask me why...).
> 
> 
> I post my new results as soon as the kernel is built.
> 
> David
> 
> 
-- 
Philippe.



