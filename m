Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388279;
	b=ATPJYoMX4x2Q2w0z7Rjqo/3Jylx+ktIUyBHFHfyg7vULr4UpiZTG2nOV+09vPCK1KMcW
	 wCWqbyzJw7zbKU9NC0BRIBgt4MqyZPrwEVU+alken1XGmfu5YxjvUZ4Om7mTAZza75XTy
	 1mPRaLUbTUZuouu7gvQGaNoo7Q2jrbQdRyLeWBX/LZFn4ijrky3Ez18EYCPQk1y5z8UMv
	 IYGePn7u1VZGkp8+NbNH8zvZuG/X2p5wU4HXba5osxA31a0w5NYSflWFL7cILpIv+AfX3
	 cWtBQwL2MJ5+IgrKWovaaIFztP7pMHHsulfgu/lFyQqbZTAcQuAV6D8HaCwR8c3pX4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388279;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:X-GND-Cause:
	 X-GND-State;
	bh=/jVlKl1wQqWm4+7oUwLLCrmfmvwg96dxUITiTgqZrcg=;
	b=ucygnVjvReQdZ84sD+cJSQfwsW3BOB5VKtmF5kKRt1C+n/fs5YxJm+VcpN0RsK30ZzHE
	 PPfgUaqtrRuJdWBulmZ4PnRCA3LhkvRHB5H5E+FNX9lfnOpHnsJDeMe4T+WuQN0kybL8W
	 fDFmZgXPi0HYCgeTq2CSKbLN7mGwBD+35A9qQR+FmOvdDJSeuj29+AFdsykcO2w/+B/Tj
	 MuYwqJlObifpXHIoDyHwqftv6umVODkn/ePw0H61DtMes7jkjrToWcSmMTA9jwpXVBhKd
	 oFdtxr2hMT1STvT81TzvAwzRuqdYzd0bqb+yyDW9aeuSUqtddKniQEzFzkAmiie9BqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b="k8/9jAnC";
	arc=none smtp.remote-ip=217.70.183.193
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A849606A321
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 09:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A849606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=k8/9jAnC
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9ACAC3E95E;
	Wed, 11 Nov 2026 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794388270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jVlKl1wQqWm4+7oUwLLCrmfmvwg96dxUITiTgqZrcg=;
	b=k8/9jAnCJjcXGmG5/jZHqytBjLSmjUQfxkOLdOo+mSHMxjAHshD5D59zUDUxYJumTPxR9z
	sGD0TP2ufDeB1UzXmIBgo+P3rKLzRasgLO3EjzmTE7JgXrkviqbXrOJlv/zJ862Ybvwtca
	vNLwb+7lESD/zOAY/AQ+LOcgii9f2Uc/e6tmiR7FEuAEZ7+wWeJIJclMdbs0+4cDo96yhP
	fCKGd0CZ4ssqnxUwQrOu9URxiYqljlJ4KIKBK6eZEiwXNDYUFsBW0MQ8dtcf1VVLPaYujS
	D9q1xYd+gfBRDlk7ogjnftTdDefmCmZhAZDUR0So/KL65lZeykKYYJV8mLLqIQ==
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Mart=C3=ADnek?= Petr <petr.martinek@elvac.eu>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: linux-evl 7.2 compilation without SMP
In-Reply-To: <27ae5abdf65c4fd2aff3949c6d424354@elvac.eu> (=?utf-8?Q?=22Mar?=
 =?utf-8?Q?t=C3=ADnek?= Petr"'s
	message of "Tue, 13 Oct 2026 07:06:29 +0000")
References: <27ae5abdf65c4fd2aff3949c6d424354@elvac.eu>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 11 Nov 2026 10:11:09 +0100
Message-ID: <87a4nf68cy.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTEWyBeKap+AgJHDaF0FfgUubqvm30xZQbzzjp/r5WWsHZPOJ9wU6uONNQmaVNeW4AlPQR4DV+EMLvulUxO+3vizeR4ba+H31hlV19ynRzpu2EbcrSmOAaqTdr8yM+5qlDU0FKVg3pEZOxv/1i+s/ZzXH4V/LokBpzomlMm3rOVMqobu0t5d/HTtzSBU/w5sSy6pg9wS4eVO7fFGgSU0mlYxKvllHTf+r4dHXIeWdBjJlPo8+8McV0u/JlccnlFAdacPjWfiIfi5vYTEMspbXZCBFgaAJX9fVvfYR8erz1NwqOP7hTqfxOJIX0ioQYQNx/bQT+lHP42d+Ded0hr0lgzMsioqwyXJM/W0VoiamIyCtCuq1unvttMTRb5nBBwDMKy2IeHhpHGF9Iost6wbpkbsefMfLvFvyHqIP5xRYwu7PAKpu1vYctJHANTi1rMlyEQ4XOzQSNOd40H9bh3eXth7KA0+Br5nmY3XXIWfgCCAbTi6xvDNurxMbJe2ptlhxE9gIes0rmCznVWUSqQwDCOW3XgxyKApsLIHtUQXu8gRmvaMtRzEUQimD+FlBMxWmMWGZ9dCU/9S1MbVsSGWpChq8GfMLGCCdg56xu8px19FweX4iR+0Uh26RIe6PSMutIK/FDiEb7ChMdBQE1u61zEAGoPVSnbo5KXXc/spoAy2HQ
X-GND-State: clean

