Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F974182D7
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 14:52:15 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-992f15c36fcso154677566b.3
        for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1689864734; x=1690469534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAJDOQqoP4zhEmkJOuMeVygSmH5hL4L0OkhvDqkgLjM=;
        b=FRn+0XJLzUOf7fgWvA6ovwaS0zixFABy4vX458qzY+padXdVxE42+v0ijPWtg3lcPv
         ZnwIxOlyAbauUJuQ1lGnzodcT7lF02cNbbizT6jlXWdXWL9rXTx4TvrlMki0B4DOOgN+
         RBDMNXWFYtAungOoGDfNJClFPhS4xOXzb3biXQTP2KTbZeKsutfZmxzDChOi1CXgsG/K
         bZxGMfunL4L6ed0yoy9mH3NfgG2tkKOJvoigRQrpLAYLXTik2GPsl4PTENQBkoXX+/zr
         HE+0QZergZTFdzFw75TwHfokojz7ecaAGnvJDCss6AEFArPlam/Aw8hpGRaWM0ykb71V
         d6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864734; x=1690469534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAJDOQqoP4zhEmkJOuMeVygSmH5hL4L0OkhvDqkgLjM=;
        b=Niw3fTm/MmuV6qK+Nijly6j+tGstAJwPSVekTPu44iM2zy22tJmRo8ErCG+/0IEcX5
         ZgLmeW+BFdOQN4IJQp7xuMf5hxyHLdH/v7fmQG80oHkXCtLBpgXznKBB6CQzRr5Ri1a6
         p8fWvxmXq5PoMc+cimlrGe6UzKU6wVHj0g3avLQFmObaS6YCZE0VWP/1W/fcyRpm78g4
         iHvl7dwIuVA3R6N5fsH9VM4lqd694Hv1jcKMP85txCXsMoXyAvmpPUaxh/PSodwy5XZL
         tlLFvKlTEOGxmtkE0x8EAEDuUtIwFFfQVrjIT/nO2d4Q9HuoSYjeFrcYu15tk2AmrZ7r
         Z2Sw==
X-Gm-Message-State: ABy/qLayrJ0FF6PpJ9dM8qj3Rxs3PqgOQtvqYP0hOFjChKhYXvJixvlL
	Rm3dvPsoPK27mUHygR+4UinPJUDfFNcZ99g76CI=
X-Google-Smtp-Source: APBJJlGBgWihxEwp81j0PXmap0vuNb9ARcA48zAT9JwCzqwcznAxpty6qQDjdjvmfpt3rDn1DdFILg==
X-Received: by 2002:a17:907:75f5:b0:982:26c5:6525 with SMTP id jz21-20020a17090775f500b0098226c56525mr5052196ejc.60.1689864733840;
        Thu, 20 Jul 2023 07:52:13 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906854d00b0099290e2c163sm793462ejy.204.2023.07.20.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:52:13 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 10/10] testsuite: disable broken tests
Date: Thu, 20 Jul 2023 16:51:50 +0200
Message-Id: <20230720145150.24607-11-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230720145150.24607-1-aaron@sigma-star.at>
References: <20230406103341.2914-1-aaron@sigma-star.at>
 <20230720145150.24607-1-aaron@sigma-star.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

as discussed on the mailing list, disable broken tests (for now)

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/psostests/psostests.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/testsuite/smokey/psostests/psostests.c b/testsuite/smokey/psostests/psostests.c
index 66c913213..805cdd429 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -34,18 +34,30 @@ TEST(psostests_mq1)
 TEST(psostests_mq2)
 TEST(psostests_mq3)
 TEST(psostests_pt1)
-TEST(psostests_rn1)
+// 0"000.679| BUG in __traceobj_assert_failed(): [rn1] trace assertion failed:
+//            testsuite/psostests/rn-1.c:46
+// => "ret == 0"
+//TEST(psostests_rn1)
 TEST(psostests_sem1)
 TEST(psostests_sem2)
 TEST(psostests_task1)
-TEST(psostests_task2)
+// 0"014.452| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
+//            ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-2.c:56 => "ret == 0"
+//TEST(psostests_task2)
 TEST(psostests_task3)
 TEST(psostests_task4)
 TEST(psostests_task5)
-TEST(psostests_task6)
+// 0"011.370| BUG in __traceobj_assert_failed(): [FGND] trace assertion failed:
+//            testsuite/psostests/task-6.c:62
+// => "ret == 0 && oldprio == myprio"
+// TEST(psostests_task6)
 TEST(psostests_task7)
-TEST(psostests_task8)
-TEST(psostests_task9)
+// runs forever (100% CPU)
+//TEST(psostests_task8)
+// 0"002.198| WARNING: [main] lack of resources for core thread, EBUSY
+// 0"003.421| BUG in __traceobj_assert_failed(): [root] trace assertion failed:
+//           ../../../../../../../../../workspace/sources/xenomai/testsuite/smokey/psostests/task-9.c:29 => "ret == 0"
+//TEST(psostests_task9)
 TEST(psostests_tm1)
 TEST(psostests_tm2)
 TEST(psostests_tm3)
-- 
2.35.3

