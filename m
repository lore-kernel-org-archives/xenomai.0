Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D928172A
	for <xenomai@lists.linux.dev>; Sat, 16 Nov 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731778824; cv=none; b=WEgYKaXT00Lz6fmfYpwSSktua9fawrAbV1p8/wfjWC0ErdHa82G0M6lVCsyGER+H2x16iOfkQRQQ7f2dMSGIPY2yfXzhbNxRpqaegK257ZA02ad4dqZ0qdC2ws/3EjSehlk0061GGX/oarT4FBguDLDgU1zuejPO29uOlrmEr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731778824; c=relaxed/simple;
	bh=+gQxSFWyn9AWt0unOK2xJhiiilyfGBKBJSdXrqodefE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lithQ2QmCTFRZrgzxofb7+JzdVV0Ygxcbd5NfI0Vqpow+1GEihkRLZPCK3EkaNTt3CHPg2xX2RwYjwIRhdWiKSxR6YnMhshP7fmIKnU6T5xdnO0TGNleOoVldcqrGtnVIpxVeITIXF14b+hYwzY3OzMUrJWLLzGfJs4dv4cbVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=SWjk1vBZ; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="SWjk1vBZ"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 8AF4B100002
	for <xenomai@lists.linux.dev>; Sat, 16 Nov 2024 17:40:18 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C07E4941A74
	for <xenomai@xenomai.org>; Sat, 16 Nov 2024 17:40:17 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2fb5111747cso17087301fa.2
        for <xenomai@xenomai.org>; Sat, 16 Nov 2024 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731778817; x=1732383617; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8W08viezMGs7dw//KlhNPgq36TkByhG8wF3rBYpHIYE=;
        b=SWjk1vBZaZNztfLlbzGo6Q4u9sOHK4CDX7yWQfacwV11anWKE+/xB5GV5pjGJPY/F6
         VMen1hT/5D2qrDQrFRFSPAmalxbgoe3bbPOnklG3SfaF9gmuS/5FGuLwipHXWl7342vz
         QJ4O+o0xWTuMIk4AnPFRP8ff9CiQFT5BiYKn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731778817; x=1732383617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8W08viezMGs7dw//KlhNPgq36TkByhG8wF3rBYpHIYE=;
        b=qdmqGU3UY1+u+dIqQWSrmT8+eRkU++u/484RQSSArBYOq5eYKWskJT248+w+FA7xjt
         LnY7ipLFe09Q1rnXIoWcriuOAc/WsxE2L8Cwty8/6LpW1a+DqwLE8693qlN235t7zbPu
         dnZWVmawspuvdP1RWKn+/k6bFz/bdyFoP9rrBKR5JzZocH6AQ1f/oi5bLx00hKl9V9Jg
         d8pA9DRaD/OOp6KwZRy5hBGzX/LP5g7P3m1XgGO2qNzBWFrYLK/7D8MX8aZ3ukT2zgvB
         RDfFuNPfIydq5abjDNbQMpCNYn/pAOG0+lAemIR3c9oZb9UKDtBuowhv/sDGV3zZwx5D
         Aejw==
X-Gm-Message-State: AOJu0YxyI1gG4b/tH5RmD+zkEXRJi2Rh2x9ZeMMkDbtgQHNMMNeYnw51
	ddk58fFJfX+xZJTaOX8OMBE0qgIuc7ngAPuXwuhWQkbgi5zfsD6aAp5nhW5zW8hoYIVkOqllcXz
	YBKtRJn/6KwTJR1K9Dgcqmmtvr3FYF8ezqB4TQn6rBlkXfhxOIvU=
X-Google-Smtp-Source: AGHT+IHy7qJAB9l4JhRArErUGtFyae3x2Y5MugdKJBCZgZ1NWz4xPwPQraehJbYNHSQ3UYGmoazuRqzMUhu5VCf1S2Q=
X-Received: by 2002:a05:651c:1b10:b0:2ff:5f94:e649 with SMTP id
 38308e7fff4ca-2ff606680b7mr34088901fa.16.1731778816933; Sat, 16 Nov 2024
 09:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
 <f006bb96-5d85-49a6-92ff-b40ab8030db5@siemens.com> <CAFc1U0uu3vBf0qx2bkzRXxQCuL0RFA5od4+AOvP6O6m4T9C44w@mail.gmail.com>
 <329cb61c-c663-4260-b240-55ffe834e71a@siemens.com> <CAFc1U0s9109_p_L2OpAxNNQVBbVV=Z-UHyvpQK7oqkF13N83WA@mail.gmail.com>
 <d966a535-015c-4ac0-85b6-a9656199660c@siemens.com>
In-Reply-To: <d966a535-015c-4ac0-85b6-a9656199660c@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Sat, 16 Nov 2024 18:40:06 +0100
Message-ID: <CAFc1U0v7vMXNJrwHPXMQLWVwd+TKxvO8Jos5LABnxKMrKZkn9g@mail.gmail.com>
Subject: Re: Error building xenomai-images
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::232 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Right, I've used an external disk (nodev option).

Much better now !

Thx


Le sam. 16 nov. 2024 =C3=A0 14:26, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 15.11.24 21:03, Pierre FICHEUX wrote:
> > How can it be possible ??
> >
>
> Check your fstab or mount units, they will likely encode this policy
> (normally for security reasons).
>
> Jan
>
> > Le ven. 15 nov. 2024 =C3=A0 17:15, Jan Kiszka <jan.kiszka@siemens.com> =
a =C3=A9crit :
> >>
> >> On 15.11.24 15:40, Pierre FICHEUX wrote:
> >>> Hi,
> >>>
> >>> AFAIK I use Docker (and Ubuntu 22.04) .
> >>>
> >>> docker run -v /home/pierre/Yocto/xenomai-images:/repo:ro -v
> >>> /media/pierre/SANDISK_PF/Yocto/xenomai-images:/work:rw -e
> >>> KAS_WORK_DIR=3D/work -v
> >>> /media/pierre/SANDISK_PF/Yocto/xenomai-images/build:/build:rw
> >>> --workdir=3D/repo -e KAS_BUILD_DIR=3D/build -e USER_ID=3D1000 -e
> >>> GROUP_ID=3D1000 --rm --init -t -i -e TERM=3Dxterm-256color -e
> >>> SHELL=3D/bin/bash --privileged --log-driver=3Dnone --user=3Droot
> >>> ghcr.io/siemens/kas/kas-isar:4.5 menu
> >>>
> >>>
> >>> The log.do_bootstrap contains the following:
> >>>
> >>> DEBUG: Executing python function sstate_task_prefunc
> >>> DEBUG: Python function sstate_task_prefunc finished
> >>> DEBUG: Executing shell function do_bootstrap
> >>> W: qemu-debootstrap is deprecated. Please use regular debootstrap dir=
ectly
> >>> I: Running command: debootstrap --verbose --variant=3Dminbase
> >>> --include=3Dlocales --components=3Dmain,contrib,non-free-firmware,non=
-free
> >>> bookworm /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r=
0/rootfs
> >>> http://deb.debian.org/debian
> >>> /usr/sbin/debootstrap: 1764: cannot create
> >>> /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs/=
test-dev-null:
> >>> Permission denied
> >>> E: Cannot install into target
> >>> '/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs=
'
> >>> mounted with noexec or nodev
> >>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>
> >> Your workdir does not allow the build to create device nodes.
> >>
> >> Jan
> >>
> >> --
> >> Siemens AG, Technology
> >> Linux Expert Center
> >
> >
> >
>
> --
> Siemens AG, Technology
> Linux Expert Center



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
