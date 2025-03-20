Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04517591
	for <xenomai@lists.linux.dev>; Thu, 20 Mar 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489455; cv=none; b=RhFhMsgxA8u4AM/Yfk9KHmITpoEVq8Jtwrs+xlmqaQGGYZi14oaC9BPlsOibMHBrO2qr0j/V+saZoPpbCjDuaHvyZn1u21cvIA3woz960CRVkZkw5jm5L8XO+NtJrPcGf3lm9jW0RVc8+osRHqSDnIUKdbK52AjF6TwEzLLW4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489455; c=relaxed/simple;
	bh=94YKUkAtiRamxMU6wtpseC1ood1ajJmaT/XbntQSwYw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iLUicSep+qWix3/9c5VTeHFfUN7PWN64AY3lln6uAIOwkh7fMzNxG5Uzf9jx96uFU+wijMp6nB0p393lItMplOQ9VDSiSe8QQNImOj4yWnOPqorh6r60ZUZr7fS8p3zq6cKbwg0OQUljSbTW8AVYIxNR+Ux2kX5KJiF6KG2rjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=glhRdloz; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="glhRdloz"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250320165042f487fc2294c241bd98
        for <xenomai@lists.linux.dev>;
        Thu, 20 Mar 2025 17:50:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=BMiRGlGnypFwMShRLuP5Ysknodc3jHVAuFmtsFYx6Qw=;
 b=glhRdlozqGy2fLTLZ7ruYvzxGIFXctlOWg86ViAflwJjT+iJQW68icGiA2/UJDGPA0L08D
 92EF+h5ui5tVpMLhe6/ZEou63cZhAWlcZ/4kTpNIlKMpm+Vuzwv5NoFVUFh9TgY7C/7VjMuF
 xiIXRHlu4+O9dwK++aScAJcu5lSWgLdDCALh9iWjpbeY+jRUjI98Oe6eXXwRgyjAJzRb/Hot
 a7aC2PG2QKifz4p7Jv5x4ZfnCNREgAAOnHzVTpJVHMl9B6fFSOkp5OxHzQIBEJ0ekdAu0mYt
 qrH9RPvgnl/kEJqiWxv7hJw/ADuF4FgtPO8SdZ5CUVCexXqNE/DEWsmg==;
Message-ID: <174dbca228b4005ac65239f3dccce36f40cd1c0d.camel@siemens.com>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Xenomai <xenomai@lists.linux.dev>
Date: Thu, 20 Mar 2025 17:50:41 +0100
In-Reply-To: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
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

On Thu, 2025-03-20 at 17:41 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> We had unbalanced hard_cond_local_irq_disable here so far.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Minus one hunk that is already in current 6.12.y, this needs to be=20
> applied to older stable versions as well.

How was that tested? I think up to now nobody really cared about
hibernation... Will that really work now when I try to test that or
will I run into (other) problems?


>=20
>  kernel/power/hibernate.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 733b1a196f09e..e1c05f276a453 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>  	syscore_resume();
> =20
>   Enable_irqs:
> +	hard_cond_local_irq_enable();
>  	system_state =3D SYSTEM_RUNNING;
>  	local_irq_enable();
> =20
> @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
>  	syscore_resume();
> =20
>   Enable_irqs:
> +	hard_cond_local_irq_enable();
>  	system_state =3D SYSTEM_RUNNING;
>  	local_irq_enable();
> =20
> @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
>   Power_up:
>  	syscore_resume();
>   Enable_irqs:
> +	hard_cond_local_irq_enable();
>  	system_state =3D SYSTEM_RUNNING;
>  	local_irq_enable();
> =20
> --=20
> 2.43.0

