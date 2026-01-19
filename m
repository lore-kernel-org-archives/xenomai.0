Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7734AAEA
	for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812374; cv=pass; b=WqhqMdKSq7/rGnc0MToRUWjnrHDE+MRkmmfjBCgSOo4sdnq1Plua8k9PXyyznnXSAZ71C0FMGhW4TfEvAz0kmyVDIX3pcDSAG2Pcjtn3OIOjuxY07izub6o558V6li1ex3WrQuEJj3ABDZEU7RCY6H4aE0nCEI8VFZ+Is7ttHcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812374; c=relaxed/simple;
	bh=ieXroQF/PgXMVeOYUHEofUtcRWqX8X7DthuqYxaXOFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqWJYTXaSOyyroVB9A3bEem/mGyE3rpWTSCp49DOpTaAj1Q/5eR4ZCGmM07sX0fBvz/Qk/ysui7bfw3D/70RKOJwq0nF1WNuMwiKIesSM0JCXUOc83vtHGxB2nYFwu2RHPJPoDfQEMDF6S7IQID+zD6TfBve0ut7ZYFfGEOjymw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=ym5KyvzM; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="ym5KyvzM"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb5810d39so3173399f8f.2
        for <xenomai@lists.linux.dev>; Mon, 19 Jan 2026 00:46:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768812368; cv=none;
        d=google.com; s=arc-20240605;
        b=BiqDS0DS4Z0nZXm+DkdRQYZNgx34EL7SoVLPw5wmaa2JTTF+td+/ECFK2OFwGRQRDn
         +/YGMjlD3jYbfcG5UzqOxwIt8GVV9OG8uQeUJJPa8WMt0P6WO3GkZyLXlrIzKJ3Z4WRR
         mewrR1jNX3WDopdKnzGk0vF6yuxcwceqNzBT5hDZOmpGj/KH+7tYIIUoFfM0P5gBszO9
         O4ZVrrr8XpqGYmuOF5VZVK14cZlbIdHNNmFd6bb4bSC3ulTr7zwVXmhFqEbZ0PxZpVAG
         YQxIbVgjchWuiodlJsYCtnFMp/yEro1GlT6LsWtuAnu+SQ+XkHqzKEF2UiDQRK8z5tgT
         8r0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6aM0YhCkCzmfts2fhBoSuW+Z7jiabCWJ/yriz04xlTU=;
        fh=Gbokv2cqjXipI/isbuuM2AkWdnz5ZRsDr4BAyqPfOQ0=;
        b=J28unirj+qVsz9ZGCQw0BnvdeffaNp6GDn4Dsc6G/PrDVT0pXTrgniXzdvx7Il2HY2
         tzOy6MEZX4koSCWgG8f9oaYUhcswd4Iyw93yNosMDOTZr7NB4tZ2MROSyYsBkkd95ePo
         JUzKe2JlY3mrNwZnkU6utAFqm1V3oJ+VLB9hgliFD6iHS38hxOd/CJiCANulfzDy3bax
         vB+N3HWGfYAwOuplw2aC2Qh6Q4wrKUy1xrinz5Zs4cEv2KmixbMPkN9R8tHqMuMz6kj/
         fdOBt5CAkLGbNWlnlSkFtz9f6ALM+s/Q9s2rY16Z53GiwztRT3tpG89GiXycLCQKw4He
         96mg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1768812368; x=1769417168; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aM0YhCkCzmfts2fhBoSuW+Z7jiabCWJ/yriz04xlTU=;
        b=ym5KyvzMEWcgAF6P/s5emti6MUy09gA/R+6Gu+310dKfRbSYMwk3Yybaq6D7lbRoBr
         NtYXam3rvrs3xgvkKPdLkTTVfbvT2q+iH6nElRW05ImpbcKRLI4TdS5BJnLqat3LmOkq
         Jq+MaIbOaaee1OwrXvsSpzeOND5lXD3EcXEHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812368; x=1769417168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aM0YhCkCzmfts2fhBoSuW+Z7jiabCWJ/yriz04xlTU=;
        b=kIhGHBygFKUzRKkAcVnLBZwqKjKKnpUMoW8uiiC+oxhMtx9T6ZZeosOUmgdRgg4QTo
         UFMSOMemojOSYvRwHY6m1cw098+1P7oIlTkfp0elMM8S3NBE/x5NcGe1n+RMj5NY9HSd
         QAyLcsu0k1efkHme6T4wytXNNEYMZJRhgnLko5cAgBlD/xrQk66qqXI5R4dj0h7TRF+M
         yC46n/EUSCjZuxjqRXPFcD5OIyWuTRU/wKx0jQl++cac6uc74WxrP5CpLCnj0MzSzIF3
         /UbM+f0t0VrJCXYAs7bnwDbxnwcYdnt96pvFLfERCx6HBM0NJoC+2MayhB80JBkIxa38
         J6fg==
X-Gm-Message-State: AOJu0YwqoTUBi63tBtHvZ8pNdGSXieOobw515sUnVR9ufge2OAuDBMN3
	73EKR/soPh6k8KTqsrw/GgZ72RzV7OtyFbfzxVmNqvG0iiRCh87DvMqIjYvB/IIL1qxcHemfF0S
	0K2OllcFQ0/gRfbIKTqNavox1Q06NADnULZIYAQJHajy4pN916iQ8VlA=
