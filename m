Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3914A83
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:05 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9928abc11deso884168066b.1
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273803; x=1690878603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCQUE7NkaIwaOhWqS/Geo6jjUBNA04XrEV7H5lTxWE4=;
        b=aqLuUJu5mOL0qhH3klsZDCxVki4yXVxd/7nJxzdRMjz/tXnvrrGrUmmV/pIgnSQvox
         l66enwY84awNBYz1LAVFWX6gUvDY+MTWfJxKK3msqoAY8XdIzvFd0uef4GyAD9mDwfuh
         VAyTFPWN1j3tsQWTVHvIPKgP9DjjbJmJRlXAk+tS1ZNrey4GmurEk/qdZfZ46uVfUiqt
         9WIFWnZCkGOwiRKocxKa4yLvpAVjIqX/yx09q/sV5ku0xPink7fyEMgKVittGDgD+USU
         yRHrhe59Dlkj3TJzJtrA6MZ/qgl0JQ1R7GqeWpF/dWaY7vFw9XD417lt8qQ6fTllBthw
         K+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273803; x=1690878603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCQUE7NkaIwaOhWqS/Geo6jjUBNA04XrEV7H5lTxWE4=;
        b=BTJbPrFOgFD4AV2Rzo5+ppaYpN8Sc7FxGyGd7+E5NVZ6kIYd537XV5e0hCrpkyKZJ9
         krgPrHXcNrsoLtTGRTSsyv2Zclm3LrwyevM9Nqd6icad0ijlcVr/Hy9CmCB3x8O/A+KW
         5+RblGTiiLa8BtzJNpYsOQgVllPQyRR+RUkRisa1DD8m2Ea4NM1QlLv8vhlvS18UuXc6
         oR2vO0IleOpZWwyD4WqI5w7dUn+n5JSK5WmaHbfKkj0c4rZAbN0/SoD9JGHWdnBCVozi
         BVBwISWUBvkE2UdwCesNU50V9h+FlwYXbwm5jG9lVy1nXBrv6eqT4G8GjWnyxss2vX15
         osCQ==
X-Gm-Message-State: ABy/qLaI4n6hjBDbKPmzLf0WAv2Yydb2O0T2rDiry74sm875EebjPQ3c
	9Kl12sClB/xR1MVBTpMJsTiYHXp+dbC6uFKW1Qk=
X-Google-Smtp-Source: APBJJlF3NDjmJ4jUDZPJW8tQmQOaaOudPVnILjixjXj3S/X4Umxtmi5ped/wNEOOZhT1zA2/ej0VSA==
X-Received: by 2002:a17:906:77c8:b0:977:e310:1ce7 with SMTP id m8-20020a17090677c800b00977e3101ce7mr12897779ejn.38.1690273803148;
        Tue, 25 Jul 2023 01:30:03 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:02 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH v6 00/10] Revive alchemy, pSOS and VxWorks tests
Date: Tue, 25 Jul 2023 10:29:49 +0200
Message-Id: <20230725082959.5144-1-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
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

Changes since v5:
- Improved task-2 fix commit message

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

