Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B189725DB07
	for <xenomai@lists.linux.dev>; Mon, 24 Mar 2025 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815151; cv=none; b=PY+1X25ALanU8saO2t8/zECReJiW7BxX1BmhpOcZqncTjygOsc+thnQKyYepmq6paMfqVbJNhb0dpUHtrD6vlm16fT+B5wKhgx2T1OwUdAQs6pTvLyEbFpggW2LJKV1jZDI/ffhBj3xfLmXThl7ZTP77/02i26+XVajZ4FsTkQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815151; c=relaxed/simple;
	bh=TTGDqH42A9saXNd8kofwQ7mvBn0BhsI6fb+pRBlfm2E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVaniyyN5VHB1p6JQUMGe9mxAZKStLmXrGpttoXKvKjWBXRbwySZ/9XMDbJC/wBnC6USQJz4EYrhRvr93jUPkxAYSCWWd6/dLnwo4UFZSjIbqHSjE28yYCXOV2CIzQqWtamRUuenIyPn0RprvcWJ8Mkd5KDG4xafF60UTnp2sYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cT7iBVxU; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cT7iBVxU"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202503241118585a978bafc8df0199e7
        for <xenomai@lists.linux.dev>;
        Mon, 24 Mar 2025 12:18:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=AA1FyUKWjGIZxVWYYof4shoSCvckL+gU/6eyQsgns1o=;
 b=cT7iBVxUpIQkjYEmVw42+FFBU99LRLJw71p1wFKw5xHaa1ACag0ISsgCxYWBJsEzvKKtnf
 a8tccsvK7ZOFQtdPKN1V3Jzesl2kB3zv5DPQlIcBn1ffTr50Sh7qyBVMjuH5FoAm54IL9le4
 iE1zvqbShrVvHFdEwQt8gpZB3RYTAVKr+GDEtwdM2Dnj7+o1JQnmsbyVaH9cQZDdPY+9CVju
 I9L1eRZUVdRyKIINBUWpPMtzS48u90xyTlPqxEIdNrAasxM01qRj/Ny7jCRgbntqmWdEdgNT
 2qB+gg2IfAgKANAo7DyBqASOXktrhc74mtKID5H/2ARTxX4JCF/4f0GA==;
Message-ID: <6523189779e8b26ef3f8829de0835b1bbeab8b1c.camel@siemens.com>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Xenomai <xenomai@lists.linux.dev>
Date: Mon, 24 Mar 2025 12:18:57 +0100
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

General question about ordering here:

The order hard_cond_local_irq_enable() followed by local_irq_enable()
seems wrong to me. We enable hard irqs first, then we unstall the
inband stage.

That means that an hard irq might arrive and will end up in the IRQ
log, which is not processed by local_irq_enable(), so we are delaying
the IRQ processing to an unknown later time.

The other way around would make more sense to me. Is my understanding
right?

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

