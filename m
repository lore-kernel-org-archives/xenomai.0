Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9318AE4
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:00 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso1373665e87.2
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864718; x=1690469518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY+KTnntO/a/kStp0vCK046g8VZ8ZBfQIXENsd7ocwU=;
        b=gkm0meRfOdP3yi2/AoL91jM60qPvZczjCA0AsDRdwDysJ3dMJMrqPFDqhJ3WLzG3vD
         Zi+xf8jW15j/ygYExmP+eskjLGu+WbiYBD0Px1u2zbjxXxONZSxxB8KTM74rKuU0QHkB
         8m3HZd1x913Ore7e9T/ccHWV0XUAk9cUwhRJd1XvestcVVv/REFae1xyd/YD8mG6uqyV
         5MdMw+bxBpAsbHOfo52awBtVUz6EoFedro41my+mh/bnhT6PUoSDYp7fpnOSEHjpb9ET
         RyrckebXk+9FC/ykZliQKyKD7QYUlDc/jR7nSjrEyCbwRcde/Tjt07XOds1Ab+rhgee+
         WqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864718; x=1690469518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY+KTnntO/a/kStp0vCK046g8VZ8ZBfQIXENsd7ocwU=;
        b=hvwoTI9M00II87yMmzEL/wRZHirnKwTZ2ObflaGNY5Br/6aroaGtyV7893TSckVLJ/
         dz3en12DcjSWszkT/OWF8jYGvRaQuq+vUXDKryck4SEzH/GgRP1Y22pcjLUlPCqgxK83
         LoEEDhfG2xZSO41kWU/DPSaHxwuSjxLgZYOL7vgiv62V59dErAFAlqv5C1yaUtUli0YB
         Z8OuV8nSL7bpbCM5EuIjkWtZoDv/p61co4wUrCsHxUwWJY4HUjrurPW4cNerkV+j/l9I
         baBjLsY39fKYL3g4PqfDYTnUf3lYc/xi8gMusc7aItgxT9xhOgZGd8k9aNllxdDYB5Zd
         P9RQ==
X-Gm-Message-State: ABy/qLZEGWrNrS8S9dGLL1wmF1OO/7z4LQHgzRdLRuTQpfAuHq7TbhwO
	r7xkiwDz8yhWJMI/o6UtQA/7ef1IX3kEtex/bN8=
X-Google-Smtp-Source: APBJJlE7SuqRudIlNECH41XvVKNHKHvM4LAT9BkRZtL0B2RMYo+p2rOu06q97F7SijMSagvsSm9BkQ==
X-Received: by 2002:a05:6512:32b8:b0:4fb:9fa7:dcda with SMTP id q24-20020a05651232b800b004fb9fa7dcdamr2024631lfe.26.1689864718075;
        Thu, 20 Jul 2023 07:51:58 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:51:57 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH v4 00/10] Revive alchemy, pSOS and VxWorks tests
