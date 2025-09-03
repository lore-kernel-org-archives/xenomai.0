Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E772EFDBE
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890788; cv=none; b=YZayYNAQDU31dmbqJo43edeoUpOhCZV9C+J2m1H+PIR8DzAWM1VE/Fa4y+DUAeHw5d83OeM3zzybOsD5TundtdWtYHOL3kQQ1XE8rryRCeGtAWh7yRr3zJlCfi283HiMA5dkP/ovMI2B52/XKyEnnUEIJpbFgGXCy6asFS6GoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890788; c=relaxed/simple;
	bh=9OAjXGsiSWyq87ixCWF3PTywdfpTbQBHNxlhUpvfjcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMhnSYe5hXflOeIFF8SLwPbxVhRRpYyDntPNNL2AkgvdVIXi/KcG6cqPZVkAbHYhbJbtK9BoeI39eseCwSbLrZ88EwAAlAN4sNI2/75G69t6SbzTmuNHBV9K18X2zlmLcGUcGmEQora+nGUArC3iqZcp8oab0orGxDzdVOuouDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=a1UZ0csj; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="a1UZ0csj"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025090309125591dd6cc0280002076c
        for <xenomai@lists.linux.dev>;
        Wed, 03 Sep 2025 11:12:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n0r1jf0YuhH5AEWefqLH/axFD81g1upT+1clZo6mBYY=;
 b=a1UZ0csjTYfrhDLgpr6vSfNjsYkGIImCO6o9K3gmnKD/j1ABnCTpEI52s8fYIIhXj+uuuE
 NII4W2t9qsA7K95/CAsUaVbImQiL63iw93ryVXhuhnh8f2JoHecbvNBnT5LsOeyr+LILoFIm
 REanf9Ctz5QCtjN3xKy07xc90YDAyH1y+tLx3B0T3ud0VcLYe711ZrTxmtlHU7+oRIq0/Yti
 3FZprgeDKPa5p1JWQXAVse6Zj+K5sKvwxvjb8XRSvjNdGnzNyuFGafI68t+J9Biazg9bL857
 N8oD/tTyYw6y/Nycq9tL7n138b2sr0heBpEXo9w5AuBXtbxrFbaem/ug==;
Message-ID: <27d1f9ac5af26a7969aaaf557c0903f4522fa26a.camel@siemens.com>
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by
 default
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Schaffner, Tobias"
	 <tobias.schaffner@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>, 
 "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Wed, 03 Sep 2025 11:12:55 +0200
In-Reply-To: <aLgAQ9fTlpvQ6wbj@trex>
References: <87jzisrkfo.fsf@xenomai.org> <87v82cpvl8.fsf@xenomai.org>
	 <ZmvxUGDwvbyg3vnW@trex> <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
	 <79b2f354ea9a0c2fe5cbe0de9c1305cf34aa6a3e.camel@siemens.com>
	 <Zx6QxE+CNTmQqZDk@trex> <ZyUH7BV50dlhvc92@trex>
	 <f1274ee9-9909-43da-97d8-f426ab9366cc@siemens.com> <aLf4UwoftyHc5pHS@trex>
	 <f8763856cc438efa5c6db68eaeccb2b801d15237.camel@siemens.com>
	 <aLgAQ9fTlpvQ6wbj@trex>
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

On Wed, 2025-09-03 at 10:45 +0200, Jorge Ramirez-Ortiz, Gmail wrote:
> On 03/09/25 10:20:01, Florian Bezdeka wrote:
> > [snip]
> >=20
> > On Wed, 2025-09-03 at 10:12 +0200, Jorge Ramirez-Ortiz, Gmail wrote:
> > > >=20
> > > > I think we should split these activities into two streams:
> > > >  - short-term: setup of a well-defined but not necessarily 100%
> > > >    finalized test environment for EVL so that we can run that
> > > >    automatically in CI
> > >=20
> > > 100%. Do you think it would be at all possible to setup a simple LAVA
> > > lab with some reference hardware - unless Xenomai has one already?
> > >=20
> > > I am not sure how it would be funded - do you know ? - but it could t=
hen
> > > also be connected to KernelCI so that Xenomai enabled systems avoid
> > > regressions.
> > >=20
> > > https://docs.kernelci.org/intro/platform-testing/
> > >=20
> > > Is this something at all possible you think?
> >=20
> > See lava.xenomai.org.
>=20
> nice, is there some document that I can read about this lava instance?
> boards, tests and so on.
>=20
> since it is maintained by Siemens, who can get an account and access to
> the test definitions?=20

The complete setup is a bit different for this project, so that
accounts to the LAVA instance itself should not be necessary.

We test through the public available xenomai-images [1] project, so
generating images and deploy them to the boards. The xenomai [2]
project is linked to the CI pipelines in xenomai-images, so that
updates to the xenomai repository trigger CI runs of xenomai-images.

The list of boards (real and virtual ones) can be found in [1]. The
test definitions reside inside the tests/jobs directory.

To use this infrastructure you must be allowed to push something to the
affected repositories. Main reason is that we have to care about the
build resources / costs. There is no process defined yet how to get
those permissions. Good community reputation / regular contributions
might be a good starting point.=20

>=20
> >=20
> > We had two labs in the past, one operated by Siemens, the other WAS
> > operated by Intel but has been decommissioned recently. (Hardware)
> > Contributions / further labs highly appreciated.
>=20
> ouch, ok. Does Xenomai get any funding ? maybe we could setup something
> with Liberapay to get donations for a company independent LAVA lab.

Well, at the end it needs someone to be responsible for the lab and
regularly care about issues like board hangs / network issues / secure
token exchange ...

It's not just the funding. We would need some kind of "stable
agreement" to operate the lab. Even if funding might get stuck at some
point.

>=20
> sorry for all the questions, just trying to understand where the project
> is since I think there could be value in having an open lab - or maybe it
> is in the works already?

Well the lab is somehow "half-open". It just needs=20

- the patches you want to test =3D> paste them to the mailing list
- someone triggering a CI run
  If you're not allowed to do so, just ask someone with the necessary
  permissions to do so.
  This is the normal workflow anyways. After patch review your patches
  will land in the xenomai [2] next branch, where CI runs will be
  triggered automatically by Jan.

>=20
> >=20
> > Revisiting the kernelci topic is on my TODO list for dovetail
> > maintenance reasons. No timeline yet and unclear how/if we would
> > integrate that.
>=20
> ok.
>=20
> >=20
> > >=20
> > >=20
> > > >  - long-term: evaluation of background load profiles and tests to
> > > >    trigger maximal latencies, with EVL, Xenomai 3 and may even
> > > >    PREEMPT_RT
> > > >=20
> > > > With the first item solved, the second could even be automated and =
may
> > > > not need some poor intern to press buttons and record numbers on a =
piece
> > > > of paper ;).
> > > >=20

[1] https://gitlab.com/Xenomai/xenomai-images
[2] https://gitlab.com/Xenomai/xenomai3/xenomai
