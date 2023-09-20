Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8CD36AEE
	for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 13:53:06 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so902078966b.3
        for <xenomai@lists.linux.dev>; Wed, 20 Sep 2023 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695217985; x=1695822785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV8aNOAcam6rWFBUTo/c53ijckyQYsCw5BjMxo7QiSw=;
        b=gOnd9EStmTc2COqxAS0/hqYEFkc6AfxqHUQ6ZKOxkfBxb2C1EExqW1qbepgkZSJzPV
         ZYUyXpcUXxJQtZYpSyatY44CST7/afNJF1A/Ct9FfGHqVh6+2brvLTDIZGklMB9fXkHu
         ls2MQkb6Pw6JXFqnlIm/yaBxkPCmzndtVICszAXFhFrFWq5Jipgp+81DuKGAKfbjUpvV
         Kzg6XHEzb2DEPh2774dg0F+A2bAdc1pWjkhcMLLL7ox2Xeke+se9QDbsDQYq9XTkjVrD
         YhR45gqNnyAH7yIexz4JQNPb8oMOXTTvUgQ9aUdfLNgQCwl35k9MvoxM1vlPrk2R2xY4
         1enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217985; x=1695822785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QV8aNOAcam6rWFBUTo/c53ijckyQYsCw5BjMxo7QiSw=;
        b=P7/KJWUeOZ4r4/H7FZ2TRILKSBDZS2VS8uIRzgtkAnwcWdssh2acqk2fASdbyPBIBt
         PojFSf+PVeHqV/gzx+xYtfED0RMFC2TERGB4zIfderunM6GZ+rnzYe9Kd8kXvP21uZKY
         mPRqrvvxXjdizwDd0KvkzcfwNrMdf0hFzEsePLX7MnIYmbpbxu9BV84xb0lWPQugLYg4
         G/SSKb8ZxAGMzGDi1fogN1Avc4b4csCXbVWfxWU5RO7ww3r5OeetqO0XrnVzVZdSZ1An
         IVIMBXgoEwQN31u5HMYbx0S2p31kEVsWQ8fyL/mzP5PSI4iszc5gQ/vWRb+uMBOwwdLH
         XP5A==
X-Gm-Message-State: AOJu0Yz9k2kF3VzcTswbI/a+u9pOBkZ97Jh341MywGj08OyS5FRQMkzI
	aS49Db9jDHHyUNDIzzSYKghPdlkjx2YWvWP9oqE=
X-Google-Smtp-Source: AGHT+IE3NvWfe4wAXWXVmQnRG7W4+EcN9KDT7KtSvoDRvT66k36wLdqM7Uzg9K+csPDNMHds8Yv+7A==
X-Received: by 2002:a17:907:7818:b0:9ae:5202:e611 with SMTP id la24-20020a170907781800b009ae5202e611mr952416ejc.14.1695217984137;
        Wed, 20 Sep 2023 06:53:04 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id mc17-20020a170906eb5100b0098733a40bb7sm9324008ejb.155.2023.09.20.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:53:03 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 0/5] Improvements for smokey skintests
Date: Wed, 20 Sep 2023 15:52:48 +0200
Message-Id: <20230920135253.5842-1-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
References: <901c80cc-d506-445e-add9-00aa0e536803@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merges all skin-related testsuite parts into common top-level smokey testcases,
which in turn spawn all the related skin tests - as discussed before.

Additionally cleans up some includes and more.

Aaron Marcher (5):
  lib: Add smokey_run_extprog as helper for testsuite
  testsuite: Merge alchemytests in single smokey case
  testsuite: Merge psostests in a single smokey case
  testsuite: Merge vxworkstests in a single smokey case
  testsuite: Drop skin test "drivers"

 include/smokey/smokey.h                       |   2 +
 lib/smokey/helpers.c                          |  15 +++
 testsuite/smokey/alchemytests/Makefile.am     |  12 --
 testsuite/smokey/alchemytests/alchemytests.c  |  85 +++++++-------
 .../smokey/alchemytests/alchemytests_driver.c |  33 ------
 testsuite/smokey/psostests/Makefile.am        |  10 --
 testsuite/smokey/psostests/psostests.c        | 111 +++++++++---------
 testsuite/smokey/psostests/psostests_driver.c |  33 ------
 testsuite/smokey/vxworkstests/Makefile.am     |  10 --
 testsuite/smokey/vxworkstests/vxworkstests.c  |  66 ++++++-----
 .../smokey/vxworkstests/vxworkstests_driver.c |  33 ------
 11 files changed, 150 insertions(+), 260 deletions(-)
 delete mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
 delete mode 100644 testsuite/smokey/psostests/psostests_driver.c
 delete mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c

-- 
2.35.3

