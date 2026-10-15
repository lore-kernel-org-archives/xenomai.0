Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466158E2A5
	for <xenomai@lists.linux.dev>; Thu, 15 Oct 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088428; cv=none; b=htD6VHQcjFhfS7f4eB+Mb7qgOITKqKTWKy8AglxqlAni4IA4YLD59iM3A13MeLhFezjcMHhc9SFP12R+O+3+qoxa1cZbuSMNdBornbpYyvDcfWicCaO2MZ8DpMojg7vEFjool2TWsCaYU7aoIttdVndNBYmbZIV2vYy4E5lIlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088428; c=relaxed/simple;
	bh=Bp7J97Q6ZpOcN+4KCLTmqwitDOxQdHwepMj5VBrdsEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B7z5rCGo1zcbzOlArLOcWkWGMS0vJ7l9fnuQKlDSVr8S7T2Js9jf4bH86d2pynAT1IFAroD09eCXK4j8eaRc2anKuwtS5uT+XdZLLB2BndlS1N+sqNbaNTyQoqYkXYPu6lkGuTgQ7NMdcj8Gf9+Fa0MjiLic8N5WLphPLBhgB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=X/I2gvuH; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="X/I2gvuH"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 164053ED7E;
	Thu, 15 Oct 2026 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1792088413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wsn5FHDZTF+J6AGXyo6agF6VLIh81Z4ZXWtQBDQ+pPY=;
	b=X/I2gvuHOoyXiRQCeTiAtT9v19GOfZDbh9JwjYWpwMtmIWyz79tAdGP03lqMT8L10S2dUi
	AfLnpyS/7BBOdjsPegjU1Y9GVo2BpxxJJh7xAsT2CE1/Kdgjo1WOTFCN1pEs9zOmuWGAYv
	Q/KHirf2SzW04zRkOywqYvr1J+aoMsIYXtlFYpFlpKI2Zpg9s0ixENbNwPdlvfvV8LPriq
	tL9jw/c0dfj6aMKd8fL2XY17hSMnP8pg5P6305QRslPu8XigGGxqlrpKJVyhe7mnajiumh
	Un8GOM1VUDsuKn6w4dYO4fHcem8mL89OnBKesZpHosyyjwnbJqZhbspG/qAxpA==
From: Philippe Gerum <rpm@xenomai.org>
To: "Richard Weinberger" <richard@nod.at>
Cc: "Jan Kiszka" <jan.kiszka@siemens.com>,  "Richard Weinberger"
 <richard.weinberger@gmail.com>,  "Xenomai" <xenomai@lists.linux.dev>,
  "Florian Bezdeka" <florian.bezdeka@siemens.com>,  "guangfeng.wang"
 <guang_feng_wang@163.com>
Subject: Re: AW: Call today
In-Reply-To: <mv9hiiqb.0db2987e-79ae-464a-9a97-05c97d029f46@nod.at> (Richard
	Weinberger's message of "Thu, 15 Oct 2026 11:57:55 +0000")
References: <98caad22-455d-41ca-bfaa-f32289c7c8e8@siemens.com>
	<CAFLxGvxKcWEvwOBnTOX9VQ2wQiUsML7r267zRMD_ixL3EyUCdA@mail.gmail.com>
	<9f598cf9-5a8e-4f3e-84ae-5e1ca7bb66de@siemens.com>
	<mv9hiiqb.0db2987e-79ae-464a-9a97-05c97d029f46@nod.at>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 15 Oct 2026 20:20:12 +0200
Message-ID: <87ik32ltb7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTET2Cs6viUJchiAGTYGuAGX1eZYkydAPrlQxCKfCWHXTRiQWd56qZwPFbv7oPO59AzK7i/t58xSP9djCwJ7PisVqE6LZVMGz/Qid2pMAPWsaIGmJ7S06p+1pccU6qCG9IEZqv0xlHDP8Zi7O7QX6GGAUMyCD9dTBSYgBR/gw+lsh8ka7Z7CZJnvWwys/f5UA8itVegKGsGBZvXQ5gAne0QWEJMcGgJ9k1znFqvD/gBgUCE3OgV26AdBuNSt38jD2Ba61CBxgI3h3M5yBD9fCllVs4JIQDgZ1WVt0uUSvpUIVWcHMPT/Xn+gSPmqbbCzqIzDnQb3/AoGy++zciVilH4ZhARyAuAx2HNp4H08wMvwz8MGRDy3xk3OkN5sYQI1wjtZuN3VB4G2rSLWBiaCWKXXkhOY6iUAi5NGUr82MT1o/j4V2cGAuPG47ajocYhbpUbDyWubmsI0w0N2CHtG2P5+rQ69GKX/lRdkd+zyMJBtuF6K31YWKV1ciy/GwD+Pzy8vCp5amvj2YdVmrO/b0drQujafRFgxNFlQo2CR0HwHrN4+XfFR6ealv4kjE3O0P3zyLjlTPZ39YMhoBXYzcudA/oVjnVriPqq0x6PCxynqhMm2MC45pG2y8/B1na1QepIe2ER0gUORu27VJdMvC1rYwzLTYvQRu7EbsVx9ab3JMQ

"Richard Weinberger" <richard@nod.at> writes:

> Am Wed, Oct 14, 2026, 11:51 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>> > I was about to ask whether somebody has (long term) latency plots
>> > for i.MX8M mini SoCs.
>> > 
>> 
>> We do not have one in CI lab, but Philippe has/had one in scope for
>> Xenomai 4 and may have related numbers from his lab.
>
> Would be good to have some solid numbers.
> On my i.mx8mm board I see latencies around 45us.
> What worries me a bit, copying memory on a different CPU in
> a Linux task significantly increases the latency up to 100us.
>

My experience with the Variscite Dart i.MX8M Mini back in 2020 has not
been that nice either. Structural latencies observed were > 200 us with
a 10Khz loop, on any attempt with every rt option: x3, x4, preempt-rt,
all the same. I was using the Variscite kernel fork of the NXP kernel
fork... Way too many forks on this table, so I cannot tell whether some
gremlin was hiding in the bsp layer which would have explained
this. That was roughly enough to sustain real-time audio requirements at
that time, but certainly not good enough for stricter requirements. This
said, those measurements date back to 2020 (kernel 4.19.35), so things
might have evolved since then, take my word with a grain of salt when it
comes to the current status of this series.

Last year, I ran evl on a Phytec i.MX8M "Pollux" board. Much better
figures (read: something we can use), but running evl for a short time
only on this board was purely opportunistic, because this target was not
aimed at real-time work and left my desk early.

PS: The issue you mentioned about seeing weird figures when memory
traffic happens between different CPUs rings a bell. Back in 2022, I did
some measurements on a TI am625 SoC, observing high impact on an
isolated CPU running the latency test, caused by tasks running on other
CPUs, moving memory around and switching context at high rate, to the
point where using this platform for real-time duty was a non-starter. A
peculiarity which must have had a reasonable explanation is that the
busier the CPU core running the sampling loop, the (really, really)
better the results. I sent some questions to TI about the whole issue at
that time, a TI engineer answered that the problem was under
investigation, then the discussion stalled, and I did not get back to
it. Again, this is old news, so the situation may have improved
(hopefully).

-- 
Philippe.
