Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512847DD43
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570079; cv=none; b=qq5F8cKLI2tw/pMYhmr/lhX3c24Yfs7xr0LpMgaRXwHugXcYcPfgCbMEz9QGvA52285I0KvxfJ9j360sW635d80qALh1IgX7LdaDKWdEbxcJTlUWimoWTaewBNPRit9y1yk9sp32yL7g5j2R4EoAF5ElpgEIyeREfUr+GKEz9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570079; c=relaxed/simple;
	bh=tnhh5lsXqzTra68EIcimUL62VZCVUXycwnkR31IWJY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=baWjF0chcW0ecMmD/e9VKFT0AI8R9dbPdK5XSCqdKmUDqdLgOWsPGfaKERzmJeg/gwvk9hl10ytWGhWkUubn97S2lHLsU1Uof7oLLJksA9MmYruTFLRNKnvycitBpfwWksXLA7LNvoZDYrkyQv+gO3Mb/0nxBoid1AD2UHu/kJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=DqyWYUiS; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DqyWYUiS"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260512071422c4d468cf9c00020726
        for <xenomai@lists.linux.dev>;
        Tue, 12 May 2026 09:14:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5QXfBxgwiitk04tI44IRJ9CN/q3dGrEV1FA4NklNQW0=;
 b=DqyWYUiS6ju7HO/9NRV+JqoTtXUlMhtZsXzZSObyEo90QIW1WpY6bCB0MFiuoulRavEZ5d
 8ykwe5AnWJwIN4M5AoBzj3AzX+JKRhsNgtF8gKkfwUPRpzZxIjnFe7/XgK3xY1yEVaMSOA9N
 WlZM2z5EBpvp0liQw4Q5/e2Dz67JdGSirnheULvy5b1jOyTghXfRN/L7xnb2yp5oNY//xT7/
 hj2eE1B7kdM9+zdDzjKQaRwgUHMaHYZlN5faFLsqeyEUTLRlcFwoGeETCZxCeLJjQb8gzOzK
 35VJYvTFD/IV8OuUzrVDMTaoSLdyWIILNKJJPFmiaq84gsoBLz6RMCSw==;
Message-ID: <854c31ce523b9f1f10b2d40c8575c1cfb6aa07a9.camel@siemens.com>
Subject: Re: [PATCH dovetail v7 00/11] riscv: Add dovetail support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Date: Tue, 12 May 2026 09:14:21 +0200
In-Reply-To: <87ik8u2t2a.fsf@xenomai.org>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
	 <87ik8u2t2a.fsf@xenomai.org>
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

On Mon, 2026-05-11 at 11:29 +0200, Philippe Gerum wrote:
> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>=20
> > Hi all,
> >=20
> > this series introduces initial support for Dovetail on RISC-V.
> >=20
> > Feedback, suggestions, and especially reviews are very welcome.
> >=20
> > Changes since v1:
> >  * Disable independent irq/softirq stack usage when pipelining
> >  * Drop KVM changes as long as they can not be properly tested
> >=20
> > Changes since v2:
> >  * Rework trap handling
> >=20
> > Changes since v3:
> >  * Included the IRQ pipelining patches to have all riscv specific
> >    patches included
> >  * Rebased to dovetail/v6.18.y-dovetail-rebase
> >  * Merged most of the fixes
> >  * Fixed IRQ Stack handling and enabled IRQ_STACKS again
> >=20
> > Changes since v4:
> >  * Rebased to dovetail/v7.0.y-dovetail-rebase
> >  * Applied suggestions from the last patch set
> >  * Added starfive-visionfive2 board support
> >  * Introduced raw console device based on sbi debug console
> >  * Reworked pipelined irq handling
> >=20
> > Changes since v5:
> >  * Rebased to tip of dovetail/v7.0.y-dovetail-rebase
> >  * Applied suggestions from the last patch set
> >  * Use mark_trap_entry/exit_raw for kernel mode exception paths which
> >    use irq_nmi_entry/exit for now, as the nmi irq handlers expect hard
> >    irqs to stay off. This may be be subject to further optimization at
> >    a later stage, but I do not see any negative impact latency wise in
> >    my tests.
> >=20
> > Changes since v6:
> > Address the review comments from the last patch set:
> >  * Keep the virtual irq state in sync with the hard irq state in trap
> >    handlers
> >  * Fix irq_nesting imbalance when running with disabled IRQ_STACKS
> >=20
>=20
> Ok, this is ready for inclusion. We should target 7.2 since the 7.1-rc
> series is already running.
>=20

I was blocked by some other hot topics here, so I didn't start the 7.1
porting yet. I might be able to apply them on top and do some more
testing for 7.1. Let's see.
