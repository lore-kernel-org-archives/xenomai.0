Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84633CEB0
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531499; cv=none; b=VL9uZCi71LJscUiZQf1idN2fB9KERiDoOnZM1dJB0EOUZekNjSkbWLcfYjldocYeq4WJLA0rNZLi55ju2+jE2fx09ochG74Gl86Zfi9qsIoK55u8FGSNDmlSSaEOZM4GUqBT7uO044PN+jJvhWwhGDa1HVpMrImXOdzxeWUqvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531499; c=relaxed/simple;
	bh=JtecDAcVQsm0J8cbJ+P3/waTyUeriwjbSD/Wbb26/HI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ia5UNqrdiYObxO+yhGM0/Ubwk16xLYDCOkEcGBUr29p/iqCBuL86VbMMBzlMn66K22xtrpqrrjphy+gL2BIpPmz2dYb9BsbRfePdlXMdWf+9AxthgdCKg10pIlfrkuEps9OP5kc+djZnZBibOAsdvDP5xhi8v7m4EFKPzi7Kv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BT23v2pt; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BT23v2pt"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260904140803e3a730dc950002079b
        for <xenomai@lists.linux.dev>;
        Fri, 04 Sep 2026 16:08:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JtecDAcVQsm0J8cbJ+P3/waTyUeriwjbSD/Wbb26/HI=;
 b=BT23v2ptFiaPUBnDDEmrMl5tz/3NQvbB4TUnrlJT4eI36k4gbRYkKeWJML/kUNkeuGAZsv
 MmUcpQV8dJhYKDium+ugu8s1ICfTjMmTKC1vayJGNsYGtKd9c7HQjQUrFR/VENUNx1Ji0J32
 rPuX0nYrskwb8z1MtbP4sNmDWMwOxvK+2pOmGCtEzEfdlqWUdSLmpiMRmVOkwXhdalZKK2fB
 icWIGtje2iTCaxlgXWWoPvqGf6NiCHHMa57kbbl6HPFtQm53EOUIDcMDVs/LCzdX60M5wF1c
 LnW85ZVGs3xfylYCPWWIyAaymuWQtdCtg+jIRec6D1+XXk7N55UsFaqQ==;
Message-ID: <9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Andrew MacPherson <andrew@elk.audio>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Fri, 04 Sep 2026 16:08:02 +0200
In-Reply-To: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
References: 
	<CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Hi Andrew,

[CC + Philippe]

On Fri, 2026-09-04 at 15:26 +0200, Andrew MacPherson wrote:
> Hello,
>=20
> We're working on an STM32MP1-based system running Xenomai and found
> that perf top shows every symbol as "unknown [00000000]", i.e.
> profiling is collecting samples, but they all point at address zero.
>=20
> I'm not a kernel developer but went through a few debug kernel builds
> with an agent which eventually led to the attached patch. This change
> does resolve the issue with perf, however I'm not sure if it's the
> correct solution.
>=20
> The reasoning is that arm_arch_timer.c's percpu IRQ registration never
> sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
> tick_regs, leaving get_irq_regs() to always return an all-zero
> pt_regs, which in turn breaks perf's sample IP.

Yep, that is wrong. The patch you provided looks OK to me. I'm just
wondering if that should be addressed in Linux as well / first.

@Philippe: Any additional thoughts? Should we take it already?


@Andrew: Could you please provide a formal patch with proper signed-off
and LLM notice (assuming agent means AI ;-)) targeting the dovetail 7.2.
branch? That should help to speed things up. Thanks!

Florian

--=20
Siemens AG, Foundational Technologies
Linux Expert Center


