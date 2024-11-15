Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0A17E010
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701048; cv=none; b=pkJTybxi5rOe0nL8My40+Vd6ftQLFcXljeX3Ix6HRKgevReoKB+Tw22Wp3CgdCQs8oedHw6QLRR5370jdhVtGz5YCcHUxrlAyTye5cKypYLQh9HijZonoDuzpiHX0x1Km0a5Dj28k9vw0mW2dw6m+qRoU29RerG9gnEQijTKvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701048; c=relaxed/simple;
	bh=REjTFvJWDO+K+9oGQHZV1VWhVFxhOthYgjU3cDYdP2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4nhtYYxig+4caNPMKhNgKVKVDb2LgMHWn0zACbeXNQWXktILscmNWuDiLoQaLdcTC92HzciKoJ4Hrn72piMTO2sG/IXorTNKAaUrP1x4JC+CvNQZlKGSofVsw60P+epUxT/8em/6WUkTPg0sTUVrnONsqlzqCFj1B4AAnH5TyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=jWgQPyGH; arc=none smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="jWgQPyGH"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 8067F200005
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 20:03:58 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B2E73941959
	for <xenomai@xenomai.org>; Fri, 15 Nov 2024 20:03:57 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2fb49510250so11116331fa.0
        for <xenomai@xenomai.org>; Fri, 15 Nov 2024 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731701037; x=1732305837; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9m/15T73uM5nosIds+ewQWm3mIHQV68lAkUoF4foV8=;
        b=jWgQPyGHqnHoXluHjPTna+TTfN7lXFXWygEy/oFMU2xW7XQ48Gl0tLoQwjvdclaIEL
         qdWMhQsICp14gF/gOowc6dNxkPQNi+SGzY7q+Ndp+KAhs31/WQ6b8QY6MCCbxxu+2RWu
         Tgl60OqfyYsyKohYLiVth9O3HpoZ9tkC/oQQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701037; x=1732305837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9m/15T73uM5nosIds+ewQWm3mIHQV68lAkUoF4foV8=;
        b=Agtdz6s1VtDOg0YU/60jEfgXAOd6O84mev2pCjPpEGUDJWqLkuud7bS96vQ+CL8Lq1
         Bl13OICNdflS7DphIOk3udcsuFKeqHIxvt/4+xl8AkvtZWEPHszxjYJ6rOYUOGxOTrlc
         faMwtO5D2HfREJsuQMrbJqlceOUs6FYIB0UymKF8D1HbYTVd8IReSuk+eoANykTarVqk
         5g04oLVDV8fuNyI1g0QvCsuRKbh+1k94sr/PdkknDUASg7dCJXSksQ7uDST5BFIclSxD
         3hPH19cQ6n8BCOFv663A92h332/Ym0qsqKpm2+ATJew7KhZirNR1hDhOVKiIL2jt1NTK
         ohjA==
X-Gm-Message-State: AOJu0YyI25dvBilrU/V3ctnMhqFFLyNsUyBTV3B1ROLnKZO48pmz5iMg
	p833ghHtwOiCQfmmrZXIh9imeDr+EzNuMkCrw//4/9HI+gK2z52r3upcLFpzKfd/CigJNpPTTyG
	nBhngXjIeMzF0Rhi+pyfwseaRaaM9x3xlc8kvOpjNkVzebA1a
X-Google-Smtp-Source: AGHT+IGLJZtXNT8OO5m37aoQQzrXJgWCR4VBYJUwLXaePzIgbIowsv4HxoURfPA9YwdbQmuJgnF+GXmwn55y4c8IzAg=
X-Received: by 2002:a2e:be89:0:b0:2fb:57b7:5cd with SMTP id
 38308e7fff4ca-2ff6064de46mr22326831fa.7.1731701036823; Fri, 15 Nov 2024
 12:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
 <f006bb96-5d85-49a6-92ff-b40ab8030db5@siemens.com> <CAFc1U0uu3vBf0qx2bkzRXxQCuL0RFA5od4+AOvP6O6m4T9C44w@mail.gmail.com>
 <329cb61c-c663-4260-b240-55ffe834e71a@siemens.com>
In-Reply-To: <329cb61c-c663-4260-b240-55ffe834e71a@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 15 Nov 2024 21:03:40 +0100
Message-ID: <CAFc1U0s9109_p_L2OpAxNNQVBbVV=Z-UHyvpQK7oqkF13N83WA@mail.gmail.com>
Subject: Re: Error building xenomai-images
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::22d as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

How can it be possible ??

Le ven. 15 nov. 2024 =C3=A0 17:15, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 15.11.24 15:40, Pierre FICHEUX wrote:
> > Hi,
> >
> > AFAIK I use Docker (and Ubuntu 22.04) .
> >
> > docker run -v /home/pierre/Yocto/xenomai-images:/repo:ro -v
> > /media/pierre/SANDISK_PF/Yocto/xenomai-images:/work:rw -e
> > KAS_WORK_DIR=3D/work -v
> > /media/pierre/SANDISK_PF/Yocto/xenomai-images/build:/build:rw
> > --workdir=3D/repo -e KAS_BUILD_DIR=3D/build -e USER_ID=3D1000 -e
> > GROUP_ID=3D1000 --rm --init -t -i -e TERM=3Dxterm-256color -e
> > SHELL=3D/bin/bash --privileged --log-driver=3Dnone --user=3Droot
> > ghcr.io/siemens/kas/kas-isar:4.5 menu
> >
> >
> > The log.do_bootstrap contains the following:
> >
> > DEBUG: Executing python function sstate_task_prefunc
> > DEBUG: Python function sstate_task_prefunc finished
> > DEBUG: Executing shell function do_bootstrap
> > W: qemu-debootstrap is deprecated. Please use regular debootstrap direc=
tly
> > I: Running command: debootstrap --verbose --variant=3Dminbase
> > --include=3Dlocales --components=3Dmain,contrib,non-free-firmware,non-f=
ree
> > bookworm /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/=
rootfs
> > http://deb.debian.org/debian
> > /usr/sbin/debootstrap: 1764: cannot create
> > /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs/te=
st-dev-null:
> > Permission denied
> > E: Cannot install into target
> > '/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs'
> > mounted with noexec or nodev
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Your workdir does not allow the build to create device nodes.
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
