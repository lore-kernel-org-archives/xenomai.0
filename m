Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432018F70
	for <xenomai@lists.linux.dev>; Sat,  5 Oct 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123387; cv=none; b=ssm3ohnYswblxV5TrVZLfozwH283vSDaUnChuvLL4yKolW4q/wLW8bZM5v8ToWiP6wTmoyAE8Z2/dBY6VFz0eq6nNPQ71bbggm1+mYw7VplgOJeiXZYDnrXxoloU9P8+BFbqP6j0iwVaG3Q+sGQSX5BgUZN1IYwZhwLuSZQb1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123387; c=relaxed/simple;
	bh=4WpqPYYLxtJ6xGfI+K3Y2L3gBTBoZmOs5we/tlNi+GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rC//2IHf8uWPb+wqb2LFaW0FROQ8IdfVKpqGifjJnd1kDmw3VIFJDGmbN9mxxL8gNc1JwP9fb7y878nwUHD6huR19nPp/0DnVJTUoqUQ54j+TeluSEgsZnt+AzIu8kc3eMj1JJUwDhbH2k1TCc4T3H0mJfVnweh1vo22yTbLGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=m8wwXX+1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="m8wwXX+1"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2facf40737eso33563571fa.0
        for <xenomai@lists.linux.dev>; Sat, 05 Oct 2024 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1728123382; x=1728728182; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHjdChhkSUZmWupBjKpXND8Wf7T0r8LBvF2xigWBKCU=;
        b=m8wwXX+11UzmNEXHxaM3cnjSYeNwSQxD3p/i8Hi3J858kdUohj78x8Q119VUx5UheK
         kI9bGuA6y8TyweRBXgYx/ssc6GYlJ7U+vmpxc2NOvsHjhaiOLsc0tKvx/SwOawASymig
         6kB31vjv8Ztco2ymqnIyTogqU71+dKHrclXP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728123382; x=1728728182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHjdChhkSUZmWupBjKpXND8Wf7T0r8LBvF2xigWBKCU=;
        b=UY5Q4+ANB+IHldgdPSwJiA8Esj22tZd2LvNFwU3zoDdzWf4G2TV2sznSPQwvFcMyYX
         fIY77iSdO5PErP2Ris/BlonFCepg5QhgpsvHnO2vzB/61Ext6mvxBLojzYGLTSWF8oft
         J6MNu2ffnbCoLuQVbQDbAUdhhoILtKVyusH49AWdZss6XkeaRl9Hyl1+rqaY8nOdWWUZ
         T4uIYJ3OmE/0F7P0ia2UxQdjNws5qWpQSRincxg4PKkWEyZq0hFykkq7PopMu4rqMQEQ
         sdyeBsnNJD+OENlM1PsDCg4l7YTdarUpEmo6VnMmHnDt+Dm9ONGo7LzLBdRL/eb/vhMO
         DhgA==
X-Gm-Message-State: AOJu0Yzcn9Ha/1ODAfS8UDLWoauZo/v3n/uOWWKQ1+FkTzZ4WSzI6x5a
	wFfsXhfRU6aPEylZup8JdAtOS/TPv+yFu8joMQnqS5xntZYrqlgpxK0r82oWqU9ySqiUCANfi57
	vENU6wDBWBnEgoVFh0i9TiCvU+Dub0KSaRNYEwg==
X-Google-Smtp-Source: AGHT+IHezziH5S5nhFTdSz0n6ff/foNzcyrYFLQTev5EUe0sRst7KCyEJS52zXuKH7+kXke07XkXQVKDyxY+H/Cwjhc=
X-Received: by 2002:a2e:1309:0:b0:2fa:dce8:7396 with SMTP id
 38308e7fff4ca-2faf3d98f11mr20051601fa.31.1728123382376; Sat, 05 Oct 2024
 03:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004190633.1814057-1-tobias.schaffner@siemens.com> <20241004190633.1814057-2-tobias.schaffner@siemens.com>
In-Reply-To: <20241004190633.1814057-2-tobias.schaffner@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sat, 5 Oct 2024 12:16:11 +0200
Message-ID: <CAFc1U0ut3dgHZ1ryooBfbfem2zHtHJ_AM33EXQftS9ayVw6iwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dovetail: Guard _TIF_RETUSER with CONFIG_DOVETAIL
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com, rpm@xenomai.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Thanks a lot for the answer. I've just booked oct 16 on my agenda.

 I think I'm already on the new list.

You were unable to be subscribed to the list because you are already
subscribed.

regards

Le ven. 4 oct. 2024 =C3=A0 22:02, Tobias Schaffner
<tobias.schaffner@siemens.com> a =C3=A9crit :
>
> _TIF_RETUSER has to be guarded by CONFIG_DOVETAIL to allow building
> CONFIG_IRQ_PIPELINE without a dovetail implementation.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  include/linux/entry-common.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 900c6e303ab3..8a84f57bfde1 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -350,13 +350,15 @@ unsigned long exit_to_user_mode_loop(struct pt_regs=
 *regs,
>
>  static inline bool do_retuser(unsigned long ti_work)
>  {
> -       if (dovetailing() && (ti_work & _TIF_RETUSER)) {
> +#ifdef CONFIG_DOVETAIL
> +       if (ti_work & _TIF_RETUSER) {
>                 hard_local_irq_enable();
>                 inband_retuser_notify();
>                 hard_local_irq_disable();
>                 /* RETUSER might have switched oob */
>                 return running_inband();
>         }
> +#endif
>
>         return false;
>  }
> --
> 2.43.0
>
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
