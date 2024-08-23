Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD38BEF
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395976; cv=none; b=LetMZU1Hfgq2zkVASbNDxxZAgo3WVo0rAsbcSaR1EDWGJXaLAFdUIs66svL8vFjupY9tMcXf9mTGqJInfzeQvmJ7ZE8AQGXNE6oImeV3mZHAEFGTWHORVjB4BSgZ0wKFQDVhCjf4tYeBcq+kMaFc62j5jkrudt1Eqv98F3TObJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395976; c=relaxed/simple;
	bh=zVIHJb2dKCVMFMCZmZZM4126uqvYg9jQNhGTlnReroo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJ+YC5o/W5hbJO3hiT9cLIXif0p9hxPr2+kh+hyr/5RJfHv+Kn7dfJELa1/gYayQJXr/oqYBEvID/uTqxJmhZ7PajhLB3s4+fvIiXlcQaNMO/kEzEGsVwAvpWEFIkzvU3gWFWC4PvA1m/48+xRz5OICTNDNLKLR/ARUCzTxQJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Ud22Y3WM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Ud22Y3WM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso8154935e9.1
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724395971; x=1725000771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3BiN1d8p7Wqn7I5ZCnSNG5EFMHdeI0DYrPVRYluBgw=;
        b=Ud22Y3WMRxIY54HaJUEtWGmykrEcCEHEWBgtcTvqfmxFT7Uad9Hg7SmklDJHCval2v
         7Fnjt5ZtvN/yOkJ5bBCQ5Yb1IOdwm3kfA/D6+ZXa2TpJGXRZhpDblzGtI0wPH336Rxyf
         gnY69BXYVxewJ5oLwuDtwf69P9ro1YSvuUG8x3hMEKL5wfGdMllE1m368bXUJO1QoPq4
         7j3DkwbC7X8n3N+Nq4Bm5km2BJCKNVi2DVtkjn161Ue3A3gg24ngLEjQsO9lJrBHJ+1x
         paGnoeofXuxKIMoUTRMNEbBESpZLXncfsXzHy40kiPbzJ6E+t5N0HoSsHDudDHQRTjBC
         lM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724395971; x=1725000771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3BiN1d8p7Wqn7I5ZCnSNG5EFMHdeI0DYrPVRYluBgw=;
        b=Z7ma3dTBmPXHCwOuEWOtJ+88lSQZcl2YqT19GA4Z0orGRPZbizzCY7ZhfeiEhs/Hod
         8XUokHN6WNQXPvlxx2wB1al2O3cswozQXeCtfPwLt93r18pNVqJ419TRwRczPA1/2dv4
         fiSZ9fx7R5gOThqYFfNcn9eXDPtRxh3wxQ8zHyHHdaU+vdr/6OE+uGThAODwKM2cY2fD
         Ja53YqGk3Xy2N8jy32wGzweg3YjAIJ97qta3WhVoJmdIWNhxGzWC90YgM+kQyzB1T90y
         jHXfSWUuPosFKMcSzXPHw8ZGaVYyCsNIChhp526kvGdK7urW5vTNmNVBi8bbRXZA62JT
         CbXA==
X-Gm-Message-State: AOJu0YyTFNQeWN9uxfy8vHRqr3m8KDvWxQJEgosf2HLKBWatPcqmrLeB
	5zUgd79ldbkfAIF07iP4remNE9HXeqe88z+yd4a+Cl9o/nWG6TP3RWqcrWw0afML4PyATkbUwkp
	T1aE=
X-Google-Smtp-Source: AGHT+IGwQ092jl+JmmSQtk2gPEI9IxaV4/CFezWIEhaHOFMdyUPX+G8OPpfabomJwKZttjemLdxjSQ==
X-Received: by 2002:a05:600c:1c95:b0:426:6eb6:1374 with SMTP id 5b1f17b1804b1-42ac36726c9mr32219215e9.0.1724395971303;
        Thu, 22 Aug 2024 23:52:51 -0700 (PDT)
Received: from localhost.localdomain ([144.208.200.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac500e119sm49558525e9.0.2024.08.22.23.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:52:50 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH 0/2] doc: Fix typos and grammar
Date: Fri, 23 Aug 2024 08:52:45 +0200
Message-ID: <20240823065247.4884-1-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

this patch set fixes mistakes I found by running hunspell etc.
on the doc/ directory.

Simon Graber (2):
  doc: Fix typos
  doc: Fix grammar

 doc/asciidoc/MIGRATION.adoc              | 14 +++++++-------
 doc/asciidoc/README.INSTALL.adoc         | 14 +++++++-------
 doc/asciidoc/TROUBLESHOOTING.COBALT.adoc | 12 ++++++------
 doc/asciidoc/man1/gpiobench.adoc         |  4 ++--
 doc/asciidoc/man1/slackspot.adoc         |  2 +-
 doc/asciidoc/man1/xeno-config.adoc       |  2 +-
 doc/doxygen/xeno3prm-common.conf.in      |  8 ++++----
 doc/doxygen/xeno3prm-html.conf.in        |  4 ++--
 doc/doxygen/xeno3prm-latex.conf.in       |  2 +-
 9 files changed, 31 insertions(+), 31 deletions(-)

-- 
2.46.0

