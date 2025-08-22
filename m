Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D91C2324
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844651; cv=none; b=bftVAaTx+oFt9vuqGjJAILEBex40B1yNBzR1SRVBfD6PgwC/j9+qlQXB3PU5yYIqjHDf1VfHndicbjy0G0YNJ0jgPtbbvnSMHBfEDID3rqJWHN64T3HRFkC9fN5e7/AdMBXw0wGjDmSzV/ZjRvw7PJoj+QmLfnCvgDrd3w5vB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844651; c=relaxed/simple;
	bh=pOalZYAsILj5jCv/tYqAwMYHWEHQiF0WJGI+qgjVAz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JwnHm9b66EiKMViDOZOciYr+gH2Yc4gnZD+8B+BR0JF++8T6QX1cwkwqZJl49emL+3h1zW/xctiXe+oY5ESJTqJ4nW5CRYzGH/diYf+WQ4aiGGljkr6vr0xwFChs8x62QHBYKL3OqxsWUKsbylgssLHbd6OIZ5cPSKo3LhsqUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GfPBtTOm; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GfPBtTOm"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250822063722cd9c045f407bf4d3bb
        for <xenomai@lists.linux.dev>;
        Fri, 22 Aug 2025 08:37:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pOalZYAsILj5jCv/tYqAwMYHWEHQiF0WJGI+qgjVAz4=;
 b=GfPBtTOmFuTrH0hMQCCCesdI0S67X7af1V1DPM+68dxH5ZRHgoi+rQ3aGNpfr9gmqR2Vqg
 nknInPRf9G+Rwp36dfY36ZTjrd8zd78xBl/CKBuzMs938I+X/OZRWiwb4iOUgrwgdGkl9LMc
 UDCw2yNYUwYW+k9zdKidQn3SlvQr4SXrbmsFNAAVAmlwiBA0DnTnn+ph6Q1OEw0+UOosItZu
 IgfYcltd0aCAS2IiApxZBL6kHg8jM0PTBAiD82HnoKk25wCjumUzKK4XHeCmOo9/RuuOS02p
 eZLqyUmLLJE0xRzh8KbHjsU2HRENxbt4jbY5x1HrnI9kAxC4SHV4F1dQ==;
Message-ID: <3645d32f3247d2ac48b862bea720508a1b59e382.camel@siemens.com>
Subject: Re: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 22 Aug 2025 08:37:21 +0200
In-Reply-To: <20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
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

On Wed, 2025-08-20 at 01:08 +0200, Florian Bezdeka wrote:
> When IRQ pipelining is enabled, it could happen that handle_edge_irq()
> is interrupted while syncing the IRQ log - for the very same IRQ - as
> hard IRQs are enabled while processing the IRQ log.
>=20
> The pipeline entry code will set the IRQS_PENDING flag and bail out
> forcing the sync code (still in handle_edge_irq()) to loop to infinity
> as the (periodic) IRQ might fire again after calling unmask_irq() from
> inside the loop.
>=20
> Delaying the call to unmask_irq() until the loop has been left fixes
> this problem.
>=20
> There is a "race window" involved. To trigger looping to infinity the
> IRQ(s) must arrive while processing the IRQ log for the same IRQ.
> Enabling some debug options like CONFIG_PROVE_LOCKING widens this
> window as execution time increases.
>=20
> This time the problem could be observed during IO APIC initialization
> on a virtual machine. That simplified debugging a lot.
>=20
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Hi all,
>=20
> the problem could be observed and debuged quite well on hyper-v with
> lockdep enabled and a slightly modified NMI handler to print out the
> current call stack.
>=20
> This seems to be a long standing issue for Dovetail. We had several
> reports in the past that debug options (like lockdep) on hypervisors
> (like VirtualBox) ended up in a boot failure.
>=20
> Once we agree that the patch is correct I can send backports, if
> necessary, haven't checked that yet.
>=20
> Best regards,
> Florian
>=20

This one will need a v2. Seems to trigger some kind of "soft IRQ state
corruption" on qemu/kvm.

Seems there is a problem in kernel/irq/chip.c when unmask_irq() is
called from the inband IRQ context. The hard IRQ might fire after the
chip->unmask_irq() call but before updating the software flag. Under
investigation...
