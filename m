Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94309C2C7
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 13:52:59 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so6291998a12.0
        for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1690206777; x=1690811577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oYSiQJOfTOkadrBpzsusxC7onjqteGDwjUEKwng54o=;
        b=HwvLVvpG7xpORCgMMBzpi8DiqFJenybPx3HefcmgIsLoT5IWQWelY4vYZ69eSJZnGL
         tjLgov+NViEjAF0JKYUn5fDTMp+z6zszbGGeQqlYrNPAHxOx04yu1FVNyxUSBk5vqqnf
         jKiPoZSraUe3vs90Cc9GxAy9CdrqWUtW+4pV6u8op+QEgoFQToqDn7efTat8ArE0oIUu
         ZsB+QAjTdNjZsu3sAGHskvCNSB6wh0gLJAJdxvMxWIalIEjHrx7VYUkCmfUx/WPHSn9P
         hnyNSxZX/pll1x3InYF/OGTBhPci6IBux9de9Hxj0fRz8m7uJm7L62mOqyA/c/i4RKW1
         u5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206777; x=1690811577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oYSiQJOfTOkadrBpzsusxC7onjqteGDwjUEKwng54o=;
        b=LTiuhq+2Ohxv2qUi1amRIqLIVQOSDNNkWXXagIz5egIXLjlAOvJhlwDEtqFE118Zat
         keDruJB4VTTME+7O9iLUyNhJGjbt9rpr/t67nqv3ZPaagmQvMaMvRYHE1Pv2tVDkyi8I
         KuS5gfweccvaeaLeLl3v8+VmcsOxO4vW04HF7brDPJKRh2YZQTcCLVBiVXZLOdtopFKv
         Ypu+udlPjuz5lhN/xFN+/KLRaXVADpDfOaVLW31x4c7lL8uG9s9zP2+kX5my22f1RXeN
         a9n6eVK2JDDfaK1mMGFhG1w3oD2unLq+4/G1P3bpf2cxunD/phJ3tVCuNorNeYNPulha
         TFCQ==
X-Gm-Message-State: ABy/qLYIcu17gf5KJpZBx08AWzk8/g59XPOqNfWqv/B+78UC3IYaFTAK
	Vtz1NvBGrHbEsKmiOau0D7IK53KIXXZ4uFZc/3M=
X-Google-Smtp-Source: APBJJlHfj9ic5lAsqTHpHfRIk5sQ0EOyKoS9uirUiS0MzMo0kAyt6bjyROzLwuvmTV4wb4O/m9ln9A==
X-Received: by 2002:aa7:d3c1:0:b0:522:37e3:74df with SMTP id o1-20020aa7d3c1000000b0052237e374dfmr1441704edr.28.1690206777521;
        Mon, 24 Jul 2023 06:52:57 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7cd42000000b0051bed498851sm6239100edw.54.2023.07.24.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:52:57 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 06/10] alchemytests: Fix gcc warning in task-9
Date: Mon, 24 Jul 2023 15:52:35 +0200
Message-Id: <20230724135239.10579-7-aaron@sigma-star.at>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

Make it static, no prototype needed anymore.

Fixes:
task-9.c:13:6: error: no previous prototype for ‘sighandler’ [-Werror=missing-prototypes]
 void sighandler(int sig)

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
---
 testsuite/smokey/alchemytests/task-9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/alchemytests/task-9.c b/testsuite/smokey/alchemytests/task-9.c
index 56cc7bfeb..9bb43efbd 100644
--- a/testsuite/smokey/alchemytests/task-9.c
+++ b/testsuite/smokey/alchemytests/task-9.c
@@ -11,7 +11,7 @@ static RT_TASK t_test;
 
 #define ONE_SECOND  1000000000ULL
 
-void sighandler(int sig)
+static void sighandler(int sig)
 {
 	/* nop */
 }
-- 
2.35.3

