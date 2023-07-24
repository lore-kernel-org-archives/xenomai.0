Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA0847B
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 13:52:54 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso6568786a12.2
        for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690206773; x=1690811573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OVQf6fGk3O+0sl7+xn+DOmjh4zttv4IbbBJuPcX93A=;
        b=TG5bXFhff9vOaCQTo9i/w8L2tw9d3gGg02HExgL8YKeYVngLsYU1NG47ZZxtEohxV5
         2AW3APaXbQ1PK4ZWWu48n/6RCF83XtbiBXLObfqOi9oPdj4cXgsAtDwmuARXAa3FCUgc
         vIpXUSGSwX6e++Hc8NUD7Huw2ZrLHyhxMcHL9Cihcke1OnHpCRwWiCmz0LzngE9ePc3U
         B7Mxz4hi69QvuqTPLrCMmF28rryUzZCwSs8GKxiYOanfPmX/bMRwYMTy2Wv5COlFkwFg
         yxXGWtVzIqo1y0iaj/k9svA5jJJX2/58UtSK2Q/2eBzvUQX0or1/KPV8JNNJ/up6vsVl
         hTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206773; x=1690811573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OVQf6fGk3O+0sl7+xn+DOmjh4zttv4IbbBJuPcX93A=;
        b=VXMeEKtgCu28DLwr2VhciBiL6AN22H5CE4dLKg4GTZk/7d6HksgGNmoBditGB5tWGN
         9DmbH3rll6dx5DH9HT8jMDfXVHeBTgcjZpEZu7wF7uvqDi0igUoz3GnXmvdnNp/nDQuJ
         druR2Jb4ltYZuv/+9Y2Odh3fJKmCSnc7j+im9qFg9vHfUDw4G46ds8YKhoTer1qwE+/d
         JakvjZqrjZ00zMWI21cHxV2qCGFEsrzX0gz890ZQSpkfIIPkoharPURh4G9lTex/cjam
         8qAMUOhHXy5U8lRN+Qv0tbToJsnhej/AK5Q3urg5JwlJCFXviIyv609kM3h0/gryO2jC
         XEYA==
X-Gm-Message-State: ABy/qLYZcKTHcST4I9ekZBrNv9MJZybjKJx5vRkvw+O6PB+DMf4vGdEL
	cmRFXHbfIDcZA6nqy+vkw1W3vpB7GpKzIxM+3gs=
X-Google-Smtp-Source: APBJJlH9VwkWIPNClOKHz/ElqwulekmcbV//xf5oVEFm4yMhkA1DX0JZXeNR/xGsEU9+L7QubQCh2g==
X-Received: by 2002:a50:ff19:0:b0:522:2b60:fc5e with SMTP id a25-20020a50ff19000000b005222b60fc5emr2566458edu.6.1690206773148;
        Mon, 24 Jul 2023 06:52:53 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0051bed498851sm6239100edw.54.2023.07.24.06.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:52:52 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH v5 00/10] Revive alchemy, pSOS and VxWorks tests
Date: Mon, 24 Jul 2023 15:52:29 +0200
Message-Id: <20230724135239.10579-1-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230720145150.24607-1-aaron@sigma-star.at>
References: <20230720145150.24607-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series fully integrates the currently abandoned alchemy, pSOS
and VxWorks tests into Xenomai's testsuite.
For each test, a Smokey testcase is hooked up.

Changes since v4:
- Added SPDX-License-Identifier lines

Aaron Marcher (7):
  testsuite: Fully integrate alchemytests into smokey
  testsuite: Fully integrate psostests into smokey
  testsuite: Fully integrate vwworkstests into smokey
  alchemytests: Check pipe-1 asprintf ret value
  alchemytests: Fix task-2
  alchemytests: Fix task-5 logic
  testsuite: disable broken tests

