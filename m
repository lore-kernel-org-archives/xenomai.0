Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7718148FF0
	for <xenomai@lists.linux.dev>; Fri,  2 Feb 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893453; cv=none; b=ka3aKic4WieOCdij46sexlMK4JkyfAO9tti25VN1Xw1pUqvANCkjKWmADbgo1ogBPSaQig55NYe/qWHcBEjpvrnxMGKZE0NQw/2yZGO4fn1t/vOFtZ2fVEmlrdCJnaZkDIUa8uAINvBXiQkz1/uPJz2lvCLEpaqsucOKZy7KReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893453; c=relaxed/simple;
	bh=1AJH+eRgktg3jyd8Z1Dbtm/IZhok/yag0q8/lvBUdIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5t5KoMZ5wWEv+DXPtTKZN8KxZiJaSXYxKuyo9GyOGJxSC+NAjvIj3Y2Pc5NNx4fDabfGSgU/xrhz/GJg+kP2+C376jWtnS+5VPxyEX/WdOCDLsaIx/j/HQNIG24ljzO46ALI/bvKhtS5bFAOiyMyYmyPDPC8zoUOpp29inftoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz9IRXWJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz9IRXWJ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2909a632e40so1922304a91.0
        for <xenomai@lists.linux.dev>; Fri, 02 Feb 2024 09:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893451; x=1707498251; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS/iqNBVyMGNY0FSZJlKAdfPAgsT5S85kCeb6MULuAI=;
        b=hz9IRXWJ80CnkmwZUEEgoidlGg22JbCwei59/lQ9AMXNhN+Lcobu9DOjxq4O0vbwAz
         bxa6Tz/s86UT5ZgX4cXVBpnvy+E2wnHFPHjGgKLOt0u+3nPA8pGcm0tmdud0JfwWHvkV
         gt0oZrBLvYJ/6ePZh4/n6d0tzGD5wH7vB1kReF29Oja8i+NIH2NNY0X6gz/I65DueWp1
         u87vuXu39aAWYU8lwNcSaaSB1PbNiLQvVgY/qrOn4wbNKixajuem28GdLhKFoIYZXepr
         Vnvnq4oXqP4QF5WydB5DxUPpldzrFaLLkW8M/HSipHZ2k3nOarWNwyUKOMmildNcIlwm
         MNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893451; x=1707498251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS/iqNBVyMGNY0FSZJlKAdfPAgsT5S85kCeb6MULuAI=;
        b=mOWdkoR/oDmKnaNRqNjmXa54pOZDByFzu1n7ER+oIIzTHRUB0QIEijert4+EuAbCY8
         +poeX691RUBJHgEDoYmmttEdEKLDAbz87HVfLHmniTi5qGBREpexchTmVFAKcDfItkZM
         2dc0YgofmS7J2afZNW2QgWbf2Uy+41vkiSM+T53BpOyxMBenldWX5FxMG+UuxSKqgOb9
         rVeB0T9i5qpn9OcGpopFZ8vzhktjxinK8wOcxmgPoSaez0f+DVtDMMWIfy3Me8em5dfm
         nCJXXA2D2TGXtMeUwpYZ1hCiv0jpk3I2ef8sovIaKcMPBksack6ych6x83R9hV015ezx
         uqVw==
X-Gm-Message-State: AOJu0YxfK1IX5UTkyMvUdQoCy/plBfqyv01tMFdflNCGV4WXUI4G0lNs
	AtLgX07LusOfmrV5SZF0TLAG+f7K7+FNJprwN9NCrpPgbVgdxBPdDmMYkEjpS3xQKt+khzPDJ0y
	qHvesZHaRro/u4tAuKyDn1Vr9N6S0INJMyMk=
X-Google-Smtp-Source: AGHT+IGsuoUqsLhAZOM0N2u1pqTIEyG4dS6nV6KuwsOPBUPOzLFI9BGEl1hQbiOF6LirwIdSXNjMq3Ee61+KN1IxQ4w=
X-Received: by 2002:a17:90a:eac4:b0:296:207b:c917 with SMTP id
 ev4-20020a17090aeac400b00296207bc917mr4818220pjb.23.1706893451024; Fri, 02
 Feb 2024 09:04:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com> <20240122160105.2452024-6-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-6-clara.kowalsky@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 2 Feb 2024 18:03:57 +0100
Message-ID: <CAFLxGvwH5i=u9_7ffN_uwctBHOANFDe3SFfoL9mxYbkpQJx8sg@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] compat support: cobalt/posix/syscall: Use syscall_get_arguments()
To: Clara Kowalsky <clara.kowalsky@siemens.com>
Cc: xenomai@lists.linux.dev, rpm@xenomai.org, jan.kiszka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:51=E2=80=AFPM Clara Kowalsky
<clara.kowalsky@siemens.com> wrote:
>
> Use the generic implementation for fetching the syscall arguments.
>
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  kernel/cobalt/posix/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.=
c
> index 6e1f15ea5..1d37cb279 100644
> --- a/kernel/cobalt/posix/syscall.c
> +++ b/kernel/cobalt/posix/syscall.c
> @@ -584,7 +584,7 @@ restart:
>          */
>
>         p =3D current;
> -       pipeline_get_syscall_args(p, regs, args);
> +       syscall_get_arguments(p, regs, args);

Hmm, how does this worth with Xenomai arm32 ABI, do you fixup regs
somewhere else?
It places XENO_ARM_SYSCALL into r7 and uses r0 for the cobalt syscall id.
So we're wasting one argument and they need shifting.

--=20
Thanks,
//richard
