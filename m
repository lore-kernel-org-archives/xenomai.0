Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D222C11CC
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264629; cv=none; b=dWd4CbhROMp7Z1uX99Skm23OESqr/GHPj3MqxNYnDrOL/NDaiDnG5KquyqDTYPphXvrcd5m1WYvhVA2o+hI6cUvDEi6L6JjytdhJC1ygwZaF7AlaAjqmSPx7i8jkYHnCrikbxakui4o5RQx4y/YHxbcvh74ngDu/G2Uq5kx7oE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264629; c=relaxed/simple;
	bh=TOZhURdR/7LIYhXxh6d8R+7mjmYGL7xCXwJH/PyxwfU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oiPIniBlatlr46/XILZx68xXliyL9esXOA3ebgMhRVJctIApMfoRdoJwSFjVE5X8iIi4kWAB7TuibABIvvYBQzoBtpRNKd8iNolcRhxKgYDFE7Dbxc3LtTfEODVl7fy9+sCjj1j1MGQJVGqoLjcXIDBPOwu/zJhY3GFKIYLhzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=lBBUjsRz; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="lBBUjsRz"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202509190650235dc3a6832d00020771
        for <xenomai@lists.linux.dev>;
        Fri, 19 Sep 2025 08:50:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=QB87yJjZRjEKnTHITqb+zub5b9jhsh0a6GJqtS/ySeA=;
 b=lBBUjsRzZ2YI5lR1/sK0PFK/2q6S4b5evh/v/c4lrRPpak7cALeXUnNuKYBzCAmZ/EV4rM
 RD3Oc3dtoLnfXvcou7Q/vzZXofIBQ3NoQ3RCckEQ4O+LuKkBJnbVXJk6zbjfA2NhtatPD50Z
 R972rOlGVjSu29s4qvLXcePKFE5NypufCFQqrmZ2MJKUiSsW7S7N8IUD4chRag/Q0n3aQOUX
 AdF1KnJ7T81BWuyxFOcfKB7qkQwttLsdu75ocavYY4TI5Jqa5B3PaXcsnMbQIK776YU2XZAt
 r2oWQu1tQ7MBVbWbXLoqymneZtsLKhKf0uoTFNdnNV1daxB4qZsxdTuA==;
Message-ID: <bd88da11b8d2e32765f8b779093f1cecc9f0a1b7.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 05/13] Update isar revision
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 19 Sep 2025 08:50:23 +0200
In-Reply-To: <91f80fd207c8b717c02205ddfa6f9e40663191f5.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
	 <91f80fd207c8b717c02205ddfa6f9e40663191f5.1758210955.git.jan.kiszka@siemens.com>
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

On Thu, 2025-09-18 at 17:55 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Required to move to trixie later on. The two fixes are awaiting upstream
> merge.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
>=20

[snip]

> + do_prepare_build:prepend() {
> +--=20
> +2.51.0
> +
> diff --git a/kas.yml b/kas.yml
> index 2020ed7..5d66228 100644
> --- a/kas.yml
> +++ b/kas.yml
> @@ -22,9 +22,16 @@ repos:
> =20
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: 483093e11cd722f0c88dc2fcbed1e937fc0abb60
> +    commit: 48a7eb4e0e9846e7e5bb44e52730d0bf59549a67
>      layers:
>        meta:
> +    patches:
> +      p1:
> +        path: isar-patches/0001-Revert-linux-custom-support-to-add-linux=
-libc-dev-pa.patch
> +        repo: xenomai
> +      p2:
> +        path: isar-patches/0002-linux-custom-Add-missing-Multi-Arch-fore=
ign-to-linux.patch
> +        repo: xenomai
> =20
>  bblayers_conf_header:
>    standard: |
> --=20
> 2.51.0

The isar update pattern again. Bumping the isar revision comes along
with carrying patches.=20

So we wait with merging this series until isar is in a usable state
again?

