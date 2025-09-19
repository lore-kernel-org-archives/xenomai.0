Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532DD2BD5A2
	for <xenomai@lists.linux.dev>; Fri, 19 Sep 2025 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264019; cv=none; b=OWV4nXWptnng52S9VLJWufiR/6DDqfheNmeC7mW2u5ch0vLe2gGGXx3Zqc0rexsnjN4DtSbxlcZDz3d7XWuQHRdQhfuHzsWUvOLNnFT0StbO96p4GVMuk/ct06ByUq83aaz+19llbZiMjAdaYSUIk5s7sHNsNb4xuGr8kCmGk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264019; c=relaxed/simple;
	bh=UvF+3tibzmSHwPF0Ajl0kEGyH2Fy5BNuTeAqMKXyzEI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S26gCyLCyQZSUHGXkrbkNFB5yZ5DGxdmwmcJwq/SC5HVX43qUZ0L+b9nsqsHMVW5eJS/1C7CoydEIUpMDClcQIrYIzecu20YIpW0tW3l/BrmTqa/abaUzmMGS/pq41HSNb9PH7Tf8w5+0rOfmlU7SSchpjf86pntOmk39DoJ6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=L65pUtTB; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="L65pUtTB"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250919064009d4e7ab94ed000207d9
        for <xenomai@lists.linux.dev>;
        Fri, 19 Sep 2025 08:40:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=K2fdGkRXM/yhAKp0CKeASm96Zzx6H/IP0rFMUxUjRck=;
 b=L65pUtTBnYvGiNwKAynyj8QDSFRr73BfqCE+7n7KSYXTAy+mm0R5i7GvFo2slazcjKDaum
 5AJAC2GvF/Ds4Xthrc8FbdRfFJkHnI0lGMEn6yKxhepoasvCUQvnHg/bJdWv6aw3IKYvyRBh
 PTyjLXBI5/lNh3qb4nY23kYzP2FHjxEZ4U1FXsEIVgbOUFaErtfFHTsrl1+73I6BQYaGp5kO
 LGpvVBtLeTeeO9qcf7UqQzEz3j9PPHg86yOKAZI3ei4YJEn8DdEv1/3t2vB1Fy0O/pslUQC7
 YoNdkHso1G9gqmNRhMO1xhMhy1flndlDsn0cYw+0FBVd49bPv33R6vNQ==;
Message-ID: <b69ae66d952499212dbb2ef98e3c74c7ebcd0933.camel@siemens.com>
Subject: Re: [dovetail 6.16, 6.12][PATCH] arm64: fpsimd: dovetail: drop
 redundant hard irqs disabling
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Xenomai <xenomai@lists.linux.dev>
Date: Fri, 19 Sep 2025 08:40:08 +0200
In-Reply-To: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
References: <7842cba9-6e22-4856-adff-9f33ef76c5c2@siemens.com>
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

On Thu, 2025-09-18 at 18:25 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> fpsimd_save_and_flush_cpu_state() itself does take care of this.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

> ---
>=20
> Changes for 6.1 will look different.
>=20
>  arch/arm64/kernel/fpsimd.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 1f5fcac32b2d2..21f8785948ca3 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -2110,13 +2110,9 @@ void __efi_fpsimd_end(void)
>  static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>  				  unsigned long cmd, void *v)
>  {
> -	unsigned long flags;
> -
>  	switch (cmd) {
>  	case CPU_PM_ENTER:
> -		flags =3D hard_cond_local_irq_save();
>  		fpsimd_save_and_flush_cpu_state();
> -		hard_cond_local_irq_restore(flags);
>  		break;
>  	case CPU_PM_EXIT:
>  		break;
> --=20
> 2.51.0
