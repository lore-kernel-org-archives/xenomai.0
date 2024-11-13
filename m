Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1D152165
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514052; cv=none; b=qgq0nbLgJWcg5Du1eiJ9GL8GICc2gCFuTn17/QgjKX8rRCi5nr0TuDVm3L8ZjPBV98YvyhAwuCZB0anlAQqXJ2+t8v8/WNtIeC8P59kXhcnHSgd23jE+GB2yZWLj6H/ewoKK5wKz21NrDWppDBWdEYr89jNG6lC/wkph8AUdTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514052; c=relaxed/simple;
	bh=voZco5hwOb8/LOhKsnUlWzqto4yIVd19KO+fpjgLB78=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UNqQxHtNScqQzVmBCMJo335n64TamURemQouS+Ke4jSu+nfmJ0TKF6HAreiJ8Gn2nqi3kyG4oDgofu4njRiAKO19eKZoJuDJTOmQhbOJq3O9Y+VZd8oIx5yrwMMNHPpdqqnNBEeG212AHsRZPtfRVrvFY2quiMF7jWPcDQE/4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=DThlHEu2; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="DThlHEu2"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 2FC4C80002
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 16:07:27 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5E056941B79
	for <xenomai@xenomai.org>; Wed, 13 Nov 2024 16:07:26 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-539e7e73740so6639712e87.3
        for <xenomai@xenomai.org>; Wed, 13 Nov 2024 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731514045; x=1732118845; darn=xenomai.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52twNiCq9NEZK9UviEq6VsqQroYTzLlwf66rU2BTAxc=;
        b=DThlHEu2iLM9e5QF6NABgfJZ806LoxzgdBNORaK0wShYeEKPgCpU0eZMzRq46BK+TN
         rVkAdnUNliZiSUkhEbT3UVwL8ft+UMFiB9zPqhZDJ3ldAI/NkZ3LOUUrYdmtVayYbuIh
         J/yR+xRWnE713QDvPy1Wl4cwKKANXNBX3AXh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731514045; x=1732118845;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52twNiCq9NEZK9UviEq6VsqQroYTzLlwf66rU2BTAxc=;
        b=jLmt7x132ZIvIiov8pt+kVkv2HVILqnjMM3+wvNuTQiQJnZYyRURUsCMszz6tbS/Cc
         1LZVtysn8TcFONuSxuwcU0cDThTJh7QcA3L4wj+tXkfkYkRJ8yPE/jftE/X4BErfSIol
         V/GzEEH2VkueLss/PYe9RxS6YU4I2hPFuN7LA2cQiLgJYzfXf0n3H0B/+eTvvuOXJqci
         IcGXhmHPjWpy3dEvIgcoof7y8kQx132Kk/OI1qNYPkYhZcdbHS49AQmlXT3wB8GkpWkj
         eEDjb/A5uIMwxAVC1y3BbnKnKsnUuyZYgs0hLXj/HMgUdR69kYDqQxEKdRBIRIKLoWXY
         Hedw==
X-Gm-Message-State: AOJu0Yw6UhFI5EhmQFDZErJ2tD7GeZFtZ2W7R2kexHChOvDWnpFLeXaA
	tFLH7BSb+ydpXssOHSIpJJgAwklVEYHtHh1Yvb4Y4E8M5YSsBmCrGjqwozxDwBl88DiGQsshZWi
	5himqny+pAXIq4x0cTGR6Jac1/IMAckzzZw4alUjTUfwWXdD/4CU=
X-Google-Smtp-Source: AGHT+IHx2ffnU5NlNUip/Wtr4urPTGk02oDFEpOAyJqfArXN4VfgwGe9yNYRO8szfAm766Imfb3/gHtPjw9TN3OxWQY=
X-Received: by 2002:a05:651c:150a:b0:2fa:d4c1:3b6b with SMTP id
 38308e7fff4ca-2ff4271df1bmr47597741fa.33.1731514045241; Wed, 13 Nov 2024
 08:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 13 Nov 2024 17:07:14 +0100
Message-ID: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
Subject: Error building xenomai-images
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::134 as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi,

I have the following error as trying to build an image with kas-container :

$ ./kas-container menu

I use the Build button for a BBB :

2024-11-13 16:05:02 - INFO     - kas 4.5 started
2024-11-13 16:05:13 - INFO     - Using /repo as root for repository xenomai
2024-11-13 16:05:13 - INFO     - Repository isar already contains
75488685dd2123417deb70f6d0923b8c2772954e as commit
2024-11-13 16:05:13 - INFO     - Repository isar checked out to
75488685dd2123417deb70f6d0923b8c2772954e
2024-11-13 16:05:13 - INFO     - /build$
/work/isar/bitbake/bin/bitbake -c build demo-image
Loading cache: 100% |                                           | ETA:  --:--:--
Loaded 0 entries from dependency cache.
Parsing recipes: 100% |##########################################| Time: 0:00:04
Parsing of 46 .bb files complete (0 cached, 46 parsed). 86 targets, 0
skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
Sstate summary: Wanted 11 Local 0 Mirrors 0 Missed 11 Current 0 (0%
match, 0% complete)
Initialising tasks: 100% |#######################################| Time: 0:00:00
NOTE: Executing Tasks
ERROR: isar-bootstrap-host-1.0-r0 do_bootstrap:
ExecutionError('/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/temp/run.do_bootstrap.1248',
1, None, None)
ERROR: Logfile of failure stored in:
/build/tmp/work/xenomai-demo-armhf/isar-bootstrap-host/1.0-r0/temp/log.do_bootstrap.1248

ERROR: isar-bootstrap-target-1.0-r0 do_bootstrap:
ExecutionError('/build/tmp/work/xenomai-demo-amd64/isar-bootstrap-target/1.0-r0/temp/run.do_bootstrap.643',
1, None, None)
ERROR: Logfile of failure stored in:
/build/tmp/work/xenomai-demo-amd64/isar-bootstrap-target/1.0-r0/temp/log.do_bootstrap.643

Same issue for QEMU.

Any idea?

Thx

-- 
Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
