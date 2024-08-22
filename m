Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95F16D9AE
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314091; cv=none; b=IdqH+Wa569mNAPNqtiKBRMGuOhRUmmGPkWR73HrfonRYBJfykcdcwTG0D0LnBkuVhOxtJY0nhGUyYRZzi6U+Yud29uw0YAKETAeIYBeW2gKt8B21wGRafIgcEJ9W9ACGa/JF5WIo6kIFSpUOggGF7fw/FfJJKVZ/l71f/Rqkgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314091; c=relaxed/simple;
	bh=J/gG2zxRHTVAGMrCUl4tV/ZXRdiQEd4xg2YJOB4Itpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ar1+Xehi2OY/JyNICslQRks9pTOd27+adEfoirnFKIjrOj9KSPPO782IyUxnEGS5ZIBxbgWvoBgSFKeSkUiDFQR6Q6oyNmsrcCepoxOFolMFwB87xxz3BdNckuE0xUGuFVvLzna17x0o1tPYkMPTnJZZnoze7t/cdHm/UmegS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=bTDd8ctf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="bTDd8ctf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533496017f8so695313e87.0
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724314086; x=1724918886; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdy0Foa+lVI0mv9BW1gd8ost7QycK2okcU6Lo6bPYZM=;
        b=bTDd8ctfMhqyn452h3UfLnAfoYzqdbkIu2dzFbfxBj7mrAhViD1nSPdBJv97ZkJ5vg
         d7dbUpeMvQUwfKm610lHzoVNfcpHvxJ0ZYqpYiBZ+F8wpI46zosqzL9eGDbxFJJfviD7
         bSyM23KnEefmokF1pl/4uSJjdzvlJkCx3RVPNav7wol0Z0Vw1v7vwnAIrYSJK3acgFTk
         OGxQOOe/ZFzI2jM8A5CPL85Oz0XPXjZKh9PYlM5QmyWa84Z0b1vYGGaV8F3IoTjhCZIc
         IQN9lgmvvBaTyi8TzOsC7N+L82Ju+ctEb3vFE+wyKhKiLySzufaxxS+BwXT1qQVBK6AM
         IsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314086; x=1724918886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tdy0Foa+lVI0mv9BW1gd8ost7QycK2okcU6Lo6bPYZM=;
        b=nnMmMvIDu/GrWrdJbZkFZxHqCVZep1+zbQGISrFrLCa/kHCret/x4p0q9Bs2FuSUpf
         RdsELlE7KDlAm1Sg+m6Qq3SXy67H2WXxs3INlJORGjpl1RiLDpM6KM7wWQXD4timQefZ
         D8zha0wxGu45U0x3hIlY3Bo47KgsJY8bmRY14vtk7IDJAOz9GXEP8f9EBkTqjlfmb3fv
         CV4iMB+SNgM0DQeYZGkPlv3yBVoA0SzrMKkIX2eSdVaKDcbUFzZfTe5OpMGJyqjO1oyP
         Lhiq7Z1K+Qa5rYz/w4B92HWagjiMjc8+xi9kHutaskA6teU0q9q+A025rWzZVpjo9TiJ
         5vRg==
X-Gm-Message-State: AOJu0Yy1SvgLIWCc9bwU1iyIwtL07h+wP05B7qQJorR3boVFDPsgmMhk
	a64TlkxMNIHx1HspHx2pezGMMx5TByjdEjTOOPeYC0WHMVhuyZSN05zrc3gyVVYau2qM4l+RPm8
	16hk=
X-Google-Smtp-Source: AGHT+IHPJIm9h9HTfpJuGiqO+xlCoGLRqHW7lbL4SdTEPDx+XKVTkJly+AmdAa9yr5eot2ogC2t/IQ==
X-Received: by 2002:a05:6512:3d0a:b0:530:d088:233f with SMTP id 2adb3069b0e04-5334fd52ed3mr587022e87.40.1724314085535;
        Thu, 22 Aug 2024 01:08:05 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefd9cd1sm52565255e9.38.2024.08.22.01.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:08:05 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 0/3] Add env vars for session and cpu-affinity
Date: Thu, 22 Aug 2024 10:07:34 +0200
Message-ID: <20240822080737.17939-1-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch set introduces two environment variables, for session
and cpu-affinity. This is to avoid having to pass them as args which
was suboptimal for larger projects with many helper programs.

The first two patches in lib/ add checks for the presence of env vars,
the third patch utilizes these for the alchemy tests.

Simon Graber (3):
  lib/copperplate: Get session name from env var
  lib/boilerplate: Get cpu-affinity from env var
  alchemytests: Set cpu-affinity by env var

 lib/boilerplate/setup.c                      | 16 +++++++++++++++
 lib/copperplate/init.c                       | 21 ++++++++++++++------
 testsuite/smokey/alchemytests/alchemytests.c | 10 +++++++++-
 3 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.46.0

