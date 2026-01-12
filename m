Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9192E7F11
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228048; cv=none; b=ukNqBaj3jK3TTrq3VKh6jDx/aAb4oW7Cq48mdCunoEdg3aQoFE0/Qy0QphbfPxHd9nivfVkn5X0uG123en0XdIalPo3EhU+1nxylArWP+L0E9MmL+LxIh59pVK7DHcBcBPa+UTDHBkvkdCrv79k9fstbdneOfXuoijAHltsKeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228048; c=relaxed/simple;
	bh=dl/6c6wonaoeWyQtbwyOQtuImI+MDCF2KVZfZDjuz7E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t4z/LBvq4y1cAZnUi3ChKTsuiB+HJ+2yhe85NqcSDB8fdFimhl+CfVtN+VBBGd8jOyT2q3Dgi5NN0Bek/OkwgAVn80MoSQUs6dB13C1hFavS4Jgb187rwhIMmunUH4UjeL1d16ToMlTxbKGyQyHteLdWsvKE++jOepEfc1NhUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KjneX8cH; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KjneX8cH"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202601121427182280c61e180002076d
        for <xenomai@lists.linux.dev>;
        Mon, 12 Jan 2026 15:27:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=oacmLdP6tPxB1wFse2Aa+TdeAj0KdE82bjE1KQo6CHE=;
 b=KjneX8cHDHWiJAFCKUUqYgHIRG9zFjFeeexnpVE3hNRstFQGFplLHwGD+uhQ1Kl6DlfTCe
 K0yfVLP6l8fOgtO4TmRDyiWk3WdUSx04GI5owRFbNGId5vrgr+Uu6JxHnEXyyLhacmJZ0PNQ
 co2xox2UkxfIB0Kih0wvn/3y02Gfs2wEuDmqpZaye6kN9uuZXPGIOcTOEyUhJGr+oGNWjRnG
 gyUFjiwzff2Vkd7bJCYmkYnHJ+HxBpUMvNUikN4ZgaebZMEFrR+9YPjtnPtpuU1Sb4al51a/
 7jrVKeH5S4tbUeKbLCBDY2boLqddshBSyeYiCdwPuAhlHWn2zNhVxvQQ==;
Message-ID: <b7273fbc764ebe2c5b40b2c1285a0ea56324caee.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 12 Jan 2026 15:27:17 +0100
In-Reply-To: <993b8ab6-6dd6-4a24-92e4-928fb03fd26c@siemens.com>
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
	 <20260109142001.2548128-2-clara.kowalsky@siemens.com>
	 <8671583f7cf796643263dde1d4e6b8640b3821c9.camel@siemens.com>
	 <993b8ab6-6dd6-4a24-92e4-928fb03fd26c@siemens.com>
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

On Fri, 2026-01-09 at 15:52 +0100, Jan Kiszka wrote:
> On 09.01.26 15:42, Florian Bezdeka wrote:
> > On Fri, 2026-01-09 at 15:20 +0100, Clara Kowalsky wrote:
> > > The linux-dovetail repo is configured in the CI/CD settings to use as
> > > configuration file this file in xenomai-images.
> > > This adds a CI job for triggering the xenomai-images CI if new commit=
s
> > > are pushed to a supported dovetail branch.
> >=20
> > What is the overall goal of this series? To trigger a CI run if one of
> > the LTS branches moved forward?
> >=20
> > If so, is there a plan to clean up all the branch specific recipes?
> > Keeping them in lockstep should not be necessary anymore, no?
> >=20
>=20
> I can't follow here. What exactly would you do differently?

Ignore that. I thought that we could remove the kernel recipes
referencing a fixed kernel version. But that would break the "build a
reference image" use case. See below.

>=20
> > In addition the gitlab magic (uncommon project configuration to point a
> > project to a CI configuration from a different project) is completely
> > hidden. The file seems unused und might easily get removed. There shoul=
d
> > be a comment somewhere explaining that.
>=20
> Good point, can be done in the file as well as in the README.
>=20
> >=20
> > I'm also unsure if we should really move that logic into the xenomai-
> > images project. Seems a bit overloaded already. Maybe it's time for a
> > xenomai-ci project?
> >=20
>=20
> xenomai-image is so far the project driving the main pipeline that also
> does on-device testing. But there is also CI in xenomai3, e.g. A
> separate "xenomai-ci" project would sound to me like all CI is handled
> there - would that be your vision?

To me the purpose of xenomai-images could be split-ed into two parts:

a) Build reference images. Images that get you to a working starting
point within seconds.

b) CI. Build all the kernel/arch/userland combinations that we need.

The b) part is getting more and more complicated, which might confuse
users - especially beginners. We have a lot of bitbake and gitlab-ci
magic. At some point it might make sense to split those different
purposes into different projects.=20

>=20
> > >=20
> > > Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> > > ---
> > >  ci/ci-dovetail.yml | 43 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 43 insertions(+)
> > >  create mode 100644 ci/ci-dovetail.yml
> > >=20
> > > diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
> > > new file mode 100644
> > > index 0000000..52685e6
> > > --- /dev/null
> > > +++ b/ci/ci-dovetail.yml
> > > @@ -0,0 +1,43 @@
> > > +#
> > > +# Xenomai Real-Time System
> > > +#
> > > +# Copyright (c) Siemens AG, 2026
> > > +#
> > > +# Authors:
> > > +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> > > +#
> > > +# SPDX-License-Identifier: MIT
> > > +#
> > > +
> > > +stages:
> > > +  - set_vars
> > > +  - trigger_xenomai_images
> > > +
> > > +default:
> > > +  image: debian:bookworm
> > > +
> > > +set-vars:
> > > +  stage: set_vars
> > > +  script:
> > > +    - |
> > > +      KERNEL_VERSION=3D$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0=
-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
> > > +      echo "KERNEL_VERSION: $KERNEL_VERSION"
> > > +      { echo "KERNEL_VERSION=3D$KERNEL_VERSION"; } > vars.env
> > > +  artifacts:
> > > +    reports:
> > > +      dotenv: vars.env
> > > +  rules:
> > > +    - if: '$CI_COMMIT_BRANCH =3D~ /^v(6\.(1|12)|5\.(10|15)|4\.19)(\.=
y)?-dovetail-rebase$/'
> >=20
> > There is no 4.19 branch in dovetail, good old ipipe times are (nearly)
> > over.
>=20
> Yeah, we may also skip 4.19 for now - or forever. The exact EOL date has
> not been set, but I already warned about it in different threads that
> all users on our end migrated away by now.
>=20

Hm. I think that the workflow is broken. We need something like -rc
branches for all the kernel versions.

If CI reveals an error for one of the branches it's already to late. A
public branch has been forwarded, so we can not revert / restore it.

The usual workflow is: Push changes to a -rc branch, run CI on it, if OK
move ahead and merge it into the "release" (=3D non-rc) branch.
