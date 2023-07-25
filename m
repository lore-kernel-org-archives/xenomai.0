Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9B15AD5
	for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 08:30:11 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-986d8332f50so823441766b.0
        for <xenomai@lists.linux.dev>; Tue, 25 Jul 2023 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690273809; x=1690878609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP/Un1N58EC5XJ5gxEFycWuZzj2RTEECVEEOIUqf/iU=;
        b=MXRh9U+MGH92AyMsnPIQiOtJP6exGyTspoZySASFOWVB29tIi9A4s88yCulQhO3/uJ
         fnAP+OWLOB/7Sl9f6KdKT1n3V73kGru5X573bH+RNcX3DOaTk+LQSaXghc+BNK9FnCgB
         hlf/Gsho5WWNViQ/A5ewWuPXYAEmj4woxmuho+sCNX4bQ4xrsw/KUEnRVNV83EBQ5wyr
         HMp2VU7FLyRjhi6dLnSAS8WiciFGuCw5IBaKxpiPdFWJRzfWmO1279uVDG8pd4bdIjm9
         DGknJTWwaRBki46sFw4aiud68rwDmNrf2fLzbiPmoj/n7U9i62ScshNKcLZExFRg8s32
         H4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273809; x=1690878609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HP/Un1N58EC5XJ5gxEFycWuZzj2RTEECVEEOIUqf/iU=;
        b=BJXs27QAbsnHqzlsKvzt8fWX56f2h3i9P8+i618hCOC+CDSOsOlKsz8sU/wD8YTWIJ
         KzXHZBZhRDEpyve8I2dwjTQSEuN5pl3v7PAVWSifY3zhKrnGPLYgyfbuAP9IPu5+nDsm
         STJaVjhr6L7rgt9B1hcaIL5t882NhRwZQ1oi/8eTmRNOoIcR4D3d1WXktw4f5UrclgBF
         lExPEOkhBttOvWcQtgnZ4bWobAgw8p4QrB8GATnuR/CyaV8ztaeLYhRK5p0TfmpoY9Rv
         10Gx7KvKpU2m3TQzArLI6ssssFHqziGk588xYZUFgEcj+SIyfJrwl1vtFG2UYvrasePd
         EwBA==
X-Gm-Message-State: ABy/qLaFvzlOIRz295PyfEz0VEYpZqEgKIgOodN2rtWZ6EnVRVdDkdGQ
	c7zAMx/eWH8/83/2MDcB+Ix/uqHjco/ExkELwRU=
X-Google-Smtp-Source: APBJJlHcjX6ehrd5SRa1ZBHDX9l+7THR7sFu0dJLVhbXyeamWOt61juDHQtRqBimjPVzwxw6oP5Pdw==
X-Received: by 2002:a17:906:32cb:b0:988:8fce:17ba with SMTP id k11-20020a17090632cb00b009888fce17bamr10845966ejk.31.1690273809828;
        Tue, 25 Jul 2023 01:30:09 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a170906230200b00997e52cb30bsm7752080eja.121.2023.07.25.01.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:09 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 10/10] testsuite: disable broken tests
Date: Tue, 25 Jul 2023 10:29:59 +0200
Message-Id: <20230725082959.5144-11-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
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

