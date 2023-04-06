Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84E7EA
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:03 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9476e2fa157so100571866b.3
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO0TPOqyft+46JBzaiQBSxiAOhXeJQooXzM24TM115M=;
        b=ilmLpZ8poJ6C6wyodmwuvqOb45ZDIBjrJui9edoOmMDUynY7v2IXo35j7KvEvcMJPU
         TJli+SKzxIBcq2aqP+PGS6HTIWBXp3+WpCiQ0wyblRKgl0t+m92ojfR7o5SYNefV6cNf
         O5nJtU+Nf6OofWYuS/2WHgEb0SoQZ9AGOkwHdPPN1lPklD4tr+C9nZUx6F+chkTTeyzr
         IeOOJeEMDU2cgKyRUmFBbJmd9oBgRXlUInwtgso2GUE09ibCvcG+Es6A59TCGN0At3Di
         D3/mRYHsS/mgHz22DrJ74se0CQzZYZQPBPhZpqUc+sKKjEHdZ3M7ZZXAdULrzSAWOFwa
         4Evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO0TPOqyft+46JBzaiQBSxiAOhXeJQooXzM24TM115M=;
        b=xZ1BNml4J8vJPYhCZJle+TgbkYdugjbUUYbf0chW4FZNQoagzUTaczTZKkHC+acB/r
         JkCG5liItP0aWkRZ3q86NWMnRStYbEEkt7TFM5NxuP96mnCCQFq8lOrXryWkB6qfMl4m
         mVJvbhIKBetkYcdJX3uf+2UMgW+1cNU4GtRzmrQZSXeeLIolUG/RJtJSFBq79cxcb6m+
         wc9KW41hffyJlERqNmOTktDslqjMXBf0ZVysRR9AZwa3qejYleK05KrZQf6B31XCSvH1
         HB1wHJ4i/pG75+y3dv1eC/nhrD2A++ov792SHSIArScJsc5fuKvRWTW1Z8KXEwHMjpxX
         9w6w==
X-Gm-Message-State: AAQBX9cUsZaochLc1OtLO/OFy/hzmDDeBs7YGRrWKGnli0aRrjgT+k2d
	vcm8X8oonbnyuV6YKwCHvcmE9gpInxQEfKOV8BA=
X-Google-Smtp-Source: AKy350ZmaAI7jSWMTLMfg/84zTR2jMg3rVBF5Wua/um/nZrolUafTnbw8NuGtn7g31xQMQ/4eY0Z+Q==
X-Received: by 2002:a05:6402:64e:b0:500:2e59:ffff with SMTP id u14-20020a056402064e00b005002e59ffffmr4616111edx.6.1680777242144;
        Thu, 06 Apr 2023 03:34:02 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:01 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH v3 0/11] Revive alchemy, pSOS and VxWorks tests
Date: Thu,  6 Apr 2023 12:33:30 +0200
Message-Id: <20230406103341.2914-1-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220413215819.22954-1-richard@nod.at>
References: <20220413215819.22954-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series is an attempt to integrate the currently abandoned
alchemy, pSOS and VxWorks tests into Xenomai's test suite.
Since each test assumes running as own process a test driver is needed
which executes each tests separately.
The driver makes use of the smokey framework.

New test results on a x86 VM (5.15.94, Xenomai master as of today):

- vxworkstests/task-2 fails:

    [8] at
    testsuite/vxworkstests/task-2.c:85
    [1] at
    testsuite/vxworkstests/task-2.c:32
    [9] at
    testsuite/vxworkstests/task-2.c:91
    [4] at
    testsuite/vxworkstests/task-2.c:57
    [10] at
    testsuite/vxworkstests/task-2.c:97
    [5] at
    testsuite/vxworkstests/task-2.c:62
    [11] at
    testsuite/vxworkstests/task-2.c:103
    [2] at
    testsuite/vxworkstests/task-2.c:37
    [12] at
    testsuite/vxworkstests/task-2.c:109
    [6] at
    testsuite/vxworkstests/task-2.c:66
       0"014.637| BUG in __traceobj_assert_failed(): [foregroundTask] trace
    assertion failed:
                  testsuite/vxworkstests/task-2.c:69
    => "ret == 0"

