Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7568806
	for <xenomai@lists.linux.dev>; Wed,  7 Dec 2022 10:20:57 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2022120710204884322a4afec34262dd
        for <xenomai@lists.linux.dev>;
        Wed, 07 Dec 2022 11:20:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=2u2FzfLwUcwX2M9fwnkdFo/ajowo7nR0zE8y+FrU2rM=;
 b=DrVHr6Jchl8U+ILq1jOvsgcmLglhu/s6PKrxIhP7ElgOV7IFQsf78Rb+l6GLhICK30wViX
 Uio3shgNhGkALo0nO7B+fyytW5zGvRLAHNx7MvV4Y8Fl/tWoi6Jm9tAYkQ+dx8HHeT6i/fmw
 8+YJsqDDEpFDVHUKNsRWibnOollFU=;
Message-ID: <bee67c31d3a41295011c406dabcf7284f3a01ad1.camel@siemens.com>
Subject: Re: [PATCH] clock : avoid panic on xnclock_set_wallclock() call
 during COBALT_STATE_WARMUP
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: florent pirou <florent.pirou@intel.com>, xenomai@lists.linux.dev
Date: Wed, 07 Dec 2022 11:20:47 +0100
In-Reply-To: <20221206113707.31311-1-florent.pirou@intel.com>
References: <20221206113707.31311-1-florent.pirou@intel.com>
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

On Tue, 2022-12-06 at 04:37 -0700, florent pirou wrote:

[snip]

> ---
>  kernel/cobalt/clock.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
> index 2b9efad4e..b1b9a3b0e 100644
> --- a/kernel/cobalt/clock.c
> +++ b/kernel/cobalt/clock.c
> @@ -282,6 +282,11 @@ void xnclock_set_wallclock(xnticks_t epoch_ns)
>  	xnsticks_t old_offset_ns, offset_ns;
>  	spl_t s;
> =20
> +	/*
> +	 * Check if time/date is set earlier than cobalt_init
> +	 */
> +	if (!nkvdso) return;
> +

Thanks, but still something to improve:

Reportings from checkpatch:

ERROR: trailing whitespace
#202: FILE: kernel/cobalt/clock.c:285:
+^I/*^M$

ERROR: trailing whitespace
#203: FILE: kernel/cobalt/clock.c:286:
+^I * Check if time/date is set earlier than cobalt_init^M$

ERROR: DOS line endings
#204: FILE: kernel/cobalt/clock.c:287:
+^I */^M$

ERROR: DOS line endings
#205: FILE: kernel/cobalt/clock.c:288:
+^Iif (!nkvdso) return;^M$

ERROR: trailing statements should be on next line
#205: FILE: kernel/cobalt/clock.c:288:
+	if (!nkvdso) return;

ERROR: DOS line endings
#206: FILE: kernel/cobalt/clock.c:289:
+^M$

>  	/*
>  	 * The epoch of CLOCK_REALTIME just changed. Since timeouts
>  	 * are expressed as monotonic ticks, we need to apply the

