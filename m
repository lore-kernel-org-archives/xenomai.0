Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405866F30D
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593820; cv=none; b=FwPbTGhlSbzgKyg2PxqoEeCKwwMoij7PeoxbzYzgBnMYkQENC8tYxfzPDhcg9VByuV693UawBbhrO3DlLewpHRmsVSywlAUfwlhs/Tm6nIbstqDTyoNDlp3Bis6qwkHKXJEtMDDwL5DW4Sqhid74SBEGzbICPLVfuOUd8OAGRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593820; c=relaxed/simple;
	bh=z1rtWPm7iTlE1gbujin8MKIT75EZDDMkkQ21kScsKcw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sX6oVJ6MBCIyxpRV7kQDY7ahTKdbKQGBr4dUxQra4AOj+cQ64Dh0KQC3xeucxbksouaY0sO/xspDJB1my7dHTmi9VRr0eBqAJ78TmR31SX+CUQQUtA4DJWs7NXHzQLgRP1STNovSI8PvidojYZ21oUmkuA3zLy9AjVezsnGaSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Nw3YocGp; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Nw3YocGp"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024071006432610b269b522322ff35f
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jul 2024 08:43:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7ii0tOqOKFmSMYJaI/1odJ62NxJIHK1PUpl8lqyvCXs=;
 b=Nw3YocGp1VKCV4gt1tmQTJns8pRPEV7vCEwj07I4R96rCX6DEwsue9nCcedxjNY82zQ3i5
 155ZGUdi9XoJe0rSqzzjGFwqfBECWREoDrtDmWsfJcjJljwxSj5GCZ2S9oV6wKfRHF8L17Ez
 0ivUpCeLmOcr3Lz16tL3QPCRFn1nM=;
Message-ID: <955cd2d2712a9e0ee73932af706ea379bf21e5b1.camel@siemens.com>
Subject: Re: [PATCH 3/5] ci: Parameterize test command and timeout
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 10 Jul 2024 08:43:21 +0200
In-Reply-To: <20240709083524.739194-4-tobias.schaffner@siemens.com>
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
	 <20240709083524.739194-4-tobias.schaffner@siemens.com>
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

