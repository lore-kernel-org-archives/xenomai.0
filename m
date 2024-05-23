Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1490014A4D9
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471368; cv=none; b=MVHzmZSeh4uGq0fpvwz341JCyC+XEwJfQdeYi4BT5BTgaT7XIQisvmjuDqJvX6ia3G2vdYIG8wgOR/+oHtm+QnsvloQUbgkR2G8S4sboHxyKkqzBV/AfNl32ynOx6ZiemRLc4kpU4E7eUsH2vPopKdw/eEjMKZ80/DQcU8dNP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471368; c=relaxed/simple;
	bh=BCu0do8NB20jPSBW+sshnpdmULmFbqXDrxqeKAYbpuw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Oo2xaHv9KFvp0M48s9VQLtMZO1ByHqitPEmnf04LVZPoEn0YMLySk1fMOtqEebUZK84qpT9DMColaT6vOdcyAO9S0ZnlOXQtP5db1WjhZtpEU4kMX1ShIPBV6i1/vHKBHynkU404175NRXej/NMj2WJP62Ir6tVxF23wLIbW1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4200ee78f34so18460765e9.3
        for <xenomai@lists.linux.dev>; Thu, 23 May 2024 06:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716471365; x=1717076165;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFXh462yuatjRbf7FlZZMlQxIRd3ep7l7dQdgowVxwI=;
        b=wWyqw7OnpFC121EG18Jmh/p+8HUXLqBJSN02EZHbGQqw4qDz79+oIhFZqXut3TTo5i
         rrOR9OU6Uys3CjSAtSeAlTYVEAv9rKXxtRIzQF03SXCJJasmjijJzGztMwmS/6EyaMdL
         WiuMVYSg81MZXS3jJ3Q0/HOhrrxu8n2ohnSjQKa5q46NLJJc7a+S7DXzVLf0Wr9QgPYM
         tdWh5+/a5Xqj8iFqJw6hWDJ1cgJYtMtXR6OQaI8XZLp1ALw7L7T4WtP+d/RthQ5V/wa8
         Zc14ReN7Dw3RhjkukkC9qucDbJJbHwxvYbjE+GVW54z7ecq7Lgr83nUI8flEc5ltZ90N
         HL1w==
X-Forwarded-Encrypted: i=1; AJvYcCXoDuw1pzXmuZSkBm7tucVsPYygwwl3lzPUbSChiDA+Tb+pqJvCnNM9Wx1tNpoGDAdaEvWrOt26YPZv1wUrYXHva1ZUiUv2Zw==
X-Gm-Message-State: AOJu0YwsRr1zgSJUmU7SjfQoTRykEgvtybGooMF/Ct5WMTLK7Dk+KnQ2
	kF4N97Y7wGbU+8f1OjS6Ss8GgruDiYgUk+xc8vJQrV3DLCZ93IAZcbJdY+Xp
X-Google-Smtp-Source: AGHT+IHdK0wBg69Gq542Pi4GpqECIAQDSlZMrfmiuGzhVX+MMh2f2dpIZiDbeiiVImsakUbmSi791Q==
X-Received: by 2002:a05:600c:3b82:b0:41a:34c3:2297 with SMTP id 5b1f17b1804b1-420fd2efc89mr36565125e9.5.1716471365323;
        Thu, 23 May 2024 06:36:05 -0700 (PDT)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1ca28sm25426935e9.15.2024.05.23.06.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 06:36:04 -0700 (PDT)
References: <Zk68Q+2tgdwEkcS9@2956c958a175> <87r0dtrmbe.fsf@xenomai.org>
 <87msohrm1a.fsf@xenomai.org> <Zk8peHJbgRay+Ya/@2956c958a175>
User-agent: mu4e 1.10.5; emacs 29.3
From: Philippe Gerum <rpm@xenomai.org>
To: JiajunDu <wonderboy512@163.com>
Cc: 87ed9urpex.fsf@xenomai.org, xenomai@lists.linux.dev
Subject: Re: A problem regarding SMP
Date: Thu, 23 May 2024 15:32:16 +0200
In-reply-to: <Zk8peHJbgRay+Ya/@2956c958a175>
Message-ID: <87ikz4sla4.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


JiajunDu <wonderboy512@163.com> writes:

> Ok, thanks for your reply. Now I understand.
>
> Best regards,
> Jiajun

You do have another option beyond the flag which is restricted to
unicast for the time being, which is using an evl (kernel) semaphore,
depleted at init:

evl_init_ksem(&ksem, 0);
...
evl_down(&ksem); /* kthread */
...
evl_broadcast(&ksem); /* master (spawner) */


-- 
Philippe.
