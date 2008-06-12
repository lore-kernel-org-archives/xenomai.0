Message-ID: <d6c8ef150806121601p4e9f197cofd2485d7ae79ed9d@domain.hid>
Date: Fri, 13 Jun 2008 01:01:03 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
In-Reply-To: <d6c8ef150806121541m4b31aa79hbaf62e23d50d742f@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150806121541m4b31aa79hbaf62e23d50d742f@domain.hid>
Subject: Re: [Xenomai-help] Change propagation using rt_heap ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

In the meantime, I have found in discussion on March 28, Gilles mail saying:

> The arm-specific bug will happen later (once the shared memory is
> mapped). Because the kernel-space and user-space will get different
> caches for the same memory area. The solution to this issue is to map
> the heap without cache, but to get this, you need modifications of
> Xenomai that only exist on my computer for now. So, if you are
> interested, I will send a patch.

Am I experiencing this arm-specific bug? I'll try with xenomai-trunk,
I see that H_NONCACHED flag is existing there. Are there any
performance problems using rt_heap with this?