On Tue, 2024-07-09 at 10:35 +0200, Tobias Schaffner wrote:
> Use variables for the timeout and the test command run by the lava job.
> This will allow us to override the values when running long term runs.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml                    | 2 ++
>  tests/jobs/xenomai-beagle-bone-black.yml | 4 ++--
>  tests/jobs/xenomai-hikey.yml             | 4 ++--
>  tests/jobs/xenomai-qemu-amd64.yml        | 4 ++--
>  tests/jobs/xenomai-qemu-arm64.yml        | 4 ++--
>  tests/jobs/xenomai-qemu-armhf.yml        | 4 ++--
>  tests/jobs/xenomai-rpi4.yml              | 4 ++--
>  tests/jobs/xenomai-x86-64-efi.yml        | 4 ++--
>  8 files changed, 16 insertions(+), 14 deletions(-)
>=20
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index 1157fa6..1160039 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -21,6 +21,8 @@ variables:
>    ISAR_IMAGE: demo-image
>    ISAR_DISTRIBUTION: xenomai-demo
>    BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}=
"
> +  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 300'"
> +  TEST_TIMEOUT_MINUTES: 30
> =20
>  default:
>    image: ghcr.io/siemens/kas/kas-isar:4.0
> diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenoma=
i-beagle-bone-black.yml
> index 17e807b..f7966ea 100644
> --- a/tests/jobs/xenomai-beagle-bone-black.yml
> +++ b/tests/jobs/xenomai-beagle-bone-black.yml
> @@ -54,7 +54,7 @@ actions:
> =20
>  - test:
>      timeout:
> -      minutes: 30
> +      minutes: ${TEST_TIMEOUT_MINUTES}
>      definitions:
>      - repository:
>          metadata:
> @@ -63,7 +63,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohe=
ll -m /tmp 300\"
> +            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
> index 8489594..67c35b9 100644
> --- a/tests/jobs/xenomai-hikey.yml
> +++ b/tests/jobs/xenomai-hikey.yml
> @@ -53,7 +53,7 @@ actions:
> =20
>  - test:
>      timeout:
> -      minutes: 30
> +      minutes: ${TEST_TIMEOUT_MINUTES}
>      definitions:
>      - repository:
>          metadata:
> @@ -62,7 +62,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohe=
ll -m /tmp 300\"
> +            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-=
amd64.yml
> index 62a268b..6a548dc 100644
> --- a/tests/jobs/xenomai-qemu-amd64.yml
> +++ b/tests/jobs/xenomai-qemu-amd64.yml
> @@ -70,7 +70,7 @@ actions:
> =20
>  - test:
>      timeout:
> -      minutes: 30
> +      minutes: ${TEST_TIMEOUT_MINUTES}
>      definitions:
>      - repository:
>          metadata:
> @@ -79,7 +79,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohe=
ll -m /tmp 300\" --vm
> +            - lava-test-case xenomai-test --shell "${TEST_COMMAND} --vm"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-=
arm64.yml
> index 9ce451d..35dd3b2 100644
> --- a/tests/jobs/xenomai-qemu-arm64.yml
> +++ b/tests/jobs/xenomai-qemu-arm64.yml
> @@ -74,7 +74,7 @@ actions:
> =20
>  - test:
>      timeout:
> -      minutes: 30
> +      minutes: ${TEST_TIMEOUT_MINUTES}
>      definitions:
>      - repository:
>          metadata:
> @@ -85,7 +85,7 @@ actions:
>              - quirin.gylstorff@siemens.org
>          run:
>            steps:
> -            - lava-test-case xenomai-smokey --shell xeno-test -k -l \"do=
hell -m /tmp 300\" --vm
> +            - lava-test-case xenomai-smokey --shell "${TEST_COMMAND} --v=
m"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-=
armhf.yml
> index 070b801..9560a85 100644
> --- a/tests/jobs/xenomai-qemu-armhf.yml
> +++ b/tests/jobs/xenomai-qemu-armhf.yml
> @@ -70,7 +70,7 @@ actions:
> =20
>  - test:
>      timeout:
> -      minutes: 30
> +      minutes: ${TEST_TIMEOUT_MINUTES}
>      definitions:
>      - repository:
>          metadata:
> @@ -79,7 +79,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohe=
ll -m /tmp 300\" --vm
> +            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
> index 627deb5..e8b9a7e 100644
> --- a/tests/jobs/xenomai-rpi4.yml
> +++ b/tests/jobs/xenomai-rpi4.yml
> @@ -53,7 +53,7 @@ actions:
> =20
>  - test:
>      timeout:
> -      minutes: 30
> +      minutes: ${TEST_TIMEOUT_MINUTES}
>      definitions:
>      - repository:
>          metadata:
> @@ -62,7 +62,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohe=
ll -m /tmp 300\"
> +            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-6=
4-efi.yml
> index f4f631a..4aafccb 100644
> --- a/tests/jobs/xenomai-x86-64-efi.yml
> +++ b/tests/jobs/xenomai-x86-64-efi.yml
> @@ -54,7 +54,7 @@ actions:
> =20
>  - test:
>      timeout:
> -      minutes: 30
> +      minutes: ${TEST_TIMEOUT_MINUTES}
>      definitions:
>      - repository:
>          metadata:
> @@ -63,7 +63,7 @@ actions:
>            description: "runs the xenomai test suite"
>          run:
>            steps:
> -            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohe=
ll -m /tmp 300\"
> +            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
>        from: inline
>        path: inline/xenomai-test-suite.yaml
>        name: xenomai-test-suite
> --=20
> 2.40.1

Just to let you know:=20

I have a patch pending that will remove the duplicate testsuite
definition (the lower part of this patch here).=20

No need to define it for each device...

