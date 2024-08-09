Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE3198845
	for <xenomai@lists.linux.dev>; Fri,  9 Aug 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217390; cv=none; b=oBbYOSyEeIfW9bXZnjaLZUPTZ7VLGnNYL4tfdVr5itVhLiP7WtCvk3XDQ69LnXxbeVin1vYg8v6yh5qkHg5u79AwDtSsLqb57vJsG76IMCx34CAbSzMgo4Lm5mjezn78/I7s063Fhv2DNRlnnBxdYLA1hcSo5KpXeCPWvjPVm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217390; c=relaxed/simple;
	bh=/xUxWaZY0ia3Q+i7A5VGVkFwv41NOsz/u5WNlOGnh1g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QEVTpYCnLkY0eJw10RN9l5o5ltBhrvL4EhVNlIXRe+2FjywHwD5VppfxM5/Vl2rHdwgmrHT5oKFgqTSYje8pC0h1XNyAGA3hPoYCcfz9nGbgJJS7rR4meKIdElSqFrgk35E0vKtguVXL05BXI4iuWJ3clsYJkxWTCUNshJqAskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=amsXB3Zy; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="amsXB3Zy"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 95C80100005
	for <xenomai@lists.linux.dev>; Fri,  9 Aug 2024 15:29:39 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B8B35740048
	for <xenomai@xenomai.org>; Fri,  9 Aug 2024 15:29:38 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso22997291fa.3
        for <xenomai@xenomai.org>; Fri, 09 Aug 2024 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1723217377; x=1723822177; darn=xenomai.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=88zXQDG3aHcjsMHykgvYdCaoE4HflMnxnYsvDo3R21I=;
        b=amsXB3ZyZhVsOqH/lVeS2Kvc6IZMB7+FHnr86yrid4t0WB3xf1zfKQw/k1ZXyzGgyp
         wwDrnGy+dxvgCc/75lnZpRWDmpECOdF71T2TIO5HAWDHmROoRBHccrgeRBXSu7mXiDQq
         zn17HIxe6/ZybWh2cf7cMx4R3xwHeVfL2OQlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217377; x=1723822177;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88zXQDG3aHcjsMHykgvYdCaoE4HflMnxnYsvDo3R21I=;
        b=WuiMzWEBVrHtRy6tqtNbjYy3aEa1HUWeLATbdEheD8DDTEoyOletWpCa9rQrOXW5Yn
         KFKo2NptNsrIHCi3jnlfxDW5MMtwEced9UneblMJp2xbfxN7KKTRT6MbcLQB4QP8xndz
         6LUqsIRxDrHwXIiIkUmrD3cb5WKGNuzateDHqavqa/O3N/UFvzjeSJo9FUOCvMl7OcTv
         DlB8m7Jk3/ad9QzmN6/EZVw2dKOAPxg+qLFXZ6IMruD+9wpElpU1fOJePmJe+wH/BJwK
         e1fS8K6th5psKeuONoKvgF33rCegzd90ynKD09jTFQeQeiDuodPi9p5eIus3bxX+fRUU
         7Ugg==
X-Gm-Message-State: AOJu0YyHJrcTIlbuzqqPO3fg+DKMgHJ8U9q6SZs+huwtldOPsw38Qflr
	GYuxWPIsLdq22q7RdlP83Tdw2xms9Qhx9Pn0ZitHVj5qkzJ2kEpfzpxeLefMf+c9zKYS1XiLyKt
	p8VNPFRLC99bVADXCf9KXRe2EG5Mes4IEhVRhjuMRYvwsEAlNC34=
X-Google-Smtp-Source: AGHT+IEIqNYgH3tizeoSlksHJsTxAAVSyyBx0z/rKTL9v1IBMWDnj6ZPyNrugWM1EWg4Ggfu4+e8q1G8woRlVtBYGA4=
X-Received: by 2002:a05:651c:1713:b0:2ef:3093:e2c3 with SMTP id
 38308e7fff4ca-2f1a6d32030mr13384931fa.31.1723217377222; Fri, 09 Aug 2024
 08:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 9 Aug 2024 17:29:26 +0200
Message-ID: <CAFc1U0sm5nyd_P2oXH20nkCjfip-d=B66htnaC0bunx4quzzFg@mail.gmail.com>
Subject: Dovetail kernel compilation error
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::22f as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

As compiling linux-6.1.y-dovetail or linux-6.6.y-dovetail I get the
following error :

kernel/xenomai/posix/timer.c:216:1: erreur: conflicting types for
=C2=ABtimer_delete=C2=BB; have =C2=ABint(timer_t)=C2=BB {alias =C2=ABint(in=
t)=C2=BB}
  216 | timer_delete(timer_t timerid)
      | ^~~~~~~~~~~~
Dans le fichier inclus depuis ./include/linux/workqueue.h:9,
                 depuis ./include/linux/mm_types.h:19,
                 depuis ./include/linux/buildid.h:5,
                 depuis ./include/linux/module.h:14,
                 depuis kernel/xenomai/posix/timer.c:19:
./include/linux/timer.h:186:12: note: previous declaration of
=C2=ABtimer_delete=C2=BB with type =C2=ABint(struct timer_list *)=C2=BB
  186 | extern int timer_delete(struct timer_list *timer);

The target is a Pi 3 used in 32 bits (Cortex A7). I use the 13-2-rel1
toolchain with Buildroot.

https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads/13-2-rel1

Thanks by advance

regards
--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
