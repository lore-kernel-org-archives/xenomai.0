Message-ID: <48EA254F.1010702@domain.hid>
Date: Mon, 06 Oct 2008 16:48:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7AD38398@domain.hid>	
	<1743f3b40809230122u177e9aaeyb0cbc53f81793929@domain.hid>	
	<48D8A7EC.7000502@domain.hid>
	<1743f3b40810060744v7d55f706m62b46a1e27498524@domain.hid>
In-Reply-To: <1743f3b40810060744v7d55f706m62b46a1e27498524@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Antonio Del Cinque <adelcinque@domain.hid>
Cc: xenomai@xenomai.org

Antonio Del Cinque wrote:
> Is there any way to track these kind of latency in the ipipe, a kind of
> worst latency case tracker? I see only "virtual" IRQs 512 and 515 running in
> Xenomai domain. I cannot see where they are set up. I guess one of them is
> the system timer, and I know this is commonly driven by the powerpc
> decrementer. Is the GPIO interrupt latency due to the system timer
> interrupt? If this is the case, where can I disable the system timer in
> Xenomai, or modify the interrupt routine? I must run in interrupt context
> because of latency requirements (they asked me for deterministic latencies
> under 20 uS).

Yes, there is the I-pipe tracer:
http://www.xenomai.org/index.php/I-pipe:Tracer

Xenomai latency test has a -f option which triggers a trace for the
worst case.

-- 
                                                 Gilles.