Mart=C3=ADnek Petr <petr.martinek@elvac.eu> writes:

> It is not possible to compile linux-evl 7.2 without SMP due to bad port of
> include/linux/spinlock_api_up.h code and kernel/irq/pipeline.c
> pipeline_percpu_data being inside define for SMP, while being used withou=
t it.
> Included are patches to fix compilation.
>
> Signed-off-by: Petr Mart=C3=ADnek <petr.martinek@elvac.eu>
> ---
> diff -Naur a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api=
_up.h
> --- a/include/linux/spinlock_api_up.h	2026-09-23 08:39:20.000000000 +0200
> +++ b/include/linux/spinlock_api_up.h	2026-10-08 14:21:40.410814000 +0200
> @@ -62,22 +62,22 @@
>    do { local_irq_restore(flags); __UNLOCK(lock, ##__VA_ARGS__); } while =
(0)
>=20=20
>  #define __HARD_LOCK(lock) \
> -  do { ___LOCK_##__VA_ARGS__(lock); } while (0)
> +  do { ___LOCK_(lock); } while (0)
>=20=20
>  #define __HARD_LOCK_IRQ(lock) \
> -  do { hard_local_irq_disable(); __HARD_LOCK(lock, ##__VA_ARGS__); } whi=
le (0)
> +  do { hard_local_irq_disable(); __HARD_LOCK(lock); } while (0)
>=20=20
>  #define __HARD_LOCK_IRQSAVE(lock, flags) \
> -  do { flags =3D hard_local_irq_save(); __HARD_LOCK(lock, ##__VA_ARGS__)=
; } while (0)
> +  do { flags =3D hard_local_irq_save(); __HARD_LOCK(lock); } while (0)
>=20=20
>  #define __HARD_UNLOCK(lock) \
> -  do { ___UNLOCK_##__VA_ARGS__(lock); } while (0)
> +  do { ___UNLOCK_(lock); } while (0)
>=20=20
>  #define __HARD_UNLOCK_IRQ(lock) \
> -  do { hard_local_irq_enable(); __HARD_UNLOCK(lock, ##__VA_ARGS__); } wh=
ile (0)
> +  do { hard_local_irq_enable(); __HARD_UNLOCK(lock); } while (0)
>=20=20
>  #define __HARD_UNLOCK_IRQRESTORE(lock, flags) \
> -  do { hard_local_irq_restore(flags); __HARD_UNLOCK(lock, ##__VA_ARGS__)=
; } while (0)
> +  do { hard_local_irq_restore(flags); __HARD_UNLOCK(lock); } while (0)
>=20=20
>  #define _raw_spin_lock(lock)			__LOCK(lock)
>  #define _raw_spin_lock_nested(lock, subclass)	__LOCK(lock)
> diff -Naur a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
> --- a/kernel/irq/pipeline.c	2026-09-23 08:39:20.000000000 +0200
> +++ b/kernel/irq/pipeline.c	2026-10-08 14:30:08.315420000 +0200
> @@ -75,6 +75,9 @@
>  	unsigned long flat[IRQ_FLAT_MAPSZ];
>  };
>=20=20
> +struct pipeline_percpu_data { };
> +static DEFINE_PER_CPU(struct pipeline_percpu_data, pipeline_percpu_data);
> +
>  #ifdef CONFIG_SMP
>=20=20
>  static struct irq_event_map bootup_irq_map __initdata;
> @@ -92,9 +95,6 @@
>  	},
>  };
>=20=20
> -struct pipeline_percpu_data { };
> -static DEFINE_PER_CPU(struct pipeline_percpu_data, pipeline_percpu_data);
> -
>  static irqreturn_t smp_call_function_ipi_handler(int irq, void *dev_id)
>  {
>  	smp_flush_oob_call_function_queue();

This one slipped through the cracks. Merged, thanks.

--=20
Philippe.
