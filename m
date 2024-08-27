Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548251465AC
	for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748330; cv=none; b=ioljB5+1DdgxHblcBlBdkDpFkdqW8euqS2WsT3/26U8zVaBsW6QetVp7lv60KvOAAfELv9GkN4CZQEFZZJ4EZeHxtrzUX3aZOig0QlWydMalqo+n5FbaP1zp5+6WY/SH7e0CXmhk+3wx78uMxlwCgv4P3MvKA4GK6OLurchbtQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748330; c=relaxed/simple;
	bh=OsXzNU4qXb/DQORCKiCsYoCEbM6vAdZVQXiwBGdIXeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRRVYyKsitCABajcLuhYsOAVjwVObUCqaw2f5ykVu5mc1PaJ9hZS+446XMffzUOaGyr43FUWasAiqFn6Rhl6Y2S9M1tfI+yvnowoLfoDy6aWkZZoB+D/iSeOSkOcjDwLPiE+KDuyVxnTdZYBFAi8J/hfBhpss1kmgirPuifH1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=djuS6vpb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="djuS6vpb"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428178fc07eso42970205e9.3
        for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724748325; x=1725353125; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hcSeyGnI+Kz7rtFEYDD4Rci9i1hIyoXhzpaXG0XJfJg=;
        b=djuS6vpbe3VlRQrHBMHjw9l8UHY2cxCJIfqIjmN1PoCn3NAmMvxVTfApAiUvzpdY8Q
         RqOlxPYgYbXwsC2x7StvTWciyR+tBKmCcPgOmrR/t3h1MQsVVmIusL++kr+eLjHN1Tqz
         0YkT8lrYeqmCErOe0mgR8wLijaYCtJ7n7+fJtLcJJLiMCCREszf+rdHLk5of27yqSpnO
         PF+wAhF5Tt4MMmk4KneouCsmPtB9Fusv8MgTCBxckf3yDbnmqyrDD+9ma4fS6y8K7Nr+
         dkPRSXNZVvJ6f3a+XhgFYEi8VKmsA7wqv9LGa8b18ysvwCT4avd63RjvExU+GK0CQdZz
         /5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748325; x=1725353125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcSeyGnI+Kz7rtFEYDD4Rci9i1hIyoXhzpaXG0XJfJg=;
        b=L9g60HWR5wXGZ+nzcAn2O/pqcklRQvHcevQmH+4Ficrfynr2NJP7UyaKVLdMzgP3/j
         /Gm7qLkyHb/v15ZMGCYCvws8ktksq/vPddyEV9pIKgvZq/ldsgTl/6LG0VTqu4GO4pMx
         hm+47plVn6x20CJtxrg1p1OdvBKq3wbG7FTdRaMDZewV1qxLpJ/TpbuZdSSFq2bxG+QR
         gXSqzb1ctkKF078oDeyMGk78o1IGOPdWSVMBkPrc64rB1mf0p7r17J32bF8g5fT1pCaD
         QW/bQ0TeNr3rp8ZJVfV3wmrOdFGX+tQ+hGkBHBURsxLxPuiU5RjcVFm7rN+th/kAap21
         FbAw==
X-Gm-Message-State: AOJu0YzUYDlsCF6V4Cq7NyKWcEIaLBJhPiz4cpUGBtEIhd9SJ47IvLaM
	FJYckIr0rxQAM8vgJzddQbb1t3261CDIoioZPfvdPSbl4yJq4qQA9tHRrxO6qSjOLgqVmDyFf/d
	eAS4=
X-Google-Smtp-Source: AGHT+IEt1mB5eF/fGp+U3aPVNjblp9Z+B4a3c4PByt4WaI7x40UpiJYiuvTp0euqNKFguxJm4chYjQ==
X-Received: by 2002:a05:600c:4f01:b0:428:f650:6a4e with SMTP id 5b1f17b1804b1-42acd5d792cmr84239365e9.23.1724748324647;
        Tue, 27 Aug 2024 01:45:24 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86da6sm211779435e9.17.2024.08.27.01.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:45:24 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v2 0/4] Add env vars for session and cpu-affinity
Date: Tue, 27 Aug 2024 10:45:17 +0200
Message-ID: <20240827084521.13547-1-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Revision 2 of this patch adds documentation for the new
environment variables.

Changes since v1:
 * Usage of environment variables is documented
 * lib/copperplate/init.c: Conditionally query XENO_SESSION_NAME

Simon Graber (4):
  lib/copperplate: Get session name from env var
  lib/boilerplate: Get cpu-affinity from env var
  alchemytests: Set cpu-affinity by env var
  Add documentation for env vars

 doc/asciidoc/README.INSTALL.adoc             |  7 ++--
 lib/boilerplate/setup.c                      | 38 +++++++++++++++-----
 lib/copperplate/init.c                       | 21 +++++++----
 testsuite/smokey/alchemytests/alchemytests.c | 10 +++++-
 4 files changed, 57 insertions(+), 19 deletions(-)

-- 
2.46.0

