Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310762D97A0
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887611; cv=none; b=jP4ipijr4+IUxyAEwNaqx85QVNh0TaeAp2MpEgDfYGnejFjX638h1Zt9drFof+o0P40OK784zdKpqRusmHtUuc2e0lbxPMFUousxVY1gIl3WnOX7u9UaJAQaagIA+26y/t4mX5BXheKDROvXTYiGMwYuLZArV/OQqpmu2Ur55XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887611; c=relaxed/simple;
	bh=Y2J6mYHFl703S8weUwzv8J1yrshrqrtEQDI7zBEnpjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c0d1+eYGVovlQSs6z+AHH3XHdOFuENfftrbXW8vUqTBhdkxFOKypyTeYzMtGZz2w7cWE9ndz88Nplh8SLQxBWvlMlmT9q4ihs1MBUyxdRw1fPOTqYYGn/rULun72bJmV5gCCrzOc+/jehPyurUt2rFBsZdzSJ8EWrxGZfP0f7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=M01tFaYY; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="M01tFaYY"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025090308200157d5a7ee6c0002077e
        for <xenomai@lists.linux.dev>;
        Wed, 03 Sep 2025 10:20:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oFcEvcuqy9CvKjbmrFN3fDy8HEWgs5czSwFmd3BVHhU=;
 b=M01tFaYYkx03bhz13Sh1l29a6JuZLZTbdfX0M6dr6C45ubcl+yURxHm21SNQATid9PsmEx
 2SMrWwO031WLUOKRwUwSvgzhBGFhNEV+betf+Eyh/NyOzSlqRh66HhT6pVfVV98pV632FjT3
 p9XPTbP1Ix/1woxj9vAHL+mRaAt0sFFaPZeWdsef6yqg0KrYVcKUbU7frUXKU2BMFot5qQhf
 3Tpb+C3Ph6iivdQJwzcRMtIRD9Mu+QCLNc+su1mkU5+f+HzGv5iRAWr809ePW8D2Xax6etUs
 L2kqPdppbmkboyKctbnOiPYWCqP5ftzLNa+Xzyd3azonRD4F+l9gk4fQ==;
Message-ID: <f8763856cc438efa5c6db68eaeccb2b801d15237.camel@siemens.com>
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by
 default
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>
Cc: "Schaffner, Tobias" <tobias.schaffner@siemens.com>, "rpm@xenomai.org"
	 <rpm@xenomai.org>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Date: Wed, 03 Sep 2025 10:20:01 +0200
In-Reply-To: <aLf4UwoftyHc5pHS@trex>
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
	 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
	 <87jzisrkfo.fsf@xenomai.org> <87v82cpvl8.fsf@xenomai.org>
	 <ZmvxUGDwvbyg3vnW@trex> <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
	 <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
	 <Zx6QxE+CNTmQqZDk@trex> <ZyUH7BV50dlhvc92@trex>
	 <f1274ee9-9909-43da-97d8-f426ab9366cc@siemens.com> <aLf4UwoftyHc5pHS@trex>
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

[snip]

On Wed, 2025-09-03 at 10:12 +0200, Jorge Ramirez-Ortiz, Gmail wrote:
> >=20
> > I think we should split these activities into two streams:
> >  - short-term: setup of a well-defined but not necessarily 100%
> >    finalized test environment for EVL so that we can run that
> >    automatically in CI
>=20
> 100%. Do you think it would be at all possible to setup a simple LAVA
> lab with some reference hardware - unless Xenomai has one already?
>=20
> I am not sure how it would be funded - do you know ? - but it could then
> also be connected to KernelCI so that Xenomai enabled systems avoid
> regressions.
>=20
> https://docs.kernelci.org/intro/platform-testing/
>=20
> Is this something at all possible you think?

See lava.xenomai.org.

We had two labs in the past, one operated by Siemens, the other WAS
operated by Intel but has been decommissioned recently. (Hardware)
Contributions / further labs highly appreciated.

Revisiting the kernelci topic is on my TODO list for dovetail
maintenance reasons. No timeline yet and unclear how/if we would
integrate that.

>=20
>=20
> >  - long-term: evaluation of background load profiles and tests to
> >    trigger maximal latencies, with EVL, Xenomai 3 and may even
> >    PREEMPT_RT
> >=20
> > With the first item solved, the second could even be automated and may
> > not need some poor intern to press buttons and record numbers on a piec=
e
> > of paper ;).
> >=20
> > Jan
> >=20
