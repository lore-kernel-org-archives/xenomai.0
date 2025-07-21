Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA311205E26
	for <xenomai@lists.linux.dev>; Mon, 21 Jul 2025 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112078; cv=none; b=DuldnFY/6QrCwEvZliApzbi5YVNjikajw/NShaAq/8BB/1Isdnb1GDwDSDdbIGCyyQwZCdQUO1Daph4JDd3mI7wwh44FjYtg5PIo1LZ8WAPb5m4h/CRDqKBgSJmxIW3SIct7CmuBbfS7ag/yN23U7JkqBywxr5RC4jd2mD7yc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112078; c=relaxed/simple;
	bh=O/qAxCjE/MLQFnDxwOilAVAYqqpzFRRv3qQDa8bcVzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPwcfIqz1k2A6Uz3NeRMXbd8gK3d2A+QaCOZ17vmsWaq07Kwl3h1pbghxGLh0raAbFiB+hmzSozGfJRYBXrivb/XnCL36Ofiw0a3kqmjbZHCrWzb02FGJjveqMCNgTpvhDBxa77bQ1Z25ie8FJtIFj/9bdQ9Op0dt8guOaiNvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=bW+eBrUd; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="bW+eBrUd"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b8134ef6aso45240861fa.0
        for <xenomai@lists.linux.dev>; Mon, 21 Jul 2025 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1753112075; x=1753716875; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lizjlg3SM5axDADwfvcU2L0sYHSQIOi6wNZ9rNmnkU=;
        b=bW+eBrUd2yjRmyA3+K9BOfkwqx7dpTqqEyvVlFhiG653MDOE/Z2Wad2j1xoIQgVYG+
         bACRYSdm1aATSqtEtj/BcXSZhV6WRJJzNOexU2eX7Sp0h54ulT5zPA/2nNOZYvS7GzV3
         wJbRpA8IHfEcU90D77DCidat3phLx4NjBEuxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112075; x=1753716875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lizjlg3SM5axDADwfvcU2L0sYHSQIOi6wNZ9rNmnkU=;
        b=GkJ48Cx6GYIvOf4P9pUk7fS0L6MCzOYBX/AICmELOjLyW6ikffp80hLxvSnig+zxpl
         MHk8ZyWKXEFFpPCPLddZu+yRa0E8nvwX63au3ARq6LaXS3fUdMeFxbL9DKcmSAR6ahBM
         k4qC8CG1xptBawFRW/cuEhA2+0OlSEk9Okod86Ys/42UlgffLoWUc+KVdvimqkynZxvP
         JMzYcqlWw4v4Ritve0yIO9On6E/0ddwIn2JVFvZ0jWlnx7Sjp1aztLUjQbl9eKCG9I3v
         ZR473u4X8V9A6S4s3qyHn6d7FF7ifiRAHbj9yA0iOpgUH1L/omubIT2WLFZo4Xa+lf4X
         Rihw==
X-Gm-Message-State: AOJu0YzY4ZCq8W+QsGilcB3Z/XvICSW/2vSDW29rCPJ8TlcDDtloyBUV
	6KpgwQ86XlIe6WPFkCgwN2eGnhSb40/6sx1CNn/AnvMamJr4pGkby7QEL8dNmE+OVRGceNJKQqe
	09bU/PJXRimqs/UUOj/XAVfm6pEQG8lEMA6qRrJbG6BXBtvIdwFho
X-Gm-Gg: ASbGnctt91dOES2Vu1Wg6Z1DoY69F5+d/mDkHAd+2vosZuvbKnLClf6vKDvlvTujPkn
	ypkwBJ74KGNIL6RxAi5xwWA1VOZ+hDgWw1G9zgGhW97qKk2Sn6dxdxl2gEGwPiMKgX214c2pWuB
	uVX/xXUZ9nY3amZvhUe0k3e/ApaoCDKL8W+PRNFDKhyjP/yjTB5l1AMWchwOlNwrJ3RE3HMXhEC
	gQ/bazN9l2IZpxEMyxbZ3TzQsusLsrlEZQTBexk
X-Google-Smtp-Source: AGHT+IFsGZRhjUpwLqQtcXRXRe1Dh6OAsJvHqnBd9wca2JSzTFLgf2RAZBGW9TxEvE4+mo4qTxVUF9ZTRm2884c5xEo=
X-Received: by 2002:a05:651c:b10:b0:32f:3671:4d6d with SMTP id
 38308e7fff4ca-3309a469ac4mr37108511fa.1.1753112074717; Mon, 21 Jul 2025
 08:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <7ec1afca-5d28-4763-a091-886e1c31412f.luis@apue.org>
In-Reply-To: <7ec1afca-5d28-4763-a091-886e1c31412f.luis@apue.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 21 Jul 2025 17:34:23 +0200
X-Gm-Features: Ac12FXyQWkN2RDtxWbEdxsU6ewX1d4ooZNUtM3l-NkStnalsSXRqXtqr8hhoZGg
Message-ID: <CAFc1U0v7ENaCASVAje4CdEoJ7xP1GmM13StK4rVCt9T88mBGSg@mail.gmail.com>
Subject: Re: xenomai.org down?
To: Luis <luis@apue.org>
Cc: xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Same for me.


Le lun. 21 juil. 2025 =C3=A0 04:45, Luis <luis@apue.org> a =C3=A9crit :
>
> https://xenomai.org
>
> GitLab Logo
> 502
> Whoops, something went wrong on our end.
> Try refreshing the page, or going back and attempting the action again.
>
> Please contact your GitLab administrator if this problem persists.
>
> Go back



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
