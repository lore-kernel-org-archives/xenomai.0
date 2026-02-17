Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5D29E110
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319795; cv=none; b=W6kMf+H9NmUnzYpXoh5fkbJam+PxU32mEGF+X9bEqM/vSTkg2oNChrnSnwsBe/txIYYoxYQI5226i1hJ/CDk4oUfLmvvtpNH5ESw3JG+pJqTCXbz4v9qNX0/Bl94QC/hnXthyu7Qev6rGwPlJ7nVEr6nBdFHsI01QxPkwhQwS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319795; c=relaxed/simple;
	bh=9yuNxvFf16CLNUhY2wRtTBAApbHd2yBevilpuhYV9Og=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q6yO/RDqt0omnva7BhdQPv9kLJIf8RzqedSAa1w/u63dhUiDXdWKGCqI77bHcyiGZByXefVS1bOviP5YJB/UZxvvPgMMrjDvEvt92wcnWEgHkt+BqX12og9kyVRjLcbetyu67JT5K569u+B5eRCJxkdiVQWY8lSnB9m1HzbF1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gx2ZHbKA; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gx2ZHbKA"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202602170916215771ffccdc000207f1
        for <xenomai@lists.linux.dev>;
        Tue, 17 Feb 2026 10:16:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7kvIKlsTDp4xRKlAsM8yCJAHU9AZZwLzclPiX28P/KY=;
 b=gx2ZHbKASadAKb5lafxHV72qiSjqqmL9KMjyVIjDYTQH3Ps86nAJnfMQNN8IY5NWXfU4uC
 TPMRUpG7cES6i4c+e0P5/1y03O8Ic4TppW65kLWRRoBoouZRXo89sj8nqfGKMQO+2IGGee8W
 jjzfEJcQNCVcMQrQYkBeBk1raqVizOoKE5fFajKrjid7RTS/lEmZfLmrRiVszaA4FIUB/rB6
 Db6cbDqXTq9Wrk0Y4V3A1gbr/4cAJPhltJGVo1hOqbEk1hzoBr5WtL8sKFqGQCi4INrqkU2Q
 b9ir4EsvJbP6paxHys0ImyPFtZkiJBCk1PhIeOIaFJWM7ULg9ZIPQGtA==;
Message-ID: <430245ce2bc8da023235e9cf1312f729d7c57494.camel@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>, Jan Kiszka <jan.kiszka@siemens.com>
Date: Tue, 17 Feb 2026 10:16:21 +0100
In-Reply-To: <87ecmjahk3.fsf@xenomai.org>
References: 
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
		<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
		<87jywbajfy.fsf@xenomai.org>
		<505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
		<9e12c4a73df2d24dd1b39ab196b0112cb4e7e6ef.camel@siemens.com>
	 <87ecmjahk3.fsf@xenomai.org>
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

On Tue, 2026-02-17 at 09:41 +0100, Philippe Gerum wrote:
> > Comparing with x86 again, I think that my proposal is "correct" in term=
s
> > of identical to what x86 does. Do all architectures have a gap here?
>=20
> x86 has a single implementation for both user and kernel preemption
> paths, arm64 has two since the privilege level is explicitly stated by
> the irq handler being called, but this still must translate identically
> logically speaking. Your implementation is missing the kernel preemption
> path after demotion.
>=20
> i.e. when checking for running_oob() || irqs_disabled(), the cases
> covered are:
>=20
> (1) in-band user path on entry (implies !irqs_disabled())
> (2) oob user path on entry (might be demoted)
> (3) (virtually) stalled in-band kernel path on entry (implies no reschedu=
le,
>   filtered out by irqentry_exit())
> (4) oob kernel path on entry (might be demoted)
>=20
> Therefore, with your patch in, el1 is now missing (4).

Right, but I'm wondering if x86 ignores this case as well.

After demotion of a oob kernel path entry, user_mode() should still be
false - bypassing the call to irqentry_exit_to_user_mode() - No?
