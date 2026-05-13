Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672F195811
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664786; cv=none; b=bW4O6iVsVWiDA4bi2YR3wOCwcscIWWNxlzhYZI1MNZ2PVpKijOuhwecImNFcPzBcy/AdICCYDUYtqkwCiL6Dbvd0aeqpDcSrzFmOWapgYhyoyOlwvcNyiEoF8erCDdVJ2Lpm2RawpTslpQTElTHx9j4PGWv4RaKDNoryMGqDk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664786; c=relaxed/simple;
	bh=wc7V1ldDrbMTD1lJec6ZkQWGseBZGoQ6x3hQuR2tLGc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S6BUoxyb+UvoK05uTPn0hnz4fLs9RrnkAegjDLr2WRvd3hGEuL7ZXgp8S7153g/v3Tef2BN7K6vhDs2VjjIYdkwUWEAg5ElzZYXEzrGNL9SfN14vphHZpiCljtARRRwXVhkyVfA1a9ooXB8T1nytWTYPmEWVwOdcJ3A23bat7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MvC1kVyb; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MvC1kVyb"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026051309324712d324a22200020751
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 11:32:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=y8FHSDLUGmd010Kc9FfUgrikLFndYEivhOQloBGnk8c=;
 b=MvC1kVybCAoyRuh+cN14zbInwrXLg8V4T9rB11wp5r04HpE+4iIqNGHSchaMPE7z7jhM0s
 Za7JNZs62FwbwGFgcvwN0L6DjlyfEIrVdCKJqxT4/fHYtwlNAEThesc1P17dIWTTehbeo3vF
 0LZOo4vlT7JJ/fYMDx3LqFW51jugHtkxdZz/dh39DPr1ZwY8DZu3gYr1h6I38xhKVg57ykT6
 zV/B2O1B6uEIzGPYPbADm6ZbxnzyB0VO5/HBK0yO4PolgeJIRUpUyph+SF8jbnhNNPHhA7TM
 5Qk767FoT1nIEo6PE9oeV7gdOZG3ineRIeAozh94npMPOZhriDczFllw==;
Message-ID: <295a77610687400d43dc4f05dbbb9e659afe4c0d.camel@siemens.com>
Subject: Re: [PATCH 00/32] lib: Finish rearrangement of includes and license
 headers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 13 May 2026 11:32:47 +0200
In-Reply-To: <a23d90ac-e797-43d3-80fe-4fa15df47e43@siemens.com>
References: 
	<20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
	 <aca24e6a-977d-428d-b892-403852958a3f@siemens.com>
	 <bc8ac763cd82eb8f2d2ab53efc0a7b0275ec2551.camel@siemens.com>
	 <a23d90ac-e797-43d3-80fe-4fa15df47e43@siemens.com>
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

On Tue, 2026-05-12 at 12:20 +0200, Tobias Schaffner wrote:
> Hi Florian,
>=20
> On 5/8/26 16:23, Florian Bezdeka wrote:
> > On Fri, 2026-05-08 at 16:15 +0200, Jan Kiszka wrote:
> > > On 08.05.26 08:22, Florian Bezdeka wrote:
> > > > Hi all,
> > > >=20
> > > > This is the missing cleanup of demo/, lib/, testuite/ and utils/ th=
at
> > > > was partially handled already in the past as preparation commits fo=
r
> > > > bugfixes or build optimizations. I finally found some time to finis=
h
> > > > that work for the missing folders.
> > > >=20
> > > > There might be even more potential for cleanups inside the include/
> > > > directory - and as a result once again inside the already cleaned
> > > > directories. I skipped that for now, as I consider include/ as an A=
PI.
> > > > Changes might force users to adapt/recompile.
> > > >=20
> > > > Tested against Dovetail 7.0 already.
> > > >=20
> > >=20
> > > How did you retrieve the header needs and coverage again, manually,
> > > script-based or AI? And what do you suggest to maintain consistency i=
n
> > > the future?
> > >=20
> >=20
> > Sorry, forgot to mention that.
> >=20
> > Formatting and sorting of includes: clang-format (with the option
> > enabled in the last patch)
> >=20
> > Indexer: The indexer part of JetBrains Clion. Used to find and eliminat=
e
> > unused includes. Followed by a manual compile to verify the result afte=
r
> > each compile unit.
> >=20
> > No AI.
> >=20
> > I haven't checked yet if there is any command line tool for identifying
> > unused includes yet. If so, we might be able to integrate something int=
o
> > CI - on the long run.
> >=20
> > For the formatting part clang-format is able to report differences - or
> > formatting violations. At the moment the code base is not ready for tha=
t
> > yet. Too much differences. Step by step.
>=20
> this must have been a lot of work and I really like that you started=20
> this. I had a closer look at the patches and decided to give summary=20
> instead of single comments on the patches as the comments apply to all=
=20
> patches.
>=20
>=20
> A general questions first and maybe this has already been discussed=20
> behind the scenes: Are we sure that we want to we prefer minimization of=
=20
> includes over self containment?

.h files: self-containment, include only what you need=20
.c files: include what you need, from private to public headers, no
          duplications.

> Simple example from the first patch: lib/alchemy/init.c removing stdio=
=20
> but using fprinf() which is now included deep behind a pretty long=20
> include chain which is a bit hard to follow and changes for the=20
> different build configurations.

lib/alchemy/init.c needed a revisit after cleaning up the private
headers. Should be fixed now.

> I personally think that only removing the unused includes and may be=20
> easier to maintain.
>=20

I'm cleaning up unused + unnecessary includes here. Everything included
by private headers already is unnecessary.

>=20
> I tried some more exotic build configurations and e.g. Mercury fails=20
> when --disable-pshared or --enable-debug is used.

Hm. Can not reproduce here - nor in CI - nor with my usual compiler/os
variations. Which ./configure line in combination with which compiler?

I might have noticed that upfront. Testing with:
  - gcc 14 on Debian 13
  - gcc 12 on Debian 13
  - gcc 12 on Debian 12
  - gcc 16 on Fedora (needs additional fixes on top, see wip/flo/gcc-16)

>=20
>=20
> Can you somehow make sure, that we do not have any ifdefs silently=20
> taking the undef path after the changes?
> Example: clocktest.c included xeno_config.h which is now removed. Is=20
> this still included indirectly and taking the if path when checking if=
=20
> HAVE_PTHREAD_SPIN_LOCK is set or is it always taking the else path now?

Whenever I removed xeno_config.h I tested that it is really already
included upfront. In this case:

In file included from ../../include/boilerplate/libc.h:30,
                 from include/cobalt/pthread.h:24,
                 from ../../include/boilerplate/ancillaries.h:23,
                 from clocktest.c:21:

But: There is no tooling behind. I should probably go and check that
again. I might have missed one.

>=20
>=20
> Some small nitpicks:
>=20
> s/Harmonzie/Harmonize/ in the commit messages.
>=20
>=20
> There are some commented includes left in the patches:
> git grep "//#include"
> demo/posix/cyclictest/error.h://#include <stdio.h>
> lib/alchemy/event.h://#include <alchemy/event.h>
> lib/trank/native.c://#include <copperplate/heapobj.h>
> lib/trank/native.c://#include <copperplate/threadobj.h>

Those have been addressed meanwhile. The current state is published as
wip/flo/refactor-includes.
