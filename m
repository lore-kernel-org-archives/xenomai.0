Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E988307487
	for <xenomai@lists.linux.dev>; Wed, 25 Jun 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850184; cv=none; b=aTKzudON+OIhI94mhUUMBLeL1538J/HS15EWZnTfK1XNofLjyTfJAkteT3SxGt5RtgHH1ZLohhMVn8X8szpn1XC7t5Ka6J65WuTgxO+scU7zssBOFpu5sc8Y+tlAc/yUUVYC7i5AS91FGziZrBWRUOkWyPJEvkLYg1NQ4HLlSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850184; c=relaxed/simple;
	bh=i9kwS3EtEKPjyx1blAm/yc5z5FsMC4NTzFO7vc6gILY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wb/IuzfdG9irYRyzTShomRVjv9xXQljVbrtHqf0PAliIqduquKbzyiuQeNTdhmGKs2KbNTtks9URXMJOroVZY6qsCzioW7z6VSx0A9s3+dj2khHby7B8VeNNn2eFeSe3DxWvgEb+UpaoKKy4yrQkEgbpdjPHABeI77wAQUFuRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fByyKwJx; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fByyKwJx"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202506251116126698d6be79e0a71d2c
        for <xenomai@lists.linux.dev>;
        Wed, 25 Jun 2025 13:16:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ekPNYk9SJ+LUsVvIjfOIs9XlRHxaPIW2Faq+V5TePDY=;
 b=fByyKwJxNmzPHwe6jljs9LlIdadLm63VDMs5PUaapuFpr7MDwjnAOn/Hu/f6MCQQrF2XFT
 j+t4mLFKbdKEqLtoS5BZDE41ptKz8u2cfQxrn9HxmIiPBZKciOHDLZDqXAtAUV4afQ5dwNZS
 TUO/tVMArAVUI8mv1Y235qX7Fh41UYGgLkRuiBM/rO/eTqc700bYDPJyg20fuZh6/OjEzVY+
 exYaUDzjC6zpinEoyLZ5EV8A1hGmmUYG2IL86NoN7cAxkoG9yQWj4VHTIVKQ+QTxhc+fLGPb
 dH5hQ3uApXmdV/C+bwe6Mux3eYIklfQy7uOanb71/Xge2dV+omlcXmIw==;
Message-ID: <4de91ab049a550d6715517da2cb240750cf839a4.camel@siemens.com>
Subject: Re: [PATCH] x86: dovetail: Use appropriate EOI on error interrupts
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 xenomai <xenomai@lists.linux.dev>
Date: Wed, 25 Jun 2025 13:16:07 +0200
In-Reply-To: <3cf01441-93e6-4004-a9e5-5183eb6740de@siemens.com>
References: <3cf01441-93e6-4004-a9e5-5183eb6740de@siemens.com>
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

On Wed, 2025-06-25 at 10:16 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Just like for the non-pipelined spurious interrupt, we need to invoke
> the non-pipelined __apic_eoi while handling error interrupts. Otherwise,
> the local APIC will stop receiving further interrupts, and the system
> will stall.
>=20
> Given that it takes very special conditions to actually trigger an error
> interrupt, this issue was very likely not relevant for most deployments.

On which hardware is that happening? Asking because of=20

/*
 * This interrupt should never happen with our APIC/SMP architecture
 */

infront of the function...

In addition we should properly check which branches are affected.
apic_eoi() vs. ack_APIC_irq() (in 5.10),=20

>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/kernel/apic/apic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 1cd5f59f7962f..278e28c5290d3 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2217,7 +2217,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
>  	if (lapic_get_maxlvt() > 3)	/* Due to the Pentium erratum 3AP. */
>  		apic_write(APIC_ESR, 0);
>  	v =3D apic_read(APIC_ESR);
> -	apic_eoi();
> +	__apic_eoi();
>  	atomic_inc(&irq_err_count);
> =20
>  	apic_pr_debug("APIC error on CPU%d: %02x", smp_processor_id(), v);
> --=20
> 2.43.0
