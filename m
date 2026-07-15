Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896C42047A
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120474; cv=none; b=IsUCzlJueON33G8xIo4wf/aSdG7tYDcFRL9C6T48AnqRaoqkp29C/aqp1x3CpvJk8EJo5Y8HD9oV6f8GQluB9UrwtRWJ41fdDHPf7YqNGSbcLbw77TC0fudl8sH5Zp5QDki/0vHS0NgDWzh6j6S5D57B/l4OxMyLJyzOK6AhUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120474; c=relaxed/simple;
	bh=KeW61NmDWgCj0JjSeb0G1b+p9Zrp3WBRncltVmprPZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A/Df6w+Io9obUEM8pXnHphfJZr6OSSJTlR7HV8f/ossHLo8f5ntUrqIqDx1WK7FjERCpa7wHah97+xIgvI2soq9LeM4Y7LOZ8QmcIP1MRYQcbn9RG/0pkGsEfONTkhGPiidj/GKfSMO4OojJZSZzFz1PzZZaF6zCrsOxjb2vPUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HSQBAAF6; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HSQBAAF6"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202607151300534baa1623f600020737
        for <xenomai@lists.linux.dev>;
        Wed, 15 Jul 2026 15:00:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vYSZfkDwNmwXThAoxaWqiuacdI1dLa6VyE/rRed83zU=;
 b=HSQBAAF6Pcj6VeI2qO5O81TeoSvz9iaBhLWo3bUk9QFJFQlPSN1cJMVnK1bj6tW+985whH
 SK2FD1+L6TfJj1vTtdq5sQCK1DsLFX4x4Rns0jZiWCmwW6jANZaaMtBDcl1esDfWMmBBLt5v
 m6IUkjYrEJL+Ucb4une2MWgXJUv/eSuxaC8t3kwLTRuIqJ9Dan/kDsHawgwEiM7T8tqi86YH
 Qz650la3keipA3lBGwcXMHYoYE/H2TClavq09fKBKW+4/M+uh6yXoAJP7eq5qFpwiEyDIEKB
 oRljOD1bqnD2pILRWthFF68L43/bgO+Ls0nBgtMG1HgBPvVNXhSUmgdA==;
Message-ID: <ed278400f8b7ca4cf3ad1c653989f86db14d867d.camel@siemens.com>
Subject: Re: [PATCH xenomai-images 1/3] ci: use stress-ng to stress EVL tests
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Wed, 15 Jul 2026 15:00:53 +0200
In-Reply-To: <20260715092822.223712-2-tobias.schaffner@siemens.com>
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
	 <20260715092822.223712-2-tobias.schaffner@siemens.com>
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

On Wed, 2026-07-15 at 11:28 +0200, Tobias Schaffner wrote:
> Use stress-ng to apply CPU, virtual memory, FPU register, and procfs load
> during EVL tests, mimicking the stressors used in Xenomai 3.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/lib/gitlab-ci-base.yml | 2 ++
>  ci/xenomai_4_evl.yml      | 2 +-
>  ci/xenomai_4_next.yml     | 2 +-
>  kas/opt/ci.yaml           | 1 +
>  4 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
> index 0540628..a3359bb 100644
> --- a/ci/lib/gitlab-ci-base.yml
> +++ b/ci/lib/gitlab-ci-base.yml
> @@ -25,6 +25,8 @@ variables:
>    ADDITIONAL_TEST_TIMEOUT_MINUTES: 10
>    TEST_MAXIMUM_LATENCY: 0
>    TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}=
' ${ADDITIONAL_XENO_TEST_ARGS}"
> +  EVL_STRESS_COMMAND: stress-ng --cpu 1 --vm 1 --vm-bytes 64M --fp 1 --p=
rocfs 1
> +  EVL_TEST_COMMAND: evl test --stress-cmd "${EVL_STRESS_COMMAND}" -k $(e=
vl test -l | grep -Ev "${EVL_TESTS_SKIP_PATTERN}")
>    SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>    SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=3D=
PATH"
>    SSTATE_MAX_AGE: 14d
> diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
> index 283a1fd..c6a92b8 100644
> --- a/ci/xenomai_4_evl.yml
> +++ b/ci/xenomai_4_evl.yml
> @@ -29,4 +29,4 @@ variables:
>    XENOMAI_VERSION: "4-next"
>    BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>    CACHE_KERNEL: evl
> -  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP=
_PATTERN}\")"
> +  TEST_COMMAND: "${EVL_TEST_COMMAND}"
> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
> index 6ef4b6a..7ecfbb5 100644
> --- a/ci/xenomai_4_next.yml
> +++ b/ci/xenomai_4_next.yml
> @@ -21,4 +21,4 @@ variables:
>    KERNEL_VERSION_WITH_QEMU: "head"
>    BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>    CACHE_KERNEL: evl
> -  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP=
_PATTERN}\")"
> +  TEST_COMMAND: "${EVL_TEST_COMMAND}"
> diff --git a/kas/opt/ci.yaml b/kas/opt/ci.yaml
> index e1466a0..f9e4bb7 100644
> --- a/kas/opt/ci.yaml
> +++ b/kas/opt/ci.yaml
> @@ -20,6 +20,7 @@ local_conf_header:
>    xenomai-ci: |
>      ROOTFS_POSTPROCESS_COMMAND:remove =3D "image_postprocess_sshd_key_re=
gen"
>      IMAGE_INSTALL +=3D "customizations-ci"
> +    IMAGE_PREINSTALL +=3D "stress-ng"

Hm... As the CI configuration is now requesting stress-ng it seems right
that it is pre-installed by the CI image.

OTOH I hate those loose dependencies. Maybe the (lib)evl test package
should pull it in instead? So that the dependency is handled at package
level. Someone else might like to install the test package and get all
dependencies accordingly.

To solve that properly it might make sense to make stress-ng the default
stressor. That would allow the packaging to properly depend on it,
instead of only "suggest" stress-ng.

>      IMAGE_INSTALL:remove =3D "sshd-regen-keys"
>      IMAGE_INSTALL:remove =3D "expand-on-first-boot"
>      IMAGE_FSTYPES =3D "${@ 'ext4.gz' if d.getVar('MACHINE', True).starts=
with('qemu') else 'tar.gz' }"
> --=20
> 2.43.0
