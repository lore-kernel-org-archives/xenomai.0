Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601E1CEE88
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681667; cv=none; b=BcZ8zVHsUr8p1XJkLcp92MB1ZrKxoGXuxRrAljvWg/D6/FZZAp00LVn9VrG816d/Fs54IV2mBHfIpfbzUVRxV0gx91DozK8lJgq98XULZlsoRf/29GLVy+uRPYGbtQhBrM9rqK65OB2bwS4dNcc+JnQRW+eeze7b2OjSPw/8nOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681667; c=relaxed/simple;
	bh=tvR76jPjEfaOOp51lXUpPh88Y0a2ZTYudIGFQN2sEoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psK/dY9rS8RJkMXbi39DBl2Ej1GUMKotXReIaecJogTdf0pq34nlWocFcKbNJLRousKe/S0vG5zM1mx8DEMEmPps5wrinOz9AwJhBz8vEMlc7xNSD4pn+WOIdafnkeU8he6/74t345z/EIrV3khc/pYrzNBbCvUYlu90euG87SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=bSmIM9bC; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="bSmIM9bC"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id DC58A80002
	for <xenomai@lists.linux.dev>; Fri, 15 Nov 2024 14:40:55 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 0C2157803CC
	for <xenomai@xenomai.org>; Fri, 15 Nov 2024 14:40:55 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ff589728e4so19681311fa.1
        for <xenomai@xenomai.org>; Fri, 15 Nov 2024 06:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731681654; x=1732286454; darn=xenomai.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNgkTqBAfwZSN1cMQIU9NWiWAVnlIKTXgaQOYQArgH8=;
        b=bSmIM9bCPiMFT2adonKio3loRO9kwimzPq6DTqLgSGWCVr4FhLvseso41e3uGoCIt8
         nPXSXHzPnOc1gDwv3tckV0dfaa3BXR3h8mO+BSAX8m6MtNQC9+XFh4XPFe3zSczTqiBg
         j8AKXLUzinF7shCjzQATVPwjPpWqLUGs/d3gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681654; x=1732286454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNgkTqBAfwZSN1cMQIU9NWiWAVnlIKTXgaQOYQArgH8=;
        b=LRT+6f2Gju619LAeI8kbfHKodq2+AQI5NG+Rrgadim9k8FvSYLsdKgAWLt+4KagdE5
         YIXAydaWx6ePyoYYuk62/LSL4qZXhmb1Aei9MBUZfJGblZCJdnk9yCdM3kpHFlTpJs+e
         rHl6++bBfcYLAbzlU743xtrCnBSgkBFBTJ+IzVLT/1ankHbiY8h1UM0TmMVUo/ATiwfH
         4fQqONQrF+JuscerPYPSCY5q628bLnVzEUXz4T5H2BxC2ICWSCVL78FoPB6C+ZGONE4A
         1G/JnxufMWyk7cDLrg9GPP1zFmjb+Ac9cRLo3yP9en6WQo1aXQvSejcddKt0c95BP+ci
         D+rg==
X-Gm-Message-State: AOJu0Yw3CRHgl7y+YXEtSX8NFGB8F6l7SwWZFGk2YZ94MWP0I4CtJOqj
	i8PypyBDeFnJ0YzbM4MfD7+3dDbRaicueOaGf5KVV3Td9Ynv1KetZNpvUcHOr8hcJBhp3Y6skYd
	OuMOBHwmBSp88C+552KdYKa2lhKNDgolYscN8tI8pYqKcox4yMFg=
X-Google-Smtp-Source: AGHT+IGPbObyEWNlS1gS2BZfQIUbrzzpYPdfot2zCfaPkUZWjK8IPp909k6bm3wa2wYCWL7WK6Oq4XoD33kX1DJy/Mw=
X-Received: by 2002:a2e:b8ca:0:b0:2fb:5be4:3645 with SMTP id
 38308e7fff4ca-2ff60550647mr8422371fa.0.1731681654064; Fri, 15 Nov 2024
 06:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
 <f006bb96-5d85-49a6-92ff-b40ab8030db5@siemens.com>
In-Reply-To: <f006bb96-5d85-49a6-92ff-b40ab8030db5@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 15 Nov 2024 15:40:43 +0100
Message-ID: <CAFc1U0uu3vBf0qx2bkzRXxQCuL0RFA5od4+AOvP6O6m4T9C44w@mail.gmail.com>
Subject: Re: Error building xenomai-images
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::234 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

