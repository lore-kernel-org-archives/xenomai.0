Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32623B612
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915311; cv=none; b=mJRNkkK7ydljfaus2uc/KGz+StKrgprW51RIomFJfUFGu6C/GZb5Ch1uWUuDVGS0Ua6A/I3k2qUYPj3C5gJkIHziO6j5GIw8OjOfa/xnzHv1lIP/87wFmQfmr8lRrvaoXSXKytTctYH1BxS2P07PG5zkCKdZ+GRwnw9YwZPxcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915311; c=relaxed/simple;
	bh=mh1fzbPL80HAajOu8um23SHvRVvNXbTDX1cyb912jtc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hs0Ei3QRbPwnQbHtndy+aNNcTRd12g7VT9WVgaXT0yJwJQ2u42L1DTlkOSTLENrEyIr6p+VUeGr2vqUO4XLynES1EjvoLLdW7jxms53EWfJuhKwlEIBMeHZbedqrfRvpkOnoUDLnZ/YyJz4Che7I6W0Rd+jsvZH8dufZWpL9Q00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RQTlFpNY; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RQTlFpNY"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250903160142f1de49ca55000207fd
        for <xenomai@lists.linux.dev>;
        Wed, 03 Sep 2025 18:01:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=l+kCnfvlVhddqVn0yhm1KHfKqa7vD+J/4G+UNqP1G60=;
 b=RQTlFpNYmZCiDruYJDLuUBaDIIAi2xfOZ8Q29I8l+PP3hBxT49TTatuXzZrBsIK1C5sHFS
 +OTt4UvQAZE6HQ5/EFRNi5e2VtM0bz4ua6wX1P2LnLKwIbXPg4mvDBCarFl/njlVZ5Wpoej6
 0LyTFudP7COujnvg1OgTMvP1rnEOrMWnURZp/WzBrTEKm6l+0GtTyP1c+J/eMTp/15cYWHLP
 1CauNmPk3vfyblMx7ZnP4X91x7cm6s/DH3ZjFUsO6kHuUSErMaNSbC9u0LOOVf1MKaW3s5NI
 zVkr9kqIcZaaCL93SLi6nL+Xl6ohBuoXdyHTOoeAeE1IbaXt4NYL0+JQ==;
Message-ID: <e7d5cddf94d3d1479e987950a07ee7483820ff1a.camel@siemens.com>
Subject: Re: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 03 Sep 2025 18:01:40 +0200
In-Reply-To: <87h5xjlf56.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
		<2cb5e8c46cc8d841cf5f452a753d37e7079f3036.camel@siemens.com>
	 <87h5xjlf56.fsf@xenomai.org>
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

On Wed, 2025-09-03 at 17:39 +0200, Philippe Gerum wrote:
> Hard irqs have always been off while running the IRQ flow handlers
> grabbing the IRQ descriptor lock, this is a fundamental requirement, no
> change there. handle_irq_event() drops the lock before calling the
> (user) IRQ handler, then reacquires it before returning to the flow
> handler.

Thanks. So

	hard_local_irq_enable();
	do_inband_irq(desc);
	hard_local_irq_disable();

in sync_current_irq_stage() allows pipeline entries for other IRQ lines
but the desc->lock prevents this for the same line. Correct?

I meanwhile applied

4e879dedd571 ("genirq: Move irq_wait_for_poll() to call site")
8d39d6ec4db5 ("genirq: Prevent migration live lock in handle_edge_irq()")
c609045abc77 ("genirq: Split up irq_pm_check_wakeup()")

all taken from 6.17-rc which seem to adress some of the issues that I
noticed during testing. Obviously the system is still exploding but in
different colors now. Good to know that there are/were some problems
with edge triggered IRQs.

Best guess for now is that IRQD_IRQ_INPROGRESS is never cleared.
Unclear how this can happen as the debugger tells me that all but one
of my CPUs are sitting in idle while one CPU is spinning in
irq_wait_on_inprogress() and waiting for IRQD_IRQ_INPROGRESS being
cleared...

Stay tuned...
