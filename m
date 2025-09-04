Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001F1494DB
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971939; cv=none; b=IHvLBWUcyEVwnY8xunvpyPLggBb6+iJBtZzfkq5bivjYqclloO2PRGM0MoARhc/6ycn8RzwE9dpllJlFIYvx8JOJ3uUEWTo7AZOD7kJglZUxKyVPxTP180pm8cbScA/55N3V5GvvWHA5ZbRHdyFOaoYp6erYSpdTIAiijSwjRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971939; c=relaxed/simple;
	bh=ss0U8Sne8JX2RRQYG70Dblzkx0zGov8b7Li0sNMZSTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p432P3VYdcaRGi6Es3V5InmMJudldT18MAnpbR5Dz7nzNClYlG8Sh+R5tRW4b3hKK4J625T/x8lNMy7/YhTWB7Cfkc4GevfTV1FntDxgJavTHRg9tHzIm6WlagICeXKLUEK/2GiJqYJ1SzyXN/Y92FePY9ZT4C1dZJmZb9f4x6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hOieqzBJ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hOieqzBJ"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250904074532c9d28586660002074a
        for <xenomai@lists.linux.dev>;
        Thu, 04 Sep 2025 09:45:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OaFf2jOWjyxyJ81+x4J2k//DvrLYPNKaXGs/yWuI8Dc=;
 b=hOieqzBJHLsiZI2yPKhbFUwxGI3o674+dL21e/VmLZW8H/cRG62wU6D5P/M9oGuLrvUfVt
 5N64yzrx99sVYFU1EOge+xKhhmhwKUblIWy4DT/kLe6hZfALksXT3zoz/r777NJDE/vefIwN
 MRcU9gxWJdRjk4CjkcehIVWqYqbpD6pkTB/Pgq3UJfE9Ndgy7KhshIVQhePXPurq1+pZCtZ6
 EchWthS3m2/QefiGP+u3pNxrvnP/KgrFLsFoVXJmuAPNB0EbYgNFScibfpDh7nVRDGWvzV2j
 Obus2pc1xxp2nDh9AyW6QIlhUdiKyayBp36senpjXjw9aD7dwpBTtUXw==;
Message-ID: <965f33cf15a8834446e448a278f30c9684df7e89.camel@siemens.com>
Subject: Re: [PATCH Dovetail] irq_pipeline: Fix system freeze triggered by
 periodic edge type IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 04 Sep 2025 09:45:31 +0200
In-Reply-To: <87wm6fjy9r.fsf@xenomai.org>
References: 
	<20250820-wip-flo-fix-edge-irq-handling-v1-1-1a2c7805b372@siemens.com>
		<2cb5e8c46cc8d841cf5f452a753d37e7079f3036.camel@siemens.com>
		<87h5xjlf56.fsf@xenomai.org>
		<e7d5cddf94d3d1479e987950a07ee7483820ff1a.camel@siemens.com>
	 <87wm6fjy9r.fsf@xenomai.org>
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

On Wed, 2025-09-03 at 18:28 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Wed, 2025-09-03 at 17:39 +0200, Philippe Gerum wrote:
> > > Hard irqs have always been off while running the IRQ flow handlers
> > > grabbing the IRQ descriptor lock, this is a fundamental requirement, =
no
> > > change there. handle_irq_event() drops the lock before calling the
> > > (user) IRQ handler, then reacquires it before returning to the flow
> > > handler.
> >=20
> > Thanks. So
> >=20
> > 	hard_local_irq_enable();
> > 	do_inband_irq(desc);
> > 	hard_local_irq_disable();
> >=20
> > in sync_current_irq_stage() allows pipeline entries for other IRQ lines
> > but the desc->lock prevents this for the same line. Correct?
> >=20
>=20
> What prevents subsequent triggers of that IRQ from happening while it
> flows down the pipeline really depends on its flow handling and the
> requirement for delivery to in-band.
>=20
> - a level-triggered interrupt stays masked until the in-band stage
> handles it.
>=20
> - mere oob-handled interrupts are unmasked as soon as the oob
> handler returns.
>=20
> - non-masked (device) interrupts are serialized by the desc->lock across
> multiple CPUs that could receive them.
>=20
> - the in-band stage is stalled (pipeline-wise) while synchronizing the
> interrupt log, so we cannot pile up handlers, although we might receive
> and mark a subsequent occurrence of some IRQ which is being propagated
> through the pipeline. That is the reason why sync_current_irq_stage() is
> a loop: we might have received more (in-band) interrupts while we were
> busy handling the current one.
>=20
> - lastly, oob handlers cannot be preempted by the same IRQ since they
>   always run with hard IRQs off.
>=20

Just found
https://lore.kernel.org/all/20250701163558.2588435-1-liangyan.peng@bytedanc=
e.com/

which was basically trying to fix the same issue for Linux. Seems I
have to understand that first. Thomas added some detailed explanation.
Let's see if that helps.

> --=20
> Philippe.
