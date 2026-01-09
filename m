Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752F238C16
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969782; cv=none; b=aCGDjeud+gehWCl0mr1dGCgln3KjdR7NxFfE4hlBdyR2WbpvHFIAnKpLfKGwSheVjQmaEfVDFu9NEtPwy4T2ox9e0f0BA9hdmLvNiGNAZHdV84kc9GfGkiKzBcGg/6jYpShvCOV+u52hXrowgaCpUCg5+XL2MpsoEQhY0PcP9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969782; c=relaxed/simple;
	bh=tE6UCQ2ktoQcNx5lOW+CH+utg+SyjcPWlG/xzebGShk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DgLlPvX1QDNjOoclFLk14XI+hWMR3JNFth5Cx9t6JeRoOXbpqsNJaSvrK9DOx1pUz9sZYVAdsvYeE9Jv/8qEwM+Ba2aV8UOdlKFyXZTjsQbT1SFk4QUfEfvegoP8fACrKsGw7GG+iMGsTmNRGawS2xmJ89f+gr/Qg8sw4WK43Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=F+ob2y3h; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="F+ob2y3h"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260109144255107d234467000207c7
        for <xenomai@lists.linux.dev>;
        Fri, 09 Jan 2026 15:42:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=r4kp0hIGtDawj8Qt/pdFEI5Agi+tpPhyuElAxeeSeEI=;
 b=F+ob2y3h6qNUQ+3YGCAvfci5Gwzyj/MrnbWqL5a4qYGdVaMGrsTM+hleV43GUd9aRH5pyc
 9paItgFtFSWX92bfgee2J46JcXzhnySjjVv6guml+FrW1D5DP01r4O9TIfd3G40lNONnvkFQ
 oCJH466zQNKT2OTPZCXVuFNjYj72qzKrKdLf/JG3+XtAVtKl5ejE0WRIGY9eAsS6a94Mcu3X
 jsJjuY+Xi+SkCfi5f21lXcp8dTyiWp1zqC38eauFyFZd5KtRtCsOe5pmfjuofhmekJb7jfle
 x1giHdCI6Fd2Rum7X6Kq2jvwsbXQkyegcVzKe24I51/eD2b2ihCsZVGQ==;
Message-ID: <8671583f7cf796643263dde1d4e6b8640b3821c9.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Fri, 09 Jan 2026 15:42:53 +0100
In-Reply-To: <20260109142001.2548128-2-clara.kowalsky@siemens.com>
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
	 <20260109142001.2548128-2-clara.kowalsky@siemens.com>
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

On Fri, 2026-01-09 at 15:20 +0100, Clara Kowalsky wrote:
> The linux-dovetail repo is configured in the CI/CD settings to use as
> configuration file this file in xenomai-images.
> This adds a CI job for triggering the xenomai-images CI if new commits
> are pushed to a supported dovetail branch.

What is the overall goal of this series? To trigger a CI run if one of
the LTS branches moved forward?

If so, is there a plan to clean up all the branch specific recipes?
Keeping them in lockstep should not be necessary anymore, no?

In addition the gitlab magic (uncommon project configuration to point a
project to a CI configuration from a different project) is completely
hidden. The file seems unused und might easily get removed. There should
be a comment somewhere explaining that.

I'm also unsure if we should really move that logic into the xenomai-
images project. Seems a bit overloaded already. Maybe it's time for a
xenomai-ci project?

>=20
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  ci/ci-dovetail.yml | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 ci/ci-dovetail.yml
>=20
> diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
> new file mode 100644
> index 0000000..52685e6
> --- /dev/null
> +++ b/ci/ci-dovetail.yml
> @@ -0,0 +1,43 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +stages:
> +  - set_vars
> +  - trigger_xenomai_images
> +
> +default:
> +  image: debian:bookworm
> +
> +set-vars:
> +  stage: set_vars
> +  script:
> +    - |
> +      KERNEL_VERSION=3D$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+=
\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
> +      echo "KERNEL_VERSION: $KERNEL_VERSION"
> +      { echo "KERNEL_VERSION=3D$KERNEL_VERSION"; } > vars.env
> +  artifacts:
> +    reports:
> +      dotenv: vars.env
> +  rules:
> +    - if: '$CI_COMMIT_BRANCH =3D~ /^v(6\.(1|12)|5\.(10|15)|4\.19)(\.y)?-=
dovetail-rebase$/'

There is no 4.19 branch in dovetail, good old ipipe times are (nearly)
over.

> +
> +trigger-xenomai-images:
> +  stage: trigger_xenomai_images
> +  needs:
> +    - set-vars
> +  trigger:
> +    project: xenomai/xenomai-images
> +    branch: next
> +    forward:
> +      pipeline_variables: true
> +  variables:
> +    KERNEL_VERSION: $KERNEL_VERSION
> +    ONLY_RUN: xenomai-3/dovetail
> --=20
> 2.52.0
