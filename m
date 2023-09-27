Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4A1D6AE
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 18:03:41 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202309271803388c962d078a062522e0
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 20:03:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UpMlY1WLavrpjzlpqaMABr5NG/NwimMWrglNJV2NuUg=;
 b=K0TdcxoLZGg255vlnQaADyMMYrVBwb3jEAbKlUssqHiSuwEx2GNdVlrCAQj9M9QpUVyjyX
 2rFEjUPIbGPjbEJOKOHL0sSXVs9XPkkaNJ7GxJRt+CJmMRseSGDOItqCDTylXzvACum1HvcE
 5KE+uggZlJVF4N+o88CqicSrLExH4=;
Message-ID: <756760aba823b02730cccf4e995019f889777567.camel@siemens.com>
Subject: Re: [stable/v3.2.x][PATCH] Fix detection of dev_addr_set
 availability on 4.19 kernels
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Wed, 27 Sep 2023 20:03:37 +0200
In-Reply-To: <5379efca-76b3-4413-85ab-41db5a9e7524@siemens.com>
References: <5379efca-76b3-4413-85ab-41db5a9e7524@siemens.com>
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

On Wed, 2023-09-27 at 08:15 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> As the SUBLEVEL in LINUX_VERSION_CODE is 8-bits only and is clamped at
> 255, we cannot detect this way that 4.19.291 also gained support for
> dev_addr_set and eth_hw_addr_set. Upstream does not care about
> out-of-tree, so work around this limitation by extracting the true
> SUBLEVEL in prepare-kernel.sh and exporting it via Kconfig.
>=20
> This is expected to remain limited to 4.19, thus is stable/v3.2.x only.
> And since 5.12, upstream has a KERNEL_VERSION_SUBLEVEL define in the
> generated version.h.

I'm not a fan of this solution, but I don't have a better idea ATM.

There is a strong feeling here that this problem will come back at some
point in time. We enabled 6.1 support for stable/v3.2.x recently so it
is not expected that this branch will disappear soon. Let's hope we
manage to maintain it over time.

Best regards,
Florian

>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 +++-
>  scripts/Kconfig.frag                                 | 4 ++++
>  scripts/prepare-kernel.sh                            | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kerne=
l/cobalt/include/asm-generic/xenomai/wrappers.h
> index 7654047b4d..8ba95af27d 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> @@ -258,7 +258,9 @@ devm_hwmon_device_register_with_groups(struct device =
*dev, const char *name,
>      (LINUX_VERSION_CODE >=3D KERNEL_VERSION(5,5,0) || \
>       LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
>      (LINUX_VERSION_CODE >=3D KERNEL_VERSION(4,20,0) || \
> -     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
> +     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,255) || \
> +     (LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(4,19,255) && \
> +      CONFIG_KVER_SUBLEVEL < 291))
>  #define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_=
LEN)
>  #define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALE=
N)
>  #endif
> diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
> index 7921286638..8eae9da693 100644
> --- a/scripts/Kconfig.frag
> +++ b/scripts/Kconfig.frag
> @@ -47,3 +47,7 @@ config XENO_REVISION_LEVEL
>  config XENO_VERSION_STRING
>         string
>         default "@VERSION_STRING@"
> +
> +config KVER_SUBLEVEL
> +       int
> +       default @KVER_SUBLEVEL@
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 64e2484e16..a06a9f2308 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -399,6 +399,7 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>  	    -e "s,@VERSION_MINOR@,$version_minor,g" \
>  	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
>  	    -e "s,@VERSION_STRING@,$version_string,g" \
> +	    -e "s,@KVER_SUBLEVEL@,$linux_SUBLEVEL,g" \
>  	    -e "s,@SRCARCH@,$linux_arch,g" \
>  	    $xenomai_root/scripts/Kconfig.frag |
>              patch_append init/Kconfig
> --=20
> 2.35.3

