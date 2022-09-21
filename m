Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EC7C
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 09:51:43 +0000 (UTC)
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 481B0C035B
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 09:41:43 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A26E2100003;
	Wed, 21 Sep 2022 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1663753295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bv1w4VCH2RUpdeQ4HcU/Qzp74hv3CMPdnFwjHHlf8Bc=;
	b=ofDqiIzdqS7B/TLwWE2wRMTsEPMijMTLL4lCfw49jUpAukodVBsd38vnHuyYb5FHNrLAAE
	HsVK6m6EGdILixa4X4W9HY/TBD/ShwkMP6n8yjSQRdGFrPfo5z182rApmdN+IU2Kxt60uu
	MO/USkBOKYA9DAIf6cWPd5ZMtNHPzcQZjSdRzn0RNGfEg5FWEPpRPrV4vhmv8/DD4i8lgs
	GB2ffIHnERag1fENQyOvQbbYxaCHOC08zwc33YPLGtWC2TTzVhmLnGXmEzVe/vb0ugq/TI
	mr5gWHC9owyTXwmmTyY73O2/dQ7+J1ZsLU5mV3oZNHdnvDUodPQ9dOogx/zXyw==
References: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai@lists.linux.dev
Subject: Re: How to debug realtime interrupt latency
Date: Wed, 21 Sep 2022 08:51:54 +0200
In-reply-to: <4WAGIR.N142QYZSDNER1@lapp.in2p3.fr>
Message-ID: <87y1ud3vzn.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:

> Hi,
>
> Let me introduce myself and what I'm working on. I'm a software
> engineer working on the real time acquisition and control system of
> the Virgo interferometer:
> https://en.wikipedia.org/wiki/Virgo_interferometer . This system is
> currently based on RTAI 5.2, which allows us to implement control loop
> up to 50 kHz. Data are exchanged using optical links of in-house PCIe
> boards. These boards are synchronized using a distributed clock. Each
> iteration of the control loop is triggered by an interrupt generated
> by the PCIe board. From the interrupt handler, we are calling a list
> of computational functions running in user space.
>
> I'm currently evaluating Xenomai 3 as a replacement of RTAI 5.2. The
> first step consist in measuring the interrupt latency. During our
> tests, one of our machines shown bigger worst case latencies than the
> RTAI 5.2 based platform running on the same hardware, or even than the
> same Xenomai 3.1 based platform running on a different hardware. That
> is why I'm looking for advice on how to debug interrupt latency.
>
> Here is my 3 setups:
>
> CentOS 7 + Linux 4.14.111 + RTAI 5.2 on Dell PowerEdge R630 Intel(R)
> Xeon(R) CPU E5-2623 v3 @ 3.00GHz
> CentOS 7 + Linux 4.14.111 + Xenomai 3.1 on Dell PowerEdge R630
> Intel(R) Xeon(R) CPU E5-2623 v3 @ 3.00GHz
> CentOS 7 + Linux 4.14.111 + Xenomai 3.1 on DELL PowerEdge T740
> Intel(R) Xeon(R) Gold 5222 CPU @ 3.80GHz
>
> Except for the kernel, all the systems run the same OS (NFS mounted
> root file system).
>
> The interrupt latency measurements are in this figure:
> http://emmanuel.pacaud.free.fr/partage/interrupt-latencies.png
>
> All the systems have irqaffinity=3D0 and isolcpus=3D1,2,3. The affinity of
> the real time interrupt is set to 1.
>
> The real time interrupt is installed using
> rt_request_irq/rt_assign_irq on RTAI, and xnintr_init/xnintr_affinity
> on Xenomai.
> The interrupt latency is measured using the in-house PCIe board (a
> time register is latched when the board emit an interrupt, and a
> current time register is read at the beginning of the interrupt
> handler).
>

Which is the frequency of the timer event in this test case?

> What would explain the latency distribution on the DELL R630 + Xenomai
> compared to RTAI on the same machine, or to itself on the other
> machine ?

Hard to say ATM. 10-15 =C2=B5s could be explained by significantly more cac=
he
misses, e.g. after a driver for a graphic adapter has issued wbinvd. Or
simply due to more convoluted code paths running the ISR. I understand
the test environment between RTAI 5.2 and Xenomai 3.1 does not change,
so cache invalidation from the kernel should bite the same way
though. Longer IRQ masking is another reason obviously, which is often a
function of cache behavior during some interrupt-free section.

> Does Xenomai perform some other tasks before the real time interrupt
> handler is called ?

No unrelated housekeeping stuff is performed, only IRQ related work is
involved upon receipt.

> Is there a way in Xenomai to measure the interrupt latency from the
> moment the kernel is awaken by an interrupt signal and the moment
> Xenomai calls the installed interrupt handler ?
>

As Hongzhan already mentioned, you may want to get some figures from the
'latency' program [1], specifically using the '-t2' option, which
measures the IRQ-to-ISR delay in kernel space (excluding any additional
latency brought by switching user contexts). This should be equivalent
to your current test case, barring the event generator and clock source.

The I-pipe has a built-in tracer (CONFIG_IPIPE_TRACE); running 'latency'
with the -f option would get you a snapshot of the active code path
before the worst-case figure was measured.

Question: are you stuck with 4.14, or could you upgrade to the 5.x
kernel series? (4.x is EOL here, we moved away from the legacy I-pipe to
Dovetail [2] with Xenomai 3.2).

[1]
https://xenomai.org/documentation/xenomai-3/html/man1/latency/index.html
[2] https://evlproject.org/dovetail/

--=20
Philippe.