AFAIK I use Docker (and Ubuntu 22.04) .

docker run -v /home/pierre/Yocto/xenomai-images:/repo:ro -v
/media/pierre/SANDISK_PF/Yocto/xenomai-images:/work:rw -e
KAS_WORK_DIR=3D/work -v
/media/pierre/SANDISK_PF/Yocto/xenomai-images/build:/build:rw
--workdir=3D/repo -e KAS_BUILD_DIR=3D/build -e USER_ID=3D1000 -e
GROUP_ID=3D1000 --rm --init -t -i -e TERM=3Dxterm-256color -e
SHELL=3D/bin/bash --privileged --log-driver=3Dnone --user=3Droot
ghcr.io/siemens/kas/kas-isar:4.5 menu


The log.do_bootstrap contains the following:

DEBUG: Executing python function sstate_task_prefunc
DEBUG: Python function sstate_task_prefunc finished
DEBUG: Executing shell function do_bootstrap
W: qemu-debootstrap is deprecated. Please use regular debootstrap directly
I: Running command: debootstrap --verbose --variant=3Dminbase
--include=3Dlocales --components=3Dmain,contrib,non-free-firmware,non-free
bookworm /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/root=
fs
http://deb.debian.org/debian
/usr/sbin/debootstrap: 1764: cannot create
/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs/test-d=
ev-null:
Permission denied
E: Cannot install into target
'/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/rootfs'
mounted with noexec or nodev
WARNING: exit code 1 from a shell command.

regards


Le mer. 13 nov. 2024 =C3=A0 18:41, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 13.11.24 17:07, Pierre FICHEUX wrote:
> > Hi,
> >
> > I have the following error as trying to build an image with kas-contain=
er :
> >
> > $ ./kas-container menu
> >
> > I use the Build button for a BBB :
> >
> > 2024-11-13 16:05:02 - INFO     - kas 4.5 started
> > 2024-11-13 16:05:13 - INFO     - Using /repo as root for repository xen=
omai
> > 2024-11-13 16:05:13 - INFO     - Repository isar already contains
> > 75488685dd2123417deb70f6d0923b8c2772954e as commit
> > 2024-11-13 16:05:13 - INFO     - Repository isar checked out to
> > 75488685dd2123417deb70f6d0923b8c2772954e
> > 2024-11-13 16:05:13 - INFO     - /build$
> > /work/isar/bitbake/bin/bitbake -c build demo-image
> > Loading cache: 100% |                                           | ETA: =
 --:--:--
> > Loaded 0 entries from dependency cache.
> > Parsing recipes: 100% |##########################################| Time=
: 0:00:04
> > Parsing of 46 .bb files complete (0 cached, 46 parsed). 86 targets, 0
> > skipped, 0 masked, 0 errors.
> > NOTE: Resolving any missing task queue dependencies
> > Sstate summary: Wanted 11 Local 0 Mirrors 0 Missed 11 Current 0 (0%
> > match, 0% complete)
> > Initialising tasks: 100% |#######################################| Time=
: 0:00:00
> > NOTE: Executing Tasks
> > ERROR: isar-bootstrap-host-1.0-r0 do_bootstrap:
> > ExecutionError('/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/=
1.0-r0/temp/run.do_bootstrap.1248',
> > 1, None, None)
> > ERROR: Logfile of failure stored in:
> > /build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/temp/log.=
do_bootstrap.1248
> >
> > ERROR: isar-bootstrap-target-1.0-r0 do_bootstrap:
> > ExecutionError('/build/tmp/work/xenomai-demo-amd64/isar-bootstrap-targe=
t/1.0-r0/temp/run.do_bootstrap.643',
> > 1, None, None)
> > ERROR: Logfile of failure stored in:
> > /build/tmp/work/xenomai-demo-amd64/isar-bootstrap-target/1.0-r0/temp/lo=
g.do_bootstrap.643
> >
> > Same issue for QEMU.
> >
> > Any idea?
>
> And build/tmp/work/xenomai-demo-armhf/isar-bootstrap-*/1.0-r0/temp/log.do=
_bootstrap are empty?
>
> BTW, what is your container engine here, docker or podman? What is the ho=
st OS?
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
