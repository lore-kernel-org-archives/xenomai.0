Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17F45C06
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745856; cv=none; b=k6RBNCobzwt673TtELE7TeooRPgQESnCGZKuiYqTpdYA0wSItsbF65w3W3rr9/mvwIQ8gw9nc+jTid3B+gEAvD0hD7ZsojjMip+aKQvyTApTM0ImuqNsEtwAMPlfHb2okaqjN+ojoSZJ+zfivPCPh8MV+eQMnXQ+IuynmgCdWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745856; c=relaxed/simple;
	bh=DHQNraTfSKNeXl6r7G6NNwEPDWR4RPsTB4kdnEyqDjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iIIzs7pKnwduH3RzrKxRam2xjwxRuDoW4EsoUYWhAsnA9cdELI5R7ngdfWQ+VM7qaVLOeq3Y4umg9xfhNvqm8vXN7PFVSWbUP3DOUFPbeMw2bQX8OhXZqDWbrRL3Mb8/CH/GGQ5DFbZtKmCLHTKxTmWYpoms2yOCo3tV4VNG0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=L2sgdFZz; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="L2sgdFZz"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240607073726f095eb7ed3181bb988
        for <xenomai@lists.linux.dev>;
        Fri, 07 Jun 2024 09:37:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PtaIFO6X8ME+f0KJ7aYDuHm9QejELwLLLxoFFqSzERI=;
 b=L2sgdFZz3FR/mzqV3Keqbr5ZCK72Au7Ck9b7PUNfrecgobpjUt0Sp7P3DhY3JHmxZwoTNT
 s3MtKE7GBrT4tp+V9MRMugWhxjKkpCuaDNL1q7wXPjoqLccmMMrB5WEEf/6mz9dTFHM1HXtx
 7LUlxIxk3G7V/f3xmwOGgN1cNxiSY=;
Message-ID: <de1d8749762542e17035afeb7b1fdb5be61107d5.camel@siemens.com>
Subject: Re: Dovetail/Xenomai 3: Timer tick locking problem
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 07 Jun 2024 09:37:25 +0200
In-Reply-To: <87o78edytl.fsf@xenomai.org>
References: <1a4aa9f3bfb30fe5b5955fea1486a5fb8b040ff2.camel@siemens.com>
	 <87wmn2eawl.fsf@xenomai.org>
	 <7a14422b15d534a2a66b6128938e24f8ed08fe99.camel@siemens.com>
	 <87o78edytl.fsf@xenomai.org>
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

On Thu, 2024-06-06 at 14:42 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Thu, 2024-06-06 at 10:18 +0200, Philippe Gerum wrote:
> > > > When running over an OOB task that is currently owning nklock, we w=
ill
> > > > release the lock unconditionally, leaving the task "unprotected" /
> > > > unsynchronized. Right?
> > >=20
> > > No, the only way for a task to hold the ugly lock safely is to disabl=
e
> > > IRQs if it has to compete with an IRQ handler. So this scenario is by
> > > definition a usage bug on the application/driver side, not on the
> > > infrastructure's. Meanwhile, the _irqsave() variant prevents spurious
> > > lock release in recursion using a special marker in the saved interru=
pt
> > > flags.
> >=20
> > I just checked all nklock usages. Most of them are indeed using the IRQ
> > safe variants. But:
> >=20
> > In xnthread_relax() we have:
> >=20
> >     splmax();
> >     xnlock_get(&nklock);
> >     xnthread_suspend(...);
> >         xnlock_get_irqsave(&nklock, s);
> >         xnlock_put_irqrestore(&nklock, s);
> >     splnone();
> >=20
> > As xnthread_suspend() is using the _irqsave() variants, it's basically
> > a noop, the recursion will be detected / handled correctly.
> >=20
> > What happens, if right after splnone() the Xenomai timer tick is
> > handled?
>=20
> At this point, the current task is relaxed and does not hold the nklock
> anymore. It's been released by ___xnsched_run() <- xnthread_suspend(),
> on the exit path.
>=20

Exactly. Thanks Philippe.

I think I narrowed it down to kvm_wait(). Propably it's not a good idea
to enable the hw IRQs unconditionally after coming back from a vCPU
kick. Testing ongoing, maybe you can have a look as well.=20



