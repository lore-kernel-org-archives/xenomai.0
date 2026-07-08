Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE14439321
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523348; cv=none; b=LQVg9ZqejSImSg4UFi3zHQZQQSI+jWE3ONaWRpqW4i338T47/xEdmASgCXn9YBgcGfeNN89ZyP5o36DYWsxQ0JazwRkwyvzWnsvGCn6trN0n5+m+6Tf1txfS88QYaolzcmMYIaxG8jVnaIMsXfTZKpydS6ooOFaLbAH4iGLoMBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523348; c=relaxed/simple;
	bh=oaHXkPjt87uBvYngkr5p7+W25B9Cx+HGq/rc/cbSGjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YyNXHL+ShBwsfeRm8YBciAjPAte97tP/AmmOiyj63E2+j4sfR6a/c79iUWE+26dqqmh4n2I2hyzx3qLg4Dp/HCcVB3HveMIxHMxlcHlkowcKWKGWJ8Jihxexpi+pYeS2Mm+p8S93AwpClx7xpSGMBFi6AFnFhx6wEKCA9hsj2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BikL6DSD; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BikL6DSD"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260708150855f20bd5fb340002070e
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jul 2026 17:08:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uEzNgPl0jKRZaJlSK8cJrK7GLhFchBR1IEiop/dMqe0=;
 b=BikL6DSD/ZM2Xv4ZPPtH7E//2MPgSCe1Rl/ChwYyD2gvS2fkyykO9SE1ZA6OAGARjKYGNH
 UPOaFEZJczXZSmr8PJjhjUp1KbGVb0SJlsTn5d6oLadtW3rdxn7hNoJGcE02q6+2HX2EZ4Qg
 hHzH0QRrUTzC66qtmiJ/iAuPn+L7aKfuO80Wb5Qkfr00zXRcqCPcQlCLAB4C3OUzMOoeN6Gt
 QCXpB50Gx0eYT0H9/AjkV4ESQmgeIJ911dTBH36iqiAXEUHZijlpSRLmuGV23Dk2aIYEuVcF
 V2oAoiHeatHYVmFmfvHlpPDRocWEP7erxgndEP0N1OB09DMJkF5RJXtQ==;
Message-ID: <a0f6ecb535ea57c66cc9d75eb3c5f0a3466927cd.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH] tests: Drop no longer existing option
 for qemu-system-aarch64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Date: Wed, 08 Jul 2026 17:08:55 +0200
In-Reply-To: <06a2c0f7-8e33-4f48-9f42-8a16dc887f8d@siemens.com>
References: <06a2c0f7-8e33-4f48-9f42-8a16dc887f8d@siemens.com>
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

On Wed, 2026-07-08 at 15:50 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This was removed from the QEMU found in Debian trixie, the version we
> no use in our lab for LAVA tests. But even in bookworm, it was already
  ^^^
/s/no/now

> redundant as this option was off by default.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  tests/jobs/xenomai-qemu-arm64.yml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-=
arm64.yml
> index 2e9d1d4..50eb1ac 100644
> --- a/tests/jobs/xenomai-qemu-arm64.yml
> +++ b/tests/jobs/xenomai-qemu-arm64.yml
> @@ -28,7 +28,6 @@ context:
>    arch: arm64
>    extra_options:
>    - -cpu cortex-a57
> -  - -global virtio-blk-device.scsi=3Doff
>    - -smp 2
>    - -device virtio-serial-device
>    - -device virtconsole,chardev=3Dcon
> --=20
> 2.47.3
