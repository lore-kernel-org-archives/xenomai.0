Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77C2F59
	for <xenomai@lists.linux.dev>; Thu,  6 Apr 2023 10:34:26 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-93071f06aa7so121580966b.3
        for <xenomai@lists.linux.dev>; Thu, 06 Apr 2023 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1680777265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opjw2bHJuPSiLEkbAxxrM4sHm4Cyr6Dfp5DyqKWK0Qw=;
        b=V8k/D6CcVzmklN+sNLWLYhR++i+hZlhFbM+6OGyyFn2g60vFSyIoAGDktNxSEMa8OV
         Wk97y8gHC3SEXaBDA2uiw7ESNytkRumJjpK6W9xuiQOEjXOkLajiBiZiH3Tyhg8B3zbi
         2+ZextpM85YnFJJCocxMalYcfB7Y/FfGL66JZaaw9HbvM0ZOE62HyISdYFg7c9TvPBV7
         hSYGYhgcf9TFeNM1eH7vyItCeiu0mDEQt/S+NTfKX81ZXLiv+03bSaJOqY7Wgv5ym0nE
         pC/orbzP+Ua7JfqkE0Qc9siqGt54o8O3OW3wBtGcZeYH1X7ymWr3Szj/zPtjKQGLAaTp
         bTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Opjw2bHJuPSiLEkbAxxrM4sHm4Cyr6Dfp5DyqKWK0Qw=;
        b=uddcVW4EE5kxQTHPwLd7EnFG+7QW9W/Flhjw1h8lIbD/BlvySc2zMb6/bI67eU1FHQ
         fCYrs5KrLqMFOCBRQ+njyN0+DjURPxbtW6r0iom5oI04bIISUouNYaRvPK4yXDk/vdw+
         zKWcmpBzI8Y4D7J13m8RZKipkFdduDxbaCe/HpLe85WL3aZPWRXa7jHHTuRUNr8IWbZY
         KVQlFQCA4tyf2TCS4Rcozf2ARdKFXtAAPVnq5/JlxpHCRL3lIE9G/5p2HQXYTg+5tsXx
         kaEF+fobBIDOI7VSwszSgJ5Zj3D2LOMfdUErLiG3zYkGDGaoSJngrNGC3i3NM8Jlsb3K
         nRAw==
X-Gm-Message-State: AAQBX9ee25f+Z4MZjqJOKF4Pxydlm7kTffOPSwQKPxCPZTDNEVYsSfiT
	o5ktcCH0FCyjb1F6dOu5YF1vIL4ez22abgPOEpE=
X-Google-Smtp-Source: AKy350bP/o+Fz49mJpbIc2kyxgsq26vgeoXKHYvtRvdH2BRkPmLNUPcz8XQz2MiVN7QmJd65e3QDhQ==
X-Received: by 2002:aa7:cc98:0:b0:501:cced:9c6c with SMTP id p24-20020aa7cc98000000b00501cced9c6cmr3778429edt.7.1680777265430;
        Thu, 06 Apr 2023 03:34:25 -0700 (PDT)
Received: from foxxylove.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a50c007000000b005021d210899sm574795edb.23.2023.04.06.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:34:25 -0700 (PDT)
From: Aaron Marcher <aaron@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: richard@nod.at,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Aaron Marcher <aaron@sigma-star.at>
Subject: [PATCH 06/11] alchemytests: Fix gcc warning in task-9
Date: Thu,  6 Apr 2023 12:33:36 +0200
Message-Id: <20230406103341.2914-7-aaron@sigma-star.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230406103341.2914-1-aaron@sigma-star.at>
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
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
 testsuite/alchemytests/task-9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/alchemytests/task-9.c b/testsuite/alchemytests/task-9.c
index e358154c59..4b62a17beb 100644
--- a/testsuite/alchemytests/task-9.c
+++ b/testsuite/alchemytests/task-9.c
@@ -10,7 +10,7 @@ static RT_TASK t_test;
 
 #define ONE_SECOND  1000000000ULL
 
-void sighandler(int sig)
+static void sighandler(int sig)
 {
 	/* nop */
 }
-- 
2.35.3

