Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5D3F076C
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157845; cv=none; b=XqLAElL+uM0eRhqm4z9G0d5za5MJwgwLha/1uuVsLtUd8mtqr5rAkJq9WQlwbKabszDqQSsAtwhaSehOaGDQ0w9l2qu5f4TtdHvHuumKVkFldPmUyOB4xj8qhJdv9ohEHOFuJGXvCaJtYrW82NskwBxig8ZTgVEuz7KSr/hROq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157845; c=relaxed/simple;
	bh=8elT1Knu1iLy1dBEPk6JIv3jnrtsMeWgS6X5KBaP0Y0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbZQm/4nAN2xopkGjHO6QEsNex0+04MoQINgjMboZMxQ1Nwzm5tKvQxrHbNyrjXvjSusJe6SgN3a+DLTd1qh6glSojJyY3GBSIxLwKCOt/b179AKttsklzj980TB0JR28EsP5yny7bdNZsQG8DZw2jwldoKyyHRWD5chJYJG+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PIpUMuH1; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PIpUMuH1"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260507110322ad5154cace00020702
        for <xenomai@lists.linux.dev>;
        Thu, 07 May 2026 13:03:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zneQGKvyTtFAZkkAvDzDjDCg96oDUFSxqRr3kGoX0cQ=;
 b=PIpUMuH1d+7V8FJnq9TmZwqP1ugqiW7D7QKJtbeZASysTkpfDyMSLxn91JALLguZgzfaqa
 /vBEhBiWOjfE5n57LKQj3cXmHC/6l5Y+RJ2ftXkRW5/562tphtlcHIbRN72aqrZ6QkgZnA4Z
 J+oQ8jNdeipm9Vd63nIcWRo+uLKEMx9icSgXjDIJaedBWVkJ/l5MZViX1TMEgdkiDSUriBvG
 uVXKWzrkAxv4BAZ2bFRHKO8Yrh23PXpHjqgzU8s1tXxUN4YoxWxlbtHEkvgzIfkP3nl5PdSj
 zslUbmnFFdHlImn8Sl9Nj1nz9oty0kt9+yJvmsvoJBy//iF/lCGWT4Eg==;
Message-ID: <dc069eaf339d470fecc3bae1d1f6e2d299c0cafb.camel@siemens.com>
Subject: Re: [PATCH] testsuite/smokey/alchemytests: Relax mq-2 test over VM
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Thu, 07 May 2026 13:03:21 +0200
In-Reply-To: <f5c42b11-56c8-4a87-be41-e1b73172425e@siemens.com>
References: <f5c42b11-56c8-4a87-be41-e1b73172425e@siemens.com>
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

On Wed, 2026-05-06 at 12:26 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> VM environment may delay or reorder the execution of tasks, so relax the
> checks.
>=20
> Part of #52.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  testsuite/smokey/alchemytests/mq-2.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/testsuite/smokey/alchemytests/mq-2.c b/testsuite/smokey/alch=
emytests/mq-2.c
> index a389e46db0..09b26b2135 100644
> --- a/testsuite/smokey/alchemytests/mq-2.c
> +++ b/testsuite/smokey/alchemytests/mq-2.c
> @@ -7,6 +7,7 @@
>  #include <alchemy/queue.h>
> =20
>  static struct traceobj trobj;
> +static bool on_vm;
> =20
>  static int tseq[] =3D {
>  	3, 4, 5, 6,
> @@ -87,9 +88,10 @@ static void main_task(void *arg)
> =20
>  	ret =3D rt_queue_inquire(&q, &info);
>  	traceobj_check(&trobj, ret, 0);
> -	traceobj_assert(&trobj, info.nmessages =3D=3D 0);
> +	traceobj_assert(&trobj, info.nmessages =3D=3D 0 || on_vm);
> =20
> -	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
> +	if (info.nmessages =3D=3D 0)
> +		traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
> =20
>  	traceobj_exit(&trobj);
>  }
> @@ -99,6 +101,8 @@ int main(int argc, char *const argv[])
>  	RT_TASK t_main;
>  	int ret;
> =20
> +	on_vm =3D argc > 1 && strcmp(argv[1], "--vm") =3D=3D 0;
> +

Seems a bit risky to expect --vm as first argument only.

>  	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
> =20
>  	ret =3D rt_task_spawn(&t_main, "main_task", 0,  50, 0, main_task, NULL)=
;
> --=20
> 2.47.3
