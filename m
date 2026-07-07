Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE193DA7F8
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418578; cv=none; b=BjGhdEbB07MVt1Ad+2ERZ8ciQImt4cPiL5lLdYBLP2Nd6yEh+HAuk0oGmkMCRO591r0SD5Oyw0lSmjnuAdu4ETJ2sqMtTpaQF/AL2sHZ2L+VR+auBCvklugbRXiuIDlPXr+aJNrspMAAMGdXXlXg7fNNxnwM2gx7pNgZHQmEUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418578; c=relaxed/simple;
	bh=LZGo/8I2YV7Tmd1MMfuU0FWx2WvzC1lFXhAB9pf1SnQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bz1gs/4MbZJ7y7JSkRCG3VCFhBikJgLIAuh2VjPwm6zL/mhVh/r1LtOCIn8PVhh9Dad5gD2DJC/CLystYGN+CJ6qvhF4S6ZYB4ss61yEmT54gxtphx8Ch2/8ZwSl1DemMKsl2xjLWV3/jOEj0SA1IaJz8oocygSZsjLWhGDuJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gDOLdx4Z; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gDOLdx4Z"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2026070710025290700a9d4400020770
        for <xenomai@lists.linux.dev>;
        Tue, 07 Jul 2026 12:02:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ltwafn0U+7WXA1M0XjANBk2aEhXsbjUtxyNd24IyC/o=;
 b=gDOLdx4Z6qxFHxcMEjOk/1WzecIjcNUE/fz/BvSHft5kyNxDJu4Qemypo5aSXsaJQSCos5
 HKuK7F/X9n0c3QAR6ru4VkJi75IaNjSRvxwM4zKXHIuyZIR+COU/Q/u3PCa7pDl1O09pKY2M
 NAN+grzvZaS/8HUEz0PD2aRfKIhN/vx4LKoehtNkUVMJvAncGlHG0SQfJBhp1KTEPJFcUcXJ
 ehNGbY4/DLx56oOoTDFiI1N0Jo01A+eDFwnB8feky6MXA6dNBfEPV25I9VzXf2jr2+GKbQgG
 Zn6SoDIUympfrPL0hcoPPG2aK//D1Y9d98yWPJwGtm9tlbvj7kHVfmyQ==;
Message-ID: <aea1bc068740212737bd02d3b6317dac1eb8fbc8.camel@siemens.com>
Subject: Re: [PATCH dovetail v10 00/11] riscv: Add dovetail support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>,
 xenomai@lists.linux.dev,  Philippe Gerum	 <rpm@xenomai.org>
Cc: jan.kiszka@siemens.com
Date: Tue, 07 Jul 2026 12:02:52 +0200
In-Reply-To: <20260706182927.281078-1-tobias.schaffner@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
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

On Mon, 2026-07-06 at 20:29 +0200, Tobias Schaffner wrote:
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
> Changes since v4:
>  * Rebased to dovetail/v7.0.y-dovetail-rebase
>  * Applied suggestions from the last patch set
>  * Added starfive-visionfive2 board support
>  * Introduced raw console device based on sbi debug console
>  * Reworked pipelined irq handling
>=20
> Changes since v5:
>  * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
>  * Applied suggestions from the last patch set
>  * Use mark_trap_entry/exit_raw for kernel mode exception paths which
>    use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
>    irqs to stay off. This may be be subject to further optimization at
>    a later stage, but I do not see any negative impact latency wise in
>    my tests.
>=20
> Changes since v6:
> Address the review comments from the last patch set:
>  * Keep the virtual irq state in sync with the hard irq state in trap
>    handlers
>  * Fix irq_nesting imbalance when running with disabled IRQ_STACKS
>=20
> Changes since v7:
>  * Simplify Trap handling
>  * Rebase to wip/flo/v7.1-dovetail-rebase
>=20
> Changes since v8:
>  * Further simplify trap handling adressing Florians suggestions and
>    recent fixes to irq-entry-common
>=20
> Changes since v9:
>  * Fix checkpatch finding in patch 11 "riscv: Add dovetail support"
>=20

Thanks, applied to the following branches:

dovetail: wip/flo/v7.1-dovetail-rebase
evl:      wip/flo/v7.1-evl-rebase

Philippe, final test run has been scheduled, expecting both branches to
be taken over by you. Any left overs?

Best regards,
Florian
