Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795031B131
	for <xenomai@lists.linux.dev>; Mon,  3 Nov 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191509; cv=none; b=DnNcv/r+2sx7/KfqsWNdI6u59QcO4Gg9Zcsf1capN+U9pM5Oilk3VxDnLOrnAh+oy0ndCSGSQLlRqvoLLh+FJYSpG1R16RvhFTn8t7YlywePY3S+ds2xfZYq+nD9n3Ozk5XZupPTabo5eYoJ0WF+XW3nB+a+SGfD5RuoJE2Jy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191509; c=relaxed/simple;
	bh=B+zDBtQKAIZef6T871UR542r5uVRZd63aBW4RM8Dcco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIFubdtqVgB+pGTzN9RGcAuurPAHeOOLDOcOaQKVVit6jLmXJHsKaLsBWKLno9/mVXFApTUPCofdGge66tKfVQMgHvgROB+jWzqVJDqsFgaV9fGxL9I43Op7N83QD4+2Q7RpMdRMIWWRxBLUEaYjQFIjkDvo4pdcrlI6oLBFzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HFi/h+Bo; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HFi/h+Bo"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251103075737b6b35ec1e8000207c2
        for <xenomai@lists.linux.dev>;
        Mon, 03 Nov 2025 08:57:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B+zDBtQKAIZef6T871UR542r5uVRZd63aBW4RM8Dcco=;
 b=HFi/h+BooKTzKUalLVWPCymyyDvxoK/RyezLal7BKKYFZlxKtQT5J484dD5hpAHnGZSheL
 /jFFlL0BYK668Y5jYnzmoZOnMKBWdw3o4Ub1PuIJr2N6NO0cDATeYlbodPF1n5d6xAD9dqGL
 XhZLHIsr0wnOivpi7dzGmkMswvYJTvdlDRft1NMYQEycqrvMaswJM+iM+D0V+eYxzpXZJPKX
 nnK+wjuXNyzZUETsaJ1jrtQbMP2nUS6MwqHoo3Cf/vCAKpzJ4PPB+yqniTwfVv86Q0BpgNsv
 8ixjZ93+vBtaV7pNDO79D8AeHlzNAlj1yL6M6wh3bMgcidBSD9U8uZfQ==;
Message-ID: <2de7f3b171d713e45a624896ea170d49066d5aeb.camel@siemens.com>
Subject: Re: Unexpected switches to in-band
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?UTF-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>, Giulio Moro
	 <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Date: Mon, 03 Nov 2025 08:57:37 +0100
In-Reply-To: <87qzujaqlw.fsf@xenomai.org>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
		<20251009151737.0d03b211@wsk>
		<20676160-4572-d92d-4b33-ff4255946345@bela.io>	<87qzv9sa9c.fsf@xenomai.org>
	 <87ikgls9kh.fsf@xenomai.org>	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
		<20251020094705.2ac256f2@wsk>
		<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>	<87o6q1ad07.fsf@xenomai.org>
	 <20251023155439.0170f987@wsk>	<87a51djuor.fsf@xenomai.org>
	 <20251027120535.7933c720@wsk>	<20251027172505.29eecfb2@wsk>
	 <875xbyawx7.fsf@xenomai.org>	<20251029145125.71debaab@wsk>
	 <20251030132602.2d1ccfcc@wsk>	<87qzukuzy5.fsf@xenomai.org>
	 <20251031165615.2c9f72f5@wsk>	<87bjlnc9u5.fsf@xenomai.org>
		<5c69758f-876b-4a56-99b7-09eb22537680@siemens.com>
		<875xbvc5a3.fsf@xenomai.org> <87qzujaqlw.fsf@xenomai.org>
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

On Fri, 2025-10-31 at 19:11 +0100, Philippe Gerum wrote:

[snip]

> > >=20
> > > > Thanks. I need to analyze the fault flags next week to see if I can=
 make
> > > > something of these, but I just stumbled on an obviously significant=
 fact
> > > > when looking at the multi-CPU view: the memory compaction daemon is
> > > > running asynchronously on other cores while the responder is taking=
 the
> > > > fault. Compaction is all about moving memory around to free larger
> > > > physical regions, so updating PTEs will happen as a result.
> > > >=20
> > > > Moreover, I could not reproduce the issue at hand, but I did not ha=
ve
> > > > CONFIG_COMPACTION enabled. In the meantime, could you try disabling=
 this
> > > > on your end, to see if the fault still appears?
> > >=20
> > > CONFIG_COMPACTION selects CONFIG_MIGRATION, and that is well-known to=
 be
> > > incompatible with RT. Xenomai 3 is warning about that that, EVL does =
not?
> > >=20
> >=20
> > Dovetail should do that when CONFIG_DOVETAIL is set, this is by
> > definition common to any rt core.
>=20
> Also, it would be much better to find a way to exclude any mm bearing
> the MMF_DOVETAIL flag from the movable set, instead of excluding
> everything that sets CONFIG_COMPACTION.

Are there any concrete ideas already? Asking because I'm expecting this
topic to appear on my radar soon, again. Some colleagues were fighting
with the opposite direction in the past: CONFIG_COMPACTION being
disabled. That caused some trouble with a memory intense application
running next to the RT workload. The OOM killer was invoked quite
regularly.

Florian