- psostests/task-6 fails:

    [9] at
    testsuite/psostests/task-6.c:79
    [1] at
    testsuite/psostests/task-6.c:22
    [10] at
    testsuite/psostests/task-6.c:87
    [3] at
    testsuite/psostests/task-6.c:39
    [11] at
    testsuite/psostests/task-6.c:95
    [4] at
    testsuite/psostests/task-6.c:44
    [5] at
    testsuite/psostests/task-6.c:49
    [6] at
    testsuite/psostests/task-6.c:54
    [2] at
    testsuite/psostests/task-6.c:27
    [7] at
    testsuite/psostests/task-6.c:59
       0"011.370| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
                  testsuite/psostests/task-6.c:62
    => "ret == 0 && oldprio == myprio"

- psostests/rn-1 fails:

    0"000.679| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
              testsuite/psostests/rn-1.c:46
    => "ret == 0"

- task-8 runs forever (100% CPU)

Changes since v2:
 - Rebase to latest master
 - Fix build failures
 - Fix some failing tests

Aaron Marcher (2):
  alchemytests: check pipe-1 asprintf ret value
  vxworkstests: fix Makefile.am reference

Richard Weinberger (9):
  testsuite: Move alchemy tests into testsuite/
  testsuite: Hook up alchemytests
  testsuite: Add a simple test driver for alchemytests
  Remove old alchemy tests Makefile
  alchemytests: Fix gcc warning in buffer-1
  alchemytests: Fix gcc warning in task-9
  testsuite: Move pSOS tests into testsuite/
  testsuite: Add a simple test driver for psostests
  testsuite: Integrate vwworks tests into testsuite/

 configure.ac                                  |   3 +
 lib/alchemy/testsuite/Makefile                |  70 --------
 lib/psos/testsuite/Makefile                   |  49 ------
 lib/vxworks/testsuite/Makefile                |  43 -----
 testsuite/Makefile.am                         |  10 +-
 testsuite/alchemytests/Makefile.am            | 159 +++++++++++++++++
 .../alchemytests}/alarm-1.c                   |   0
 testsuite/alchemytests/alchemytest_driver.c   |  84 +++++++++
 .../alchemytests}/buffer-1.c                  |   2 +-
 .../alchemytests}/event-1.c                   |   0
 .../alchemytests}/heap-1.c                    |   0
 .../alchemytests}/heap-2.c                    |   0
 .../alchemytests}/mq-1.c                      |   0
 .../alchemytests}/mq-2.c                      |   0
 .../alchemytests}/mq-3.c                      |   0
 .../alchemytests}/mutex-1.c                   |   0
 .../alchemytests}/pipe-1.c                    |   6 +-
 .../alchemytests}/sem-1.c                     |   0
 .../alchemytests}/sem-2.c                     |   0
 .../alchemytests}/task-1.c                    |   0
 .../alchemytests}/task-10.c                   |   0
 .../alchemytests}/task-2.c                    |   0
 .../alchemytests}/task-3.c                    |   0
 .../alchemytests}/task-4.c                    |   0
 .../alchemytests}/task-5.c                    |   0
 .../alchemytests}/task-6.c                    |   0
 .../alchemytests}/task-7.c                    |   0
 .../alchemytests}/task-8.c                    |   0
 .../alchemytests}/task-9.c                    |   2 +-
 testsuite/psostests/Makefile.am               | 166 ++++++++++++++++++
 .../testsuite => testsuite/psostests}/mq-1.c  |   0
 .../testsuite => testsuite/psostests}/mq-2.c  |   0
 .../testsuite => testsuite/psostests}/mq-3.c  |   0
 testsuite/psostests/psostest_driver.c         |  85 +++++++++
 .../testsuite => testsuite/psostests}/pt-1.c  |   0
 .../testsuite => testsuite/psostests}/rn-1.c  |   0
 .../testsuite => testsuite/psostests}/sem-1.c |   0
 .../testsuite => testsuite/psostests}/sem-2.c |   0
 .../psostests}/task-1.c                       |   0
 .../psostests}/task-2.c                       |   0
 .../psostests}/task-3.c                       |   0
 .../psostests}/task-4.c                       |   0
 .../psostests}/task-5.c                       |   0
 .../psostests}/task-6.c                       |   0
 .../psostests}/task-7.c                       |   0
 .../psostests}/task-8.c                       |   0
 .../psostests}/task-9.c                       |   0
 .../testsuite => testsuite/psostests}/tm-1.c  |   0
 .../testsuite => testsuite/psostests}/tm-2.c  |   0
 .../testsuite => testsuite/psostests}/tm-3.c  |   0
 .../testsuite => testsuite/psostests}/tm-4.c  |   0
 .../testsuite => testsuite/psostests}/tm-5.c  |   0
 .../testsuite => testsuite/psostests}/tm-6.c  |   0
 .../testsuite => testsuite/psostests}/tm-7.c  |   0
 testsuite/vxworkstests/Makefile.am            | 100 +++++++++++
 .../vxworkstests}/lst-1.c                     |   0
 .../vxworkstests}/msgQ-1.c                    |   0
 .../vxworkstests}/msgQ-2.c                    |   0
 .../vxworkstests}/msgQ-3.c                    |   0
 .../vxworkstests}/rng-1.c                     |   0
 .../vxworkstests}/sem-1.c                     |   0
 .../vxworkstests}/sem-2.c                     |   0
 .../vxworkstests}/sem-3.c                     |   0
 .../vxworkstests}/sem-4.c                     |   0
 .../vxworkstests}/task-1.c                    |   0
 .../vxworkstests}/task-2.c                    |   0
 testsuite/vxworkstests/vxworkstest_driver.c   |  74 ++++++++
 .../vxworkstests}/wd-1.c                      |   0
 68 files changed, 685 insertions(+), 168 deletions(-)
 delete mode 100644 lib/alchemy/testsuite/Makefile
 delete mode 100644 lib/psos/testsuite/Makefile
 delete mode 100644 lib/vxworks/testsuite/Makefile
 create mode 100644 testsuite/alchemytests/Makefile.am
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/alarm-1.c (100%)
 create mode 100644 testsuite/alchemytests/alchemytest_driver.c
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/buffer-1.c (99%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/event-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/heap-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/heap-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/mq-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/mq-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/mq-3.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/mutex-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/pipe-1.c (97%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/sem-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/sem-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-10.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-3.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-4.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-5.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-6.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-7.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-8.c (100%)
 rename {lib/alchemy/testsuite => testsuite/alchemytests}/task-9.c (97%)
 create mode 100644 testsuite/psostests/Makefile.am
 rename {lib/psos/testsuite => testsuite/psostests}/mq-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/mq-2.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/mq-3.c (100%)
 create mode 100644 testsuite/psostests/psostest_driver.c
 rename {lib/psos/testsuite => testsuite/psostests}/pt-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/rn-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/sem-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/sem-2.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-2.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-3.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-4.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-5.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-6.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-7.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-8.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/task-9.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-1.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-2.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-3.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-4.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-5.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-6.c (100%)
 rename {lib/psos/testsuite => testsuite/psostests}/tm-7.c (100%)
 create mode 100644 testsuite/vxworkstests/Makefile.am
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/lst-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/msgQ-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/msgQ-2.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/msgQ-3.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/rng-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/sem-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/sem-2.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/sem-3.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/sem-4.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/task-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/task-2.c (100%)
 create mode 100644 testsuite/vxworkstests/vxworkstest_driver.c
 rename {lib/vxworks/testsuite => testsuite/vxworkstests}/wd-1.c (100%)

-- 
2.35.3

