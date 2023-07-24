Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6CC8F8
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 13:53:01 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so6607343e87.2
        for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690206779; x=1690811579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XcCLWC39+8QMjcUTvdz7glL5ZxbKtjyuZbxFizKY08=;
        b=vtreznwu2iIuxwpYZzmv3Kqv34XHZegXrXspf4xCwcns2VTN+QtuyKp0CectztYNut
         3ZHBTMrqhBtO8OOAxvoRzRBroo3CusJ+vlMrS6IWX3m2g5FccGIBvO1Hkxe0QrYlG53w
         cJ1TNKsXuYQgiL8hm0ee3bQwbbgHq1jmAE13gmFqEEAuhaNrMar67FS0LMYwIeYV4k+N
         hwL4Rn/OoVqMXL0+3kceOaSFelRhJl3vc/hqtn0Pc1wQWssQghnq3YQKOssLtODzJkNY
         H7LzcMmMpyT3D5cPbCqUygYUgVQz3xHfa53IlAZSEjLGbdiWt0eE1FDKzNXOHnd00UCE
         kFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206779; x=1690811579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XcCLWC39+8QMjcUTvdz7glL5ZxbKtjyuZbxFizKY08=;
        b=XVJzPg+K25mYT5o2ZmXTvnudNDIlfAJMmPDI1CiVUb+jaEM4J2XST0lbkyoJE9CjsC
         gmohejllncxmA4MRFEYi6T25jn3Y6WNoE84CjOti3a/1C2U7ep25eo87fybeeLNYVl5B
         2HfGzNQf2MzNOsd/CKujAV8ThY9Vk303DZ+F0/Cjjpw9zw7PFU2LwcGKJfcwfrSQDWpt
         Z+W8Z3EQ8TDimVBd1jwnIog90duaMOpOGrmERFA2gtlS3+OoD/NAlFdgyEI0P+2gexVx
         ZgxpvdCb2xTS6BLXqjU0y0iac/KSQdyFtygrfHZmcT6Rt9AdySKT5vNa4MH1awIxtKyf
         MAhA==
X-Gm-Message-State: ABy/qLYVsftNcPsqO/jcXELKShBdiZO9YIHzU2MKmS6MgK5XXVdz8BJa
	Vu1YMD3VA9IvnUEyQxsrYXcePF01MjPtMQkRLcU=
X-Google-Smtp-Source: APBJJlHB++YV3s4I36Aan9DtPFfn60QdlowwkQwu70uXJxST2Mp6LzMJ0x0DBC+B4ME8rb6UnAHXjA==
X-Received: by 2002:a05:6512:114a:b0:4f8:67aa:4f03 with SMTP id m10-20020a056512114a00b004f867aa4f03mr6023434lfg.1.1690206779658;
        Mon, 24 Jul 2023 06:52:59 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0051bed498851sm6239100edw.54.2023.07.24.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:52:59 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 09/10] alchemytests: Fix task-5 logic
Date: Mon, 24 Jul 2023 15:52:38 +0200
Message-Id: <20230724135239.10579-10-aaron@sigma-star.at>
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

Semaphore call in wrong logical order, so that on the second
rt_task_set_priority call the task doesn't exist anymore and thus the
call fails with EINVAL.

This commit fixes the order so that the test passes again.

Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/task-5.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testsuite/smokey/alchemytests/task-5.c b/testsuite/smokey/alchemytests/task-5.c
index b9075945d..2aecd8125 100644
--- a/testsuite/smokey/alchemytests/task-5.c
+++ b/testsuite/smokey/alchemytests/task-5.c
@@ -45,17 +45,17 @@ static void foreground_task(void *arg)
 
 	traceobj_mark(&trobj, 4);
 
-	ret = rt_sem_v(&sem);
-	traceobj_check(&trobj, ret, 0);
+	ret = rt_task_inquire(NULL, &info);
+	traceobj_assert(&trobj, ret == 0 && info.prio == 21);
 
 	traceobj_mark(&trobj, 5);
 
-	ret = rt_task_inquire(NULL, &info);
-	traceobj_assert(&trobj, ret == 0 && info.prio == 21);
+	ret = rt_task_set_priority(&t_bgnd, info.prio);
+	traceobj_check(&trobj, ret, 0);
 
 	traceobj_mark(&trobj, 6);
 
-	ret = rt_task_set_priority(&t_bgnd, info.prio);
+	ret = rt_sem_v(&sem);
 	traceobj_check(&trobj, ret, 0);
 
 	traceobj_mark(&trobj, 7);
-- 
2.35.3

