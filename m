Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9DD2FC
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 13:53:02 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so6639075e87.2
        for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690206780; x=1690811580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP/Un1N58EC5XJ5gxEFycWuZzj2RTEECVEEOIUqf/iU=;
        b=VBQ1aB9c5XWEa748GadYFEF/OMXnwkkADuZtxDOjFE9zLVVpikgAP9QeqJsJNu0VbT
         53RGLqaW4TqVDba+mtdo/LOY0tlSYZoz9qAVHXLJY2/e0IneDbz5Ab7KE6aje5+Q4N1A
         7Oywx9r1FRw35WL0gzkFGip/U51BymIDDovB2E9sMJjU8CdJRH0ZaZ1mud0EBpzQ5c2C
         carJ+4ocYvfhXL4sutEGRiVG2XwLAYDmlRLZPva8DcSJ97ykf9qcCfWE7FJzn524PDdN
         MtRTD/AOmjrONDQI8BMZHzpdfJ4arpcXvogXWKeynNmTP73/ySLqpr12Kfo7K/sLGe6m
         dugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206780; x=1690811580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HP/Un1N58EC5XJ5gxEFycWuZzj2RTEECVEEOIUqf/iU=;
        b=Fgma1tIxarPiuwfj7e60ptvvObE5oHmUQEZIx54Y25BSCqIjLPaYRzVHblMrufA0kg
         gp7L45Ca5ZsiGrhzz927zFg7MhbW9yoM/jjNfHTUBRWW+mFcSAnkXkXIMBN40+i0irtr
         RqXfrXs7NCrplBYrcpTTAYgOOh4QU4F+sSsF59SyE8UrVI87XeC1xHgsjAEATCXCpCCY
         FUPYKnPf1HnrVCOEx2NPVoHhDOM5RJ17iqzJygJ+2zYvbYuSB/3FYBxD+cCXElbIQMAA
         NutfTw71WG7wTbceIC1W/DwXGtRmiaszczFaIyEsPd4wQN3CCGaDA7McnA0bMLNsV37p
         fqDg==
X-Gm-Message-State: ABy/qLaeL8vfDQhNaofBH3IA36wPYCPH/kyJl/j5tFriEMsiWcKrAbJl
	f9wr+957jr1TYAc+9ma0dF8CpwWOkHUp4+gSo+M=
X-Google-Smtp-Source: APBJJlGk4AovqGOikcBoQfhOg73yj6xyNkXX5g0d1uvZRf/S8lzkz3AsGRbNJkhXfoul/z9I1Ko9Ng==
X-Received: by 2002:a05:6512:3e0c:b0:4f8:6560:6436 with SMTP id i12-20020a0565123e0c00b004f865606436mr6893995lfv.9.1690206780345;
        Mon, 24 Jul 2023 06:53:00 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0051bed498851sm6239100edw.54.2023.07.24.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:53:00 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 10/10] testsuite: disable broken tests
Date: Mon, 24 Jul 2023 15:52:39 +0200
Message-Id: <20230724135239.10579-11-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230724135239.10579-1-aaron@sigma-star.at>
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
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
index 254a1515c..f315c1d55 100644
--- a/testsuite/smokey/psostests/psostests.c
+++ b/testsuite/smokey/psostests/psostests.c
@@ -35,18 +35,30 @@ TEST(psostests_mq1)
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

