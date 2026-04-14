Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DDD39657D
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164581; cv=none; b=STpGZKgOw/kpEB9kcockUjtPFyOeP34V040Vv5pNPbwZhhJ4+7mP0bUhIcE2eXjY6ag0+Le3eg1HU+ZmEDeLbWMhBDPCU+TK0U50klNi9QBiBr16Ov0j7hbmzvECRpC7OoqwgemISQxf6uT73ylUza0oP0X27nOAfMsJNElf8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164581; c=relaxed/simple;
	bh=sfMQCY+8TuOgqTFpBnW3I7HlIBdF7OWnIpxXltjgBm8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BMKPNwmV005agpMpBOQKyHO6+1l4BnIbOa7TXJ50mKx4DPnSgyOYfUUNpvPh9yvv6WZtvcSA9/BAQbJmkwdlW8Go8gRFM18FdyZSIevlJheIjwywsLEG8hrIol5UZN6bQUs8bOdahL2Ge/wrZYRBXWrg6KoBMBmzDEFqnYj4IWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B61B4298599;
	Tue, 14 Apr 2026 13:02:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id dcds7Tks1z7C; Tue, 14 Apr 2026 13:02:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 263C329859E;
	Tue, 14 Apr 2026 13:02:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oV5CgMx6wkcw; Tue, 14 Apr 2026 13:02:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id EB16E298599;
	Tue, 14 Apr 2026 13:02:54 +0200 (CEST)
Date: Tue, 14 Apr 2026 13:02:54 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
	upstream+xenomai <upstream+xenomai@sigma-star.at>
Message-ID: <277806441.56046.1776164574699.JavaMail.zimbra@nod.at>
In-Reply-To: <0b212101-486d-4334-9e03-89ed95fdfd99@siemens.com>
References: <20260412073425.956320-1-richard@nod.at> <af74e234-327a-4b59-a33d-8d817e34eaec@siemens.com> <946371069.54252.1776111069832.JavaMail.zimbra@nod.at> <0b212101-486d-4334-9e03-89ed95fdfd99@siemens.com>
Subject: Re: [PATCH] xnsynch_requeue_sleeper: Return early when
 !XNSYNCH_PRIO
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF149 (Linux)/8.8.12_GA_3809)
Thread-Topic: xnsynch_requeue_sleeper: Return early when !XNSYNCH_PRIO
Thread-Index: sK+lt7CFTPqV4Fe5gTgHtp+td2/lYg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> Right, a prio adjustment of the lock-holder that is blocked on xddp will
> not take place with PP - prio adjustments happen already on lock entry.
> But your changes would still cause regressions to
> xnsynch_requeue_sleeper.
>=20
> Let's step back: In the PI case, the lock holder will be on a FIFO queue
> while waiting for messages. So it may not be woken up first if there are
> multiple waiters - that is something we probably cannot change as we
> have no information about other waiters in that queue and their urgency.
>=20
> Once woken up, my next question would be if the right prio is used from
> there on until the lock is released. That should be checked by test
> case.
>=20
> Now to clarify why your changes is not yet correct: A thread is blocked
> on a PP mutex while holding a PI one. If someone tries to get the PI
> lock while have a high prio than the PP mutex, the necessary propagation
> of this prio to lock owner will no longer work. I'm not sure if we have
> such a test case in Xenomai, we definitely should, and this one would
> reveal the regression.
>=20
> Maybe this is already enough and correct:
>=20
> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
> index 70c05c1f49..33ef8ef183 100644
> --- a/kernel/cobalt/synch.c
> +++ b/kernel/cobalt/synch.c
> @@ -963,7 +963,9 @@ void xnsynch_requeue_sleeper(struct xnthread *thread)
> =09struct xnsynch *synch =3D thread->wchan;
> =09struct xnthread *owner;
>=20
> -=09XENO_BUG_ON(COBALT, !(synch->status & XNSYNCH_PRIO));
> +=09/* Nothing to do if waiting in a FIFO queue */
> +=09if ((synch->status & XNSYNCH_PRIO) =3D=3D 0)

The comment is a bit misleading, IMHO.
!XNSYNCH_PRIO does not guarantee that the synch object is a FIFO queue.

> +=09=09return;

It passed my tests. I'll resend updates patches ASAP.

Thanks,
//richard
