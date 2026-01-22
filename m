Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F2449ECE
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079936; cv=none; b=GTh162vfDIALYNJYV30gFRfRLqvLMSIyecFtVhaZcYXHyE//1isKt+MZ/sPXh53tLHJuFPs4b4TKlQroP8YnH7pBOoC90f27f465oaTJ/on7dWxgWoooM1FyCVuiDAFjD9eXKQVahLY0izXIqJBTINaIDkaxxztRsE/MJ/VQzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079936; c=relaxed/simple;
	bh=h5bBXqFtBfjkb5VEbz8WsFKa6LuEwO06+vhr7Tg2Hg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DgeWdGvGOprQWMCwezGlDf0ErnzMQObyYMKbFhXP+g1xrRf6JhbBUfPKfAhk6O7gWGwz/RPAhqJzRh2mybJ5YxeMl0+u8i1dE0ob+66eHxvM54GzKWbA7qO/OHiESUzXBGxS0vfaf8P2iGoBtRJuBf6iFXauB+9IFsaxgvyZtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HmFP1Eim; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HmFP1Eim"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026012211052117e3bd5a6200020796
        for <xenomai@lists.linux.dev>;
        Thu, 22 Jan 2026 12:05:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NfTu++9Cgl90zqYJSrRlIYXVW91K1R6eE8rvEANWMEY=;
 b=HmFP1EimYMPtTOe7JObVWjgSuFj1zMpSUwQwgkgYiGu5U88ucR2OLUSWUTgT+UJpDmbWZ0
 fHrHjBv8Y0HAvCOD7TuPcjyyb1miteykKgqugmzYJytMPFzCXLbcz/jbiygxh7MIgv8/q7bk
 flYcSJyzfRNleinIyHYaKwCteUpspLix/i8eMRNvQ4sqehHsSIGOfuIj5upM4GxOKkteedU4
 4yyMVYDQQIT/tQfU6foNU5+WkFCMFvvqlUTVLCrIzPvT0EG2hAN276O1qHM8QExCajhjOx9j
 XshKdtpX+d6JeWHY+gmF1BwhpOC0Uu3K66K0qzWTEezD2kAMTnRVqxfA==;
Message-ID: <fee490c4f759ab6c6b88e207f4ece1f285179eac.camel@siemens.com>
Subject: Re: [PATCH dovetail v4 00/12] riscv: Add dovetail support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
Date: Thu, 22 Jan 2026 12:05:20 +0100
In-Reply-To: <20260122102304.421957-1-tobias.schaffner@siemens.com>
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
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

On Thu, 2026-01-22 at 11:22 +0100, Tobias Schaffner wrote:
> Hi all,
>=20
> this series introduces initial support for Dovetail on RISC-V.
>=20
> Feedback, suggestions, and especially reviews are very welcome.
>=20
> Changes since v1:
>  * Disable independent irq/softirq stack usage when pipelining
>  * Drop KVM changes as long as they can not be properly tested
>=20
> Changes since v2:
>  * Rework trap handling
>=20
> Changes since v3:
>  * Included the IRQ pipelining patches to have all riscv specific
>    patches included
>  * Rebased to dovetail/v6.18.y-dovetail-rebase
>  * Merged most of the fixes
>  * Fixed IRQ Stack handling and enabled IRQ_STACKS again
>=20
> Best,
> Tobias
>=20

Some questions:=20

- What is the stability state of this series right now? Any known and
  open issues?

- Which platform(s) was/were used for testing?

- Any stress and over-night tests that were executed?
  I'm not necessarily talking about the CI tests that we do. I'm more
  interested in io/cpu/memory/swapping/suspend stress tests.

- State of CI integration: I see that some risc-v support was added to
  xenomai images. Is there real HW behind already? If so: What kind of
  board?


I guess it's too late for 6.18 as we still have some problems for the
existing archs, but 6.19 (once we were able to catch up again) looks
doable.

Florian