Date: Thu, 20 Jul 2023 16:51:40 +0200
Message-Id: <20230720145150.24607-1-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230406103341.2914-1-aaron@sigma-star.at>
References: <20230406103341.2914-1-aaron@sigma-star.at>
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
 .../smokey/alchemytests}/alarm-1.c            |   0
 testsuite/smokey/alchemytests/alchemytests.c  |  55 +++++++
 .../smokey/alchemytests/alchemytests_driver.c |  32 ++++
 .../smokey/alchemytests}/buffer-1.c           |   2 +-
 .../smokey/alchemytests}/event-1.c            |   0
 .../smokey/alchemytests}/heap-1.c             |   0
 .../smokey/alchemytests}/heap-2.c             |   0
 .../smokey/alchemytests}/mq-1.c               |   0
 .../smokey/alchemytests}/mq-2.c               |   0
 .../smokey/alchemytests}/mq-3.c               |   0
 .../smokey/alchemytests}/mutex-1.c            |   0
 .../smokey/alchemytests}/pipe-1.c             |   6 +-
 .../smokey/alchemytests}/sem-1.c              |   0
 .../smokey/alchemytests}/sem-2.c              |   0
 .../smokey/alchemytests}/task-1.c             |   0
 .../smokey/alchemytests}/task-10.c            |   0
 .../smokey/alchemytests}/task-2.c             |   4 +-
 .../smokey/alchemytests}/task-3.c             |   0
 .../smokey/alchemytests}/task-4.c             |   0
 .../smokey/alchemytests}/task-5.c             |  10 +-
 .../smokey/alchemytests}/task-6.c             |   0
 .../smokey/alchemytests}/task-7.c             |   0
 .../smokey/alchemytests}/task-8.c             |   0
 .../smokey/alchemytests}/task-9.c             |   2 +-
 testsuite/smokey/psostests/Makefile.am        | 148 ++++++++++++++++++
 .../smokey/psostests}/mq-1.c                  |   0
 .../smokey/psostests}/mq-2.c                  |   0
 .../smokey/psostests}/mq-3.c                  |   0
 testsuite/smokey/psostests/psostests.c        |  68 ++++++++
 testsuite/smokey/psostests/psostests_driver.c |  33 ++++
 .../smokey/psostests}/pt-1.c                  |   0
 .../smokey/psostests}/rn-1.c                  |   0
 .../smokey/psostests}/sem-1.c                 |   0
 .../smokey/psostests}/sem-2.c                 |   0
 .../smokey/psostests}/task-1.c                |   0
 .../smokey/psostests}/task-2.c                |   0
 .../smokey/psostests}/task-3.c                |   0
 .../smokey/psostests}/task-4.c                |   0
 .../smokey/psostests}/task-5.c                |   0
 .../smokey/psostests}/task-6.c                |   0
 .../smokey/psostests}/task-7.c                |   0
 .../smokey/psostests}/task-8.c                |   0
 .../smokey/psostests}/task-9.c                |   0
 .../smokey/psostests}/tm-1.c                  |   0
 .../smokey/psostests}/tm-2.c                  |   0
 .../smokey/psostests}/tm-3.c                  |   0
 .../smokey/psostests}/tm-4.c                  |   0
 .../smokey/psostests}/tm-5.c                  |   0
 .../smokey/psostests}/tm-6.c                  |   0
 .../smokey/psostests}/tm-7.c                  |   0
 testsuite/smokey/vxworkstests/Makefile.am     |  94 +++++++++++
 .../smokey/vxworkstests}/lst-1.c              |   0
 .../smokey/vxworkstests}/msgQ-1.c             |   0
 .../smokey/vxworkstests}/msgQ-2.c             |   0
 .../smokey/vxworkstests}/msgQ-3.c             |   0
 .../smokey/vxworkstests}/rng-1.c              |   0
 .../smokey/vxworkstests}/sem-1.c              |   0
 .../smokey/vxworkstests}/sem-2.c              |   0
 .../smokey/vxworkstests}/sem-3.c              |   0
 .../smokey/vxworkstests}/sem-4.c              |   0
 .../smokey/vxworkstests}/task-1.c             |   0
 .../smokey/vxworkstests}/task-2.c             |   0
 testsuite/smokey/vxworkstests/vxworkstests.c  |  45 ++++++
 .../smokey/vxworkstests/vxworkstests_driver.c |  32 ++++
 .../smokey/vxworkstests}/wd-1.c               |   0
 71 files changed, 686 insertions(+), 177 deletions(-)
 delete mode 100644 lib/alchemy/testsuite/Makefile
 delete mode 100644 lib/psos/testsuite/Makefile
 delete mode 100644 lib/vxworks/testsuite/Makefile
 create mode 100644 testsuite/smokey/alchemytests/Makefile.am
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (100%)
 create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
 create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (99%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (97%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (100%)
 rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (97%)
 create mode 100644 testsuite/smokey/psostests/Makefile.am
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-2.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/mq-3.c (100%)
 create mode 100644 testsuite/smokey/psostests/psostests.c
 create mode 100644 testsuite/smokey/psostests/psostests_driver.c
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/pt-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/rn-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/sem-2.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-2.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-3.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-4.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-5.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-6.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-7.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-8.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/task-9.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-1.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-2.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-3.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-4.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-5.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-6.c (100%)
 rename {lib/psos/testsuite => testsuite/smokey/psostests}/tm-7.c (100%)
 create mode 100644 testsuite/smokey/vxworkstests/Makefile.am
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/lst-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-2.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/msgQ-3.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/rng-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-2.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-3.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/sem-4.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-1.c (100%)
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/task-2.c (100%)
 create mode 100644 testsuite/smokey/vxworkstests/vxworkstests.c
 create mode 100644 testsuite/smokey/vxworkstests/vxworkstests_driver.c
 rename {lib/vxworks/testsuite => testsuite/smokey/vxworkstests}/wd-1.c (100%)

-- 
2.35.3

