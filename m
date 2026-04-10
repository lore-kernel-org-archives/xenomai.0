Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0D3101A5
	for <xenomai@lists.linux.dev>; Fri, 10 Apr 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855665; cv=none; b=GYkNN6MH2ckV15PIOlaXRDZwogEVJxNfknodsmMTopwRY5RayWJs0Qko89Zjrwfjh7QqDNj+EiIIfZ3CG7QMzAop2bSR88ljfktEAJ6KywyZFzWFOq8V5F9ly6Ud6+YzLOV0gFFDUY6s1Atau/5Evg8iClb0i9TcAI+VXNgJwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855665; c=relaxed/simple;
	bh=HU0kKf5V0ygJ25yxe2YA5HBKcEX/CPDXZIWUw3WgyyI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JafQvSEPLenR6VaEo10868vSLt0cFLI4iqGJKyZy7LRSfbfWoDnJe2djxCCzp14kVVpGXodH7SR7yNiOgYAAkYHmxlz0FTClmLmEZYjHeab2A+9CO8gOkwmUTQOVIvp9+YOu7uUJKhsbFdymVJEqSjV8RrRPtwnTJHtnR12ykF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eIkkbf1Q; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eIkkbf1Q"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026041021141005f82b422b000207c2
        for <xenomai@lists.linux.dev>;
        Fri, 10 Apr 2026 23:14:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=FO2ZfB8709b/rzNHzjmF5OJRQGU4rKYbmwjxi7J9ta8=;
 b=eIkkbf1QGzvwIt0wGTk21+yfvMC/o9zFpgxWFxle2A3038HDg8Vu/v3BGLPtKlV2DlGjz2
 o/wczGeLuttbTZOxAKtteXC/+GrICauU4scTyEo950QaGwLDaQDaCc/CA/tthjvtdjH+oVTw
 7gQN48csLMmSV4g9BrlXLeu9xg+5BTRaArCYjaBkAQ3eUYMEgBAcgtBO7ovRpqFK+kWv43JV
 aZB/HzSNr5FOHmZm4fHA6K786Jyiv6xIilWvHDFQtR6RuGzK5MLcVRJGZTEN6yWgj6AkZHyW
 cmuQ0aI5Jdpf1B/8j84v7eM51iDfSc/a7J7i+V/VtZMDhpnYFTfZPHWw==;
Message-ID: <989b39fccc6fb102ddc938bbae87f476b2eced11.camel@siemens.com>
Subject: Re: [PATCH] Fix memcpy WARNING in kernel
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Hannes Diethelm <hannes.diethelm@gmail.com>, xenomai@lists.linux.dev
Date: Fri, 10 Apr 2026 23:14:10 +0200
In-Reply-To: <b3a7cb51-870c-4856-86a9-f8714aa09e6a@gmail.com>
References: <b3a7cb51-870c-4856-86a9-f8714aa09e6a@gmail.com>
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

Hi Hannes,

On Fri, 2026-04-10 at 22:21 +0200, Hannes Diethelm wrote:
> Related to https://lore.kernel.org/xenomai/f10afb4e-2aaf-4a3a-8bc7-893c1a=
09cdd1@siemens.com/T/#t I try my first
> patch submit on a mailing list. I hope this is all right.
>=20
>  From 34d65bcc3343b5323f19cd73561bf39d2652481c Mon Sep 17 00:00:00 2001
> From: Hannes Diethelm <hannes.diethelm@gmail.com>
> Date: Fri, 10 Apr 2026 21:56:16 +0200
> Subject: [PATCH] Fix memcpy WARNING in kernel

Close... Looks like you copied the file content of the generated .patch
file into your mail client.

Just send the patch using git send-email [1] or remove the lines above.
In case you like some more tooling around patch submission you might
have a look at b4 [2] , which can be used easily for Xenomai as the
mailing list is hosted on lore.kernel.org.

All of that might be fixed on merge by Jan, but maybe you want to give
it a second try as there is one possible improvement:

Proposal for the v2 patch/mail subject:

drivers/net/stack: Migrate struct rt_proc_call to flexible array member

Proposal for To, Cc:
The patch made it to the list, all good, feel free to add the Maintainer
(=3DJan) to To or Cc.

Thanks for your contribution!

Best regards,
Florian

[1] https://git-scm.com/docs/git-send-email
[2] https://b4.docs.kernel.org/en/latest/

>=20
> Warning was:
> memcpy: detected field-spanning write (size 80) of single field "call->pr=
iv_data" at drivers/xenomai/net/stack/rtnet_rtpc.c:93 (size 0)
>=20
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>   kernel/drivers/net/stack/include/rtnet_rtpc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/drivers/net/stack/include/rtnet_rtpc.h b/kernel/drive=
rs/net/stack/include/rtnet_rtpc.h
> index 01d7ab152..f4ad47306 100644
> --- a/kernel/drivers/net/stack/include/rtnet_rtpc.h
> +++ b/kernel/drivers/net/stack/include/rtnet_rtpc.h
> @@ -43,7 +43,7 @@ struct rt_proc_call {
>   	atomic_t ref_count;
>   	wait_queue_head_t call_wq;
>   	rtpc_cleanup_proc cleanup_handler;
> -	char priv_data[0] __attribute__((aligned(8)));
> +	char priv_data[] __attribute__((aligned(8)));
>   };
>  =20
>   #define CALL_PENDING 1000 /* result value for blocked calls */
> --=20
> 2.47.3
