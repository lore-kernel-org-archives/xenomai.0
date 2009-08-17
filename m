Message-ID: <4A895028.6010205@domain.hid>
Date: Mon, 17 Aug 2009 14:42:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30907280509u685a18di730cc0b021ab06eb@domain.hid>	
	<4A6EECF1.9000103@domain.hid>
	<b88603c30908170537u72f789c0y75564389c9bd6c8e@domain.hid>
In-Reply-To: <b88603c30908170537u72f789c0y75564389c9bd6c8e@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Pagefaults during mlocked Realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> We have not much progress tracing the problem so far. But in parallel
> to the tracing we also updated a kernel to the latest xenomai git
> status of the 2.4.8 branch, just to see whether we are not facing
> problems that are solved already.
> 
> This version however crashes and dumps its call-stack directly when
> starting the latency test application. Interesting is that it crashes
> at a check that is added recently in xnshadow_harden:
> XENO_BUGON(NUCLEUS, !irqs_disable_hw());
> 
> Please find attached the .config

Ok. Thanks for reporting. I am afraid there is a hole in the way Xenomai
2.4 uses the Linux preemptible context switches. I do not even
understand how it is supposed to have worked at one time.

It is my fault, of course, since I am always testing head with the full
modification for unlocked context switches, and only 2.4 once in a while.

I will test this configuration and will keep you informed as soon as I
have a fix.

-- 
                                          Gilles