X-Gm-Gg: AZuq6aIEdAtSm5uLeIbfjH4Fn25Nte7qh94ApJ3eIKrx3VmL4NgsmFBmbgl73LCnzbB
	IM8w7sM28Z1SBCO/o6VIvxkTDpYiPMjglx9UvMRWTIjkq2HJ43pbJakEG/T073fucty1QMJWFSz
	WSXXrOndphX5IegEUf/Q6jKRJ5bJqP7tJyarBPcMBPi4/9pWF7lUcm0SVhENTggbYiPRYyX/upJ
	7Yr3Z3qhic/pzP9N/Dvs2JnUSEyNKIzRVXxQ0I43rEtGXo9M+DiJlhLqKnLWxQsTpQWgoIDVe6D
	vA3UZXCmMwJDyMinKUTM7EqsXGznjhL1mbk9jbVOYrzsjllkLyBLckKYSixtrsI2Z1MYKj51wyu
	QSTCop2nmUsLJwvmVyvFnVrkDkA==
X-Received: by 2002:a05:6000:2484:b0:430:f1ae:c7a9 with SMTP id
 ffacd0b85a97d-4356a029d59mr13148066f8f.22.1768812368334; Mon, 19 Jan 2026
 00:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAFc1U0utp_YgpET_EgBb=Q6e3orJfisB5_sSLq53APX73eWyJg@mail.gmail.com>
 <d3c3d55b-3f51-4629-bfa8-17634c2e567a@siemens.com>
In-Reply-To: <d3c3d55b-3f51-4629-bfa8-17634c2e567a@siemens.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 19 Jan 2026 09:45:57 +0100
X-Gm-Features: AZwV_Qi8m9kr_rC5zCv72zz78_nEqPtWX0v-DJPSqgzWctDhMf35evmccVmmOw8
Message-ID: <CAFc1U0teoyTNuo_Ux8Gmack0JE-fFzntxz5aXwPhk7MZdM90pQ@mail.gmail.com>
Subject: Re: xenomai-image problem
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No, I've tried for Pi4/64, BBB, QEMU/ARM64.

Le lun. 19 janv. 2026 =C3=A0 09:16, Jan Kiszka <jan.kiszka@siemens.com> a =
=C3=A9crit :
>
> On 19.01.26 08:49, Pierre FICHEUX wrote:
> > Hi all,
> >
> > I try to use the current version of xenomai-image and I get an error
> > at the beginning of the build (Xenomai 3 with several targets).
> >
> > $ ./kas-container menu
> > 2026-01-19 08:41:30 - INFO     - kas 5.1 started on Debian GNU/Linux 12
> > 2026-01-19 08:42:02 - INFO     - Saving configuration as /work/.config.=
yaml
> > 2026-01-19 08:42:02 - INFO     - Using /repo as root for repository xen=
omai
> > 2026-01-19 08:42:02 - INFO     - Repository isar already contains
> > 9792d18e9334b3cec72e2ade6a1065084c0c24d6 as commit
> > 2026-01-19 08:42:02 - INFO     - Repository isar checked out to
> > 9792d18e9334b3cec72e2ade6a1065084c0c24d6
> > 2026-01-19 08:42:02 - INFO     - /work/build$
> > /work/isar/bitbake/bin/bitbake -c build demo-image
> > Loading cache: 100% |
> >      | ETA:  --:--:--
> > Loaded 0 entries from dependency cache.
> > Parsing recipes: 100%
> > |######################################################| Time: 0:00:02
> > Parsing of 52 .bb files complete (0 cached, 52 parsed). 107 targets, 0
> > skipped, 0 masked, 0 errors.
> > NOTE: Resolving any missing task queue dependencies
> > Sstate summary: Wanted 12 Local 0 Mirrors 0 Missed 12 Current 1 (0%
> > match, 7% complete)00:00
> > Initialising tasks: 100%
> > |###################################################| Time: 0:00:00
> > NOTE: Executing Tasks
> > ERROR: isar-mmdebstrap-target-1.0-r0 do_bootstrap:
> > ExecutionError('/work/build/tmp/work/xenomai-demo-armhf/isar-mmdebstrap=
-target/1.0-r0/temp/run.do_bootstrap.296',
> > 25, None, None)
> > ERROR: Logfile of failure stored in:
> > /work/build/tmp/work/xenomai-demo-armhf/isar-mmdebstrap-target/1.0-r0/t=
emp/log.do_bootstrap.296
> > ...
> >
> > The error seems to be the result of a missing dpkg command.
> >
> > | I: installing essential packages...
> > | chroot: failed to run command =E2=80=98dpkg=E2=80=99: No such file or=
 directory
> >
> > I've used it some months ago without any problem, do I need to update
> > anything else ?
> >
> > Thx by advance
> >
>
> There might be a problem with registering qemu-user-static via
> binfmt_misc for the execution of arm binaries on your host. I guess
> building an x86 target works, right?
>
> You could try to clean the local binfmt_misc registration once:
>
> echo "-1" > /proc/sys/fs/binfmt_misc/status
>
> kas-container will set it up again on the next call.
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center



--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
