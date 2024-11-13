Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5033FE
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511504; cv=none; b=sLcUENNu2kVBP689qMGLV8sC/oVi/VTPSE9KLK9O3Bg+dC1UECIkXhVz/pHv/MKSH9VyzWSW6q6shGosf/OYa5+g492ChzMaf8CsJH00uhcXEpA9Td+Z7rrQHTQuBhut37j4y6U8VZa9cL1jerTGkP8lTX32JI8b3SxcQvuTdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511504; c=relaxed/simple;
	bh=5WQO86KOoN8Et1AsPLKnK9s1mhyU1Ja0IjXt4C92cw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWqerRTbDqZdvp3bUDkNrjNbqIFayhRSpIlyRq/WpVmSOKqsdpCIPjcO98kD4O68/abopCoBXxFA73b3drgYH1UvRrCSOgRgzTaJzIgv57sP25KNAjsnPI0bRtVjdsf4d2DNviW5l0bFdHJac11fpWE/Wv+H3BddOL+oEdJCZ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LRvh+Nd5; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LRvh+Nd5"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241113152456b7e70a1c746cff8a3a
        for <xenomai@lists.linux.dev>;
        Wed, 13 Nov 2024 16:24:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nXprrAYW8b2GRCT/Ein9gpWY3B1Yq0/1XRoZipdJcH4=;
 b=LRvh+Nd5SkaRqhUQA4qNd7XNnibewqQsct+Qh6eMSo3n1Mf/3/SBYmvwB0jVTqdge/2PkD
 E8SmdrQUUDYzUuSKXJBxp0ZHArB8lFo93SrxgZKuwk1VsLDQBy9jbWQdRS7Pw7DyXM81jpwE
 Zj6DgqoID+qgocad2iKecUjWEelLvn+vONoKFRoWuOjTuu3gS19v4MWu68gPczJCzgqR3yWl
 JwTBBBvVhiNmpRlTI5LZyxavPLYOPgo94wttzKZcMV1LTk+sV9scOH2EM35TTIRpd/Pu8lgO
 HdMyCDyjEKZm02aLQgx0CUrYzrqQVh5XmLvhCEoHHD7E45d+SpwfefwA==;
Message-ID: <af9e0e0eb919c82645a4afa6334f134fecb7b163.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 1/2] ci: Add scheduled job to build
 lavacli container
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Date: Wed, 13 Nov 2024 16:24:46 +0100
In-Reply-To: <f1e1d2111b007f20009485359b45482d09934429.1731508393.git.jan.kiszka@siemens.com>
References: <cover.1731508393.git.jan.kiszka@siemens.com>
	 <f1e1d2111b007f20009485359b45482d09934429.1731508393.git.jan.kiszka@siemens.com>
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

On Wed, 2024-11-13 at 15:33 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> We want to switch to self-built Debian containers with lavacli
> pre-installed. That will speed-up the start of test jobs and avoid the
> manual installation of lavacli in each of them. To keep that container
> up to date, prepare a pipeline job that will be scheduled once a month
> to perform a build and deployment to gitlab.com (source.denx.de lacks
> a container registry).
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .gitlab-ci.yml        | 14 +++++++++++++-
>  ci/Dockerfile.lavacli | 17 +++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 ci/Dockerfile.lavacli
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b8945bc..37d2a6d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -15,6 +15,7 @@ variables:
> =20
>  stages:
>    - parent
> +  - build
> =20
>  .parent:
>    stage: parent
> @@ -56,4 +57,15 @@ xenomai-3/next-long-term:
>      include:
>        - local: '/ci/xenomai_3_next_long_term.yml'
>    rules:
> -  - if: $CI_PIPELINE_SOURCE =3D=3D "schedule"
> +    - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $ONLY_RUN =3D=3D $CI=
_JOB_NAME'
> +
> +lavacli-container:
> +  image: quay.io/buildah/stable
> +  stage: build
> +  before_script:
> +    - buildah login -u "$CONTAINER_DEPLOY_TOKEN_USER" --password $CONTAI=
NER_DEPLOY_TOKEN_PWD $CONTAINER_REGISTRY

Where are those CONTAINER_ variables coming from?

Using them as cmdline arguments can easily leak them by enabling
something like CI_DEBUG_TRACE.

We break the "fork and re-use CI configuration" workflow even more now.

> +  script:
> +    - buildah build -f ci/Dockerfile.lavacli -t $CONTAINER_REGISTRY/xeno=
mai/xenomai-lava-container/lavacli .
> +    - buildah push $CONTAINER_REGISTRY/xenomai/xenomai-lava-container/la=
vacli
> +  rules:
> +    - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $ONLY_RUN =3D=3D $CI=
_JOB_NAME'
> diff --git a/ci/Dockerfile.lavacli b/ci/Dockerfile.lavacli
> new file mode 100644
> index 0000000..5d5725b
> --- /dev/null
> +++ b/ci/Dockerfile.lavacli
> @@ -0,0 +1,17 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +FROM debian:stable
> +
> +ARG DEBIAN_FRONTEND=3Dnoninteractive
> +
> +RUN apt-get update && \
> +    apt-get install -y sudo gettext-base jq xmlstarlet lavacli
> --=20
> 2.43.0

