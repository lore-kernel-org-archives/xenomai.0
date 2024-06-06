Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984942E639
	for <xenomai@lists.linux.dev>; Thu,  6 Jun 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670863; cv=none; b=N3NwyqO6H/tfjc4XRvXy4v7j0hh/MMHGKr93o8r88N/NHCAVkAss4/bfYxVJ+wK1lQYMnv5cvbhPEV5no5hkOfqc7Z+Thak2ODUOM5uMTQ7nv5ly/3X9PRWftaTxb+li2lIRKczBdwVnP60SgpHfQKGYAAGy53IFuVJQa252XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670863; c=relaxed/simple;
	bh=tOUgTey9jtLemjEPhiy8G+shfgGtVi36LxrOrPL0bWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFetx3l0EhWMKnMEE9JsPTk7TN6XZ4EvPp8ZqJjY3KXmx/xj9qTjupFMY4MweVT30+yRFDx6gcusUB+vVm6rSyNX8RcRaOfBTmHUnFUeBk4fEYulxm8hfIhPkBLbN6X5iq9ROMCJxGpAp9UfIwRWCxZSGwwP2nl3tJ8JYb3BdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cbJoefg4; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cbJoefg4"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240606104735aead011e8f32929404
        for <xenomai@lists.linux.dev>;
        Thu, 06 Jun 2024 12:47:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=X9eeIsc6jXKTEcSJhlx1HdS8e8eX+eTIDAYca7b2gMY=;
 b=cbJoefg4p+SU4r+MDKooJzTvup/B2XQSsSdqIsE/vw5D/ARil6hMWQDD8fcVZlbZVpX7VB
 NVYx7bVB2xHHYspufH3JVkosEq08gmfXMcE3ceUb6Es1NalnLkNPxXLs3sDWQSRWao9riWev
 nM4pZg1kjTCXcgCt0iMUwlmk2JIr0=;
Message-ID: <7a14422b15d534a2a66b6128938e24f8ed08fe99.camel@siemens.com>
Subject: Re: Dovetail/Xenomai 3: Timer tick locking problem
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 06 Jun 2024 12:47:34 +0200
In-Reply-To: <87wmn2eawl.fsf@xenomai.org>
References: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
	 <87wmn2eawl.fsf@xenomai.org>
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

On Thu, 2024-06-06 at 10:18 +0200, Philippe Gerum wrote:
> > When running over an OOB task that is currently owning nklock, we will
> > release the lock unconditionally, leaving the task "unprotected" /
> > unsynchronized. Right?
>=20
> No, the only way for a task to hold the ugly lock safely is to disable
> IRQs if it has to compete with an IRQ handler. So this scenario is by
> definition a usage bug on the application/driver side, not on the
> infrastructure's. Meanwhile, the _irqsave() variant prevents spurious
> lock release in recursion using a special marker in the saved interrupt
> flags.

I just checked all nklock usages. Most of them are indeed using the IRQ
safe variants. But:

In xnthread_relax() we have:

    splmax();
    xnlock_get(&nklock);
    xnthread_suspend(...);
        xnlock_get_irqsave(&nklock, s);
        xnlock_put_irqrestore(&nklock, s);
    splnone();

As xnthread_suspend() is using the _irqsave() variants, it's basically
a noop, the recursion will be detected / handled correctly.

What happens, if right after splnone() the Xenomai timer tick is
handled?




