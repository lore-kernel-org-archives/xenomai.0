Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FF1CAA1
	for <xenomai@lists.linux.dev>; Mon, 25 Sep 2023 15:13:06 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c00c0f11b2so109150031fa.1
        for <xenomai@lists.linux.dev>; Mon, 25 Sep 2023 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695654784; x=1696259584; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALjb8bAYDO2NyAEQXOyLqm35gzP3mbF8ybFeyjUWIu0=;
        b=jjCzfavPI0CQGuXR8wfQZqBzXkGuy46GP5fn2EkJ7I7hXlQ2lbzQ43fV1gOC4UmUDE
         4+Dyu6i85uSq9NtF3HZctGzOIAoy10N38gofojUygdmsA3FEzt2tqzorLAL04Pn4ut+H
         Z8iExJfxBcaL/VWcLwGyFrQvJcatMwhgMqBEmXRoygJT6N4N27axs7JzsyutyMNeSNWT
         GUPl/VweI1rdww0M4BQfvAuNSoQcYBlJtnbF/OZkN4XfDfwSHeXZHur4EdHHUmjonnC4
         nPbJkX3UuqERMvJmYWqzFL5pIQk7W8Bt3mpPsQIDYKUH62ZM2KTdzW2kqgk61vQV54Bo
         T7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654784; x=1696259584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALjb8bAYDO2NyAEQXOyLqm35gzP3mbF8ybFeyjUWIu0=;
        b=fI5hHi46wGC36FtgsxdB+Y1fqGOr5rHTPfH1F/AS0KO4BLfB+wLxMiW/dVC2Fo3Icd
         EERFaF4q0zKQ1rhqXuZmiqYJeTtNScDMMfFB25wdRkGCBOvCA3jMI07Fzn7Ukz8pnPI7
         zcMPkkFYjiPBbQ6sPT5eJSMLoE7MKmsyCBy40JaSq/2xuFd40O2ZnnK6B9uYrTwFbccx
         B9FIu8YOifbmWLOSrK47oQ2qzRNBPP5hRtQSPpUTXsqLgAdAGGsLbro6/5xuAMomHEry
         zpFbHO+7BK6l22aiaJCVjMEPA80AmmfBtsPo20emyG+KeBlnHsAvNpEuLRW+i2ZQgb4A
         4OFA==
X-Gm-Message-State: AOJu0YxrxW6JfHT/L8esC6BlBsMzwrt9lLZFdbm6XUWCFrjGOO8cNY7d
	irQksxjv3EuHJ1b8mWZl77WZB1OFMHD383JZG54=
X-Google-Smtp-Source: AGHT+IFOyv0nFoxJKCDXrnzXwYIqYdIu1qXjvEFaVPyvvO+mKQ9OW+Jpx3hjikZzfdCj5EE6Dh7zfg==
X-Received: by 2002:a2e:8512:0:b0:2b6:df6b:84c0 with SMTP id j18-20020a2e8512000000b002b6df6b84c0mr5993756lji.25.1695654784417;
        Mon, 25 Sep 2023 08:13:04 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id t15-20020a170906608f00b009a9fbeb15f2sm6430007ejj.62.2023.09.25.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:13:04 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 0/1 V2] lib: Drop cpu-affinity=0 from skin-tests helper
Date: Mon, 25 Sep 2023 17:12:55 +0200
Message-Id: <20230925151256.22161-1-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230925130311.17757-1-aaron@sigma-star.at>
References: <20230925130311.17757-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- Introduce parameter to control arguments on a case-to-case basis

Aaron Marcher (1):
  lib: Drop cpu-affinity=0 from skin-tests helper

 include/smokey/smokey.h                      | 2 +-
 lib/smokey/helpers.c                         | 8 ++++++--
 testsuite/smokey/alchemytests/alchemytests.c | 3 ++-
 testsuite/smokey/psostests/psostests.c       | 3 ++-
 testsuite/smokey/vxworkstests/vxworkstests.c | 3 ++-
 5 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.35.3