Richard Weinberger (3):
  testsuite: Remove old alchemytests Makefile
  alchemytests: Fix gcc warning in buffer-1
  alchemytests: Fix gcc warning in task-9

 configure.ac                                  |   7 +-
 lib/alchemy/testsuite/Makefile                |  70 ---------
 lib/psos/testsuite/Makefile                   |  49 ------
 lib/vxworks/testsuite/Makefile                |  43 -----
 testsuite/smokey/Makefile.am                  |  15 +-
 testsuite/smokey/alchemytests/Makefile.am     | 148 ++++++++++++++++++
 .../smokey/alchemytests}/alarm-1.c            |   1 +
 testsuite/smokey/alchemytests/alchemytests.c  |  56 +++++++
 .../smokey/alchemytests/alchemytests_driver.c |  33 ++++
 .../smokey/alchemytests}/buffer-1.c           |   3 +-
 .../smokey/alchemytests}/event-1.c            |   1 +
 .../smokey/alchemytests}/heap-1.c             |   1 +
 .../smokey/alchemytests}/heap-2.c             |   1 +
 .../smokey/alchemytests}/mq-1.c               |   1 +
 .../smokey/alchemytests}/mq-2.c               |   1 +
 .../smokey/alchemytests}/mq-3.c               |   1 +
 .../smokey/alchemytests}/mutex-1.c            |   1 +
 .../smokey/alchemytests}/pipe-1.c             |   7 +-
 .../smokey/alchemytests}/sem-1.c              |   1 +
 .../smokey/alchemytests}/sem-2.c              |   1 +
 .../smokey/alchemytests}/task-1.c             |   1 +
 .../smokey/alchemytests}/task-10.c            |   1 +
 .../smokey/alchemytests}/task-2.c             |   5 +-
 .../smokey/alchemytests}/task-3.c             |   1 +
 .../smokey/alchemytests}/task-4.c             |   1 +
 .../smokey/alchemytests}/task-5.c             |  11 +-
 .../smokey/alchemytests}/task-6.c             |   1 +
 .../smokey/alchemytests}/task-7.c             |   1 +
 .../smokey/alchemytests}/task-8.c             |   1 +
 .../smokey/alchemytests}/task-9.c             |   3 +-
 testsuite/smokey/psostests/Makefile.am        | 148 ++++++++++++++++++
 .../smokey/psostests}/mq-1.c                  |   1 +
 .../smokey/psostests}/mq-2.c                  |   1 +
 .../smokey/psostests}/mq-3.c                  |   1 +
 testsuite/smokey/psostests/psostests.c        |  69 ++++++++
 testsuite/smokey/psostests/psostests_driver.c |  34 ++++
 .../smokey/psostests}/pt-1.c                  |   1 +
 .../smokey/psostests}/rn-1.c                  |   1 +
 .../smokey/psostests}/sem-1.c                 |   1 +
 .../smokey/psostests}/sem-2.c                 |   1 +
 .../smokey/psostests}/task-1.c                |   1 +
 .../smokey/psostests}/task-2.c                |   1 +
 .../smokey/psostests}/task-3.c                |   1 +
 .../smokey/psostests}/task-4.c                |   1 +
 .../smokey/psostests}/task-5.c                |   1 +
 .../smokey/psostests}/task-6.c                |   1 +
 .../smokey/psostests}/task-7.c                |   1 +
 .../smokey/psostests}/task-8.c                |   1 +
 .../smokey/psostests}/task-9.c                |   1 +
 .../smokey/psostests}/tm-1.c                  |   1 +
 .../smokey/psostests}/tm-2.c                  |   1 +
 .../smokey/psostests}/tm-3.c                  |   1 +
 .../smokey/psostests}/tm-4.c                  |   1 +
 .../smokey/psostests}/tm-5.c                  |   1 +
 .../smokey/psostests}/tm-6.c                  |   1 +
 .../smokey/psostests}/tm-7.c                  |   1 +
 testsuite/smokey/vxworkstests/Makefile.am     |  94 +++++++++++
 .../smokey/vxworkstests}/lst-1.c              |   1 +
 .../smokey/vxworkstests}/msgQ-1.c             |   1 +
 .../smokey/vxworkstests}/msgQ-2.c             |   1 +
 .../smokey/vxworkstests}/msgQ-3.c             |   1 +
 .../smokey/vxworkstests}/rng-1.c              |   1 +
 .../smokey/vxworkstests}/sem-1.c              |   1 +
 .../smokey/vxworkstests}/sem-2.c              |   1 +
 .../smokey/vxworkstests}/sem-3.c              |   1 +
 .../smokey/vxworkstests}/sem-4.c              |   1 +
 .../smokey/vxworkstests}/task-1.c             |   1 +
 .../smokey/vxworkstests}/task-2.c             |   1 +
 testsuite/smokey/vxworkstests/vxworkstests.c  |  46 ++++++
 .../smokey/vxworkstests/vxworkstests_driver.c |  33 ++++
 .../smokey/vxworkstests}/wd-1.c               |   1 +
 71 files changed, 749 insertions(+), 177 deletions(-)
 delete mode 100644 lib/alchemy/testsuite/Makefile
 delete mode 100644 lib/psos/testsuite/Makefile
 delete mode 100644 lib/vxworks/testsuite/Makefile
 create mode 100644 testsuite/smokey/alchemytests/Makefile.am
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (97%)
 create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
 create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (96%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (94%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (95%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (98%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (94%)
 create mode 100644 testsuite/smokey/psostests/Makefile.am
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-1.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-2.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-3.c (98%)
 create mode 100644 testsuite/smokey/psostests/psostests.c
 create mode 100644 testsuite/smokey/psostests/psostests_driver.c
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/pt-1.c (96%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/rn-1.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-1.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-2.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-1.c (95%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-2.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-3.c (96%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-4.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-5.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-6.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-7.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-8.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-9.c (98%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-1.c (95%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-2.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-3.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-4.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-5.c (97%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-6.c (95%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-7.c (95%)
 create mode 100644 testsuite/smokey/vxworkstests/Makefile.am
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/lst-1.c (99%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-1.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-2.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-3.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/rng-1.c (99%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-1.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-2.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-3.c (97%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-4.c (98%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-1.c (96%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-2.c (98%)
 create mode 100644 testsuite/smokey/vxworkstests/vxworkstests.c
 create mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/wd-1.c (97%)

-- 
2.35.3

